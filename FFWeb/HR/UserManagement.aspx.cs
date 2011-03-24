﻿using System;
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
    //Populates the Supervisor list when the page is loaded
    protected void SupervisorList_Load(object sender, EventArgs e)
    {
        ((ListBox)wsEmployeeAccountInfo.ContentTemplateContainer.FindControl("SupervisorList")).DataSource =
        ff.vw_EmployeeInRolewFirstLastNameEmpIDUserIDs
            .Select(u => new
            {
                empID = u.empId,
                approver = ((((u.firstName + " ") + u.lastName) + " (") + u.empId + ")")
            });
        ((ListBox)wsEmployeeAccountInfo.ContentTemplateContainer.FindControl("SupervisorList")).DataValueField = "empId";
        ((ListBox)wsEmployeeAccountInfo.ContentTemplateContainer.FindControl("SupervisorList")).DataTextField = "approver";
        ((ListBox)wsEmployeeAccountInfo.ContentTemplateContainer.FindControl("SupervisorList")).DataBind();
        ((ListBox)wsEmployeeAccountInfo.ContentTemplateContainer.FindControl("SupervisorList")).Rows = 6;
    }

    //Adds the newly created user to the Employee table and links them together in EmployeeMembership
    protected void cuwCreateUser_CreatedUser(object sender, EventArgs e)
    {
        string tmpFirstName = ((TextBox)wsEmployeeAccountInfo.ContentTemplateContainer.FindControl("FirstName")).Text;
        string tmpLastName = ((TextBox)wsEmployeeAccountInfo.ContentTemplateContainer.FindControl("LastName")).Text;
        string tmpSupervisor = ((ListBox)wsEmployeeAccountInfo.ContentTemplateContainer.FindControl("SupervisorList")).SelectedValue;
        string tmpEmpID = ((TextBox)wsEmployeeAccountInfo.ContentTemplateContainer.FindControl("EmployeeID")).Text;
        CheckBoxList tempCheck = (CheckBoxList)wsEmployeeAccountInfo.ContentTemplateContainer.FindControl("RoleList");
        for(int i = 0; i < tempCheck.Items.Count; i++)
        {
            if (tempCheck.Items[i].Selected)
            { Roles.AddUserToRole(((TextBox)wsEmployeeAccountInfo.ContentTemplateContainer.FindControl("UserName")).Text
                , tempCheck.Items[i].Text); }
        }

        Employee emp = new Employee()
        {
            firstName = tmpFirstName,
            lastName = tmpLastName,
            empId = Convert.ToInt32(tmpEmpID),
            supervisor = Convert.ToInt32(tmpSupervisor),
            approver = 456,
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
        lblUserEditError.Text = "";
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
        lblUserEditError.Text = "";
        lblSearchError.Text = "";
        getAllUsers();
    }

    //Brings up the editing area for when a user is selected from the gridview
    protected void gvManageUsers_SelectedIndexChanged(Object sender, EventArgs e)
    {
        DivUserDetails.Visible = true;
        fillSupervisorApproverDropDowns();
        int empID = Convert.ToInt32(gvManageUsers.SelectedRow.Cells[1].Text);
        Employee ManagedEmployee = ff.Employees.Where(em => em.empId == empID).First();
        System.Guid userID = ff.EmployeeMemberships.Where(emp => emp.empId == empID).Select(emp => emp.userId).First();
        tbFirstName.Text = ManagedEmployee.firstName;
        tbLastName.Text = ManagedEmployee.lastName;
        lblEmpId.Text = ManagedEmployee.empId.ToString();
        lblUsername.Text = ff.aspnet_Users.Where(use => use.UserId == userID).Select(use => use.UserName).First();
        lblEmail.Text = ff.aspnet_Memberships.Where(use => use.UserId == userID).Select(use => use.Email).First();
        ddlSupervisors.SelectedValue = ManagedEmployee.supervisor.ToString();
        ddlApprovers.SelectedValue = ManagedEmployee.approver.ToString();
        tbMinHours.Text = ManagedEmployee.minHoursPerWeek.ToString();
        tbVacation.Text = ManagedEmployee.vacationLeave.ToString();
        tbSickDays.Text = ManagedEmployee.sickDays.ToString();
        tbFlexHours.Text = ManagedEmployee.flexHours.ToString();
        if (ManagedEmployee.isActive == 1) cbActiveUser.Checked = true;
    }

    //Returns a list of all Supervisors ..... List<String> is placeholder for correct type
    protected void fillSupervisorApproverDropDowns()
    {
        //Fills Approvers DDL with all users in role TimesheetApprover
        ddlApprovers.DataSource = ff.vw_EmployeeInRolewFirstLastNameEmpIDUserIDs
            .Where(r => r.RoleName == "TimesheetApprover")
            .Select(u => new
            {
                empID = u.empId,
                tsa = ((((u.empId + ": ") + u.firstName) + " ") + u.lastName)
            });
        ddlApprovers.DataTextField = "tsa";
        ddlApprovers.DataValueField = "empId";
        ddlApprovers.DataBind();

        //Fills Supervisors DDL with all users in ??? can supervisors be anyone?
        ddlSupervisors.DataSource = ff.vw_EmployeeInRolewFirstLastNameEmpIDUserIDs
            .Select(u => new
            {
                empID = u.empId,
                tsa = ((((u.empId + ": ") + u.firstName) + " ") + u.lastName)
            });
        ddlSupervisors.DataTextField = "tsa";
        ddlSupervisors.DataValueField = "empId";
        ddlSupervisors.DataBind();
    }

    //Cancels Editing of an Employee and hides the editing div
    protected void buttonDetailsCancel_Click(object sender, EventArgs e)
    {
        lblUserEditError.Text = "";
        DivUserDetails.Visible = false;
    }

    //Fills changed information into object and submits changes to DB
    protected void buttonDetailsSubmit_Click(object sender, EventArgs e)
    {
        Employee ManagedEmployee = ff.Employees.Where(em => em.empId == Convert.ToInt32(lblEmpId.Text)).First();
        ManagedEmployee.firstName = tbFirstName.Text;
        ManagedEmployee.lastName = tbLastName.Text;
        ManagedEmployee.supervisor = Convert.ToInt32(ddlSupervisors.SelectedValue);
        ManagedEmployee.approver = Convert.ToInt32(ddlApprovers.SelectedValue);
        ManagedEmployee.minHoursPerWeek = Convert.ToDecimal(tbMinHours.Text);
        ManagedEmployee.vacationLeave = Convert.ToInt32(tbVacation.Text);
        ManagedEmployee.sickDays = Convert.ToInt32(tbSickDays.Text);
        ManagedEmployee.flexHours = Convert.ToDecimal(tbFlexHours.Text);
        if (cbActiveUser.Checked)
        {
            ManagedEmployee.isActive = 1;
        }
        else
        {
            ManagedEmployee.isActive = 0;
        }

        try
        {
            ff.SubmitChanges();
        }
        catch (Exception ex)
        {
            lblUserEditError.Text = ex.Message;
            lblUserEditError.ForeColor = System.Drawing.Color.Red;
        }
        lblUserEditError.Text = "User Has been updated. Show all users to see changes.";
        lblUserEditError.ForeColor = System.Drawing.Color.ForestGreen;
    }
    #endregion

    #region Assign Employee to Project

    #endregion

}