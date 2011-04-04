<%@ Page Title="" Language="C#" MasterPageFile="~/FlyingFishMasterPage.master" AutoEventWireup="true" CodeFile="TimesheetEntry2.aspx.cs" Inherits="Timesheet_TimesheetEntry2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" Runat="Server">
    Project ID: 
    <asp:DropDownList ID="ddlProjectId" runat="server" AutoPostBack="True" 
        onselectedindexchanged="ddlProjectId_SelectedIndexChanged">
    </asp:DropDownList>
    <asp:TextBox ID="tbProjectID" runat="server"></asp:TextBox><br />
    WP ID: 
    <asp:DropDownList ID="ddlWpId" runat="server" AutoPostBack="True">
    </asp:DropDownList>
    <asp:TextBox ID="tbWpID" runat="server"></asp:TextBox><br />
    Sunday: <asp:TextBox ID="tbSun" runat="server"></asp:TextBox><br />
    Monday: <asp:TextBox ID="tbMon" runat="server"></asp:TextBox><br />
    Tuesday: <asp:TextBox ID="tbTue" runat="server"></asp:TextBox><br />
    Wednesday: <asp:TextBox ID="tbWed" runat="server"></asp:TextBox><br />
    Thursday: <asp:TextBox ID="tbThu" runat="server"></asp:TextBox><br />
    Friday: <asp:TextBox ID="tbFri" runat="server"></asp:TextBox><br />
    Saturday: <asp:TextBox ID="tbSat" runat="server"></asp:TextBox><br />
    Note: <asp:TextBox ID="tbNote" runat="server"></asp:TextBox><br />

    <asp:Button ID="btnCreateNewRecord" runat="server" Text="Button" 
        onclick="btnCreateNewRecord_Click" />
    <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
</asp:Content>

