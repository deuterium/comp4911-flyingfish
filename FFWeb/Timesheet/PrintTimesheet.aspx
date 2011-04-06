<%@ Page Title="" Language="C#" MasterPageFile="~/FlyingFishMasterPage.master" AutoEventWireup="true"
    CodeFile="PrintTimesheet.aspx.cs" Inherits="Timesheet_PrintTimesheet" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="Server">

    Start Date:

    <asp:TextBox ID="tbPeriodStart" runat="server" Width="80"></asp:TextBox>
    <asp:RequiredFieldValidator ID="rfvStartDate" runat="server" ControlToValidate="tbPeriodStart"
        ErrorMessage="Please specifiy a start date." ForeColor="Red" 
        Display="Dynamic"></asp:RequiredFieldValidator>
    <asp:RangeValidator ID="RangeValidator1" runat="server" 
        ErrorMessage="Not a valid date!" Type="Date" MaximumValue="12/31/2100" 
        MinimumValue="1/1/1900" ControlToValidate="tbPeriodStart" ForeColor="#FF3300"></asp:RangeValidator>
 
        <asp:GridView ID="gvPrintTimesheet" runat="server">
        </asp:GridView>
        <asp:Button ID="btnGetTimesheet" runat="server" Text="Get Timesheet" OnClick="btnGetTimesheet_Click" />
        <asp:Label ID="Label1" runat="server"></asp:Label>
</asp:Content>
