<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Project.aspx.cs" Inherits="PM_Project" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div id="divCreateProject" runat="server" visible="true">
    <table>
        <tr>
            <td colspan="2">
                <asp:Label ID="lblMsg" runat="server" Text="Fill in the following information below to create a project." />
            </td>
        </tr>
        <tr>
            <td align="right">
                <asp:Label ID="lblProjectID" runat="server" Text="Project ID: "></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="tbProjectID" runat="server" />
                <asp:RequiredFieldValidator ID="rfvID" runat="server" 
                    ControlToValidate="tbProjectID" ErrorMessage="Project ID is required" 
                    ForeColor="Red">*</asp:RequiredFieldValidator>
                <asp:CompareValidator ID="cvID" runat="server" 
                    ErrorMessage="ID must be an integer." ForeColor="Red" Operator="DataTypeCheck" 
                    Type="Integer" ControlToValidate="tbProjectID">*</asp:CompareValidator>
            </td>
        </tr>
        <tr>
            <td align="right">
                <asp:Label ID="lblProjectName" runat="server" Text="Project Name: "></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="tbProjectName" runat="server" />
                <asp:RequiredFieldValidator ID="rfvName" runat="server" 
                    ControlToValidate="tbProjectName" ErrorMessage="Project name is required" 
                    ForeColor="Red">*</asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revName" runat="server" 
                    ControlToValidate="tbProjectName" 
                    ErrorMessage="Project name must only contain letters from A-Z." 
                    ForeColor="Red" ValidationExpression="^[a-zA-Z\s]+$">*</asp:RegularExpressionValidator>
            </td>
        </tr>
        <tr>
            <td colspan="2" align="center">
                <asp:Button ID="btnCreateProject" runat="server" Text="Create Project" 
                    onclick="btnCreateProject_Click" />
            </td>
        </tr>
    </table>
        <asp:Label ID="lblError" runat="server" Text="" ForeColor="Red"></asp:Label>
    <asp:ValidationSummary ID="vsCreateProject" runat="server" ForeColor="Red" />
    </div>
    <div id="divCreateSuccess" runat="server" visible="false">
        <asp:Label ID="lblSuccessMsg" runat="server" 
            Text="Project is successfully created." ForeColor="Lime"></asp:Label>
        <br />
        <asp:Button ID="btnCreate" runat="server" Text="Manage Project" 
            onclick="btnCreate_Click" style="height: 26px" />
        <asp:Button ID="btnViewProjects" runat="server" Text="View Projects" 
            onclick="btnViewProjects_Click" />
    </div>
    </form>
</body>
</html>
