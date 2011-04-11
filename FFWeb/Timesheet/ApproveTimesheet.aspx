<%@ Page Title="" Language="C#" MasterPageFile="~/FlyingFishMasterPage.master" AutoEventWireup="true"
    CodeFile="ApproveTimesheet.aspx.cs" Inherits="Timesheet_ApproveTimesheet" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="Server">

<asp:Label ID="approveTitle" runat="server" Text="Timesheet Approval" Font-Bold="true" Font-Size="Large" />
<br />
<div class="divline"></div>
<br />
    <center>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" OnSelectedIndexChanged="GridView1_SelectedIndexChanged"
        PersistedSelection="true" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None"
        BorderWidth="1px" CellPadding="3">
        <Columns>
            <asp:BoundField DataField="EmployeeName" HeaderText="Employee Name" SortExpression="EmployeeName" />
            <asp:BoundField DataField="EmpID" HeaderText="ID" SortExpression="EmpID" />
            <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date" />
            <asp:BoundField DataField="Project" HeaderText="Project ID" SortExpression="Project" />
            <asp:BoundField DataField="WorkPackage" HeaderText="Work Package" SortExpression="WorkPackage" />
            <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" />
            <asp:BoundField DataField="Comments" HeaderText="Comments" SortExpression="Comments" />
            <asp:ButtonField ButtonType="Button" CommandName="Select" HeaderText="Select" ShowHeader="True"
                Text="Select" />
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
    <asp:GridView ID="GridView2" runat="server" BackColor="White" AutoGenerateColumns="false"
        BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3">
        <Columns>
            <asp:BoundField DataField="EmployeeName" HeaderText="Employee Name" SortExpression="EmployeeName" />
            <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date" />
            <asp:BoundField DataField="Project" HeaderText="Project" SortExpression="Project" />
            <asp:BoundField DataField="WorkPackage" HeaderText="Work Package" SortExpression="WorkPackage" />
            <asp:BoundField DataField="Mon" HeaderText="Mon" SortExpression="Mon" />
            <asp:BoundField DataField="Tue" HeaderText="Tue" SortExpression="Tue" />
            <asp:BoundField DataField="Wed" HeaderText="Wed" SortExpression="Wed" />
            <asp:BoundField DataField="Thu" HeaderText="Thu" SortExpression="Thu" />
            <asp:BoundField DataField="Fri" HeaderText="Fri" SortExpression="Fri" />
            <asp:BoundField DataField="Sat" HeaderText="Sat" SortExpression="Sat" />
            <asp:BoundField DataField="Sun" HeaderText="Sun" SortExpression="Sun" />
            <asp:BoundField DataField="Note" HeaderText="Notes" SortExpression="Note" />
            <asp:BoundField DataField="Total" HeaderText="Total" SortExpression="Total" />
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
    </center>
    <br />
    <fieldset id="field" runat="server">
        <legend>Comments</legend>
        <center>
            <asp:TextBox ID="tbComments" runat="server" TextMode="MultiLine" BorderWidth="0px"
                Width="608px" Rows="3" MaxLength="255" Height="80px"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="tbComments"
                ErrorMessage="Comments are required!" ForeColor="Red"></asp:RequiredFieldValidator>
        </center>
    </fieldset>
    <br />
    <asp:DropDownList ID="DropDownList1" runat="server">
        <asp:ListItem>Approve</asp:ListItem>
        <asp:ListItem>Reject</asp:ListItem>
    </asp:DropDownList>
    <br /><br />
    <asp:Button ID="btnSubmit" runat="server" OnClick="btnSubmit_Click" Text="Submit" />
</asp:Content>
