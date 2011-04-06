<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CustomGridView_Sample.aspx.cs" Inherits="Reports_CustomGridView_Sample" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>

     <asp:GridView ID="gvStatus" runat="server" AutoGenerateColumns="False" OnRowCancelingEdit="gvStatus_RowCancelingEdit"
        OnRowCommand="gvStatus_RowCommand" OnRowEditing="gvStatus_RowEditing" OnRowUpdating="gvStatus_RowUpdating">
        <Columns>
            
            <asp:TemplateField HeaderText="FirstName LastName (EmpNo)">
                <EditItemTemplate>
                    <asp:Label ID="lblEmployee1" runat="server" Text='<%# Bind("EmpNameNumber") %>'></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblEmployee2" runat="server" Text='<%# Bind("EmpNameNumber") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            

            <asp:TemplateField HeaderText="Is this Employee Active?">
                <EditItemTemplate>
                    <asp:TextBox ID="tbEtc" Width="60px" runat="server" Text='<%# Bind("Active") %>' />
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblEtc" runat="server" Text='<%# Bind("Active") %>'></asp:Label>
                </ItemTemplate>
                <ControlStyle Width="75px" />
                <ItemStyle Width="75px" />
            </asp:TemplateField>
            

            <asp:CommandField ButtonType="Button" ShowEditButton="True" UpdateText="Save">
                <ItemStyle HorizontalAlign="Center" Wrap="False" />
            </asp:CommandField>
        </Columns>
    </asp:GridView>

    </div>
    </form>
</body>
</html>
