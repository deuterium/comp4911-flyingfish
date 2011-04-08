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

    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div id="ajaxkeygen" runat="server" visible="false" class="ajaxkeygen">
            </div>
            <div id="ajaxkeygenwindow" class="keygenwindow" visible="false" runat="server">
                    <asp:Label ID="lblKey" runat="server" Text="You must enter a password for your Timesheet Digital Signature"></asp:Label>
                    <br />
                    <table class="cent" runat="server" id="tblKeygenForm">
                        <tr>
                            <td>
                                <asp:Label ID="lblPassword" runat="server" Text="Password: "></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="tbPassword" runat="server" TextMode="Password"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                                    ErrorMessage="Password required." ForeColor="Red" ControlToValidate="tbPassword">*</asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblPasswordConfirm" runat="server" Text="Confirm Password: "></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="tbPasswordConfirm" runat="server" TextMode="Password"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Confirm password required." 
                                    ForeColor="Red" ControlToValidate="tbPasswordConfirm">*</asp:RequiredFieldValidator>
                                <asp:CompareValidator ID="cvPasswordConfirm" runat="server" ErrorMessage="Passwords do not match." 
                                    ForeColor="Red" ControlToValidate="tbPasswordConfirm" ControlToCompare="tbPassword">*</asp:CompareValidator>
                            </td>
                        </tr>
                    </table>
                    <br />
                    <asp:Button ID="btnPasswordConfirm" runat="server" Text="Submit" 
                        onclick="btnPasswordConfirm_Click" />
                    <br /><br />
                    <asp:Button ID="btnDownload" runat="server" Text="Download Key" 
                        onclick="btnDownload_Click" Visible="false" />
                    <asp:Button ID="btnClose" runat="server" 
                        Text="Close (I have downloaded my key)" Visible="false" 
                        onclick="btnClose_Click" />
                </div>
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="btnPasswordConfirm" EventName="Click" />
            <asp:AsyncPostBackTrigger ControlID="btnClose" EventName="Click" />
            <asp:AsyncPostBackTrigger ControlID="btnDownload" EventName="Click" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>

