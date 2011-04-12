<%@ Page Title="" Language="C#" MasterPageFile="~/FlyingFishMasterPage.master" AutoEventWireup="true" CodeFile="TimesheetSummaryReport.aspx.cs" Inherits="Reports_TimesheetSummaryReport" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="ctnHeader" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="ctnBody" ContentPlaceHolderID="content" Runat="Server">
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
                    <asp:Label ID="lblDateFor" runat="server" Text="Cut-off Date:"></asp:Label>
                </td>
                <td>
                      <asp:TextBox ID="tbForDate" runat="server"></asp:TextBox>
                      <asp:CalendarExtender ID="cexForDate" runat="server" TargetControlID="tbForDate" Format="yyyy/MM/dd" >
                      </asp:CalendarExtender>
                      <asp:RegularExpressionValidator ForeColor="Red" ID="revCutOffDate" runat="server"
                        ValidationExpression="^[0-9]{4}/{1}[0-9]{2}/{1}[0-9]{2}$" ControlToValidate="tbForDate"
                        ErrorMessage="End date must be in format 'YYYY/MM/DD'" Text="*">
                      </asp:RegularExpressionValidator>
                      <asp:RangeValidator ForeColor="Red" ID="rgvCutOffDate" runat="server" ControlToValidate="tbForDate"
                        ErrorMessage="End date must be between 2010/01/01 and 2500/01/01." MaximumValue="2500/01/01"
                        MinimumValue="2010/01/01" Text="*">
                    </asp:RangeValidator>
                    <asp:RequiredFieldValidator ID="rfvForDate" runat="server" ControlToValidate="tbForDate" ForeColor="Red"
                        ErrorMessage="Cut-off date is required." Text="*"></asp:RequiredFieldValidator>
                </td>
            </tr>
        </table>
        <asp:ValidationSummary ForeColor="Red" ID="vsAllValidationErrors" runat="server" />
        <br />
        <asp:Button ID="btnSubmit" runat="server" Text="Submit" 
                        onclick="btnSubmit_Click" />
        <br />
        <br />

        <center>
        <asp:UpdatePanel ID="upGridView" runat="server">
            <ContentTemplate>
                <asp:Label ID="lblResults" runat="server" Text="" ForeColor="Green"></asp:Label>
                <asp:GridView ID="gvSummary" runat="server" BackColor="White" 
                    BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3" >
                    <FooterStyle BackColor="White" ForeColor="#000066" />
                    <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                    <RowStyle ForeColor="#000066" />
                    <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                    <SortedAscendingHeaderStyle BackColor="#007DBB" />
                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                    <SortedDescendingHeaderStyle BackColor="#00547E" />
                </asp:GridView>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="btnSubmit" EventName="Click" />
            </Triggers>
        </asp:UpdatePanel>
        </center>
</asp:Content>
