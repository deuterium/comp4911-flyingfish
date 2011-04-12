<%@ Page Title="" Language="C#" MasterPageFile="~/FlyingFishMasterPage.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" Runat="Server">
    <div>
    
    <h2>Welcome to FlyingFish!</h2>
    <p>
    Welcome to the FlyingFish Project Management Application! This web app simplifies the management of software development projects.
    </p>
    
    <p>
    <b>You can use FlyingFish to easily:</b>
    <asp:BulletedList id="bdlFeatures" runat="server" onclick="bdlFeatures_Click">
        <asp:ListItem>Create, update, and view projects and work packages</asp:ListItem>
        <asp:ListItem>Divide projects into work packages</asp:ListItem>
        <asp:ListItem>Allocate budgets to projects and work packages</asp:ListItem>
        <asp:ListItem>Create and update employees and users</asp:ListItem>
        <asp:ListItem>Assign employees to projects and work packages</asp:ListItem>
        <asp:ListItem>View reports that track project, work package, and employee progress</asp:ListItem>
        <asp:ListItem>Enter or view weekly timesheets</asp:ListItem>
    </asp:BulletedList>
    </p>

    <p>
    <b>All your data is safe thanks to:</b>
    <asp:BulletedList id="bdlSecurityFeatures" runat="server">
        <asp:ListItem>Secure login and password encryption</asp:ListItem>
        <asp:ListItem>Electronic signatures on timesheets</asp:ListItem>
        <asp:ListItem>Roles to prevent unauthorized site access</asp:ListItem>
        <asp:ListItem>Unicode character encoding</asp:ListItem>
    </asp:BulletedList>
    </p>
    
    <p>
    Let FlyingFish do the stuff you're too smart to do manually! Remember, FlyingFish good. To begin, click the Login button and enter your username and password. Your username is your firstname_lastname.
    </p>
    
    </div>

    
</asp:Content>

