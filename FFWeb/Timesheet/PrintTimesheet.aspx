<%@ Page Title="" Language="C#" MasterPageFile="~/FlyingFishMasterPage.master" AutoEventWireup="true"
    CodeFile="PrintTimesheet.aspx.cs" Inherits="Timesheet_PrintTimesheet" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    Start Date:

    <asp:TextBox ID="tbPeriodStart" runat="server" Width="80"></asp:TextBox>
                    <asp:CalendarExtender ID="cexPeriodStart" runat="server" Format="yyyy/MM/dd" TargetControlID="tbPeriodStart" >
                    </asp:CalendarExtender>
                    <asp:RequiredFieldValidator ID="rfvStartDate" runat="server" Text="*" ControlToValidate="tbPeriodStart"
                        ErrorMessage="Please specifiy a start date." ForeColor="Red">
                    </asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ForeColor="Red" ID="revStartDate" runat="server" 
                        ValidationExpression="^[0-9]{4}/{1}[0-9]{2}/{1}[0-9]{2}$" ControlToValidate="tbPeriodStart"
                        ErrorMessage="Start date must be in format 'YYYY/MM/DD'" >*</asp:RegularExpressionValidator>
                    <asp:RangeValidator ForeColor="Red" ID="rgvStartDate" runat="server" ControlToValidate="tbPeriodStart"
                        ErrorMessage="Start date must be between 2010/01/01 and 2500/01/01."
                        MaximumValue="2500/01/01" MinimumValue="2010/01/01" Text="*">
                    </asp:RangeValidator>
 
        <asp:GridView ID="gvPrintTimesheet" runat="server">
        </asp:GridView>
        <asp:Button ID="btnGetTimesheet" runat="server" Text="Get Timesheet" OnClick="btnGetTimesheet_Click" />
        <asp:Label ID="Label1" runat="server"></asp:Label>
</asp:Content>
