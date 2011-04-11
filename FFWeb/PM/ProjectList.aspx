﻿<%@ Page Title="" Language="C#" MasterPageFile="~/FlyingFishMasterPage.master" AutoEventWireup="true"
    CodeFile="ProjectList.aspx.cs" Inherits="PM_ProjectList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .style1
        {
            width: 222px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="Server">
    <br />
    <div id="divproj">
        <asp:Label ID="lblMsg" runat="server" Text="List of Active Projects:" Font-Bold="true"
            Font-Size="Large"></asp:Label>
        <br />
        <div class="divline" runat="server" />
        <br />
        <asp:GridView ID="gvProjects" runat="server" OnRowCommand="gvProjects_RowCommand"
            AutoGenerateColumns="False" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None"
            BorderWidth="1px" CellPadding="3" CssClass="cent">
            <Columns>
                <asp:BoundField DataField="projID" HeaderText="Project ID" SortExpression="projID" />
                <asp:BoundField DataField="projName" HeaderText="Project Name" SortExpression="projName" />
                <asp:BoundField DataField="manager" HeaderText="Manager" SortExpression="manager" />
                <asp:ButtonField CommandName="btnView" Text="View" ButtonType="Button" />
                <asp:ButtonField ButtonType="Button" CommandName="btnDeactivate" Text="Deactivate" />
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
        <br />
    </div>
    <div id="divunactiveproj">
        <asp:Label ID="lblMsg2" runat="server" Text="List of Inactive Projects:" Font-Bold="true"
            Font-Size="Large"></asp:Label>
        <br />
        <div id="Div1" class="divline" runat="server" />
        <br />
        <asp:GridView ID="gvUnassignedProj" runat="server" OnRowCommand="gvUnassignedProj_RowCommand"
            AutoGenerateColumns="False" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None"
            BorderWidth="1px" CellPadding="3" CssClass="cent">
            <Columns>
                <asp:BoundField DataField="projID" HeaderText="Project ID" SortExpression="projID" />
                <asp:BoundField DataField="projName" HeaderText="Project Name" SortExpression="projName" />
                <asp:BoundField DataField="manager" HeaderText="Manager" SortExpression="manager" />
                <asp:ButtonField ButtonType="Button" CommandName="btnActivate" Text="Activate" />
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
    </div>
    <asp:Label ID="lblException" runat="server"></asp:Label>
</asp:Content>
