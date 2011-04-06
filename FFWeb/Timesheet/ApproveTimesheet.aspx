<%@ Page Title="" Language="C#" MasterPageFile="~/FlyingFishMasterPage.master" AutoEventWireup="true"
    CodeFile="ApproveTimesheet.aspx.cs" Inherits="Timesheet_ApproveTimesheet" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="Server">
    <div style="float: left">
        <asp:GridView ID="GridView1" runat="server" DataKeyNames="empId,tsDate" AutoGenerateColumns="False"
            DataSourceID="gvTimesheetHeader" AllowPaging="True" AllowSorting="True" CellPadding="4"
            ForeColor="#333333" GridLines="None">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:CommandField ShowSelectButton="True" />
                <asp:BoundField DataField="empId" HeaderText="empId" ReadOnly="True" SortExpression="empId" />
                <asp:BoundField DataField="tsDate" HeaderText="tsDate" ReadOnly="True" SortExpression="tsDate" />
                <asp:BoundField DataField="status" HeaderText="status" ReadOnly="True" SortExpression="status" />
                <asp:BoundField DataField="comments" HeaderText="comments" ReadOnly="True" SortExpression="comments" />
            </Columns>
            <EditRowStyle BackColor="#2461BF" />
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#EFF3FB" />
            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#F5F7FB" />
            <SortedAscendingHeaderStyle BackColor="#6D95E1" />
            <SortedDescendingCellStyle BackColor="#E9EBEF" />
            <SortedDescendingHeaderStyle BackColor="#4870BE" />
        </asp:GridView>
        &nbsp;</div>
    <div style="float: left">
        <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" DataSourceID="dvTimesheetHeader"
            Height="50px" Width="125px" CellPadding="4" ForeColor="#333333" GridLines="None">
            <AlternatingRowStyle BackColor="White" />
            <CommandRowStyle BackColor="#D1DDF1" Font-Bold="True" />
            <EditRowStyle BackColor="#2461BF" />
            <FieldHeaderStyle BackColor="#DEE8F5" Font-Bold="True" />
            <Fields>
                <asp:BoundField DataField="empId" HeaderText="empId" ReadOnly="True" SortExpression="empId" />
                <asp:BoundField DataField="notes" HeaderText="notes" ReadOnly="True" SortExpression="notes" />
                <asp:BoundField DataField="tsDate" HeaderText="tsDate" ReadOnly="True" SortExpression="tsDate" />
                <asp:BoundField DataField="projId" HeaderText="projId" ReadOnly="True" SortExpression="projId" />
                <asp:BoundField DataField="wpId" HeaderText="wpId" ReadOnly="True" SortExpression="wpId" />
                <asp:BoundField DataField="sat" HeaderText="sat" ReadOnly="True" SortExpression="sat" />
                <asp:BoundField DataField="sun" HeaderText="sun" ReadOnly="True" SortExpression="sun" />
                <asp:BoundField DataField="mon" HeaderText="mon" ReadOnly="True" SortExpression="mon" />
                <asp:BoundField DataField="tue" HeaderText="tue" ReadOnly="True" SortExpression="tue" />
                <asp:BoundField DataField="wed" HeaderText="wed" ReadOnly="True" SortExpression="wed" />
                <asp:BoundField DataField="fri" HeaderText="fri" ReadOnly="True" SortExpression="fri" />
                <asp:BoundField DataField="thu" HeaderText="thu" ReadOnly="True" SortExpression="thu" />
            </Fields>
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#EFF3FB" />
        </asp:DetailsView>
        &nbsp;</div>
    <asp:LinqDataSource ID="gvTimesheetHeader" runat="server" ContextTypeName="FlyingFishClassesDataContext"
        EntityTypeName="" Select="new (empId, tsDate, status, comments)" TableName="TimeSheetHeaders"
        OrderBy="status desc">
    </asp:LinqDataSource>
    <asp:LinqDataSource ID="dvTimesheetHeader" runat="server" ContextTypeName="FlyingFishClassesDataContext"
        EntityTypeName="" Select="new (empId, notes, tsDate, projId, wpId, sat, sun, mon, tue, wed, fri, thu)"
        TableName="TimeSheetEntries" Where="empId == @empId">
        <WhereParameters>
            <asp:ControlParameter ControlID="GridView1" Name="empId" PropertyName="SelectedValue"
                Type="Int32" DefaultValue="0" />
        </WhereParameters>
    </asp:LinqDataSource>
    <div>
        <asp:DropDownList ID="DropDownList1" runat="server">
            <asp:ListItem>Approve</asp:ListItem>
            <asp:ListItem>Reject</asp:ListItem>
        </asp:DropDownList>
        <br /><br />
        <asp:Button ID="btnSubmit" runat="server" OnClick="btnSubmit_Click" Text="Submit" /></div>
    <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
</asp:Content>
