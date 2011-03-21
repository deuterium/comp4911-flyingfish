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

    #region Menu Items
    //Shows the create employee div when link is clicked
    protected void lbCreateUser_Click(object sender, EventArgs e)
    {
        if (DivManageUsers.Visible || DivUserMain.Visible || DivAssignUsers.Visible)
        {
            DivManageUsers.Visible = false;
            DivUserMain.Visible = false;
            DivAssignUsers.Visible = false;
        }
        DivNewUser.Visible = true;

    }

    //Shows the manage employee div when link is clicked
    protected void ManageUserLabel_Click(object sender, EventArgs e)
    {
        if (DivNewUser.Visible || DivUserMain.Visible || DivAssignUsers.Visible)
        {
            DivNewUser.Visible = false;
            DivUserMain.Visible = false;
            DivAssignUsers.Visible = false;
        }
        DivManageUsers.Visible = true;
        getAllUsers();

    }

    //Shows the assign employee div when link is clicked
    protected void AssignUserLabel_Click(object sender, EventArgs e)
    {
        if (DivNewUser.Visible || DivUserMain.Visible || DivManageUsers.Visible)
        {
            DivNewUser.Visible = false;
            DivUserMain.Visible = false;
            DivManageUsers.Visible = false;
        }
        DivAssignUsers.Visible = true;
    }
    #endregion

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

    #region Manage Employees
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

    //Searches for employees containing the provided last name when button clicked
    protected void buttonSearch_Click(object sender, EventArgs e)
    {
        DivUserDetails.Visible = false;
        if (tbSearch.Text == "" || ff.Employees.Where(emp => emp.lastName.Contains(tbSearch.Text))
                .Select(emp => new { emp.empId, emp.firstName, emp.lastName, emp.vacationLeave, emp.sickDays, emp.flexHours, emp.isActive })
                .Count() == 0)
        {
            lblSearchError.Enabled = true;
            lblSearchError.Text = "No Employee results";
            lblSearchError.ForeColor = System.Drawing.Color.Red;
            gvManageUsers.DataSource = null;
            gvManageUsers.DataBind();
        }
        else
        {
            lblSearchError.Enabled = false;
            lblSearchError.Text = "";
            gvManageUsers.DataSource = ff.Employees.Where(emp => emp.lastName.Contains(tbSearch.Text)).Select(emp => new { emp.empId, emp.firstName, emp.lastName, emp.vacationLeave, emp.sickDays, emp.flexHours, emp.isActive });
            gvManageUsers.DataBind();
        }
    }

    //Displays all employees when button clicked
    protected void buttonAllUsers_Click(object sender, EventArgs e)
    {
        DivUserDetails.Visible = false;
        lblSearchError.Enabled = false;
        lblSearchError.Text = "";
        getAllUsers();
    }

    //Brings up the editing area for when a user is selected from the gridview
    protected void gvManageUsers_SelectedIndexChanged(Object sender, EventArgs e)
    {
        DivUserDetails.Visible = true;
        int empID = Convert.ToInt32(gvManageUsers.SelectedRow.Cells[1].Text);
        //ManagedEmployee me;
        var em = from emp in ff.Employees
                 where emp.empId == empID
                 select emp;
        System.Guid userID = ff.EmployeeMemberships.Where(emp => emp.empId == empID).Select(emp => emp.userId).First();
        tbFirstName.Text = em.First().firstName;
        tbLastName.Text = em.First().lastName;
        lblEmpId.Text = em.First().empId.ToString();
        lblUsername.Text = ff.aspnet_Users.Where(use => use.UserId == userID).Select(use => use.UserName).First();
        tbEmail.Text = ff.aspnet_Memberships.Where(use => use.UserId == userID).Select(use => use.Email).First();
        //ddl > Supervisor = em.First().supervisor;
        //ddl > Approver = em.First().approver;
        tbMinHours.Text = em.First().minHoursPerWeek.ToString();
        tbVacation.Text = em.First().vacationLeave.ToString();
        tbSickDays.Text = em.First().sickDays.ToString();
        tbFlexHours.Text = em.First().flexHours.ToString();
        if (em.First().isActive == 1) cbActiveUser.Checked = true;
    }

    //Returns a list of all Supervisors ..... List<String> is placeholder for correct type
    protected List<String> getAllSupervisors() { return null; }

    //Returns a list of all Approvers ..... List<String> is placeholder for correct type
    protected List<String> getAllApprovers() { return null; }
    #endregion

    #region Assign Employee to Project

    #endregion
}