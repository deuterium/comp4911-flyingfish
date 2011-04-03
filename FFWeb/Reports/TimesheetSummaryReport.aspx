<%@ Page Title="" Language="C#" MasterPageFile="~/FlyingFishMasterPage.master" AutoEventWireup="true" CodeFile="TimesheetSummaryReport.aspx.cs" Inherits="Reports_TimesheetSummaryReport" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="ctnHeader" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="ctnBody" ContentPlaceHolderID="content" Runat="Server">
    <asp:ToolkitScriptManager ID="tsmManager" runat="server">
    </asp:ToolkitScriptManager>
    <center>
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
                      <asp:RegularExpressionValidator ForeColor="Red" ID="revDate" runat="server" ValidationExpression="^[0-9]{4}/{1}[0-9]{2}/{1}[0-9]{2}$"
                        ErrorMessage="* Date must be in format 'YYYY/MM/DD'" ControlToValidate="tbForDate">*</asp:RegularExpressionValidator>
                      <asp:RangeValidator ForeColor="Red" ID="rgvDate" runat="server" ErrorMessage="* Date must be between 2010/01/01 and 2500/01/01." ControlToValidate="tbForDate" MaximumValue="2500\01\01" MinimumValue="2010\01\01" Text="*"></asp:RangeValidator>
                </td>
            </tr>
        </table>
        <asp:ValidationSummary ForeColor="Red" ID="vsAllValidationErrors" runat="server" DisplayMode="List" />

        <br />
        <asp:Button ID="btnSubmit" runat="server" Text="Submit" 
                        onclick="btnSubmit_Click" />
        <br />
        <br />

        <asp:UpdatePanel ID="upGridView" runat="server">
            <ContentTemplate>
                <asp:GridView ID="gvSummary" runat="server" >
                </asp:GridView>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="btnSubmit" EventName="Click" />
            </Triggers>
        </asp:UpdatePanel>
    </center>
</asp:Content>
