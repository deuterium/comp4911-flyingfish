<%@ Page Title="" Language="C#" MasterPageFile="~/FlyingFishMasterPage.master" AutoEventWireup="true" CodeFile="TimesheetEntry.aspx.cs" Inherits="Timesheet_TimesheetEntry" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" Runat="Server">
<style type="text/css">

input 
{
    width: 20px;
}

.notes 
{
    width: 100px;
}


</style>
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
        ContextTypeName="FFLib.FlyingFishClassesDataContext" EntityTypeName="" 
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
</asp:Content>

