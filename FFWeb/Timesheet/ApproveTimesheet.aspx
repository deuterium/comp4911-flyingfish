<%@ Page Title="" Language="C#" MasterPageFile="~/FlyingFishMasterPage.master" AutoEventWireup="true"
    CodeFile="ApproveTimesheet.aspx.cs" Inherits="Timesheet_ApproveTimesheet" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="Server">

    <asp:GridView ID="GridView1" runat="server"
        onselectedindexchanged="GridView1_SelectedIndexChanged" PersistedSelection="true">
        <Columns>
            <asp:ButtonField ButtonType="Button" CommandName="Select" HeaderText="Select" 
                ShowHeader="True" Text="Select" />
        </Columns>
    </asp:GridView>
    <asp:GridView ID="GridView2" runat="server">
    </asp:GridView>
        <fieldset id="field" runat="server"  >
            <legend>Comments</legend>
            <center>
                <asp:TextBox ID="tbComments" runat="server" TextMode="MultiLine" BorderWidth="0px"
                    Width="608px" Rows="3" MaxLength="255" Height="80px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                    ControlToValidate="tbComments" ErrorMessage="Comments are required!" 
                    ForeColor="Red"></asp:RequiredFieldValidator>
            </center>
        </fieldset>
        <asp:DropDownList ID="DropDownList1" runat="server">
            <asp:ListItem>Approve</asp:ListItem>
            <asp:ListItem>Reject</asp:ListItem>
        </asp:DropDownList>
        <br />
        <asp:Button ID="btnSubmit" runat="server" OnClick="btnSubmit_Click" Text="Submit" />
   
   
    <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
   
   
</asp:Content>
