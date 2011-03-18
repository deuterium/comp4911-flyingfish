using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using FFLib;

public partial class UserManagement : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }
    protected void lbCreateUser_Click(object sender, EventArgs e)
    {
        if (DivManageUsers.Visible) DivManageUsers.Visible = false;
        DivNewUser.Visible = true;

    }
    protected void ManageUserLabel_Click(object sender, EventArgs e)
    {
        if (DivNewUser.Visible) DivNewUser.Visible = false;
        DivManageUsers.Visible = true;

    }
    protected void cuwCreateUser_CreatedUser(object sender, EventArgs e)
    {
        FlyingFishClassesDataContext ff = new FlyingFishClassesDataContext();
        string tmpFirstName = ((TextBox)wsEmployeeAccountInfo.ContentTemplateContainer.FindControl("FirstName")).Text;
        string tmpLastName = ((TextBox)wsEmployeeAccountInfo.ContentTemplateContainer.FindControl("LastName")).Text;
        string tmpRole = ((DropDownList)wsEmployeeAccountInfo.ContentTemplateContainer.FindControl("RoleList")).SelectedItem.Text;
        string tmpEmpID = ((TextBox)wsEmployeeAccountInfo.ContentTemplateContainer.FindControl("EmployeeID")).Text;
        Roles.AddUserToRole(((TextBox)wsEmployeeAccountInfo.ContentTemplateContainer.FindControl("UserName")).Text, tmpRole);

        if (ff.Employees.Where(te => te.empId == Convert.ToInt32(tmpEmpID)).ToArray().Length > 0)
        {
            ((Literal)wsEmployeeAccountInfo.ContentTemplateContainer.FindControl("ErrorMessage")).Text
                = "Employee Number alerady exists.";
        }
        else {
            ((Literal)wsEmployeeAccountInfo.ContentTemplateContainer.FindControl("ErrorMessage")).Text = "";
            Employee emp = new Employee()
            {
                firstName = tmpFirstName,
                lastName = tmpLastName,
                empId = Convert.ToInt32(tmpEmpID),
                supervisor = 1,
                approver = 1,
                minHoursPerWeek = 0,
                vacationLeave = 0,
                sickDays = 0,
                flexHours = 0,
                isActive = 1
            };
            ff.Employees.InsertOnSubmit(emp);
            ff.SubmitChanges();
        }
    }
}