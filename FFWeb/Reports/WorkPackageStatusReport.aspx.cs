using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using FFLib;
using System.Data;


/* TO DO:
 * Validators
 * Persist changes
 * Enable Editing of ETC or EAC
 * Calculate PDays and PDollars
 * Turns hours into Days
 * Create functionality
 */

public partial class Reports_WorkpackageStatusReport : System.Web.UI.Page {
    FlyingFishClassesDataContext ffdb = new FlyingFishClassesDataContext();
    WorkPackageStatusReport wpsr;
    
    protected void Page_Load(object sender, EventArgs e) {
        if (!IsPostBack) {
            populateProjects();
            populateWorkpackages();
        }

        // for testing purposes only, so I don't have to fill out the form every time
        GetWorkPackageStatusReport(4911, "1", Convert.ToDateTime("2011/01/01"), Convert.ToDateTime("2011/03/01"));
    }

    private void populateProjects() {
        ddlAllProjects.DataSource = ffdb.Projects.Select(p => new {
            ProjID = p.projId,
            ProjectName = p.projName + " (" + p.projId + ")"
        });
        ddlAllProjects.DataValueField = "ProjId";
        ddlAllProjects.DataTextField = "ProjectName";
        ddlAllProjects.DataBind();
        //PopulateWorkpackages();
    }

    private void populateWorkpackages() {
        ddlWorkpackages.DataSource = ffdb.WorkPackages
                                   .Where(wp => wp.projId == Convert.ToInt16(ddlAllProjects.SelectedValue))
                                   .Select(wp => new {
                                       WpID = wp.wpId,
                                       WpName = wp.name + " (" + wp.wpId + ")"
                                   });
        ddlWorkpackages.DataValueField = "WpId";
        ddlWorkpackages.DataTextField = "WpName";
        ddlWorkpackages.DataBind();
    }

    protected void ddlAllProjects_SelectedIndexChanged(object sender, EventArgs e) {
        populateWorkpackages();
    }

    // NEED DAYS! NOT HOURS! DIVIDE IT BY 8!!!

