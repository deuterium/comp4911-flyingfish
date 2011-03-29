<%@ Page Title="" Language="C#" MasterPageFile="~/FlyingFishMasterPage.master" AutoEventWireup="true" CodeFile="TimesheetSummaryReport.aspx.cs" Inherits="Reports_TimesheetSummaryReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" Runat="Server">
    Week 1 = <asp:Label ID="lblWeek1" runat="server" Text=""></asp:Label>
    <br />
    Week 2 = <asp:Label ID="lblWeek2" runat="server" Text=""></asp:Label>
    <br />
    Week 3 = <asp:Label ID="lblWeek3" runat="server" Text=""></asp:Label>
    <br />
    Week 4 = <asp:Label ID="lblWeek4" runat="server" Text=""></asp:Label>
    <br />
    <br />
    Month 1 = <asp:Label ID="lblMonth1" runat="server" Text=""></asp:Label>
    <br />
    Month 2 = <asp:Label ID="lblMonth2" runat="server" Text=""></asp:Label>
    <br />
    Month 3 = <asp:Label ID="lblMonth3" runat="server" Text=""></asp:Label>
    <br />
    Month 4 = <asp:Label ID="lblMonth4" runat="server" Text=""></asp:Label>
    <br />
    <br />

    <asp:GridView ID="gvSummary" runat="server">
    </asp:GridView>
</asp:Content>

