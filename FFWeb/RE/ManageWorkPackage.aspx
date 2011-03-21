<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ManageWorkPackage.aspx.cs" Inherits="RE_ManageWorkPackage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table>
            <tr>
                <td align="right">
                    <asp:Label ID="lblWPName" runat="server" Text="Work Package: "></asp:Label>
                </td>
                <td>
                    <asp:Label ID="lblWPName2" runat="server" Text=""></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="right">
                    <asp:Label ID="lblWPID" runat="server" Text="Work Package ID: "></asp:Label>
                </td>
                <td>
                    <asp:Label ID="lblWPID2" runat="server" Text=""></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="right">
                    <asp:Label ID="lblAlloc" runat="server" Text="Allocated Budget: "></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="tbAlloc" runat="server" Text="" />
                </td>
            </tr>
            <tr>
                <td align="right">
                    <asp:Label ID="lblUnalloc" runat="server" Text="Unallocated Budget: "></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="tbUnalloc" runat="server" Text="" />
                </td>
            </tr>
            <tr>
                <td align="right">
                    <asp:Label ID="lblDescription" runat="server" Text="Description: "></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="tbDescription" runat="server" Text="" TextMode="MultiLine" />
                </td>
            </tr>
            <tr>
                <td align="right">
                    <asp:Label ID="lblEmployeeList" runat="server" Text="Assigned Employees: "></asp:Label>
                </td>
                <td>
                    <asp:GridView ID="gvEmployees" runat="server">
                    </asp:GridView>
                </td>
            </tr>
            </table>
            <asp:LinkButton ID="lbAssignEmp" runat="server" onclick="lbAssignEmp_Click">Assign a Employee</asp:LinkButton>
            <asp:LinkButton ID="lbAssignRE" runat="server">Assign a Responsible Engineer</asp:LinkButton>
    </div>
    <div id="divAssignEmp" runat="server" visible="false">
        <asp:Label ID="lblAEmp" runat="server" Text="Choose an employee to add to work package:"></asp:Label>
        <asp:GridView ID="gvUnassignedEmployees" runat="server" 
            onselectedindexchanged="gvUnassignedEmployees_SelectedIndexChanged" 
            OnRowCommand="gvUnassignedEmployees_RowCommand" style="margin-left: 0px">
            <Columns>
                <asp:ButtonField ButtonType="Button" Text="Add" CommandName="btnAdd" />
            </Columns>
        </asp:GridView>
    </div>
    </form>
    
</body>
</html>
