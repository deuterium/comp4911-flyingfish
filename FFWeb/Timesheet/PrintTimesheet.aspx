<%@ Page Title="" Language="C#" MasterPageFile="~/FlyingFishMasterPage.master" AutoEventWireup="true"
    CodeFile="PrintTimesheet.aspx.cs" Inherits="Timesheet_PrintTimesheet" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>

    <asp:Label ID="lbltpTitle" runat="server" Text="Timesheet List" Font-Bold="true" Font-Size="Large" />
    <br />
    <div class="divline"></div>
    <br />
    <asp:Label Text="Start Date: " runat="server" ID="lbltpStart" />
    <asp:TextBox ID="tbPeriodStart" runat="server" Width="80"></asp:TextBox>
    <asp:CalendarExtender ID="cexPeriodStart" runat="server" Format="yyyy/MM/dd" TargetControlID="tbPeriodStart">
    </asp:CalendarExtender>
    <asp:RequiredFieldValidator ID="rfvStartDate" runat="server" Text="*" ControlToValidate="tbPeriodStart"
        ErrorMessage="Please specifiy a start date." ForeColor="Red">
    </asp:RequiredFieldValidator>
    <asp:RegularExpressionValidator ForeColor="Red" ID="revStartDate" runat="server"
        ValidationExpression="^[0-9]{4}/{1}[0-9]{2}/{1}[0-9]{2}$" ControlToValidate="tbPeriodStart"
        ErrorMessage="Start date must be in format 'YYYY/MM/DD'">*</asp:RegularExpressionValidator>
    <asp:RangeValidator ForeColor="Red" ID="rgvStartDate" runat="server" ControlToValidate="tbPeriodStart"
        ErrorMessage="Start date must be between 2010/01/01 and 2500/01/01." MaximumValue="2500/01/01"
        MinimumValue="2010/01/01" Text="*">
    </asp:RangeValidator>


    <asp:Label Text="End Date: " runat="server" ID="lbltpEnd" />
    <asp:TextBox ID="tbPeriodEnd" runat="server" Width="80"></asp:TextBox>
    <asp:CalendarExtender ID="cexPeriodEnd" runat="server" Format="yyyy/MM/dd" TargetControlID="tbPeriodEnd">
    </asp:CalendarExtender>
    <asp:CompareValidator ID="CompareValidator1" runat="server" 
        ControlToCompare="tbPeriodStart" ControlToValidate="tbPeriodEnd" 
        ErrorMessage="End date must be larger than start date!" ForeColor="Red" 
        Operator="GreaterThan" Type="Date">*</asp:CompareValidator>
    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Text="*" ControlToValidate="tbPeriodEnd"
        ErrorMessage="Please specifiy a start date." ForeColor="Red">
    </asp:RequiredFieldValidator>
    <asp:RegularExpressionValidator ForeColor="Red" ID="RegularExpressionValidator1" runat="server"
        ValidationExpression="^[0-9]{4}/{1}[0-9]{2}/{1}[0-9]{2}$" ControlToValidate="tbPeriodEnd"
        ErrorMessage="End date must be in format 'YYYY/MM/DD'">*</asp:RegularExpressionValidator>
    <asp:RangeValidator ForeColor="Red" ID="RangeValidator1" runat="server" ControlToValidate="tbPeriodEnd"
        ErrorMessage="End date must be between 2010/01/01 and 2500/01/01." MaximumValue="2500/01/01"
        MinimumValue="2010/01/01" Text="*">
    </asp:RangeValidator>
    <br /><br />
    <center>
    <asp:GridView ID="gvPrintTimesheet" runat="server" BackColor="White" AutoGenerateColumns="False"
        BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3">
        <Columns>
            <asp:BoundField DataField="Project" HeaderText="Project ID" 
                SortExpression="Project" />
            <asp:BoundField DataField="WP" HeaderText="Work Package ID" 
                SortExpression="WP" />
            <asp:BoundField DataField="total" HeaderText="Total Hours" 
                SortExpression="total" />
            <asp:BoundField DataField="Sun" HeaderText="Sun" SortExpression="Sun" />
            <asp:BoundField DataField="Mon" HeaderText="Mon" SortExpression="Mon" />
            <asp:BoundField DataField="Tue" HeaderText="Tue" SortExpression="Tue" />
            <asp:BoundField DataField="Wed" HeaderText="Wed" SortExpression="Wed" />
            <asp:BoundField DataField="Thu" HeaderText="Thu" SortExpression="Thu" />
            <asp:BoundField DataField="Fri" HeaderText="Fri" SortExpression="Fri" />
            <asp:BoundField DataField="Sat" HeaderText="Sat" SortExpression="Sat" />
            <asp:BoundField DataField="Note" HeaderText="Notes" SortExpression="Note" />
            <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date" />
        </Columns>
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
    </center>
    <br />
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="Red" />
    <br />
    <asp:Button ID="btnGetTimesheet" runat="server" Text="Get Timesheet" OnClick="btnGetTimesheet_Click" />
    <asp:Label ID="Label1" runat="server"></asp:Label>
</asp:Content>
