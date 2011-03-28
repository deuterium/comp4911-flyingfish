<%@ Page Title="" Language="C#" MasterPageFile="~/FlyingFishMasterPage.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" Runat="Server">
<div>
Welcome to the FlyingFish Project Management Application. This software simplifies the management of software development projects.
<br /><br /><br />
You can use FlyingFish to easily:
<asp:BulletedList id="bdlFeatures" runat="server">
    <asp:ListItem>Create, update, and view projects and work packages</asp:ListItem>
    <asp:ListItem>Divide projects into work packages</asp:ListItem>
    <asp:ListItem>Allocate budgets to projects and work packages</asp:ListItem>
    <asp:ListItem>Create and update employees and users</asp:ListItem>
    <asp:ListItem>Assign employees to projects and work packages</asp:ListItem>
    <asp:ListItem>View reports that track project, work package, and employee progress</asp:ListItem>
    <asp:ListItem>Enter or view weekly timesheets</asp:ListItem>
</asp:BulletedList>
All your data is safe thanks to:
<asp:BulletedList id="bdlSecurityFeatures" runat="server">
    <asp:ListItem>Secure login using HTTPS</asp:ListItem>
    <asp:ListItem>Password encryption</asp:ListItem>
    <asp:ListItem>Electronic signatures on timesheets</asp:ListItem>
    <asp:ListItem>Roles to prevent unauthorized site access</asp:ListItem>
    <asp:ListItem>Unicode character encoding</asp:ListItem>
</asp:BulletedList>
<br />
Let FlyingFish do the stuff your too smart to do manually! Remember, FlyingFish good. To begin, click the Login button and enter your username and password. Your username is your firstname_lastname.
</div>
</asp:Content>

