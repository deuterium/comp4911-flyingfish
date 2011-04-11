<%@ Page Title="" Language="C#" MasterPageFile="~/FlyingFishMasterPage.master" AutoEventWireup="true"
    CodeFile="ManageProject.aspx.cs" Inherits="PM_ManageProject" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="Server">
    <asp:ScriptManager ID="sm1" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div>
                <table>
                    <tr>
                        <td>
                            <asp:Label ID="lblProjID" runat="server" Text="Project ID: " Font-Bold="true" Font-Size="Large" />
                        </td>
                        <td>
                            <asp:Label ID="lblProjID2" runat="server" Text="" />
                        </td>
                        <td>
                            <asp:Label ID="blank1" Text="&nbsp&nbsp&nbsp&nbsp&nbsp" runat="server" />
                        </td>
                        <td>
                            <asp:Label ID="lblAllocMsg" runat="server" Text="Allocated Budget: " Font-Bold="true"
                                Font-Size="Large" />
                        </td>
                        <td>
                            <asp:Label ID="lblAlloc2" runat="server" Text=""></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblProjName" runat="server" Text="Project Name: " Font-Bold="true"
                                Font-Size="Large" />
                        </td>
                        <td>
                            <asp:Label ID="lblProjName2" runat="server" Text="" />
                        </td>
                        <td>
                            <asp:Label ID="Label1" Text="&nbsp&nbsp&nbsp&nbsp&nbsp" runat="server" />
                        </td>
                        <td>
                            <asp:Label ID="lblUnallocMsg" runat="server" Text="Unallocated Budget: " Font-Bold="true"
                                Font-Size="Large" />
                            <asp:Label Visible="false" ID="lblUnallocMsg2" runat="server" Text="Unallocated Budget: " />
                        </td>
                        <td>
                            <asp:Label ID="lblUnalloc2" runat="server" Text="" />
                            <asp:TextBox ID="tbUnalloc" runat="server" Visible="false" />
                            <asp:CompareValidator ID="cvUnallocated" runat="server" Visible="false" ControlToValidate="tbUnalloc"
                                ErrorMessage="Invalid Budget." ForeColor="Red" Operator="DataTypeCheck" Type="Currency" />
                            &nbsp&nbsp&nbsp&nbsp&nbsp
                            <asp:RangeValidator ID="rvUnalloc" runat="server" ControlToValidate="tbUnalloc" ErrorMessage="Budget must be a positive number."
                                ForeColor="Red" MaximumValue="2147483647" MinimumValue="0" Type="Currency" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1">
                            <asp:Label ID="lblProjectManager" runat="server" Text="Project Manager:" Font-Bold="true"
                                Font-Size="Large" />
                        </td>
                        <td colspan="1">
                            <asp:Label ID="lblProjectManager2" runat="server" Text="" />
                        </td>
                    </tr>
                </table>
                <div id="divOriginalAlloc" runat="server">
                    <br />
                    <asp:Button ID="btnChangeAlloc" runat="server" Text="Edit Budget" OnClick="btnChangeAlloc_Click" />
                    <asp:Button ID="btnSaveAlloc" runat="server" Visible="false" Text="Save Changes"
                        OnClick="btnSaveAlloc_Click" />
                    <asp:Button ID="btnCancelAlloc" runat="server" Visible="false" Text="Cancel" CausesValidation="False"
                        OnClick="btnCancelAlloc_Click" />
                </div>
                <div id="divChangeAlloc" runat="server" visible="false">
                    <!--<asp:Label ID="lblAllocMsg2" runat="server" Text="Allocated Budget: " />
                        <asp:TextBox ID="tbAlloc" runat="server" />
                        <br />-->
                    <br />
                    <br />
                </div>
                <asp:Label ID="lblError" runat="server" ForeColor="Red"></asp:Label>
            </div>
            <br />
            <br />
            <asp:Label ID="lblActiveMessage" runat="server" Text="List of active work packages:"
                Font-Bold="True" Font-Size="Large" />
            <br />
            <div class="divline">
            </div>
            <br />
            <asp:GridView ID="gvWorkPackages" runat="server" OnRowCommand="gvWorkPackages_RowCommand"
                AutoGenerateColumns="False" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None"
                BorderWidth="1px" CellPadding="3" CssClass="cent">
                <Columns>
                    <asp:BoundField DataField="wpId" HeaderText="Work Package ID" SortExpression="wpId" />
                    <asp:BoundField DataField="name" HeaderText="Name" SortExpression="name" />
                    <asp:BoundField DataField="description" HeaderText="Description" SortExpression="description" />
                    <asp:BoundField DataField="unallocated_dollars" HeaderText="Unallocated Dollars"
                        SortExpression="unallocated_dollars" />
                    <asp:BoundField DataField="allocated_dollars" HeaderText="Allocated Dollars" SortExpression="allocated_dollars" />
                    <asp:BoundField DataField="projId" HeaderText="Project ID" SortExpression="projId"
                        Visible="False" />
                    <asp:ButtonField Text="View" CommandName="btnView" ButtonType="Button" />
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
            <asp:Label ID="lblUnactiveMessage" runat="server" Text="List of inactive work packages:"
                Font-Bold="True" Font-Size="Large" />
            <br />
            <div class="divline">
            </div>
            <br />
            <asp:GridView ID="gvUnactiveWP" runat="server" OnRowCommand="gvUnactiveWP_RowCommand"
                AutoGenerateColumns="False" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None"
                BorderWidth="1px" CellPadding="3" CssClass="cent">
                <Columns>
                    <asp:BoundField DataField="wpId" HeaderText="Work Package ID" SortExpression="wpId" />
                    <asp:BoundField DataField="name" HeaderText="Name" SortExpression="name" />
                    <asp:BoundField DataField="description" HeaderText="Description" SortExpression="description" />
                    <asp:BoundField DataField="unallocated_dollars" HeaderText="Unallocated Dollars"
                        SortExpression="unallocated_dollars" />
                    <asp:BoundField DataField="allocated_dollars" HeaderText="Allocated Dollars" SortExpression="allocated_dollars" />
                    <asp:BoundField DataField="projId" HeaderText="Project ID" SortExpression="projId"
                        Visible="False" />
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
            <br />
            <asp:Button ID="lbCreateWP" Text="Create a Work Package" runat="server" OnClick="lbCreateWP_Click">
            </asp:Button>
            <asp:Button ID="lbProjectList" runat="server" Text="View Project List" OnClick="lbProjectList_Click">
            </asp:Button>
            <br />
            <asp:Label ID="lblException" runat="server" Text=""></asp:Label>
            <br />
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
