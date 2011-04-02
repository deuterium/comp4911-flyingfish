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

        try
        {
            var qry = (from o in ff.EmployeeMemberships
                       join emp in ff.aspnet_Users on o.userId equals emp.UserId
                       where emp.UserName == User.Identity.Name
                       select o.empId).Single();

            Session["CurEmpId"] = qry.ToString();
            //Label1.Text += "\t" + Convert.ToString(Session["CurEmpId"]);

            System.DateTime currentDate = System.DateTime.Now;
            System.DateTime actualQryDate = currentDate;
            System.DayOfWeek dayOfWeek = currentDate.DayOfWeek;

            // trying to get the sunday of the week picked by the user
            switch (dayOfWeek.ToString())
            {
                case "Monday": actualQryDate = currentDate.AddDays(-1); break;
                case "Tuesday": actualQryDate = currentDate.AddDays(-2); break;
                case "Wednesday": actualQryDate = currentDate.AddDays(-3); break;
                case "Thursday": actualQryDate = currentDate.AddDays(-4); break;
                case "Friday": actualQryDate = currentDate.AddDays(-5); break;
                case "Saturday": actualQryDate = currentDate.AddDays(-6); break;
                default: break;
            }
            Session["CurrentDate"] = actualQryDate;

            Label1.Text = Session["CurrentDate"].ToString();


        }
        catch
        {
            Response.Redirect("~/Login.aspx");
        }

       
    }
}