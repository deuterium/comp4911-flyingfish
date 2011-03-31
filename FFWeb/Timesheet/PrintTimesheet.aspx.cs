using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using FFLib;

public partial class Timesheet_PrintTimesheet : System.Web.UI.Page
{
    FlyingFishClassesDataContext ff = new FlyingFishClassesDataContext();
    protected void Page_Load(object sender, EventArgs e)
    {
        // shows the prvious week timesheet as default

        showPreviousWeekTimesheet();
    }


    protected void btnGetTimesheet_Click(object sender, EventArgs e)
    {
        //Shows previous week's timesheet
        //needs a session object to hold the empId
        //

        if (tbStartDate.Text == string.Empty)
        {
            showPreviousWeekTimesheet();
        }
        else
        {
            qryTimesheet();
        }



    }

    public void showPreviousWeekTimesheet()
    {
        System.DateTime now = System.DateTime.Now.Date;
        System.DateTime pre = now.AddDays(-6);
        var qry = from o in ff.TimesheetEntries
                  where o.empId == Convert.ToInt32(Session["CurEmpId"]) && o.tsDate <= now && o.tsDate >= pre
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
                      Note = o.notes
                  };

        gvPrintTimesheet.DataSource = qry;
        gvPrintTimesheet.DataBind();

        //Label1.Text = now + " " + pre;
    }

    public void qryTimesheet()
    {
        System.DateTime qryDate = Convert.ToDateTime(tbStartDate.Text);
        System.DateTime actualQryDate = qryDate;
        System.DayOfWeek dayOfWeek = qryDate.DayOfWeek;

        // trying to get the sunday of the week picked by the user
        switch (dayOfWeek.ToString())
        {
            case "Monday": actualQryDate = qryDate.AddDays(-1); break;
            case "Tuesday": actualQryDate = qryDate.AddDays(-2); break;
            case "Wednesday": actualQryDate = qryDate.AddDays(-3); break;
            case "Thursday": actualQryDate = qryDate.AddDays(-4); break;
            case "Friday": actualQryDate = qryDate.AddDays(-5); break;
            case "Saturday": actualQryDate = qryDate.AddDays(-6); break;
            default: break;
        }

       
        System.DateTime pre = actualQryDate.AddDays(6);
        Label1.Text = actualQryDate + " " + pre;
        var qry = from o in ff.TimesheetEntries
                  // code to determine the role or id
                  where o.tsDate >= actualQryDate && o.tsDate <= pre && o.empId == Convert.ToInt32(Session["CurEmpId"])
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
                      Note = o.notes
                  };

        gvPrintTimesheet.DataSource = qry;
        gvPrintTimesheet.DataBind();
    }
}