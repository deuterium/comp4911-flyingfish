<%@ Page Title="" Language="C#" MasterPageFile="~/FlyingFishMasterPage.master" AutoEventWireup="true" CodeFile="ManageProject.aspx.cs" Inherits="PM_ManageProject" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" Runat="Server">
        <br />
        <table>
            <tr>
                <td align="right">
                    <asp:Label ID="lblProjID" runat="server" Text="Project ID: "></asp:Label>
                </td>
                <td>
                    <asp:Label ID="lblProjID2" runat="server" Text=""></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="right">
                    <asp:Label ID="lblProjName" runat="server" Text="Project Name: "></asp:Label>
                </td>
                <td>
                    <asp:Label ID="lblProjName2" runat="server" Text=""></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="left" colspan="2">
                    <asp:Label ID="lblMessage" runat="server" Text="List of work packages:"></asp:Label>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <asp:GridView ID="gvWorkPackages" runat="server" 
                        OnRowCommand="gvWorkPackages_RowCommand">
                        <Columns>
                            <asp:ButtonField Text="View" CommandName="btnView" />
                        </Columns>
                    </asp:GridView>
                </td>
            </tr>
            <tr>
                <td align="center" colspan="2">
                    <asp:LinkButton ID="lbCreateWP" runat="server" onclick="lbCreateWP_Click">Create a Work Package</asp:LinkButton>
                </td>
            </tr>
        </table>
</asp:Content>

