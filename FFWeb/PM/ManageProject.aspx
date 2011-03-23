<%@ Page Title="" Language="C#" MasterPageFile="~/FlyingFishMasterPage.master" AutoEventWireup="true" CodeFile="ManageProject.aspx.cs" Inherits="PM_ManageProject" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" Runat="Server">
        <br />
            <div align="center">
                    <asp:Label ID="lblProjID" runat="server" Text="Project ID: " Font-Bold="true" Font-Size="Large" />
                    <asp:Label ID="lblProjID2" runat="server" Text="" Font-Bold="true" Font-Size="Large" />
                    <br />
                    <asp:Label ID="lblProjName" runat="server" Text="Project Name: " Font-Bold="true" Font-Size="Large" />
                    <asp:Label ID="lblProjName2" runat="server" Text="" Font-Bold="true" Font-Size="Large" />
            </div>
                    <br /><br />
                    <asp:Label ID="lblMessage" runat="server" Text="List of work packages:" Font-Bold="true" Font-Size="Large" />
                    <br /><br /><br />

                    <asp:GridView ID="gvWorkPackages" runat="server" 
                        OnRowCommand="gvWorkPackages_RowCommand" AutoGenerateColumns="False" 
                        BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" 
                        CellPadding="3" CssClass="cent">
                        <Columns>
                            <asp:BoundField DataField="wpId" HeaderText="Work Package ID" 
                                SortExpression="wpId" />
                            <asp:BoundField DataField="name" HeaderText="Name" SortExpression="name" />
                            <asp:BoundField DataField="description" HeaderText="Description" 
                                SortExpression="description" />
                            <asp:BoundField DataField="unallocated_dollars" 
                                HeaderText="Unallocated Dollars" SortExpression="unallocated_dollars" />
                            <asp:BoundField DataField="allocated_dollars" HeaderText="Allocated Dollars" 
                                SortExpression="allocated_dollars" />
                            <asp:BoundField DataField="projId" HeaderText="Project ID" 
                                SortExpression="projId" Visible="False" />
                            <asp:ButtonField Text="View Workpackages" CommandName="btnView" 
                                ButtonType="Button" />
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

                    <asp:LinkButton ID="lbCreateWP" runat="server" onclick="lbCreateWP_Click">Create a Work Package</asp:LinkButton>
        <asp:LinkButton ID="lbProjectList" runat="server" onclick="lbProjectList_Click">View Project List</asp:LinkButton>
        </asp:Content>

