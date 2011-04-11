<%@ Page Title="" Language="C#" MasterPageFile="~/FlyingFishMasterPage.master" AutoEventWireup="true"
    CodeFile="TimesheetEntry.aspx.cs" Inherits="Timesheet_TimesheetEntry" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="Server">
    <style type="text/css">
        input
        {
            width: 30px;
        }
        
        .notes
        {
            width: 100px;
        }
        
        
        .style1
        {
            width: 161px;
        }
        
        .newRecord input
        {
           width: 100px;
        }
        
        
        .style2
        {
            width: 30%;
        }
        
        
        </style>
    <div id="divTimeSheet" runat="server">
        <table style="width: 100%;">
            <tr>
                <td class="style1">
                    &nbsp; Name
                </td>
                <td>
                    &nbsp;
                    <asp:LoginName ID="LoginName1" runat="server" />
                </td>
                <td>
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td class="style1">
                    &nbsp; Employee Number
                </td>
                <td>
                    &nbsp;
                    <asp:Label ID="lbEmpNo" runat="server" Text="Label"></asp:Label>
                </td>
                <td>
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td class="style1">
                    &nbsp; Date
                </td>
                <td>
                    &nbsp;
                    <asp:Label ID="lbDate" runat="server" Text="Label"></asp:Label>
                </td>
                <td>
                    &nbsp;
                </td>
            </tr>
        </table>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="empId,tsDate,projId,wpId"
            DataSourceID="LinqDataSource1" AllowPaging="True" AllowSorting="True" 
            CellPadding="3" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" 
            BorderWidth="1px">
            <Columns>
                <asp:CommandField ShowEditButton="True" />
                <asp:BoundField DataField="projId" HeaderText="projId" ReadOnly="True" SortExpression="projId" />
                <asp:BoundField DataField="wpId" HeaderText="wpId" ReadOnly="True" SortExpression="wpId" />
                <asp:BoundField DataField="sat" HeaderText="sat" SortExpression="sat" />
                <asp:BoundField DataField="sun" HeaderText="sun" SortExpression="sun" />
                <asp:BoundField DataField="mon" HeaderText="mon" SortExpression="mon" />
                <asp:BoundField DataField="tue" HeaderText="tue" SortExpression="tue" />
                <asp:BoundField DataField="wed" HeaderText="wed" SortExpression="wed" />
                <asp:BoundField DataField="thu" HeaderText="thu" SortExpression="thu" />
                <asp:BoundField DataField="fri" HeaderText="fri" SortExpression="fri" />
                <asp:BoundField DataField="notes" HeaderText="notes" SortExpression="notes">
                    <ControlStyle CssClass="notes" />
                </asp:BoundField>
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
        <asp:GridView ID="gvTotals" runat="server">
        </asp:GridView>
        <asp:LinqDataSource ID="LinqDataSource1" runat="server" ContextTypeName="FlyingFishClassesDataContext"
            EntityTypeName="" TableName="TimesheetEntries" Where="empId == @empId &amp;&amp; tsDate &gt;= @tsDate"
            EnableUpdate="True">
            <WhereParameters>
                <asp:SessionParameter Name="empId" SessionField="CurEmpId" Type="Int32" />
                <asp:SessionParameter Name="tsDate" SessionField="CurrentDate" Type="DateTime" />
            </WhereParameters>
        </asp:LinqDataSource>
        <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
        <asp:Button ID="btnNewRecord" runat="server" Text="NewRecord" OnClick="btnNewRecord_Click"
            Width="141px" />
    </div>
    <div id="divNewRecord" runat="server" class="newRecord">
        &nbsp;<br />
        <table class="style2">
            <tr>
                <td>
        Project ID:</td>
                <td>
        <asp:DropDownList ID="ddlProjectId" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlProjectId_SelectedIndexChanged">
        </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td>
        WP ID:</td>
                <td>
        <asp:DropDownList ID="ddlWpId" runat="server" AutoPostBack="True">
        </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td>
        Sunday:</td>
                <td>
        <asp:TextBox ID="tbSun" runat="server" Height="22px" Width="107px"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="tbSun"
            ErrorMessage="Work hour is required!" ForeColor="Red">*</asp:RequiredFieldValidator>
        <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="tbSun"
            ErrorMessage="You worked too hard!" ForeColor="Red" MaximumValue="15" MinimumValue="0"
            Type="Integer">*</asp:RangeValidator>
                </td>
            </tr>
            <tr>
                <td>
        Monday:</td>
                <td>
        <asp:TextBox ID="tbMon" runat="server"></asp:TextBox>
        <asp:RangeValidator ID="RangeValidator2" runat="server" ControlToValidate="tbMon"
            ErrorMessage="You worked too hard!" ForeColor="Red" MaximumValue="15" MinimumValue="0"
            Type="Integer">*</asp:RangeValidator>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="tbMon"
            ErrorMessage="Work hour is required!" ForeColor="Red">*</asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>
        Tuesday:</td>
                <td>
        <asp:TextBox ID="tbTue" runat="server"></asp:TextBox>
        <asp:RangeValidator ID="RangeValidator3" runat="server" ControlToValidate="tbThu"
            ErrorMessage="You worked too hard!" ForeColor="Red" MaximumValue="15" MinimumValue="0"
            Type="Integer">*</asp:RangeValidator>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="tbThu"
            ErrorMessage="Work hour is required!" ForeColor="Red">*</asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>
        Wednesday:</td>
                <td>
        <asp:TextBox ID="tbWed" runat="server"></asp:TextBox>
        <asp:RangeValidator ID="RangeValidator4" runat="server" ControlToValidate="tbWed"
            ErrorMessage="You worked too hard!" ForeColor="Red" MaximumValue="15" MinimumValue="0"
            Type="Integer">*</asp:RangeValidator>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="tbWed"
            ErrorMessage="Work hour is required!" ForeColor="Red">*</asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>
        Thursday:</td>
                <td>
        <asp:TextBox ID="tbThu" runat="server"></asp:TextBox>
        <asp:RangeValidator ID="RangeValidator5" runat="server" ControlToValidate="tbThu"
            ErrorMessage="You worked too hard!" ForeColor="Red" MaximumValue="15" MinimumValue="0"
            Type="Integer">*</asp:RangeValidator>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="tbThu"
            ErrorMessage="Work hour is required!" ForeColor="Red">*</asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>
        Friday:</td>
                <td>
        <asp:TextBox ID="tbFri" runat="server"></asp:TextBox>
        <asp:RangeValidator ID="RangeValidator6" runat="server" ControlToValidate="tbFri"
            ErrorMessage="You worked too hard!" ForeColor="Red" MaximumValue="15" MinimumValue="0"
            Type="Integer">*</asp:RangeValidator>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="tbFri"
            ErrorMessage="Work hour is required!" ForeColor="Red">*</asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>
        Saturday:</td>
                <td>
        <asp:TextBox ID="tbSat" runat="server"></asp:TextBox>
        <asp:RangeValidator ID="RangeValidator7" runat="server" ControlToValidate="tbSat"
            ErrorMessage="You worked too hard!" ForeColor="Red" MaximumValue="15" MinimumValue="0"
            Type="Integer">*</asp:RangeValidator>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="tbSat"
            ErrorMessage="Work hour is required!" ForeColor="Red">*</asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>
        Note:
                </td>
                <td>
        <asp:TextBox ID="tbNote" runat="server"></asp:TextBox>
                </td>
            </tr>
        </table>
        <br />
        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="Red" />
        <asp:Button ID="btnCreateNewRecord" runat="server" Text="Create" OnClick="btnCreateNewRecord_Click" />
    </div>
    <asp:Label ID="Label2" runat="server" Text="" ForeColor="Red"></asp:Label><br />
</asp:Content>
