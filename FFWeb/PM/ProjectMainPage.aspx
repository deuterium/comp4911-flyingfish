<%@ Page Title="" Language="C#" MasterPageFile="~/FlyingFishMasterPage.master" AutoEventWireup="true" CodeFile="ProjectMainPage.aspx.cs" Inherits="PM_ProjectMainPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" Runat="Server">
This page allows you to view and update existing projects or work packages, or create new ones.
<br /><br /><br />
<b>To view or edit projects:</b>
<asp:BulletedList BulletStyle="Numbered" ID="bdlUpdateProject" runat="server">
    <asp:ListItem>Click on Project Management &gt; Project List.</asp:ListItem>
    <asp:ListItem>Select a Project.</asp:ListItem>
</asp:BulletedList>
<b>To Create a Project:</b>
<asp:BulletedList BulletStyle="Numbered" ID="bdlCreateProject" runat="server">
    <asp:ListItem>Click Create a Project from the DropDownList or
         <a href="Project.aspx">Click Here</a>.
    </asp:ListItem>
    <asp:ListItem>Enter the ProjectId, Project Name, and Unallocated Budget.</asp:ListItem>
    <asp:ListItem>Click Create Project.</asp:ListItem>
</asp:BulletedList>
<b>To assign employees to a Project or WorkPackage:</b>
<asp:BulletedList BulletStyle="Numbered" ID="bdlAssignEmployees" runat="server">
    <asp:ListItem>Click User Management &gt; Assign Employee to Project.</asp:ListItem>
    <asp:ListItem>Enter the ProjectId, Project Name, and Unallocated Budget.</asp:ListItem>
    <asp:ListItem>Click Create Project.</asp:ListItem>
</asp:BulletedList>
</asp:Content>
