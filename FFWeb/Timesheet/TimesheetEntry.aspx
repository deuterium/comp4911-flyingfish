<%@ Page Title="" Language="C#" MasterPageFile="~/FlyingFishMasterPage.master" AutoEventWireup="true" CodeFile="TimesheetEntry.aspx.cs" Inherits="Timesheet_TimesheetEntry" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" Runat="Server">
<style type="text/css">

input 
{
    width: 20px;
}


</style>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
        DataKeyNames="empId,tsDate,projId,wpId" DataSourceID="LinqDataSource1">
        <Columns>
            <asp:BoundField DataField="projId" HeaderText="projId" SortExpression="projId" 
                ReadOnly="True" />
            <asp:BoundField DataField="wpId" HeaderText="wpId" SortExpression="wpId" 
                ReadOnly="True" />
            <asp:BoundField DataField="sat" HeaderText="sat" SortExpression="sat" >
            <ItemStyle Width="20px" />
            </asp:BoundField>
            <asp:BoundField DataField="sun" HeaderText="sun" SortExpression="sun" />
            <asp:BoundField DataField="mon" HeaderText="mon" SortExpression="mon" />
            <asp:BoundField DataField="tue" HeaderText="tue" SortExpression="tue" />
            <asp:BoundField DataField="wed" HeaderText="wed" SortExpression="wed" />
            <asp:BoundField DataField="thu" HeaderText="thu" SortExpression="thu" />
            <asp:BoundField DataField="fri" HeaderText="fri" SortExpression="fri" />
            <asp:BoundField DataField="notes" HeaderText="notes" SortExpression="notes" />
            <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" 
                ShowSelectButton="True" />
        </Columns>
    </asp:GridView>
    <asp:LinqDataSource ID="LinqDataSource1" runat="server" 
        ContextTypeName="FFLib.FlyingFishClassesDataContext" EnableDelete="True" 
        EnableInsert="True" EnableUpdate="True" EntityTypeName="" 
        TableName="TimesheetEntries" 
        Where="empId == @empId &amp;&amp; tsDate &lt;= @tsDate1">
        <WhereParameters>
            <asp:SessionParameter Name="empId" SessionField="CurEmpId" Type="Int32" />
            <asp:SessionParameter Name="tsDate1" SessionField="CurrentDate" 
                Type="DateTime" />
        </WhereParameters>
    </asp:LinqDataSource>
    <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
</asp:Content>

