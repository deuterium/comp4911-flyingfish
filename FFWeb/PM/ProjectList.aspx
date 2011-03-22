<%@ Page Title="" Language="C#" MasterPageFile="~/FlyingFishMasterPage.master" AutoEventWireup="true" CodeFile="ProjectList.aspx.cs" Inherits="PM_ProjectList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .style1
        {
            width: 222px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" Runat="Server">
    <br />
    <table>
        <tr>
            <td colspan="2">
                <asp:Label ID="lblMsg" runat="server" Text="List of Projects:"></asp:Label>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <asp:GridView ID="gvProjects" runat="server" OnRowCommand="gvProjects_RowCommand">
                    <Columns>
                        <asp:ButtonField CommandName="btnView" Text="View" />
                    </Columns>
                </asp:GridView>
            </td>
        </tr>
        
    </table>
</asp:Content>

