<%@ Page Language="C#" Title="" AutoEventWireup="true" CodeFile="TimeSheetv3.aspx.cs" Inherits="Timesheet_TimeSheetv3"   EnableEventValidation="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:GridView ID="dvTimeSheet" AutoGenerateColumns="False" runat="server" OnRowCancelingEdit="dvTimeSheet_RowCancelingEdit"
            OnRowEditing="dvTimeSheet_RowEditing" OnRowCommand="dvTimeSheet_RowCommand" OnRowUpdating="dvTimeSheet_RowUpdating">
            <Columns>
                <asp:TemplateField HeaderText="ProjID">
                    <EditItemTemplate>
                        <asp:Label ID="lblProj" runat="server" Text='<%# Bind("ProjID") %>'></asp:Label>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblProj2" runat="server" Text='<%# Bind("ProjID") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Work Package ID">
                    <EditItemTemplate>
                        <asp:Label ID="lblWp" runat="server" Text='<%# Bind("WpID") %>'></asp:Label>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblWp2" runat="server" Text='<%# Bind("WpID") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Mon">
                    <EditItemTemplate>
                        <asp:TextBox ID="tbMon" Width="60px" runat="server" Text='<%# Bind("Mon") %>' />
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblMon" runat="server" Text='<%# Bind("Mon") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Tue">
                    <EditItemTemplate>
                        <asp:TextBox ID="tbTue" Width="60px" runat="server" Text='<%# Bind("Tue") %>' />
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblTue" runat="server" Text='<%# Bind("Tue") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Wed">
                    <EditItemTemplate>
                        <asp:TextBox ID="tbWed" Width="60px" runat="server" Text='<%# Bind("Wed") %>' />
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblWed" runat="server" Text='<%# Bind("Wed") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Thur">
                    <EditItemTemplate>
                        <asp:TextBox ID="tbThur" Width="60px" runat="server" Text='<%# Bind("Thur") %>' />
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblThur" runat="server" Text='<%# Bind("Thur") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Fri">
                    <EditItemTemplate>
                        <asp:TextBox ID="tbFri" Width="60px" runat="server" Text='<%# Bind("Fri") %>' />
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblFri" runat="server" Text='<%# Bind("Fri") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Sat">
                    <EditItemTemplate>
                        <asp:TextBox ID="tbSat" Width="60px" runat="server" Text='<%# Bind("Sat") %>' />
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblSat" runat="server" Text='<%# Bind("Sat") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Sun">
                    <EditItemTemplate>
                        <asp:TextBox ID="tbSun" Width="60px" runat="server" Text='<%# Bind("Sun") %>' />
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblSun" runat="server" Text='<%# Bind("Sun") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Notes">
                    <EditItemTemplate>
                        <asp:TextBox ID="tbNote" Width="60px" runat="server" Text='<%# Bind("Notes") %>' />
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblNote" runat="server" Text='<%# Bind("Notes") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:CommandField ButtonType="Button" CausesValidation="false" ShowEditButton="True" UpdateText="Update" >
                
                    <ItemStyle HorizontalAlign="Center" Wrap="False" />
                </asp:CommandField>
            </Columns>
        </asp:GridView>
    </div>
    </form>
</body>
</html>
