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

    }


    protected void btnGetTimesheet_Click(object sender, EventArgs e)
    {
        //Shows previous week's timesheet
        //needs a session object to hold the empId
        

        System.DateTime now = System.DateTime.Now.Date;
        System.DateTime pre = now.AddDays(-7);
        var qry = from o in ff.TimeSheetEntries
                  where o.empId == 1 && o.tsDate < now && o.tsDate > pre
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