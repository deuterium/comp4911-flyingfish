<%@ Page Title="" Language="C#" MasterPageFile="~/FlyingFishMasterPage.master" AutoEventWireup="true" CodeFile="TimesheetEntry.aspx.cs" Inherits="Timesheet_TimesheetEntry" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" Runat="Server">
<style type="text/css">

    input 
{
    }

.notes 
{
    width: 140px;
}


</style>
<div id="divTimeSheet" runat="server" >

    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
        DataKeyNames="empId,tsDate,projId,wpId" DataSourceID="LinqDataSource1" 
        AllowPaging="True" AllowSorting="True">
        <Columns>
            <asp:CommandField ShowEditButton="True" ShowSelectButton="True" />
            <asp:BoundField DataField="empId" HeaderText="empId" ReadOnly="True" 
                SortExpression="empId" />
            <asp:BoundField DataField="tsDate" HeaderText="tsDate" ReadOnly="True" 
                SortExpression="tsDate" />
            <asp:BoundField DataField="projId" HeaderText="projId" ReadOnly="True" 
                SortExpression="projId" />
            <asp:BoundField DataField="wpId" HeaderText="wpId" ReadOnly="True" 
                SortExpression="wpId" />
            <asp:BoundField DataField="sat" HeaderText="sat" SortExpression="sat" />
            <asp:BoundField DataField="sun" HeaderText="sun" SortExpression="sun" />
            <asp:BoundField DataField="mon" HeaderText="mon" SortExpression="mon" />
            <asp:BoundField DataField="tue" HeaderText="tue" SortExpression="tue" />
            <asp:BoundField DataField="wed" HeaderText="wed" SortExpression="wed" />
            <asp:BoundField DataField="thu" HeaderText="thu" SortExpression="thu" />
            <asp:BoundField DataField="fri" HeaderText="fri" SortExpression="fri" />
            <asp:BoundField DataField="notes" HeaderText="notes" SortExpression="notes" >
            <ControlStyle CssClass="notes" />
            </asp:BoundField>
        </Columns>
    </asp:GridView>
    <asp:LinqDataSource ID="LinqDataSource1" runat="server" 
        ContextTypeName="FlyingFishClassesDataContext" EntityTypeName="" 
        TableName="TimesheetEntries" 
        Where="empId == @empId &amp;&amp; tsDate &gt;= @tsDate" 
        EnableUpdate="True">
        <WhereParameters>
            <asp:SessionParameter Name="empId" SessionField="CurEmpId" Type="Int32" />
            <asp:SessionParameter Name="tsDate" SessionField="CurrentDate" 
                Type="DateTime" />
        </WhereParameters>
    </asp:LinqDataSource>
    <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
    <asp:Button ID="btnNewRecord" runat="server" Text="NewRecord" 
        onclick="btnNewRecord_Click" Width="141px"  />
    </div>
<div id="divNewRecord" runat="server" >
    Project ID: 
    <asp:DropDownList ID="ddlProjectId" runat="server" AutoPostBack="True" 
        onselectedindexchanged="ddlProjectId_SelectedIndexChanged">
    </asp:DropDownList>
    <br />
    WP ID: 
    <asp:DropDownList ID="ddlWpId" runat="server" AutoPostBack="True">
    </asp:DropDownList>
    <br />
    Sunday: <asp:TextBox ID="tbSun" runat="server"></asp:TextBox>
    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
        ControlToValidate="tbSun" ErrorMessage="Work hour is required!" ForeColor="Red">*</asp:RequiredFieldValidator>
    <asp:RangeValidator ID="RangeValidator1" runat="server" 
        ControlToValidate="tbSun" ErrorMessage="You worked too hard!" ForeColor="Red" 
        MaximumValue="15" MinimumValue="0" Type="Integer">*</asp:RangeValidator>
    <br />
    Monday: <asp:TextBox ID="tbMon" runat="server"></asp:TextBox>
    <asp:RangeValidator ID="RangeValidator2" runat="server" 
        ControlToValidate="tbMon" ErrorMessage="You worked too hard!" ForeColor="Red" 
        MaximumValue="15" MinimumValue="0" Type="Integer">*</asp:RangeValidator>
    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
        ControlToValidate="tbMon" ErrorMessage="Work hour is required!" ForeColor="Red">*</asp:RequiredFieldValidator>
    <br />
    Tuesday: <asp:TextBox ID="tbTue" runat="server"></asp:TextBox>
    <asp:RangeValidator ID="RangeValidator3" runat="server" 
        ControlToValidate="tbThu" ErrorMessage="You worked too hard!" ForeColor="Red" 
        MaximumValue="15" MinimumValue="0" Type="Integer">*</asp:RangeValidator>
    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
        ControlToValidate="tbThu" ErrorMessage="Work hour is required!" ForeColor="Red">*</asp:RequiredFieldValidator>
    <br />
    Wednesday: <asp:TextBox ID="tbWed" runat="server"></asp:TextBox>
    <asp:RangeValidator ID="RangeValidator4" runat="server" 
        ControlToValidate="tbWed" ErrorMessage="You worked too hard!" ForeColor="Red" 
        MaximumValue="15" MinimumValue="0" Type="Integer">*</asp:RangeValidator>
    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
        ControlToValidate="tbWed" ErrorMessage="Work hour is required!" ForeColor="Red">*</asp:RequiredFieldValidator>
    <br />
    Thursday: <asp:TextBox ID="tbThu" runat="server"></asp:TextBox>
    <asp:RangeValidator ID="RangeValidator5" runat="server" 
        ControlToValidate="tbThu" ErrorMessage="You worked too hard!" ForeColor="Red" 
        MaximumValue="15" MinimumValue="0" Type="Integer">*</asp:RangeValidator>
    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" 
        ControlToValidate="tbThu" ErrorMessage="Work hour is required!" ForeColor="Red">*</asp:RequiredFieldValidator>
    <br />
    Friday: <asp:TextBox ID="tbFri" runat="server"></asp:TextBox>
    <asp:RangeValidator ID="RangeValidator6" runat="server" 
        ControlToValidate="tbFri" ErrorMessage="You worked too hard!" ForeColor="Red" 
        MaximumValue="15" MinimumValue="0" Type="Integer">*</asp:RangeValidator>
    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" 
        ControlToValidate="tbFri" ErrorMessage="Work hour is required!" ForeColor="Red">*</asp:RequiredFieldValidator>
    <br />
    Saturday: <asp:TextBox ID="tbSat" runat="server"></asp:TextBox>
    <asp:RangeValidator ID="RangeValidator7" runat="server" 
        ControlToValidate="tbSat" ErrorMessage="You worked too hard!" ForeColor="Red" 
        MaximumValue="15" MinimumValue="0" Type="Integer">*</asp:RangeValidator>
    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" 
        ControlToValidate="tbSat" ErrorMessage="Work hour is required!" ForeColor="Red">*</asp:RequiredFieldValidator>
    <br />
    Note: <asp:TextBox ID="tbNote" runat="server"></asp:TextBox><br />

    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="Red" />
    

    <asp:Button ID="btnCreateNewRecord" runat="server" Text="Button" 
        onclick="btnCreateNewRecord_Click" Width="84px" />
    
    </div>
    <asp:Label ID="Label2" runat="server" Text="" ForeColor="Red"></asp:Label><br />
</asp:Content>

