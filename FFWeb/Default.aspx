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
        <asp:ListItem>Secure login and password encryption</asp:ListItem>
        <asp:ListItem>Electronic signatures on timesheets</asp:ListItem>
        <asp:ListItem>Roles to prevent unauthorized site access</asp:ListItem>
        <asp:ListItem>Unicode character encoding</asp:ListItem>
    </asp:BulletedList>
    <br />
    Let FlyingFish do the stuff your too smart to do manually! Remember, FlyingFish good. To begin, click the Login button and enter your username and password. Your username is your firstname_lastname.
        <asp:Button runat="server" Text="Ajax Test" ID="btnajaxtest" onclick="btnajaxtest_Click" />
    </div>

    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div id="ajaxkeygen" runat="server" visible="false" class="ajaxkeygen">
            </div>
            <div id="ajaxkeygenwindow" class="keygenwindow" visible="false" runat="server">
                    <p class="ajaxblurb" id="ajaxblurb" runat="server">You must enter a password for your Timesheet Digital Signature</p>
                    <br />
                    <table class="cent" runat="server" id="tblKeygenForm">
                        <tr>
                            <td>
                                <asp:Label ID="Label2" runat="server" Text="Password: "></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label3" runat="server" Text="Confirm Password: "></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                    <br />
                    <asp:Button ID="btnPasswordConfirm" runat="server" Text="Submit" 
                        onclick="btnPasswordConfirm_Click" />

                    <asp:Label id="lblPubKeyGen" Visible="false" runat="server" Text="Your Public key is: " /><asp:Label runat="server" ID="test"></asp:Label>
                    <br /><br />
                    <asp:Button ID="btnAjaxContinue" runat="server" Text="Continue" 
                        onclick="btnAjaxContinue_Click" Visible="false" />
                </div>
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="btnajaxtest" EventName="Click" />
            <asp:AsyncPostBackTrigger ControlID="btnPasswordConfirm" EventName="Click" />
            <asp:AsyncPostBackTrigger ControlID="btnAjaxContinue" EventName="Click" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>

