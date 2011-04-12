using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

/// <summary>
/// Code behind for teh TimesheetSummaryReport.
/// Dynamically populates the Projects DropDownList.
/// Fetches the data from the database and adds it to the page elements.
/// </summary>
public partial class Reports_TimesheetSummaryReport : System.Web.UI.Page
{
    // Database context for Object Relational Mapping.
    private static FlyingFishClassesDataContext ffdb = new FlyingFishClassesDataContext();

    /// <summary>
    /// Loads the project names and IDs into the DropDownList.
    /// </summary>
    /// <param name="sender">the object that called the event</param>
    /// <param name="e">the action event</param>
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack) {
            ddlAllProjects.DataSource = ffdb.Projects.Select(p => new {
                ProjID = p.projId,
                ProjectName = (p.projName + " (") + p.projId + ")"
            });
            ddlAllProjects.DataValueField = "ProjId";
            ddlAllProjects.DataTextField = "ProjectName";
            ddlAllProjects.DataBind();
        }
    }

    /// <summary>
    /// Fetches data from the database and populates the GridView.
    /// Gets the work done by each employee on each workpackage of 
    /// the specified project for the past 4 weeks and past 4 months.
    /// Ignores data after the specified date and only includes
    /// APPROVED timesheets.
    /// </summary>
    /// <param name="projId">The ID of the project to get data for.</param>
    /// <param name="dateFor">The last date to get data for. Data beyond this date will excluded.</param>
    public void GetTimesheetSummaryReport(int projId, DateTime dateFor) {


        /*
         * A giant database query calculates the hours worked on each workpackage by each employee of the specified project
         * for the past 4 weeks and the past 4 months, and the total hours spent on the work package.
         * The query only considers APPROVED timesheets and excludes those past the specified date.
         */
        var qry = from tse in ffdb.TimesheetEntries
                  join emp in ffdb.Employees on tse.empId equals emp.empId
                  join proj in ffdb.Projects on tse.projId equals proj.projId
                  join wp in ffdb.WorkPackages on tse.wpId equals wp.wpId
                  orderby tse.projId, tse.wpId, tse.empId
                  where tse.TimesheetHeader.status.Equals("APPROVED")
                  group tse by new { tse.projId, wp, emp } into g
                  select new
                  {
                      WorkPackage = g.Key.wp.name + " (" + g.Key.wp.wpId + ")",
                      Employee = g.Key.emp.firstName + " " + g.Key.emp.lastName + " (" + g.Key.emp.empId + ")",
                      Week1 = (from w1 in ffdb.TimesheetEntries
                               where (w1.empId == g.Key.emp.empId)
                                    && w1.tsDate >= dateFor.AddDays(-7)
                                    && w1.tsDate <= dateFor
                                    && (w1.projId == g.Key.projId)
                                    && (w1.wpId.Equals(g.Key.wp.wpId))
                               select w1.totalHours).FirstOrDefault(),
                      Week2 = (from w1 in ffdb.TimesheetEntries
                               where (w1.empId == g.Key.emp.empId)
                                    && w1.tsDate >= dateFor.AddDays(-14)
                                    && w1.tsDate <= dateFor.AddDays(-7)
                                    && (w1.projId == g.Key.projId)
                                    && (w1.wpId.Equals(g.Key.wp.wpId))
                               select w1.totalHours).FirstOrDefault(),
                      Week3 = (from w1 in ffdb.TimesheetEntries
                               where (w1.empId == g.Key.emp.empId)
                                    && w1.tsDate >= dateFor.AddDays(-21)
                                    && w1.tsDate <= dateFor.AddDays(-14)
                                    && (w1.projId == g.Key.projId)
                                    && (w1.wpId.Equals(g.Key.wp.wpId))
                               select w1.totalHours).FirstOrDefault(),
                      Week4 = (from w1 in ffdb.TimesheetEntries
                               where (w1.empId == g.Key.emp.empId)
                                    && w1.tsDate >= dateFor.AddDays(-28)
                                    && w1.tsDate <= dateFor.AddDays(-21)
                                    && (w1.projId == g.Key.projId)
                                    && (w1.wpId.Equals(g.Key.wp.wpId))
                               select w1.totalHours).FirstOrDefault(),
                      Month1 = (from w1 in ffdb.TimesheetEntries
                                where (w1.empId == g.Key.emp.empId)
                                    && w1.tsDate.Month == dateFor.Month
                                    && w1.tsDate.Year.Equals(dateFor.Year)
                                    && (w1.projId == g.Key.projId) && (w1.wpId.Equals(g.Key.wp.wpId))
                                select w1.totalHours).FirstOrDefault(),
                      Month2 = (from w1 in ffdb.TimesheetEntries
                                where (w1.empId == g.Key.emp.empId)
                                    && w1.tsDate.Month == dateFor.AddMonths(-1).Month
                                    && w1.tsDate.Year.Equals(dateFor.AddMonths(-1).Year)
                                    && (w1.projId == g.Key.projId)
                                    && (w1.wpId.Equals(g.Key.wp.wpId))
                                select w1.totalHours).FirstOrDefault(),
                      Month3 = (from w1 in ffdb.TimesheetEntries
                                where (w1.empId == g.Key.emp.empId)
                                    && w1.tsDate.Month.Equals(dateFor.AddMonths(-2).Month)
                                    && w1.tsDate.Year.Equals(dateFor.AddMonths(-2).Year)
                                    && (w1.projId == g.Key.projId)
                                    && (w1.wpId.Equals(g.Key.wp.wpId))
                                select w1.totalHours).FirstOrDefault(),
                      Month4 = (from w1 in ffdb.TimesheetEntries
                                where (w1.empId == g.Key.emp.empId)
                                    && w1.tsDate.Month == dateFor.AddMonths(-3).Month
                                    && w1.tsDate.Year.Equals(dateFor.AddMonths(-3).Year)
                                    && (w1.projId == g.Key.projId)
                                    && (w1.wpId.Equals(g.Key.wp.wpId))
                                select w1.totalHours).FirstOrDefault()
                      //TotalHours = (from t in ffdb.TimesheetEntries
                      //              join tsh in ffdb.TimesheetHeaders on (t.empId + t.tsDate.ToString()) equals (tsh.empId + tsh.tsDate.ToString())
                      //              where (t.tsDate <= (DateTime)ViewState["cutOffDate"])
                      //                  && (t.projId == Convert.ToInt32(ViewState["projId"]))
                      //                  && (t.wpId.Equals(ViewState["wpId"]))
                      //                  && (tsh.status.Equals("APPROVED"))
                      //                  && (t.projId == g.Key.projId) && (t.wpId.Equals(g.Key.wp.wpId))
                      //              group t by new { t.projId, t.wpId, ID = t.empId } into gp
                      //              select new {
                      //                  hours = (decimal)gp.Sum(s => (s.mon + s.tue + s.wed + s.thu + s.fri + s.sat + s.sun))
                      //              })
                  };

        // Binds the query data to the Grid View.
        gvSummary.DataSource = qry;
        gvSummary.DataBind();
        gvSummary.Visible = true;

        // Changes the Header columns of the Grid View to more informative names.
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
        //gvSummary.HeaderRow.Cells[10].Text = "Total Hours to Date";

        // gvSummary.EmptyDataText = "-"; // does not work
    }

    /// <summary>
    /// Gets the input data and puts it in the correct format.
    /// Passes the data (date and project id) to the GetTimesheetSummaryReport method.
    /// </summary>
    /// <param name="sender">Object that called the event</param>
    /// <param name="e">the action event</param>
    protected void btnSubmit_Click(object sender, EventArgs e) {
        //gvSummary.DataSource = null;
        //gvSummary.DataBind();
        //gvSummary.Visible = false;
        
        if (tbForDate.Text.Equals("")) {
            tbForDate.Text = DateTime.Now.ToString("yyyy/MM/dd");
        }

        this.GetTimesheetSummaryReport(Convert.ToInt16(ddlAllProjects.SelectedValue), Convert.ToDateTime(tbForDate.Text));
    }
}