    public void GetWorkPackageStatusReport(int projId, String wpId, DateTime start, DateTime end) {
        // Find out how much work each employee has done on the work package
        // Calculate the PDays and PDollar value of this work
        // Calculate the EAC from the ACWP and ETC
        // Calculate the percent complete
        // Calculate the total

        List<KeyValuePair<int, double>> acwpForAll = getAcwpForAll(projId, wpId, start, end);
        List<EmployeeWorkPackageETC> etcForAll = getEtcForAll(projId, wpId, start, end);

        var qry = from tse in ffdb.TimesheetEntries
                  join proj in ffdb.Projects on tse.projId equals proj.projId
                  join wp in ffdb.WorkPackages on (tse.projId + tse.wpId) equals (wp.projId + wp.wpId)
                  join emp in ffdb.Employees on tse.empId equals emp.empId
                  join wpre in ffdb.WorkPackageResponsibleEngineers on (tse.projId + tse.wpId) equals (wpre.projId + wpre.wpId)
                  join re in ffdb.Employees on wpre.responsibleEngineer equals re.empId
                  join pm in ffdb.Employees on proj.manager equals pm.empId
                  orderby tse.projId, tse.wpId, tse.empId
                  where (tse.tsDate >= start) && (tse.tsDate <= end)
                        && (tse.projId == projId) && (tse.wpId == wpId)
                  select new {
                      Proj = proj,
                      PM = pm,
                      WP = wp,
                      WPRE = wpre,
                      RE = re,
                      Emp = emp.firstName + " " + emp.lastName + " (" + emp.empId + ")",
                      ACWP = getAcwpForEmployee(tse.empId, acwpForAll),
                      ETC = getEtcForEmployee(tse.empId, etcForAll),
                      EAC = getEacForEmployee(getAcwpForEmployee(tse.empId, acwpForAll), getEtcForEmployee(tse.empId, etcForAll)),
                      PercentComplete = getPercentComplete(getAcwpForEmployee(tse.empId, acwpForAll),
                                        getEacForEmployee(getAcwpForEmployee(tse.empId, acwpForAll),
                                                getEtcForEmployee(tse.empId, etcForAll)).ToString())
                  };

        if (qry.Count() == 0) {
            gvStatus.DataSource = null;
            gvStatus.DataBind();
            lblResults.Visible = true;
            divReportData.Visible = false;
            return;
        }

        DataTable dt = new DataTable();
        dt.Columns.Add(new DataColumn("Employee", typeof(System.String)));
        dt.Columns.Add(new DataColumn("ACWP", typeof(System.String)));
        dt.Columns.Add(new DataColumn("ETC", typeof(System.String)));
        dt.Columns.Add(new DataColumn("EAC", typeof(System.String)));
        dt.Columns.Add(new DataColumn("PercentComplete", typeof(System.String)));
                
        foreach (var row in qry) {
            DataRow dr = dt.NewRow();
            dr["Employee"] = row.Emp;
            dr["ACWP"] = row.ACWP;
            dr["ETC"] = row.ETC;
            dr["EAC"] = row.EAC; 
            dr["PercentComplete"] = row.PercentComplete; 
            dt.Rows.Add(dr);
        }

        gvStatus.DataSource = dt;
        gvStatus.DataBind();

        var q = qry.FirstOrDefault();

        lblWpId.Text = q.WP.wpId;
        lblWpName.Text = q.WP.name;
        lblRe.Text = q.RE.firstName + " " + q.RE.lastName + " (" + q.RE.empId + ")";
        lblPm.Text = q.PM.firstName + " " + q.PM.lastName + " (" + q.PM.empId + ")";
        lblReportNo.Text = "Unavailabile";
        lblReportPeriod.Text = start.ToString("yyyy/MM/dd") + " to " + end.ToString("yyyy/MM/dd");
        lblPmBac.Text = this.getPMBudget(projId, wpId).ToString();

        double reBAC = 0;

        foreach (var item in qry) {
            if (!(item.EAC.Equals("Unknown"))) {
                reBAC += Convert.ToDouble(item.EAC);
            }
        }
        
        lblReBac.Text = reBAC.ToString();
        if (reBAC == 0) {
            lblReBac.Text = "Unknown";
        }
        
        double totalAcwp = 0;

        foreach (var item in qry) {
            if (!(item.ACWP.Equals("Unknown"))) {
                totalAcwp += Convert.ToDouble(item.ACWP);
            }
        }


        lblTotalAcwp.Text = totalAcwp.ToString() + " hours";
        if (totalAcwp == 0) {
            lblTotalAcwp.Text = "Unknown";
        }
        
        wpsr = getExistingReportDetails(projId, wpId, start, end);
        if (wpsr == null) {
            tbComments.Text = "";
            tbWorkAccomplished.Text = "";
            tbWorkPlannedNext.Text = "";
            tbProblemsEncountered.Text = "";
            tbProblemsAncticipatedNext.Text = "";
        } else {
            tbComments.Text = wpsr.comments;
            tbWorkAccomplished.Text = wpsr.workAccomplished;
            tbWorkPlannedNext.Text = wpsr.workPlannedNext;
            tbProblemsEncountered.Text = wpsr.problemsEncountered;
            tbProblemsAncticipatedNext.Text = wpsr.problemsAnticipated;
        }

        lblResults.Visible = false;
        divReportData.Visible = true;

    }

    private void createNewReport() {

    }


    private double getPMBudget(int projId, String wpId) {
        var qry = (from wp in ffdb.WorkPackages
                   where (wp.projId == projId) && wp.wpId.Equals(wpId)
                   select wp).FirstOrDefault();
        return (Double)(qry.unallocated_dollars + qry.allocated_dollars);
    }

