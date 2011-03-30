<%@ Page Title="" Language="C#" MasterPageFile="~/FlyingFishMasterPage.master" AutoEventWireup="true" CodeFile="TimesheetSummaryReport.aspx.cs" Inherits="Reports_TimesheetSummaryReport" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" Runat="Server">
    <asp:ToolkitScriptManager ID="tsmManager" runat="server">
    </asp:ToolkitScriptManager>
    <table>
        <tr>
            <td>
                <asp:Label ID="lblProject" runat="server" Text="Project: "></asp:Label>
            </td>
            <td>
                <asp:DropDownList ID="ddlAllProjects" runat="server">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lblDateFor" runat="server" Text="Report Date:"></asp:Label>
            </td>
            <td>
                  <asp:TextBox ID="tbForDate" runat="server"></asp:TextBox>
                  <asp:CalendarExtender ID="cexForDate" runat="server" TargetControlID="tbForDate" Format="yyyy/MM/dd" >
                  </asp:CalendarExtender>
            </td>
        </tr>
    </table>
    <asp:Button ID="btnSubmit" runat="server" Text="Submit" 
        onclick="btnSubmit_Click" />
    <br />
    <br />

    <asp:GridView ID="gvSummary" runat="server" >
    </asp:GridView>
</asp:Content>
