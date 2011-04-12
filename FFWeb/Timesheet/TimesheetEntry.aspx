<%@ Page Title="" Language="C#" MasterPageFile="~/FlyingFishMasterPage.master" AutoEventWireup="true"
    CodeFile="TimesheetEntry.aspx.cs" Inherits="Timesheet_TimesheetEntry" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="Server">
    <div id="divTimeSheet" runat="server">
            <asp:Label ID="lblteTitle" runat="server" Text="Timesheet Management" Font-Bold="true"
            Font-Size="Large" />
        <br />
        <div class="divline">
        </div>
        <br />
        <table>
            <tr>
                <td class="tableTE1">
                    <asp:Label ID="lblteName" runat="server" Text="Name: " Font-Bold="true" />
                </td>
                <td>
                    <asp:LoginName ID="LoginName1" runat="server" />
                </td>
            </tr>
            <tr>
                <td class="tableTE1">
                    <asp:Label ID="lblteEmpNo" runat="server" Text="Employee Number: " Font-Bold="true" />
                </td>
                <td>
                    <asp:Label ID="lbEmpNo" runat="server" Text="Label" />
                </td>
            </tr>
            <tr>
                <td class="tableTE1">
                    <asp:Label ID="lblteDate" runat="server" Font-Bold="true" Text="Date: " />
                </td>
                <td>
                    <asp:Label ID="lbDate" runat="server" Text="Label" />
                </td>
            </tr>
        </table>
        <br />
        <asp:Label ID="lbltesublblList" runat="server" Text="Submitted Timesheets" Font-Bold="true" />
        <br />
        <div class="divline">
        </div>
        <br />
        <center>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="empId,tsDate,projId,wpId"
                DataSourceID="LinqDataSource1" AllowPaging="True" AllowSorting="True" CellPadding="3"
                BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px">
                <Columns>
                    <asp:BoundField DataField="projId" HeaderText="projId" ReadOnly="True" SortExpression="projId" />
                    <asp:BoundField DataField="wpId" HeaderText="wpId" ReadOnly="True" SortExpression="wpId" />
                    <asp:TemplateField HeaderText="Sat">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("sat") %>' Width="20px" />
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label3" runat="server" Text='<%# Bind("sat") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Sun">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("sun") %>' Width="20px" />
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label4" runat="server" Text='<%# Bind("sun") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Mon">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("mon") %>' Width="20px" />
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label5" runat="server" Text='<%# Bind("mon") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Tue">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("tue") %>' Width="20px" />
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label6" runat="server" Text='<%# Bind("tue") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Wed">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("wed") %>' Width="20px" />
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label7" runat="server" Text='<%# Bind("wed") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Thu">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox6" runat="server" Text='<%# Bind("thu") %>' Width="20px" />
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label8" runat="server" Text='<%# Bind("thu") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Fri">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox7" runat="server" Text='<%# Bind("fri") %>' Width="20px" />
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label9" runat="server" Text='<%# Bind("fri") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Notes">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox8" runat="server" Text='<%# Bind("notes") %>' Width="100px" />
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label10" runat="server" Text='<%# Bind("notes") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:CommandField ShowEditButton="True" ButtonType="Button" />
                </Columns>
                <EditRowStyle Width="20px" />
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
        <asp:Label ID="lblteSubmitSuccess" runat="server" Text="" />
    </div>
    <div id="divtotal" runat="server">
        <asp:Label ID="lbltesublblTotal" runat="server" Text="Total" Font-Bold="true" />
        <br />
        <div class="divline">
        </div>
        <br />
        <center>
            <asp:GridView ID="gvTotals" runat="server" BackColor="White" AutoGenerateColumns="false"
                BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3">
                <Columns>
                    <asp:BoundField DataField="sat" HeaderText="Sat" SortExpression="sat" />
                    <asp:BoundField DataField="sun" HeaderText="Sun" SortExpression="sun" />
                    <asp:BoundField DataField="mon" HeaderText="Mon" SortExpression="mon" />
                    <asp:BoundField DataField="tue" HeaderText="Tue" SortExpression="tue" />
                    <asp:BoundField DataField="wed" HeaderText="Wed" SortExpression="wed" />
                    <asp:BoundField DataField="thur" HeaderText="Thur" SortExpression="thur" />
                    <asp:BoundField DataField="fri" HeaderText="Fri" SortExpression="fri" />
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
        <asp:LinqDataSource ID="LinqDataSource1" runat="server" ContextTypeName="FlyingFishClassesDataContext"
            EntityTypeName="" TableName="TimesheetEntries" Where="empId == @empId &amp;&amp; tsDate &gt;= @tsDate"
            EnableUpdate="True">
            <WhereParameters>
                <asp:SessionParameter Name="empId" SessionField="CurEmpId" Type="Int32" />
                <asp:SessionParameter Name="tsDate" SessionField="CurrentDate" Type="DateTime" />
            </WhereParameters>
        </asp:LinqDataSource>
        <%--<asp:Label ID="lblteSubmitSuccess" runat="server" Text="" />--%>
        <br />
        <asp:Button ID="btnNewRecord" runat="server" Text="New Record" OnClick="btnNewRecord_Click" />
    </div>
    <div id="divNewRecord" runat="server" class="newRecord">

    <asp:Label ID="lblteNewEntTitle" runat="server" Text="Create New Timesheet Entry" Font-Bold="true" />
    <br />
    <div class="divline"></div>
    <br />
        <table>
            <tr>
                <td>
                    <asp:Label ID="lblteProjId" runat="server" Text="Project ID: " />
                </td>
                <td>
                    <asp:DropDownList ID="ddlProjectId" CssClass="ddlProjectId" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlProjectId_SelectedIndexChanged">
                    </asp:DropDownList>
                </td>
                <td>
                    &nbsp&nbsp&nbsp&nbsp&nbsp
                </td>
                <td>
                    <asp:Label ID="lbltewpID" runat="server" Text="Work Package ID: " />
                </td>
                <td>
                    <asp:DropDownList ID="ddlWpId" CssClass="ddlProjectId" runat="server" AutoPostBack="True">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblteSun" runat="server" Text="Sunday: " />
                </td>
                <td>
                    <asp:TextBox ID="tbSun" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="tbSun"
                        ErrorMessage="Invalid Amount of Hours!" ForeColor="Red">*</asp:RequiredFieldValidator>
                    <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="tbSun"
                        ErrorMessage="You worked too hard!" ForeColor="Red" MaximumValue="15" MinimumValue="0"
                        Type="Integer">*</asp:RangeValidator>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblteMon" runat="server" Text="Monday: " />
                </td>
                <td>
                    <asp:TextBox ID="tbMon" runat="server"></asp:TextBox>
                    <asp:RangeValidator ID="RangeValidator2" runat="server" ControlToValidate="tbMon"
                        ErrorMessage="Invalid Amount of Hours!" ForeColor="Red" MaximumValue="15" MinimumValue="0"
                        Type="Integer">*</asp:RangeValidator>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="tbMon"
                        ErrorMessage="Work hour is required!" ForeColor="Red">*</asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblteTues" runat="server" Text="Tuesday: " />
                </td>
                <td>
                    <asp:TextBox ID="tbTue" runat="server"></asp:TextBox>
                    <asp:RangeValidator ID="RangeValidator3" runat="server" ControlToValidate="tbThu"
                        ErrorMessage="Invalid Amount of Hours!" ForeColor="Red" MaximumValue="15" MinimumValue="0"
                        Type="Integer">*</asp:RangeValidator>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="tbThu"
                        ErrorMessage="Work hour is required!" ForeColor="Red">*</asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblteWed" runat="server" Text="Wednesday: " />
                </td>
                <td>
                    <asp:TextBox ID="tbWed" runat="server"></asp:TextBox>
                    <asp:RangeValidator ID="RangeValidator4" runat="server" ControlToValidate="tbWed"
                        ErrorMessage="Invalid Amount of Hours!" ForeColor="Red" MaximumValue="15" MinimumValue="0"
                        Type="Integer">*</asp:RangeValidator>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="tbWed"
                        ErrorMessage="Work hour is required!" ForeColor="Red">*</asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblteThur" runat="server" Text="Thursday: " />
                </td>
                <td>
                    <asp:TextBox ID="tbThu" runat="server"></asp:TextBox>
                    <asp:RangeValidator ID="RangeValidator5" runat="server" ControlToValidate="tbThu"
                        ErrorMessage="Invalid Amount of Hours!" ForeColor="Red" MaximumValue="15" MinimumValue="0"
                        Type="Integer">*</asp:RangeValidator>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="tbThu"
                        ErrorMessage="Work hour is required!" ForeColor="Red">*</asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblteFri" runat="server" Text="Friday: " />
                </td>
                <td>
                    <asp:TextBox ID="tbFri" runat="server"></asp:TextBox>
                    <asp:RangeValidator ID="RangeValidator6" runat="server" ControlToValidate="tbFri"
                        ErrorMessage="Invalid Amount of Hours!" ForeColor="Red" MaximumValue="15" MinimumValue="0"
                        Type="Integer">*</asp:RangeValidator>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="tbFri"
                        ErrorMessage="Work hour is required!" ForeColor="Red">*</asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblteSat" runat="server" Text="Saturday: " />
                </td>
                <td>
                    <asp:TextBox ID="tbSat" runat="server"></asp:TextBox>
                    <asp:RangeValidator ID="RangeValidator7" runat="server" ControlToValidate="tbSat"
                        ErrorMessage="Invalid Amount of Hours!" ForeColor="Red" MaximumValue="15" MinimumValue="0"
                        Type="Integer">*</asp:RangeValidator>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="tbSat"
                        ErrorMessage="Work hour is required!" ForeColor="Red">*</asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblteNotes" runat="server" Text="Note: " />
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
