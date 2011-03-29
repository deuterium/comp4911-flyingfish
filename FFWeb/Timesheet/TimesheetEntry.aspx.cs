using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using FFLib;

public partial class Timesheet_TimesheetEntry : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        FlyingFishClassesDataContext ff = new FlyingFishClassesDataContext();

       
        var qry = (from o in ff.EmployeeMemberships
                  join emp in ff.aspnet_Users on o.userId equals emp.UserId
                  where emp.UserName == User.Identity.Name
                  select o.empId).Single();

        Session["CurEmpId"] = qry.ToString();
        //Label1.Text += "\t" + Convert.ToString(Session["CurEmpId"]);


    }
}