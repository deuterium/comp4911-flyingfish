<%@ Page Title="" Language="C#" MasterPageFile="~/FlyingFishMasterPage.master" AutoEventWireup="true"
    CodeFile="ApproveTimesheet.aspx.cs" Inherits="Timesheet_ApproveTimesheet" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="Server">
    <asp:GridView ID="gv1" runat="server" AllowPaging="True" DataKeyNames="empId,tsDate" AutoGenerateSelectButton="True"
        AllowSorting="True" AutoGenerateColumns="False" DataSourceID="LinqDataSource1">
        <Columns>
            <asp:BoundField DataField="empId" HeaderText="empId" ReadOnly="True" SortExpression="empId" />
            <asp:BoundField DataField="tsDate" HeaderText="tsDate" ReadOnly="True" SortExpression="tsDate" />
            <asp:BoundField DataField="status" HeaderText="status" ReadOnly="True" SortExpression="status" />
            <asp:BoundField DataField="comments" HeaderText="comments" ReadOnly="True" SortExpression="comments" />
        </Columns>
    </asp:GridView>
    <asp:LinqDataSource ID="LinqDataSource1" runat="server" ContextTypeName="FFLib.FlyingFishClassesDataContext"
        EntityTypeName="" OrderBy="status" Select="new (empId, tsDate, status, comments)"
        TableName="TimeSheetHeaders">
    </asp:LinqDataSource>
    <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False"
        DataSourceID="LinqDataSource2" Height="50px" Width="125px">
        <Fields>
            <asp:BoundField DataField="empId" HeaderText="empId" ReadOnly="True" SortExpression="empId" />
            <asp:BoundField DataField="tsDate" HeaderText="tsDate" ReadOnly="True" SortExpression="tsDate" />
            <asp:BoundField DataField="projId" HeaderText="projId" ReadOnly="True" SortExpression="projId" />
            <asp:BoundField DataField="wpId" HeaderText="wpId" ReadOnly="True" SortExpression="wpId" />
            <asp:BoundField DataField="sat" HeaderText="sat" ReadOnly="True" SortExpression="sat" />
            <asp:BoundField DataField="mon" HeaderText="mon" ReadOnly="True" SortExpression="mon" />
            <asp:BoundField DataField="sun" HeaderText="sun" ReadOnly="True" SortExpression="sun" />
            <asp:BoundField DataField="fri" HeaderText="fri" ReadOnly="True" SortExpression="fri" />
            <asp:BoundField DataField="thu" HeaderText="thu" ReadOnly="True" SortExpression="thu" />
            <asp:BoundField DataField="wed" HeaderText="wed" ReadOnly="True" SortExpression="wed" />
            <asp:BoundField DataField="tue" HeaderText="tue" ReadOnly="True" SortExpression="tue" />
            <asp:BoundField DataField="notes" HeaderText="notes" ReadOnly="True" SortExpression="notes" />
        </Fields>
    </asp:DetailsView>
    <asp:LinqDataSource ID="LinqDataSource2" runat="server" ContextTypeName="FFLib.FlyingFishClassesDataContext"
        EntityTypeName="" Select="new (empId, tsDate, projId, wpId, sat, mon, sun, fri, thu, wed, tue, notes)"
        TableName="TimeSheetEntries" Where="empId == @empId">
        <WhereParameters>
            <asp:ControlParameter ControlID="gv1" Name="empId" PropertyName="SelectedValue" Type="Int32" />
        </WhereParameters>
    </asp:LinqDataSource>
    <br />
    <asp:Button ID="Button1" runat="server" onclick="Button1_Click" 
        style="height: 26px" Text="Approve" />
</asp:Content>
