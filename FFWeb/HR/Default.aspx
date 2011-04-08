<%@ Page Title="" Language="C#" MasterPageFile="~/HR/HRMaster.master" AutoEventWireup="true"
    CodeFile="Default.aspx.cs" Inherits="HR_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HRContent" runat="Server">

<div id="DivUserMain" runat="server">

<h2>User Management</h2>

<p>
This feature is used by the Human Resources staff to create accounts for new employees, edit existing employee information, and assign employees to project.
</p>

<h4>Create New Employees</h4>
<p>
This page is used to give a new employee an account in the system. 
</p>
<p>
<b>When creating a new employee you can:</b>
<asp:BulletedList id="bltCreateEmpFeatures" runat="server">
    <asp:ListItem>specify the employee’s first and last name, user name, and ID.</asp:ListItem>
    <asp:ListItem>setup the initial security question and answer and password.</asp:ListItem>
    <asp:ListItem>assign the employee to one or more roles.</asp:ListItem>
    <asp:ListItem>assign the employee a supervisor and a timesheet approver.</asp:ListItem>
 </asp:BulletedList>
 </p>

<h4>Edit Employee Information</h4>
<p>
You are given a list of all employees, which you can search by last name. Once you’ve found the employee you want to update, you can click the select button. A form will be displayed with all the user’s information (except security information such as the security question and answer, and the employee’s password). You can change an employee’s p-level, first and last name, minimum hours per week, roles, and who their supervisor and timesheet approver is.
</p>

<h4>Assign Employees to Projects</h4>
<p>
This page lets you choose a project and shows two lists of employees. The left list is all the employees not assigned to the chosen project and the right list is all the employees currently assigned to the chosen project. You can select 1 or more employees from either list and the buttons below the lists to assign or un-assign the selected employees to or from the project.
</p>
<p>
<b>Notes:</b> the changes are immediate (as soon as you click the assign or un-assign buttons, the changes have been realized). To un-assign a responsible engineer, you must first choose a different responsible engineer. To un-assign the project manager, you must first choose a different project manager.
</p>

    </div>
</asp:Content>