    private double getREBudget(int projId, String wpId) {
        var qry = (from wp in ffdb.WorkPackages
                   where (wp.projId == projId) && wp.wpId.Equals(wpId)
                   select wp).FirstOrDefault();
        return (Double)(qry.unallocated_dollars + qry.allocated_dollars);
    }



    private WorkPackageStatusReport getExistingReportDetails(int projId, String wpId, DateTime start, DateTime end) {
        WorkPackageStatusReport wpsr = (from sr in ffdb.WorkPackageStatusReports
                                where sr.endDate.Equals(end)
                                        && sr.startDate.Equals(start)
                                        && (sr.projId == projId)
                                        && (sr.wpId == wpId)
                                select sr).FirstOrDefault();
        
        return wpsr;
    }

    private List<KeyValuePair<int, double>> getAcwpForAll(int projId, String wpId, DateTime start, DateTime end) {
        var qry = from t in ffdb.TimesheetEntries
                    where (t.projId == projId)
                            && (t.wpId == wpId)
                            && (t.tsDate >= start)
                            && (t.tsDate <= end)
                    group t by new { t.projId, t.wpId, ID = t.empId } into g
                    select new {
                        empId = g.Key.ID,
                        hours = (double)g.Sum(s => (s.mon + s.tue + s.wed + s.thu + s.fri + s.sat + s.sun))
                    };
        List<KeyValuePair<int, double>> listAcwp = new List<KeyValuePair<int, double>>();
        foreach (var acwp in qry) {
            listAcwp.Add(new KeyValuePair<int, double>(acwp.empId, acwp.hours));
        }
        return listAcwp;
    }

    private List<EmployeeWorkPackageETC> getEtcForAll(int projId, String wpId, DateTime start, DateTime end) {
        var qry = from etc in ffdb.EmployeeWorkPackageETCs
                   where (etc.projId == projId)
                           && (etc.wpId == wpId)
                           && (etc.dateUpdated >= start)
                           && (etc.dateUpdated <= end)
                           && (etc.dateUpdated ==
                                   (from du in ffdb.EmployeeWorkPackageETCs
                                    select du.dateUpdated).Max())
                    select etc;

        List<EmployeeWorkPackageETC> listEtc = new List<EmployeeWorkPackageETC>();
        foreach (var etc in qry) {
            listEtc.Add(etc);
        }
        return listEtc;
    }

    private String getAcwpForEmployee(int empId, List<KeyValuePair<int, double>> list) {
        String s = (from afa in list
                    where afa.Key == empId
                    select afa.Value).FirstOrDefault().ToString();
        if (s == null || s.Equals("")) {
            s = "0";
        }
        return s;
    }

    private String getEtcForEmployee(int empId, List<EmployeeWorkPackageETC> list) {
       String s = (from afa in list
                  where afa.empId == empId
                  select afa.ETC_days).FirstOrDefault().ToString();
       if (s == null || s.Equals("")) {
           s = "Unknown";
       }
       return s;
    }

    private String getEacForEmployee(String empEtc, String empAcwp) {
        double etc = 0;
        double acwp = 0;

        if (!empEtc.Equals("Unknown")) {
            return "Unknown";
        }

        if (!empAcwp.Equals("Unknown")) {
            acwp = Convert.ToDouble(empAcwp);
        }

        return (etc + acwp).ToString();
    }

    private Double calculateEstimate(String empAcwp, String empEtc, String empEac, Boolean calculateEac) {
        double acwp = 0;
        double etc = 0;
        double eac = 0;

        if (!empAcwp.Equals("Unknown")) {
            acwp = Convert.ToDouble(empAcwp);
        }

        if (!empEac.Equals("Unknown")) {
            eac = Convert.ToDouble(empEac);
        }

        if (!empEtc.Equals("Unknown")) {
            etc = Convert.ToDouble(empEtc);
        }

        if (calculateEac) {
            return acwp + etc;
        } else {
            return eac - acwp;
        }
    }
    
