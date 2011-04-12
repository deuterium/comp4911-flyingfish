using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text.RegularExpressions;

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
            Employee user = getUser();
            if (!User.IsInRole("ProjectManager")) {
                Response.Redirect("~/Login.aspx");           
            }

            var qry = (from p in ffdb.Projects
                       where (p.manager == user.empId)
                       select new {
                           ProjID = p.projId,
                           ProjectName = p.projName + " (" + p.projId + ")"
                       }).Distinct();
            
            ddlAllProjects.DataSource = qry;
            ddlAllProjects.DataValueField = "ProjID";
            ddlAllProjects.DataTextField = "ProjectName";
            ddlAllProjects.DataBind();
            
            tbForDate.Text = DateTime.Now.ToString("yyyy/MM/dd");
            
        }
    }

    private Employee getUser() {
        if (!(User.IsInRole("ProjectManager") || User.IsInRole("ResponsibleEngineer"))) {
            return null;
        }
        String[] tokens = Regex.Split(User.Identity.Name, "_");
        String firstName = tokens[0];
        String lastName = tokens[1];
        Employee e = (from emp in ffdb.Employees
                      where (String.Compare(firstName, emp.firstName, true) == 0)
                         && (String.Compare(lastName, emp.lastName, true) == 0)
                      select emp).FirstOrDefault();

        return e;
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
                  select new {
                      WorkPackage = g.Key.wp.name + " (" + g.Key.wp.wpId + ")",
                      Employee = g.Key.emp.firstName + " " + g.Key.emp.lastName + " (" + g.Key.emp.empId + ")",
                      Week1 = (from w1 in ffdb.TimesheetEntries
                               where (w1.empId == g.Key.emp.empId)
                                    && w1.tsDate >= dateFor.AddDays(-7)
                                    && w1.tsDate <= dateFor
                                    && (w1.projId == g.Key.projId)
                                    && (w1.wpId.Equals(g.Key.wp.wpId))
                                    && (w1.TimesheetHeader.status.Equals("APPROVED"))
                               select w1.totalHours).FirstOrDefault(),
                      Week2 = (from w1 in ffdb.TimesheetEntries
                               where (w1.empId == g.Key.emp.empId)
                                    && w1.tsDate >= dateFor.AddDays(-14)
                                    && w1.tsDate <= dateFor.AddDays(-7)
                                    && (w1.projId == g.Key.projId)
                                    && (w1.wpId.Equals(g.Key.wp.wpId))
                                    && (w1.TimesheetHeader.status.Equals("APPROVED"))
                               select w1.totalHours).FirstOrDefault(),
                      Week3 = (from w1 in ffdb.TimesheetEntries
                               where (w1.empId == g.Key.emp.empId)
                                    && w1.tsDate >= dateFor.AddDays(-21)
                                    && w1.tsDate <= dateFor.AddDays(-14)
                                    && (w1.projId == g.Key.projId)
                                    && (w1.wpId.Equals(g.Key.wp.wpId))
                                    && (w1.TimesheetHeader.status.Equals("APPROVED"))
                               select w1.totalHours).FirstOrDefault(),
                      Week4 = (from w1 in ffdb.TimesheetEntries
                               where (w1.empId == g.Key.emp.empId)
                                    && w1.tsDate >= dateFor.AddDays(-28)
                                    && w1.tsDate <= dateFor.AddDays(-21)
                                    && (w1.projId == g.Key.projId)
                                    && (w1.wpId.Equals(g.Key.wp.wpId))
                                    && (w1.TimesheetHeader.status.Equals("APPROVED"))
                               select w1.totalHours).FirstOrDefault(),
                      Month1 = getTotalMonthlyHours(g.Key.emp.empId, dateFor, g.Key.projId, g.Key.wp.wpId).ToString(),
                      Month2 = getTotalMonthlyHours(g.Key.emp.empId, dateFor.AddMonths(-1), g.Key.projId, g.Key.wp.wpId).ToString(),
                      Month3 = getTotalMonthlyHours(g.Key.emp.empId, dateFor.AddMonths(-2), g.Key.projId, g.Key.wp.wpId).ToString(),
                      Month4 = getTotalMonthlyHours(g.Key.emp.empId, dateFor.AddMonths(-3), g.Key.projId, g.Key.wp.wpId).ToString(),
                      TotalHours = (from w1 in ffdb.TimesheetEntries
                                    where (w1.empId == g.Key.emp.empId)
                                        && (w1.projId == g.Key.projId)
                                        && (w1.wpId.Equals(g.Key.wp.wpId))
                                        && (w1.TimesheetHeader.status.Equals("APPROVED"))
                                    select w1.totalHours).Sum()
                  };

        //foreach (var row in qry) {
        //    if (row.Week1.Value.ToString().Equals("0.0")) {

        //    }
        //}

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


    private Object getTotalMonthlyHours(int empId, DateTime cutOffDate, int projId, String wpId) {
        String strEmp = empId.ToString();
        
        var qry = (from w1 in ffdb.TimesheetEntries
                   where (w1.empId == empId)
                       && (w1.tsDate <= cutOffDate)
                       && (w1.tsDate.Month == cutOffDate.Month)
                       && (w1.tsDate.Year == cutOffDate.Year)
                       && (w1.projId == projId)
                       && (w1.wpId.Equals(wpId))
                       && (w1.TimesheetHeader.status.Equals("APPROVED"))
                   select w1.totalHours).Sum();

        if (qry == null) {
            return String.Empty;
        }

        return qry;
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
