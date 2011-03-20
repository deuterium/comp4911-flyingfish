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
    //DatabaseContext
    FlyingFishClassesDataContext ff = new FlyingFishClassesDataContext();

    //PageLoad Method
    protected void Page_Load(object sender, EventArgs e)
    {
    }
    
    //Shows the create user div when link is clicked
    protected void lbCreateUser_Click(object sender, EventArgs e)
    {
        if (DivManageUsers.Visible) DivManageUsers.Visible = false;
        DivNewUser.Visible = true;

    }

    //Shows the manage users div when link is clicked
    protected void ManageUserLabel_Click(object sender, EventArgs e)
    {
        if (DivNewUser.Visible) DivNewUser.Visible = false;
        DivManageUsers.Visible = true;
        getAllUsers();

    }

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
            //throw new Exception("Employee Number already exists.");
            //OMG WHY DOES THIS LITERAL NOT UPDATE!!!!! if i make a label or another literal it updates fine.
            ((Literal)wsEmployeeAccountInfo.ContentTemplateContainer.FindControl("ErrorMessage")).Text
                = "Employee Number already exists.";
            e.Cancel = true;
        }
        else
        {
            ((Literal)wsEmployeeAccountInfo.ContentTemplateContainer.FindControl("ErrorMessage")).Text = "";
            e.Cancel = false;
        }
    }

    //Restarts the created user wizard when the button is clicked
    protected void cuwCreateUser_ContinueButtonClick(object sender, EventArgs e)
    {
        cuwCreateUser.ActiveStepIndex = 0;
    }

    //Binds all employees to the gridview
    protected void getAllUsers()
    {
        //Old code, not complete, may be useful in feature
        //List<ManagedEmployee> employees = new List<ManagedEmployee>();
        //var UsersQry = from a in ff.EmployeeMemberships
        //               select a;
        //foreach (EmployeeMembership e in UsersQry)
        //{
        //    employees.Add(new ManagedEmployee(ff.aspnet_Users.Where(u => u.UserId == e.userId).FirstOrDefault()
        //        , ff.Employees.Where(emp => emp.empId == e.empId).FirstOrDefault()));
        //}
        //gvManageUsers.DataSource = employees;

        gvManageUsers.DataSource = ff.Employees.Select(emp => new { emp.empId, emp.firstName, emp.lastName, emp.vacationLeave, emp.sickDays, emp.flexHours, emp.isActive });
        gvManageUsers.DataBind();
    }

    //Brings up the editing area for when a user is selected from the gridview
    protected void gvManageUsers_SelectedIndexChanged(Object sender, EventArgs e)
    {
        dvUser.DataSource = ff.EmployeeMemberships.Where(emp => emp.empId == Convert.ToInt32(gvManageUsers.SelectedRow.Cells[1].Text)).Select(emp => emp.Employee);
        dvUser.DataBind();
    }

    //Searches for employees containing the provided last name when button clicked
    protected void buttonSearch_Click(object sender, EventArgs e)
    {
        gvManageUsers.DataSource = ff.Employees.Where(emp => emp.lastName.Contains(tbSearch.Text)).Select(emp => new { emp.empId, emp.firstName, emp.lastName, emp.vacationLeave, emp.sickDays, emp.flexHours, emp.isActive });
        gvManageUsers.DataBind();
    }

    //Displays all employees when button clicked
    protected void buttonAllUsers_Click(object sender, EventArgs e)
    {
        getAllUsers();
    }
}