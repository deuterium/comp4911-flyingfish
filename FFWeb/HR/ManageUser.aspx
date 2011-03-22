<%@ Page Title="User Management" Language="C#" MasterPageFile="~/FlyingFishMasterPage.master" AutoEventWireup="true"
    CodeFile="ManageUser.aspx.cs" Inherits="ManageUser" %>

<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="Server">
    Search for an Employee (Last Name):
    <asp:TextBox ID="tbSearch" runat="server"></asp:TextBox>
    <asp:Button ID="buttonSearch" runat="server" Text="Search" OnClick="buttonSearch_Click" />
    &nbsp;<asp:Button ID="buttonAllUsers" runat="server" Text="Show All Users" OnClick="buttonAllUsers_Click" />
    <hr />
    <asp:Label ID="lblSearchError" runat="server" Enabled="False"></asp:Label>
    <asp:GridView ID="gvManageUsers" runat="server" AutoGenerateSelectButton="True" OnSelectedIndexChanged="gvManageUsers_SelectedIndexChanged">
    </asp:GridView>
    <br />
    <div id="DivUserDetails" runat="server" visible="false">
        <table id="tableUserDetails">
        <tr>
        <td colspan="4"><b>Edit Employee Information</b></td>
        </tr>
            <tr>
                <td>
                    Employee ID Number:
                </td>
                <td>
                    <asp:Label ID="lblEmpId" runat="server" Width="125" />
                </td>
                <td>
                    Username:
                </td>
                <td>
                    <asp:Label ID="lblUsername" runat="server" Width="125" />
                </td>
            </tr>
            <tr>
                <td>
                    First Name:
                </td>
                <td>
                    <asp:TextBox ID="tbFirstName" runat="server" Width="125" />
                </td>
                <td>
                    Last Name:
                </td>
                <td>
                    <asp:TextBox ID="tbLastName" runat="server" Width="125" />
                </td>
            </tr>
            <tr>
                <td>
                    Supervisor:
                </td>
                <td>
                    <asp:DropDownList ID="DropDownList1" Width="125" runat="server">
                    </asp:DropDownList>
                </td>
                <td>
                    Timesheet Approver:
                </td>
                <td>
                    <asp:DropDownList ID="DropDownList2" Width="125" runat="server">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td>
                    Vacation Leave: 
                </td>
                <td>
                    <asp:TextBox ID="tbVacation" Width="125" runat="server" />
                </td>
                <td>
                    Sick Days:  
                </td>
                <td>
                    <asp:TextBox ID="tbSickDays" Width="125" runat="server" />
                </td>
            </tr>
            <tr>
                <td>
                    Min. Hours per Week:
                </td>
                <td>
                    <asp:TextBox ID="tbMinHours" Width="125" runat="server" />
                </td>
                <td>
                    Flex Hours: 
                </td>
                <td>
                    <asp:TextBox ID="tbFlexHours" Width="125" runat="server" />
                </td>
            </tr>
            <tr>
                <td>
                    Email Address:
                </td>
                <td>
                    <asp:TextBox ID="tbEmail" Width="125" runat="server" />
                </td>
                <td>
                    Active User: 
                </td>
                <td>
                    <asp:CheckBox id="cbActiveUser" Text="" runat="server" checked="false"/>
                </td>
            </tr>
        </table>
        <asp:Button ID="buttonDetailsSubmit" Text="Submit Changes" runat="server" />
    </div>
</asp:Content>
