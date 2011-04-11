using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Timesheet_PrintTimesheet : System.Web.UI.Page
{
    FlyingFishClassesDataContext ff = new FlyingFishClassesDataContext();
    protected void Page_Load(object sender, EventArgs e)
    {
        // if the user logins in
        try
        {
            var qry = (from o in ff.EmployeeMemberships
                       join emp in ff.aspnet_Users on o.userId equals emp.UserId
                       where emp.UserName == User.Identity.Name
                       select o.empId).Single();

            Session["CurEmpId"] = qry.ToString();
        }
        catch
        {
            Response.Redirect("~/Login.aspx");
        }


        // shows the prvious week timesheet as default

        showPreviousWeekTimesheet();
    }


    protected void btnGetTimesheet_Click(object sender, EventArgs e)
    {
        //Shows previous week's timesheet
        //needs a session object to hold the empId
        //

            qryTimesheet();



    }

    public void showPreviousWeekTimesheet()
    {
        System.DateTime now = System.DateTime.Now.Date;
        System.DateTime pre = now.AddDays(-6);
        var qry = from o in ff.TimesheetEntries
                  where o.empId == Convert.ToInt32(Session["CurEmpId"]) && o.tsDate < now && o.tsDate > pre
                  select new
                  {
                      Project = o.projId,
                      WP = o.wpId,
                      total = o.sun + o.mon + o.tue + o.wed + o.thu + o.fri + o.sat,
                      Sun = o.sun,
                      Mon = o.mon,
                      Tue = o.tue,
                      Wed = o.wed,
                      Thu = o.thu,
                      Fri = o.fri,
                      Sat = o.sat,
                      Note = o.notes,
                      Date = o.tsDate
                  };

        gvPrintTimesheet.DataSource = qry;
        gvPrintTimesheet.DataBind();

        //Label1.Text = now + " " + pre;
    }

    public void qryTimesheet()
    {
        System.DateTime qryDate = Convert.ToDateTime(tbPeriodStart.Text);
        System.DateTime endDate = Convert.ToDateTime(tbPeriodEnd.Text);


        var qry = from th in ff.TimesheetHeaders
                  join tse in ff.TimesheetEntries on new { th.tsDate, th.empId } equals new { tse.tsDate, tse.empId }
                  join emp in ff.Employees on tse.empId equals emp.empId
                  where tse.empId == Convert.ToInt32(Session["CurEmpId"]) && tse.tsDate >= qryDate && tse.tsDate <= endDate
                  select new
                  {
                      EmployeeName = emp.firstName + " " + emp.lastName + "(" + th.empId + ")",
                      Date = th.tsDate,
                      Project = tse.projId,
                      WorkPackage = tse.wpId,
                      Mon = tse.mon,
                      Tue = tse.tue,
                      Wed = tse.wed,
                      Thu = tse.thu,
                      Fri = tse.fri,
                      Sat = tse.sat,
                      Sun = tse.sun,
                      Note = tse.notes,
                      Status = th.status,
                      Comments = th.comments
                  };

        gvPrintTimesheet.DataSource = qry;
        gvPrintTimesheet.DataBind();
    }
}