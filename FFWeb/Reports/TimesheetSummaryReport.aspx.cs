using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using FFLib;

public partial class Reports_TimesheetSummaryReport : System.Web.UI.Page
{
    FlyingFishClassesDataContext ffdb = new FlyingFishClassesDataContext();

    protected void Page_Load(object sender, EventArgs e)
    {
        //this.GetTimesheetSummaryReport(4911, new DateTime(2011, 2, 8));
        ddlAllProjects.DataSource = ffdb.Projects.Select(p => new {
            ProjID = p.projId,
            ProjectName = (p.projName + " (") + p.projId + ")"
        });
        ddlAllProjects.DataValueField = "ProjId";
        ddlAllProjects.DataTextField = "ProjectName";
        ddlAllProjects.DataBind();
    }

    public void GetTimesheetSummaryReport(int projId, DateTime dateFor) {
        

        //http://odetocode.com/blogs/scott/archive/2007/09/24/nested-selects-in-linq-to-sql.aspx
        
        // ONLY GET APPROVED TSs **********

        var qry = from tse in ffdb.TimesheetEntries
                  join emp in ffdb.Employees on tse.empId equals emp.empId
                  join proj in ffdb.Projects on tse.projId equals proj.projId
                  join wp in ffdb.WorkPackages on tse.wpId equals wp.wpId
                  orderby tse.projId, tse.wpId, tse.empId
                  select new {
                      WorkPackage = wp.name,
                      Employee = emp.firstName + " " + emp.lastName + " (" + emp.empId + ")",
                      Week1 = (double?)
                              (from w1 in ffdb.TimesheetEntries
                               where (w1.empId == tse.empId) && w1.tsDate >= dateFor.AddDays(-7) && w1.tsDate <= dateFor
                               select new {
                                   sum = (w1.mon + w1.tue + w1.wed + w1.thu + w1.fri + w1.sat + w1.sun)
                               }).First().sum,
                      Week2 = (double?)
                              (from w1 in ffdb.TimesheetEntries
                               where (w1.empId == tse.empId) && w1.tsDate >= dateFor.AddDays(-14) && w1.tsDate <= dateFor.AddDays(-7)
                               select new {
                                   sum = (w1.mon + w1.tue + w1.wed + w1.thu + w1.fri + w1.sat + w1.sun)
                               }).First().sum,
                      Week3 = (double?)
                              (from w1 in ffdb.TimesheetEntries
                               where (w1.empId == tse.empId) && w1.tsDate >= dateFor.AddDays(-21) && w1.tsDate <= dateFor.AddDays(-14)
                               select new {
                                   sum = (w1.mon + w1.tue + w1.wed + w1.thu + w1.fri + w1.sat + w1.sun)
                               }).First().sum,
                      Week4 = (double?)
                              (from w1 in ffdb.TimesheetEntries
                               where (w1.empId == tse.empId) && w1.tsDate >= dateFor.AddDays(-28) && w1.tsDate <= dateFor.AddDays(-21)
                               select new {
                                   sum = (w1.mon + w1.tue + w1.wed + w1.thu + w1.fri + w1.sat + w1.sun)
                               }).First().sum,
                      Month1 = (double?)
                               (from w1 in ffdb.TimesheetEntries
                               where (w1.empId == tse.empId) && w1.tsDate.Month == dateFor.Month
                               select new {
                                   sum = (w1.mon + w1.tue + w1.wed + w1.thu + w1.fri + w1.sat + w1.sun)
                               }).First().sum,
                      Month2 = (double?)
                               (from w1 in ffdb.TimesheetEntries
                                where (w1.empId == tse.empId) && w1.tsDate.Month == dateFor.AddMonths(-1).Month
                                select new {
                                    sum = (w1.mon + w1.tue + w1.wed + w1.thu + w1.fri + w1.sat + w1.sun)
                                }).First().sum,
                      Month3 = (double?)
                               (from w1 in ffdb.TimesheetEntries
                                where (w1.empId == tse.empId) && w1.tsDate.Month == dateFor.AddMonths(-2).Month
                                select new {
                                    sum = (w1.mon + w1.tue + w1.wed + w1.thu + w1.fri + w1.sat + w1.sun)
                                }).First().sum,
                      Month4 = (double?)
                               (from w1 in ffdb.TimesheetEntries
                                where (w1.empId == tse.empId) && w1.tsDate.Month == dateFor.AddMonths(-3).Month
                                select new {
                                    sum = (w1.mon + w1.tue + w1.wed + w1.thu + w1.fri + w1.sat + w1.sun)
                                }).First().sum
                  };

        gvSummary.DataSource = qry;
        gvSummary.DataBind();

        gvSummary.HeaderRow.Cells[0].Text = "Work Package";
        gvSummary.HeaderRow.Cells[1].Text = "Employee";
        // week 1
        gvSummary.HeaderRow.Cells[2].Text = dateFor.ToString("MMM dd");
        // week 2
        gvSummary.HeaderRow.Cells[3].Text = dateFor.AddDays(-7).ToString("MMM dd");
        // week 3
        gvSummary.HeaderRow.Cells[4].Text = dateFor.AddDays(-14).ToString("MMM dd");
        // week 4
        gvSummary.HeaderRow.Cells[5].Text = dateFor.AddDays(-21).ToString("MMM dd");
        // month 1
        gvSummary.HeaderRow.Cells[6].Text = dateFor.ToString("MMM");
        // month 2
        gvSummary.HeaderRow.Cells[7].Text = dateFor.AddMonths(-1).ToString("MMM");
        // month 3
        gvSummary.HeaderRow.Cells[8].Text = dateFor.AddMonths(-2).ToString("MMM");
        // month 4
        gvSummary.HeaderRow.Cells[9].Text = dateFor.AddMonths(-3).ToString("MMM");

        // gvSummary.EmptyDataText = "-"; // does not work
    }
    protected void btnSubmit_Click(object sender, EventArgs e) {
        this.GetTimesheetSummaryReport(Convert.ToInt16(ddlAllProjects.SelectedValue), Convert.ToDateTime(tbForDate.Text));
    }
}