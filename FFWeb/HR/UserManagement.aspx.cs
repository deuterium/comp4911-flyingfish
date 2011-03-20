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
    FlyingFishClassesDataContext ff = new FlyingFishClassesDataContext();
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
        getAllUsers();

    }
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
        ff.Employees.InsertOnSubmit(emp);

        ff.EmployeeMemberships.InsertOnSubmit(new EmployeeMembership
        {
            empId = Convert.ToInt32(tmpEmpID),
            userId = ff.aspnet_Users
                .Where(u => u.UserName == ((TextBox)wsEmployeeAccountInfo.ContentTemplateContainer.FindControl("UserName")).Text)
                .ToArray()[0].UserId
        });
        ff.SubmitChanges();
    }
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
    protected void cuwCreateUser_ContinueButtonClick(object sender, EventArgs e)
    {
        cuwCreateUser.ActiveStepIndex = 0;
    }
    protected void getAllUsers()
    {
        List<ManagedEmployee> employees = new List<ManagedEmployee>();
        var UsersQry = from a in ff.EmployeeMemberships
                       select a;

        foreach (EmployeeMembership e in UsersQry)
        {
            employees.Add(new ManagedEmployee(ff.aspnet_Users.Where(u => u.UserId == e.userId).FirstOrDefault()
                , ff.Employees.Where(emp => emp.empId == e.empId).FirstOrDefault()));
        }

        gvManageUsers.DataSource = employees;
        gvManageUsers.DataBind();
    }
    protected void gvManageUsers_SelectedIndexChanged(Object sender, EventArgs e) 
    {
        labelSelected.Text = "empid: " + gvManageUsers.SelectedRow.Cells[3].Text;
    }
}