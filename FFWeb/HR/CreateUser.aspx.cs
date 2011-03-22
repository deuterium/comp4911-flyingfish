using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using FFLib;

public partial class CreateUser : System.Web.UI.Page
{
    //DatabaseContext
    FlyingFishClassesDataContext ff = new FlyingFishClassesDataContext();

    //PageLoad Method
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    #region Create New Employee
    //Adds the newly created user to the Employee table and links them together in EmployeeMembership
    protected void cuwCreateUser_CreatedUser(object sender, EventArgs e)
    {
        string tmpFirstName = ((TextBox)wsEmployeeAccountInfo.ContentTemplateContainer.FindControl("FirstName")).Text;
        string tmpLastName = ((TextBox)wsEmployeeAccountInfo.ContentTemplateContainer.FindControl("LastName")).Text;
        string tmpRole = ((DropDownList)wsEmployeeAccountInfo.ContentTemplateContainer.FindControl("RoleList")).SelectedItem.Text;
        string tmpEmpID = ((TextBox)wsEmployeeAccountInfo.ContentTemplateContainer.FindControl("EmployeeID")).Text;
        Roles.AddUserToRole(((TextBox)wsEmployeeAccountInfo.ContentTemplateContainer.FindControl("UserName")).Text, tmpRole);

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
        //Employee table updated
        ff.Employees.InsertOnSubmit(emp);

        //EmployeeMembership updated (link created here)
        ff.EmployeeMemberships.InsertOnSubmit(new EmployeeMembership
        {
            empId = Convert.ToInt32(tmpEmpID),
            userId = ff.aspnet_Users
                .Where(u => u.UserName == ((TextBox)wsEmployeeAccountInfo.ContentTemplateContainer.FindControl("UserName")).Text)
                .ToArray()[0].UserId
        });
        ff.SubmitChanges();
    }

    //Checks to see an en employee is already created with an EmpID
    protected void cuwCreateUser_CreatingUser(object sender, LoginCancelEventArgs e)
    {
        string tmpEmpID = ((TextBox)wsEmployeeAccountInfo.ContentTemplateContainer.FindControl("EmployeeID")).Text;
        if (ff.Employees.Where(te => te.empId == Convert.ToInt32(tmpEmpID)).ToArray().Length > 0)
        {
            ((Label)wsEmployeeAccountInfo.ContentTemplateContainer.FindControl("lblUserWizardError")).Enabled = true;
            ((Label)wsEmployeeAccountInfo.ContentTemplateContainer.FindControl("lblUserWizardError")).Text
                = "Employee Number already exists.";
            e.Cancel = true;
        }
        else
        {
            ((Label)wsEmployeeAccountInfo.ContentTemplateContainer.FindControl("lblUserWizardError")).Text = "";
            ((Label)wsEmployeeAccountInfo.ContentTemplateContainer.FindControl("lblUserWizardError")).Enabled = false;
            e.Cancel = false;
        }
    }

    //Restarts the created user wizard when the button is clicked
    protected void cuwCreateUser_ContinueButtonClick(object sender, EventArgs e)
    {
        cuwCreateUser.ActiveStepIndex = 0;
    }
    #endregion

}