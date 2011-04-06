﻿using System;
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
        // shows the prvious week timesheet as default

        showPreviousWeekTimesheet();
    }


    protected void btnGetTimesheet_Click(object sender, EventArgs e)
    {
        //Shows previous week's timesheet
        //needs a session object to hold the empId
        //

        if (tbPeriodStart.Text == string.Empty)
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


        var qry = from o in ff.TimesheetEntries
                  // code to determine the role or id
                  where o.tsDate > qryDate && o.empId == Convert.ToInt32(Session["CurEmpId"])
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
    }
}