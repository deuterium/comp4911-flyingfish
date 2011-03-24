using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using FFLib;

public partial class Reports_Reports : System.Web.UI.Page
{
    FlyingFishClassesDataContext ff = new FlyingFishClassesDataContext();

    protected void Page_Load(object sender, EventArgs e)
    {
        
       
    }


    protected void btnReport_Click(object sender, EventArgs e)
    {
        //var qry = from o in ff.WorkPackages
        //          where o.projId == 10
        //          select o;

        //foreach (var wp in qry)
        //{
        //    var empList = from emp in ff.EmployeeWorkPackages
        //                  where emp.wpId == wp.wpId
        //                  select emp;

        //    foreach (var ep in empList)
        //    {
        //        var timesheet = from ts in ff.TimeSheetEntries
        //                        where ts.empId == ep.empId && ts.wpId == ep.wpId
        //                        select ts;

        //    }
        //}

        var qry = (from o in ff.WorkPackages
                  join emp in ff.EmployeeWorkPackages on o.wpId equals emp.wpId
                  join ts in ff.TimeSheetEntries on emp.wpId equals ts.wpId
                  join th in ff.TimeSheetHeaders on ts.empId equals th.empId
                  where th.status == "APPROVED"
                  //where o.projId == Convert.ToInt32(tbProjectID.Text)
                  
                  select new
                  {
                      Project = o.projId,
                      WorkPackage = o.wpId,
                      EmployeeId = ts.empId,
                      Saturday = ts.sat,
                      Sunday = ts.sun,
                      Monday = ts.mon,
                      Tuesday = ts.tue,
                      Wednesday = ts.wed,
                      Thursday = ts.thu,
                      Friday = ts.fri,
                      Date = ts.tsDate
                  }).Distinct();

        gvReport.DataSource = qry;
        gvReport.DataBind();
    }
}