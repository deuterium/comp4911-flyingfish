<%@ Page Language="C#" Title="New WorkPackage" MasterPageFile="~/FlyingFishMasterPage.master"
    AutoEventWireup="true" CodeFile="WorkPackage.aspx.cs" Inherits="RE_WorkPackage" %>

<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="Server">
    <div id="divCreateWorkPackage" runat="server">
        <asp:Label ID="lblMsg2" runat="server" Text="Work Package Creation" Font-Bold="true"
            Font-Size="Large" />
        <br />
        <div class="divline" />
        <br />
        <asp:Label ID="lblMsg" runat="server" Text="Fill in the following information below to create a work package." />
        <br />
        <br />
        <table>
            <tr>
                <td align="right">
                    <asp:Label ID="lblwpID" runat="server" Text="Work Package ID: " />
                </td>
                <td>
                    <asp:Label ID="lblProjID" runat="server" Text="" ForeColor="#660066"></asp:Label>
                    <asp:TextBox ID="tbwpID" runat="server" />
                    <asp:RequiredFieldValidator ID="rfvID" runat="server" ControlToValidate="tbwpID"
                        ErrorMessage="Work Package ID is required." ForeColor="Red">*</asp:RequiredFieldValidator>
                    <asp:CompareValidator ID="cvID" runat="server" ControlToValidate="tbwpID" ErrorMessage="Work Package ID must be an int."
                        ForeColor="Red" Type="Integer" Operator="DataTypeCheck">*</asp:CompareValidator>
                    <asp:RangeValidator ID="rvID" runat="server" ControlToValidate="tbwpID" ErrorMessage="Work Package ID must be a positive integer."
                        ForeColor="Red" MaximumValue="2147483647" MinimumValue="1" Type="Integer">*</asp:RangeValidator>
                </td>
                <td align="right">
                    <asp:Label ID="lblwpName" runat="server" Text="Work Package Name: " />
                </td>
                <td>
                    <asp:TextBox ID="tbwpName" runat="server" />
                    <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="tbwpName"
                        ErrorMessage="Work Package Name is required." ForeColor="Red">*</asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revName" runat="server" ControlToValidate="tbwpName"
                        ErrorMessage="Work package name must only contain letters from A-Z." ForeColor="Red"
                        ValidationExpression="^[a-zA-Z\s]+$">*</asp:RegularExpressionValidator>
                </td>
            </tr>
            <tr>
                <td align="left">
                    <asp:Label ID="lblDescription" runat="server" Text="Description: " />
                </td>
            </tr>
            <tr>
                <td colspan="4">
                    <asp:TextBox ID="tbDescription" runat="server" Rows="10" Width="515px" TextMode="MultiLine" />
                </td>
            </tr>
            <tr>
                <td align="center" colspan="2">
                    <asp:Label ID="lblError" runat="server" ForeColor="Red"></asp:Label>
                    <asp:ValidationSummary ID="vsSummary" runat="server" ForeColor="Red" />
                    <br />
                </td>
            </tr>
        </table>
        <asp:Button ID="btnCreateWorkPackage" runat="server" Text="Create Work Package" OnClick="btnCreateWorkPackage_Click" />
        <br />
        <br />
        <asp:LinkButton ID="lbProjectList" runat="server" OnClick="lbProjectList_Click" CausesValidation="False">Go to Project List</asp:LinkButton>
        <br />
        <asp:LinkButton ID="lbProject" runat="server" CausesValidation="False" OnClick="lbProject_Click">Go to Project</asp:LinkButton>
        <br />
    </div>
    <div id="divCreateSuccess" runat="server" visible="false">
        <asp:Label ID="lblSuccessMsg" runat="server" Text="Work Package is successfully created."
            ForeColor="Lime"></asp:Label>
        <br />
        <asp:Button ID="btnManage" runat="server" Text="Manage Work Package" OnClick="btnManage_Click" />
    </div>
    <asp:Label ID="lblException" runat="server" Text=""></asp:Label>
</asp:Content>
