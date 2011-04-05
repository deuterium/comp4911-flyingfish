using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using FFLib;
using System.Data;
using System.Text.RegularExpressions;

/* TO DO:
 * Calculate PDays and PDollars
 * Turns hours into Days
 * Create functionality
 * Improve look/layout
 * Restrict project choices to all projects (for HR) and only projects you manage (PMs)
 * Documentation
 * Validation with better user messages
 */

/// <summary>
/// 
/// </summary>
public partial class Reports_WorkpackageStatusReport : System.Web.UI.Page {
    FlyingFishClassesDataContext ffdb = new FlyingFishClassesDataContext();
    public const String EmptyCellText = "Unknown";

    protected void Page_Load(object sender, EventArgs e) {
        if (!IsPostBack) {
            populateProjects();
            populateWorkpackages();
        }
        
        // for testing purposes only, so I don't have to fill out the form every time
        // ViewState["projId"] = 4911;
        // ViewState["wpId"] = "1";
        // ViewState["startDate"] = "2011/01/01";
        // ViewState["endDate"] = "2011/03/01";
        //GetWorkPackageStatusReport();
    }

    private void populateProjects() {
        ddlAllProjects.DataSource = ffdb.Projects.Select(p => new {
            ProjID = p.projId,
            ProjectName = p.projName + " (" + p.projId + ")"
        });
        ddlAllProjects.DataValueField = "ProjId";
        ddlAllProjects.DataTextField = "ProjectName";
        ddlAllProjects.DataBind();
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

    public void test() {
        lblResults.Text += (Convert.ToInt16(ViewState["projId"]).ToString()) + "<br />";
        lblResults.Text += (ViewState["wpId"]).ToString() + "<br />";
        lblResults.Text += ((DateTime)ViewState["startDate"]).ToString() + "<br />";
        lblResults.Text += ((DateTime)ViewState["endDate"]).ToString() + "<br />";
    }

    // NEED DAYS! NOT HOURS! DIVIDE IT BY 8!!!

    public void GetWorkPackageStatusReport() {
        // Find out how much work each employee has done on the work package
        // Calculate the PDays and PDollar value of this work
        // Calculate the EAC from the ACWP and ETC
        // Calculate the percent complete
        // Calculate the total

        List<KeyValuePair<int, double>> acwpForAll = getAcwpForAll();
        List<EmployeeWorkPackageETC> etcForAll = getEtcForAll();
        
        // logic needs to factor in plevels per timesheet (in case change, can't use bulk)

        var qry = from tse in ffdb.TimesheetEntries
                  join proj in ffdb.Projects on tse.projId equals proj.projId
                  join wp in ffdb.WorkPackages on (tse.projId + tse.wpId) equals (wp.projId + wp.wpId)
                  join emp in ffdb.Employees on tse.empId equals emp.empId
                  join wpre in ffdb.WorkPackageResponsibleEngineers on (tse.projId + tse.wpId) equals (wpre.projId + wpre.wpId)
                  join re in ffdb.Employees on wpre.responsibleEngineer equals re.empId
                  join pm in ffdb.Employees on proj.manager equals pm.empId
                  orderby tse.projId, tse.wpId, tse.empId
                  where (tse.tsDate >= (DateTime)ViewState["startDate"]) && (tse.tsDate <= (DateTime)ViewState["endDate"])
                        && (tse.projId == Convert.ToInt16(ViewState["projId"])) && (tse.wpId.Equals(ViewState["wpId"]))
                  select new {
                      Proj = proj,
                      PM = pm,
                      WP = wp,
                      WPRE = wpre,
                      RE = re,
                      Emp = emp.firstName + " " + emp.lastName + " (" + emp.empId + ")",
                      ACWP = getAcwpForEmployee(tse.empId, acwpForAll),
                      ETC = getEtcForEmployee(tse.empId, etcForAll),
                      EAC = getEacForEmployee(getEtcForEmployee(tse.empId, etcForAll), getAcwpForEmployee(tse.empId, acwpForAll)),
                      PercentComplete = getPercentComplete( (getAcwpForEmployee(tse.empId, acwpForAll)),
                                                            (getEacForEmployee(getEtcForEmployee(tse.empId, etcForAll),
                                                                getAcwpForEmployee(tse.empId, acwpForAll))) ).ToString()
                      
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
            DataRow drDays = dt.NewRow();
            drDays["Employee"] = row.Emp;
            drDays["ACWP"] = row.ACWP;
            drDays["ETC"] = row.ETC;
            drDays["EAC"] = row.EAC;
            drDays["PercentComplete"] = row.PercentComplete;
            dt.Rows.Add(drDays);
            //DataRow drDollars = dt.NewRow();
            //drDollars["Employee"] = row.Emp;
            //drDollars["ACWP"] = row.ACWP;
            //drDollars["ETC"] = row.ETC;
            //drDollars["EAC"] = row.EAC;
            //drDollars["PercentComplete"] = row.PercentComplete;
            //dt.Rows.Add(drDollars);
        }

        gvStatus.DataSource = dt;
        gvStatus.DataBind();

        var q = qry.FirstOrDefault();

        lblWp.Text = q.WP.name + " (" + q.WP.wpId + ")";
        lblRe.Text = q.RE.firstName + " " + q.RE.lastName + " (" + q.RE.empId + ")";
        lblPm.Text = q.PM.firstName + " " + q.PM.lastName + " (" + q.PM.empId + ")";
        lblReportPeriod.Text = ((DateTime)ViewState["startDate"]).ToString("yyyy/MM/dd")
            + " to " + ((DateTime)ViewState["endDate"]).ToString("yyyy/MM/dd");
        lblPmBac.Text = this.getPMBudget().ToString();

        double reBAC = 0;

        foreach (var item in qry) {
            if (!(item.EAC.Equals(EmptyCellText))) {
                reBAC += Convert.ToDouble(item.EAC);
            }
        }
        
        lblReBac.Text = reBAC.ToString();
        if (reBAC == 0) {
            lblReBac.Text = EmptyCellText;
        }
        
        double totalAcwp = 0;

        foreach (var item in qry) {
            if (!(item.ACWP.Equals(EmptyCellText))) {
                totalAcwp += Convert.ToDouble(item.ACWP);
            }
        }


        lblTotalAcwp.Text = totalAcwp.ToString() + " hours";
        if (totalAcwp == 0) {
            lblTotalAcwp.Text = EmptyCellText;
        }

        WorkPackageStatusReport wpsr = getExistingReportDetails();
        ViewState["isNewReport"] = false;

        if (wpsr == null) {
            tbComments.Text = "";
            tbWorkAccomplished.Text = "";
            tbWorkPlannedNext.Text = "";
            tbProblemsEncountered.Text = "";
            tbProblemsAncticipatedNext.Text = "";
            ViewState["isNewReport"] = true;
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

    private void getPLevelRate(int empId, DateTime periodStart, DateTime periodEnd) {
        // determine if their plevel has changed within the reporting period

        // if no, load one value

        // if yes, find calculate total owed
        
        // get the most recent date before the plevel
        var qry = from empPlvl in ffdb.EmployeePersonLevels
                  join plvl in ffdb.PersonLevels on empPlvl.fiscalYear equals plvl.fiscalYear
                  where empPlvl.dateUpdated <= periodEnd && empPlvl.empId == empId
                  select new { empPlvl.pLevel, plvl.rate };

        if (qry.Count() > 1) {
            // handle multiples
        }

        //return qry.FirstOrDefault().pLevel;
    }

    private double getPMBudget() {
        var qry = (from wp in ffdb.WorkPackages
                   where (wp.projId == (Convert.ToInt16(ViewState["projId"]))) && wp.wpId.Equals(ViewState["wpId"])
                   select wp).FirstOrDefault();
        return (Double)(qry.unallocated_dollars + qry.allocated_dollars);
    }

    private double getREBudget() {
        var qry = (from wp in ffdb.WorkPackages
                   where (wp.projId == (Convert.ToInt16(ViewState["projId"]))) && wp.wpId.Equals(ViewState["wpId"])
                   select wp).FirstOrDefault();
        return (Double)(qry.unallocated_dollars + qry.allocated_dollars);
    }



    private WorkPackageStatusReport getExistingReportDetails() {
        WorkPackageStatusReport wpsr = (from sr in ffdb.WorkPackageStatusReports
                                        where sr.endDate.Equals((DateTime)ViewState["endDate"])
                                            && sr.startDate.Equals((DateTime)ViewState["startDate"])
                                            && (sr.projId == (Convert.ToInt16(ViewState["projId"])))
                                            && (sr.wpId.Equals(ViewState["wpId"]))
                                        select sr).FirstOrDefault();
        
        return wpsr;
    }

    private List<KeyValuePair<int, double>> getAcwpForAll() {
        var qry = from t in ffdb.TimesheetEntries
                  where (t.projId == (Convert.ToInt16(ViewState["projId"])))
                            && (t.wpId.Equals(ViewState["wpId"]))
                            && (t.tsDate >= ((DateTime)ViewState["startDate"]))
                            && (t.tsDate <= ((DateTime)ViewState["endDate"]))
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

    private List<EmployeeWorkPackageETC> getEtcForAll() {
        var qry = from etc in ffdb.EmployeeWorkPackageETCs
                  where (etc.projId == (Convert.ToInt16(ViewState["projId"])))
                           && (etc.wpId.Equals(ViewState["wpId"]))
                           && (etc.dateUpdated >= ((DateTime)ViewState["startDate"]))
                           && (etc.dateUpdated <= ((DateTime)ViewState["endDate"]))
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
           s = EmptyCellText;
       }
       return s;
    }
    
    private String getEacForEmployee(String empEtc, String empAcwp) {
        double etc = 0;
        double acwp = 0;
        double eac = 0;

        if (empEtc.Equals(EmptyCellText)) {
            return EmptyCellText;
        }

        if (empAcwp.Equals(EmptyCellText) || empAcwp == null) {
            return EmptyCellText;
        }
        
        acwp = Convert.ToDouble(empAcwp);
        etc = Convert.ToDouble(empEtc);
        eac = etc + acwp;
        
        return eac.ToString();
    }

    private Double calculateEstimate(String empAcwp, String empEtc, String empEac, Boolean calculateEac) {
        double acwp = 0;
        double etc = 0;
        double eac = 0;

        if (!empAcwp.Equals(EmptyCellText)) {
            acwp = Convert.ToDouble(empAcwp);
        }

        if (!empEac.Equals(EmptyCellText)) {
            eac = Convert.ToDouble(empEac);
        }

        if (!empEtc.Equals(EmptyCellText)) {
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
        double pc = 0;

        if (!empAcwp.Equals(EmptyCellText)) {
            acwp = Convert.ToDouble(empAcwp);
        }

        if (empEac.Equals(EmptyCellText)) {
            return EmptyCellText;
        }

        eac = Convert.ToDouble(empEac);

        pc = (acwp / eac) * 100;
        pc = Math.Round(pc, 1);
        
        return pc.ToString();
    }

    protected void btnSubmit_Click(object sender, EventArgs e) {
        ViewState["projId"] = Convert.ToInt16(ddlAllProjects.SelectedValue);
        ViewState["wpId"] = ddlWorkpackages.SelectedValue;
        ViewState["startDate"] = Convert.ToDateTime(tbPeriodStart.Text);
        ViewState["endDate"] = Convert.ToDateTime(tbPeriodEnd.Text);
        GetWorkPackageStatusReport();
    }

    protected void btnNewReport_Click(object sender, EventArgs e) {
        ViewState["projId"] = Convert.ToInt16(ddlAllProjects.SelectedValue);
        ViewState["wpId"] = ddlWorkpackages.SelectedValue;
        ViewState["startDate"] = Convert.ToDateTime(tbPeriodStart.Text);
        ViewState["endDate"] = Convert.ToDateTime(tbPeriodEnd.Text);
        GetWorkPackageStatusReport();
    }

    protected void gvStatus_RowEditing(object sender, GridViewEditEventArgs e) {
        gvStatus.EditIndex = e.NewEditIndex;
        GetWorkPackageStatusReport();
    }

    private void UpdateETC(String strEtc, String strEac, double acwp, EmployeeWorkPackageETC empWpEtc) {
        double etc = 0;
        double eac = 0;
        
        if (!strEtc.Equals(EmptyCellText)) {
            try {
                etc = Convert.ToDouble(strEtc);
                if (etc <= 0) {
                    strEtc = EmptyCellText;
                }
            }
            catch (Exception ex) {
                strEtc = EmptyCellText;
            }
        }

        if (!strEac.Equals(EmptyCellText)) {
            try {
                eac = Convert.ToDouble(strEac);
                if (eac <= 0) {
                    strEac = EmptyCellText;
                }
                if (eac < (etc + acwp)) {
                    strEac = EmptyCellText;
                }
            }
            catch (Exception ex) {
                strEac = EmptyCellText;
            }
        }

        // Calculate missing value
        if (strEac.Equals(EmptyCellText)) {
            if (strEtc.Equals(EmptyCellText)) {
                empWpEtc.ETC_days = null;
            }
            else {
                etc = Convert.ToDouble(strEtc);
                empWpEtc.ETC_days = (int)(etc);
            }
        }
        else {
            eac = Convert.ToDouble(strEac);
            empWpEtc.ETC_days = (int)(eac - acwp);
        }
        
        ffdb.SubmitChanges();
    }

    protected void gvStatus_RowUpdating(object sender, GridViewUpdateEventArgs e) {
        GridViewRow row = gvStatus.Rows[e.RowIndex];
        int empId = extractEmpId(((Label)row.Cells[0].Controls[1]).Text);

        EmployeeWorkPackageETC empWpEtc = (from ewetc in ffdb.EmployeeWorkPackageETCs
                                           where ewetc.empId == empId
                                                && ewetc.dateUpdated.Equals(Convert.ToDateTime(ViewState["endDate"]))
                                           select ewetc).FirstOrDefault();

        String strEtc = e.NewValues["ETC"].ToString();
        String strEac = e.NewValues["EAC"].ToString();
        String strAcwp = ((Label)row.Cells[1].Controls[1]).Text;
        double acwp = Convert.ToDouble(strAcwp);
        double etc = 0;
        double eac = 0;

        if (strEtc == null) {
            strEtc = EmptyCellText;
        }

        if (strEac == null) {
            strEac = EmptyCellText;
        }
        
        // If no current ETC, create one and exit update
        if (empWpEtc != null) {
            UpdateETC(strEtc, strEac, acwp, empWpEtc);
            gvStatus.EditIndex = -1;
            e.Cancel = true;
            GetWorkPackageStatusReport();
            return;
        } else {
            empWpEtc = new EmployeeWorkPackageETC();
        }

        if (!strEtc.Equals(EmptyCellText)) {
            try {
                etc = Convert.ToDouble(strEtc);
                if (etc <= 0) {
                    strEtc = EmptyCellText;
                }
            } catch (Exception ex) {
                strEtc = EmptyCellText;
            }
        }

        if (!strEac.Equals(EmptyCellText)) {
            try {
                eac = Convert.ToDouble(strEac);
                if (eac <= 0) {
                    strEac = EmptyCellText;
                }
                if (eac < (etc + acwp)) {
                    strEac = EmptyCellText;
                }
            } catch (Exception ex) {
                strEac = EmptyCellText;
            }
        }

        // Calculate missing value
        if (strEac.Equals(EmptyCellText)) {
            if (strEtc.Equals(EmptyCellText)) {
                empWpEtc.ETC_days = null;
            } else {
                etc = Convert.ToDouble(strEtc);
                empWpEtc.ETC_days = (int)(etc);
            }
        } else {
            eac = Convert.ToDouble(strEac);
            empWpEtc.ETC_days = (int)(eac - acwp);
        }

        empWpEtc.empId = empId;
        empWpEtc.projId = Convert.ToInt16(ViewState["projId"]);
        empWpEtc.wpId = (String)ViewState["wpId"];
        
        if (DateTime.Now <= Convert.ToDateTime(ViewState["endDate"])) {
            empWpEtc.dateUpdated = DateTime.Now;
        } else {
            empWpEtc.dateUpdated = Convert.ToDateTime(ViewState["endDate"]);
        }

        ffdb.EmployeeWorkPackageETCs.InsertOnSubmit(empWpEtc);
        ffdb.SubmitChanges();

        gvStatus.EditIndex = -1;
        e.Cancel = true;
        GetWorkPackageStatusReport();
        
    }

    private int extractEmpId(String emp) {
        int empId = -1;
        String[] tokens = Regex.Split(emp, " "); 
        String strEmpId = tokens[2].TrimEnd(')').TrimStart('(');
        try {
            empId = Convert.ToInt16(strEmpId);
        }
        catch (Exception e) {
            return -1;
        }
        return empId;
            
    }

    protected void gvStatus_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e) {
        gvStatus.EditIndex = -1;
        GetWorkPackageStatusReport();
    }

    protected void gvStatus_RowCommand(object sender, GridViewCommandEventArgs e) {
        GetWorkPackageStatusReport();
    }

    protected void btnSave_Click(object sender, EventArgs e) {
        if (Page.IsValid) {
            lblResults.Text = "";
            lblResults.Visible = true;
            Boolean isNewReport = false;
            
            WorkPackageStatusReport wpsr = getExistingReportDetails();

            if (wpsr == null) {
                wpsr = new WorkPackageStatusReport();
                wpsr.projId = Convert.ToInt16(ViewState["projId"]);
                wpsr.wpId = ddlWorkpackages.SelectedValue;
                wpsr.startDate = Convert.ToDateTime(ViewState["startDate"]);
                wpsr.endDate = Convert.ToDateTime(ViewState["endDate"]);
                isNewReport = true;
            }

            wpsr.comments = tbComments.Text;
            wpsr.workAccomplished = tbWorkAccomplished.Text;
            wpsr.workPlannedNext = tbWorkPlannedNext.Text;
            wpsr.problemsEncountered = tbProblemsEncountered.Text;
            wpsr.problemsAnticipated = tbProblemsAncticipatedNext.Text;

            if (isNewReport) {
                ffdb.WorkPackageStatusReports.InsertOnSubmit(wpsr);
            }

            try {
                ffdb.SubmitChanges();
                lblResults.ForeColor = System.Drawing.Color.Green;
                lblResults.Text = "Report successfully saved!<br />";
            }
            catch (Exception ex) {
                lblResults.ForeColor = System.Drawing.Color.Red;
                lblResults.Text = "Unable to save report at this time.<br />";
                Trace.Write(ex.Message);
            }

        }
    }
}