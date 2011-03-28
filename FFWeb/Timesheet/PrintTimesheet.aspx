<%@ Page Title="" Language="C#" MasterPageFile="~/FlyingFishMasterPage.master" AutoEventWireup="true"
    CodeFile="PrintTimesheet.aspx.cs" Inherits="Timesheet_PrintTimesheet" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="Server">
    
   
    Start Date:
    <asp:TextBox ID="tbStartDate" runat="server"></asp:TextBox>
    <asp:RangeValidator ID="rvDate" runat="server" 
        ErrorMessage="Invalid format or Not within the valid time period (1900 ~ 2100)" 
        Type="Date" ControlToValidate="tbStartDate" ForeColor="Red" 
        MaximumValue="2100/12/31" MinimumValue="1900/1/1"></asp:RangeValidator>
    
    <asp:GridView ID="gvPrintTimesheet" runat="server">
    </asp:GridView>
    
    <asp:Button ID="btnGetTimesheet" runat="server" Text="Get Timesheet" 
        onclick="btnGetTimesheet_Click" />
</asp:Content>
