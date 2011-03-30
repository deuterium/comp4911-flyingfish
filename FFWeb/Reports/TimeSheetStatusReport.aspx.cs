using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using FFLib;

/* TO DO:
 * Validators
 * Persist data (Add new entries)
 * Finish getting data/doing calcs
 */

public partial class Reports_TimeSheetStatusReport : System.Web.UI.Page {
    FlyingFishClassesDataContext ffdb = new FlyingFishClassesDataContext();
    WorkPackageStatusReport wpsr;
    WorkPackageResponsibleEngineer wpre;

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
            ProjectName = (p.projName + " (") + p.projId + ")"
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
                                       WpName = wp.name + "(" + wp.wpId + ")"
                                   });
        ddlWorkpackages.DataValueField = "WpId";
        ddlWorkpackages.DataTextField = "WpName";
        ddlWorkpackages.DataBind();
    }

    protected void ddlAllProjects_SelectedIndexChanged(object sender, EventArgs e) {
        populateWorkpackages();
    }

    public void GetWorkPackageStatusReport(int projId, String wpId, DateTime start, DateTime end) {
        // Find out how much work each employee has done on the work package
        // Calculate the PDays and PDollar value of this work
        // Calculate the EAC from the ACWP and ETC
        // Calculate the percent complete
        // Calculate the total

        var acwpForAll = from t in ffdb.TimesheetEntries
                         where (t.projId == projId)
                                 && (t.wpId == wpId)
                                 && (t.tsDate >= start)
                                 && (t.tsDate <= end)
                         group t by new { t.projId, t.wpId, ID = t.empId } into g
                         select new {
                             empId = g.Key.ID,
                             hours = (double)g.Sum(s => (s.mon + s.tue + s.wed + s.thu + s.fri + s.sat + s.sun))
                         };

        // restrict date to within reporting period
        var etcForAll = from etc in ffdb.EmployeeWorkPackageETCs
                        where (etc.projId == projId)
                                && (etc.wpId == wpId)
                                && (etc.dateUpdated ==
                                        (from du in ffdb.EmployeeWorkPackageETCs
                                         select du.dateUpdated).Max())
                        select new {
                            empId = etc.empId,
                            days = (double)etc.ETC_days.GetValueOrDefault(0)
                        };

        var qry = from tse in ffdb.TimesheetEntries
                  join emp in ffdb.Employees on tse.empId equals emp.empId
                  join proj in ffdb.Projects on tse.projId equals proj.projId
                  join wp in ffdb.WorkPackages on tse.wpId equals wp.wpId
                  orderby tse.projId, tse.wpId, tse.empId
                  where (tse.tsDate >= start) && (tse.tsDate <= end)
                  select new {
                      Emp = emp.firstName + " " + emp.lastName + " (" + emp.empId + ")",
                      ACWP = ((double?)
                             (from afa in acwpForAll
                              where afa.empId == tse.empId
                              select afa.hours).FirstOrDefault()).GetValueOrDefault(),
                      // get last estimate before this report ends
                      ETC = ((double?)
                             (from efa in etcForAll
                              where efa.empId == tse.empId
                              select efa.days).FirstOrDefault()).GetValueOrDefault(),
                      EAC = (((double?)
                            (from afa in acwpForAll
                             where afa.empId == tse.empId
                             select afa.hours).FirstOrDefault()).GetValueOrDefault()
                             +
                             ((double?)
                             (from efa in etcForAll
                              where efa.empId == tse.empId
                              select efa.days).FirstOrDefault()).GetValueOrDefault()),
                      Complete = // ACWP
                            (((double?)
                             (from afa in acwpForAll
                              where afa.empId == tse.empId
                              select afa.hours).FirstOrDefault()).GetValueOrDefault()
                             /
                          // EAC
                            (((double?)
                            (from afa in acwpForAll
                             where afa.empId == tse.empId
                             select afa.hours).FirstOrDefault()).GetValueOrDefault()
                             +
                             ((double?)
                             (from efa in etcForAll
                              where efa.empId == tse.empId
                              select efa.days).FirstOrDefault()).GetValueOrDefault()))
                              * 100,
                      Project = proj
                  };

        gvStatus.DataSource = qry;
        gvStatus.DataBind();

        wpsr = (from sr in ffdb.WorkPackageStatusReports
                where (sr.reportDate <= end)
                            && (sr.projId == projId)
                            && (sr.wpId == wpId)
                select sr).First();

        wpre = (from re in ffdb.WorkPackageResponsibleEngineers
                where (projId == wpsr.projId && wpId == wpsr.wpId)
                select re).First();

        lblWpId.Text = wpsr.wpId;
        lblWpName.Text = wpsr.WorkPackage.name;
        lblRe.Text = wpre.EmployeeWorkPackage.EmployeeProject.Employee.firstName
                        + " " + wpre.EmployeeWorkPackage.EmployeeProject.Employee.lastName
                        + " (" + wpre.responsibleEngineer + ")";
        lblPm.Text = qry.First().Project.Employee.firstName
                        + " " + qry.First().Project.Employee.lastName
                        + " (" + qry.First().Project.manager + ")";
        lblReportNo.Text = "Unavailabile";
        lblReportPeriod.Text = "";
        lblPmBac.Text = "NULL";
        lblReBac.Text = "NULL";
        lblTotalAcwp.Text = "NULL";

        tbComments.Text = wpsr.comments;
        tbWorkAccomplished.Text = wpsr.workAccomplished;
        tbWorkPlannedNext.Text = wpsr.workPlannedNext;
        tbProblemsEncountered.Text = wpsr.problemsEncountered;
        tbProblemsAncticipatedNext.Text = wpsr.problemsAnticipated;

    }
    protected void btnSubmit_Click(object sender, EventArgs e) {
        DateTime periodStart = Convert.ToDateTime(tbPeriodStart.Text);
        DateTime periodEnd = Convert.ToDateTime(tbPeriodEnd.Text);
        int projId = Convert.ToInt16(ddlWorkpackages.SelectedValue);
        GetWorkPackageStatusReport(projId, ddlWorkpackages.SelectedValue, periodStart, periodEnd);
    }
}