<%@ Page Language="C#" Title="New WorkPackage" MasterPageFile="~/FlyingFishMasterPage.master" AutoEventWireup="true" CodeFile="WorkPackage.aspx.cs" Inherits="RE_WorkPackage" %>
<asp:Content ID="Content2" ContentPlaceHolderID="content" Runat="Server">

    <div id="divCreateWorkPackage" runat="server">
        <table>
            <tr>
                <td colspan="2">
                    <asp:Label ID="lblMsg" runat="server" Text="Fill in the following information below to create a work package." />
                </td>
            </tr>
            <tr>
                <td align="right">
                    <asp:Label ID="lblwpID" runat="server" Text="Work Package ID: " />
                </td>
                <td>
                    <asp:TextBox ID="tbwpID" runat="server" />
                    <asp:RequiredFieldValidator ID="rfvID" runat="server" 
                        ControlToValidate="tbwpID" ErrorMessage="Work Package ID is required." 
                        ForeColor="Red">*</asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td align="right">
                    <asp:Label ID="lblwpName" runat="server" Text="Work Package Name: " />
                </td>
                <td>
                    <asp:TextBox ID="tbwpName" runat="server" />
                    <asp:RequiredFieldValidator ID="rfvName" runat="server" 
                        ControlToValidate="tbwpName" ErrorMessage="Work Package Name is required." 
                        ForeColor="Red">*</asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revName" runat="server" 
                    ControlToValidate="tbwpName" 
                    ErrorMessage="Work package name must only contain letters from A-Z." 
                    ForeColor="Red" ValidationExpression="^[a-zA-Z\s]+$">*</asp:RegularExpressionValidator>
                </td>
            </tr>
            <tr>
                <td align="right">
                    <asp:Label ID="lblAllocated" runat="server" Text="Allocated Budget: " />
                </td>
                <td>
                    <asp:TextBox ID="tbAllocated" runat="server" />
                    <asp:RequiredFieldValidator ID="rfvAllocated" runat="server" 
                        ControlToValidate="tbAllocated" ErrorMessage="Allocated budget is required." 
                        ForeColor="Red">*</asp:RequiredFieldValidator>
                    <asp:CompareValidator ID="cvAllocated" runat="server" 
                        ControlToValidate="tbAllocated" 
                        ErrorMessage="Allocated budget must be an integer." ForeColor="Red" 
                        Operator="DataTypeCheck" Type="Integer">*</asp:CompareValidator>
                </td>
            </tr>
            <tr>
                <td align="right">
                    <asp:Label ID="lblUnallocated" runat="server" Text="Unallocated Budget: " />
                </td>
                <td>
                    <asp:TextBox ID="tbUnallocated" runat="server" />
                    <asp:RequiredFieldValidator ID="rfvUnallocated" runat="server" 
                        ControlToValidate="tbUnallocated" 
                        ErrorMessage="Unallocated budget is required." ForeColor="Red">*</asp:RequiredFieldValidator>
                    <asp:CompareValidator ID="cvUnallocated" runat="server" 
                        ControlToValidate="tbUnallocated" 
                        ErrorMessage="Unallocated budget must be an integer." ForeColor="Red" 
                        Operator="DataTypeCheck" Type="Integer">*</asp:CompareValidator>
                </td>
            </tr>
            <tr>
                <td align="right">
                    <asp:Label ID="lblDescription" runat="server" Text="Description: " />
                </td>
                <td>
                    <asp:TextBox ID="tbDescription" runat="server" Rows="10" TextMode="MultiLine" />
                </td>
            </tr>
            <tr>
                <td align="center" colspan="2">
                    <asp:Button ID="btnCreateWorkPackage" runat="server" Text="Create Work Package" 
                        onclick="btnCreateWorkPackage_Click" />
                    <br />
                    <asp:Label ID="lblError" runat="server" ForeColor="Red"></asp:Label>
                </td>
            </tr>
        </table>
    </div>
    <div id="divCreateSuccess" runat="server" visible="false">
        <asp:Label ID="lblSuccessMsg" runat="server" 
            Text="Work Package is successfully created." ForeColor="Lime"></asp:Label>
        <br />
        <asp:Button ID="btnCreate" runat="server" Text="Create Another Work Package" 
            onclick="btnCreate_Click" />
    </div>
</asp:Content>