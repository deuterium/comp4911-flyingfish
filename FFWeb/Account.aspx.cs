using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

public partial class Account : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (User.Identity.IsAuthenticated)
        {
            FlyingFishClassesDataContext ff = new FlyingFishClassesDataContext();

            var empId = ff.EmployeeMemberships
                    .Where(a => a.userId == (Guid)Membership.GetUser().ProviderUserKey)
                    .Select(a => a.empId).Single();

            var sickDays = ff.Employees.Where(a => a.empId == empId)
                    .Select(a => a.sickDays).Single();

            var vacationDays = ff.Employees.Where(a => a.empId == empId)
                    .Select(a => a.vacationLeave).Single();

            lblSickDaysAmount.Text = sickDays.ToString();
            lblVacationDaysAmount.Text = vacationDays.ToString();
        }
        else
        {
            Response.Redirect("~/Login.aspx");
        }
    }
    protected void ContinuePushButton_Command(object sender, CommandEventArgs e)
    {
        Response.Redirect("~/Account.aspx", true);
    }
}