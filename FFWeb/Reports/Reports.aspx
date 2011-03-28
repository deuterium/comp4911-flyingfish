<%@ Page Title="" Language="C#" MasterPageFile="~/FlyingFishMasterPage.master" AutoEventWireup="true"
    CodeFile="Reports.aspx.cs" Inherits="Reports_Reports" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="Server">
    <table>
        <tr>
            <td>
                Project ID:
            </td>
            <td>
                <asp:TextBox ID="tbProjectID" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                Start Date:
            </td>
            <td>
                <asp:TextBox ID="tbStartDate" runat="server"></asp:TextBox>
            </td>
            <td>
                End Date:
            </td>
            <td>
                <asp:TextBox ID="tbEndDate" runat="server"></asp:TextBox>
            </td>
        </tr>
    </table>
    <asp:Button ID="btnReport" runat="server" Text="Generate Report" 
        onclick="btnReport_Click" />

    <div class="divline"></div>

    <asp:GridView ID="gvReport" runat="server">
    </asp:GridView>

</asp:Content>