    private String getPercentComplete(String empAcwp, String empEac) {
        double acwp = 0;
        double eac = 0;

        if (!empAcwp.Equals("Unknown")) {
            acwp = Convert.ToDouble(empAcwp);
        }

        if (!empEac.Equals("Unknown")) {
            eac = Convert.ToDouble(empEac);
            return ((acwp / eac) * 100).ToString();
        }
        else {
            return "Unknown";
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e) {
        DateTime periodStart = Convert.ToDateTime(tbPeriodStart.Text);
        DateTime periodEnd = Convert.ToDateTime(tbPeriodEnd.Text);
        int projId = Convert.ToInt16(ddlAllProjects.SelectedValue);
        GetWorkPackageStatusReport(projId, ddlWorkpackages.SelectedValue, periodStart, periodEnd);
    }

    protected void btnNewReport_Click(object sender, EventArgs e) {
        DateTime periodStart = Convert.ToDateTime(tbPeriodStart.Text);
        DateTime periodEnd = Convert.ToDateTime(tbPeriodEnd.Text);
        int projId = Convert.ToInt16(ddlAllProjects.SelectedValue);
        GetWorkPackageStatusReport(projId, ddlWorkpackages.SelectedValue, periodStart, periodEnd);
    }

    protected void gvStatus_RowEditing(object sender, GridViewEditEventArgs e) {
        gvStatus.EditIndex = e.NewEditIndex;
        gvStatus.DataBind();
    }

    protected void gvStatus_RowUpdated(object sender, GridViewUpdatedEventArgs e) {
        // handle row updated
    }

    protected void gvStatus_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e) {
        gvStatus.EditIndex = -1;
        gvStatus.DataBind();
    }

    protected void gvStatus_RowCommand(object sender, GridViewCommandEventArgs e) {
        // handle row command
    }

    protected void btnSave_Click(object sender, EventArgs e) {
        if (Page.IsValid) {
            lblResults.Text = "";
            lblResults.Visible = true;
            DateTime start = Convert.ToDateTime(tbPeriodStart.Text);
            DateTime end = Convert.ToDateTime(tbPeriodEnd.Text);
            int projId = Convert.ToInt16(ddlAllProjects.SelectedValue);

            var report = (from sr in ffdb.WorkPackageStatusReports
                          where sr.endDate.Equals(end)
                              && sr.startDate.Equals(start)
                              && (sr.projId == projId)
                              && (sr.wpId.Equals(ddlWorkpackages.SelectedValue))
                          select sr).SingleOrDefault();
            if (report == null) {
                lblResults.Text += "No report found!\n";
                wpsr = new WorkPackageStatusReport();
                wpsr.startDate = Convert.ToDateTime(tbPeriodStart.Text);
                wpsr.endDate = Convert.ToDateTime(tbPeriodEnd.Text);
                wpsr.comments = tbComments.Text;
                wpsr.workAccomplished = tbWorkAccomplished.Text;
                wpsr.workPlannedNext = tbWorkPlannedNext.Text;
                wpsr.problemsEncountered = tbProblemsEncountered.Text;
                wpsr.problemsAnticipated = tbProblemsAncticipatedNext.Text;
                ffdb.WorkPackageStatusReports.InsertOnSubmit(wpsr);
                try {
                    ffdb.SubmitChanges();
                }
                catch (Exception ex) {
                    lblResults.Text += "Unable to save report at this time.";
                }
 
            } else {
                report.comments = tbComments.Text;
                report.workAccomplished = tbWorkAccomplished.Text;
                report.workPlannedNext = tbWorkPlannedNext.Text;
                report.problemsEncountered = tbProblemsEncountered.Text;
                report.problemsAnticipated = tbProblemsAncticipatedNext.Text;
                try {
                    ffdb.SubmitChanges();
                }
                catch (Exception ex) {
                    lblResults.Text += "Unable to save report at this time.";
                }
 
            }

            
            lblResults.Text += "Is read only? " + ffdb.WorkPackageStatusReports.IsReadOnly;
            
                   }
    }
}