<%@ Page Title="" Language="C#" MasterPageFile="~/FlyingFishMasterPage.master" AutoEventWireup="true"
    CodeFile="PrintTimesheet.aspx.cs" Inherits="Timesheet_PrintTimesheet" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="Server">
    
    <asp:GridView ID="gvPrintTimesheet" runat="server">
    </asp:GridView>
    
    <asp:Button ID="btnGetTimesheet" runat="server" Text="Get Timesheet" 
        onclick="btnGetTimesheet_Click" />
</asp:Content>
