<%@ Page Title="" Language="C#" MasterPageFile="~/HR/HRMaster.master" AutoEventWireup="true"
    CodeFile="ManageEmployee.aspx.cs" Inherits="HR_ManageEmployee" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HRContent" runat="Server">
    <div id="DivManageUsers" runat="server">
        <br />
        <asp:Label ID="Label1" runat="server" Text="Search for an Employee (Last Name): " />
        <asp:TextBox ID="tbSearch" runat="server"></asp:TextBox>
        <asp:Button ID="buttonSearch" runat="server" Text="Search" OnClick="buttonSearch_Click" />
        &nbsp;<asp:Button ID="buttonAllUsers" runat="server" Text="Show All Users" OnClick="buttonAllUsers_Click" />
        <br />
        <div class="divline">
        </div>
        <asp:Label ID="lblSearchError" runat="server" Enabled="False"></asp:Label>
        <br />
        <div id="DivUserGridView" runat="server">
            <asp:GridView ID="gvManageUsers" runat="server" OnSelectedIndexChanged="gvManageUsers_SelectedIndexChanged"
                HorizontalAlign="Center" AllowPaging="True" OnPageIndexChanging="gvManageUsers_PageIndexChanging"
                AutoGenerateColumns="False" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None"
                BorderWidth="1px" CellPadding="3" PageSize="15">
                <Columns>
                    <asp:BoundField DataField="empId" HeaderText="Employee ID" SortExpression="empId" />
                    <asp:BoundField DataField="firstName" HeaderText="First Name" SortExpression="firstName" />
                    <asp:BoundField DataField="lastName" HeaderText="Last Name" SortExpression="lastName" />
                    <asp:BoundField DataField="vacationLeave" HeaderText="Vacation Leave" SortExpression="vacationLeave" />
                    <asp:BoundField DataField="sickDays" HeaderText="Sick Days" SortExpression="sickDays" />
                    <asp:BoundField DataField="flexHours" HeaderText="Flex Hours" SortExpression="flexHours" />
                    <asp:BoundField DataField="isActive" HeaderText="Active" SortExpression="isActive" />
                    <asp:CommandField ShowSelectButton="True" ButtonType="Button" />
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
        </div>
        <div id="DivUserDetails" runat="server" visible="false" style="">
            <table style="background-color: #EFF3FB; border-color: #B5C7DE; border-width: 1px;
                border-style: Solid; font-family: Verdana; font-size: 0.8em; border-collapse: collapse;
                margin-left: auto; margin-right: auto;">
                <tr>
                    <td>
                        <table id="tableUserDetails">
                            <tr>
                                <td colspan="4">
                                    <b>Edit Employee Information</b>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Employee ID Number:
                                </td>
                                <td>
                                    <asp:Label ID="lblEmpId" runat="server" />
                                </td>
                                <td>
                                    Username:
                                </td>
                                <td>
                                    <asp:Label ID="lblUsername" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    First Name:
                                </td>
                                <td>
                                    <asp:TextBox ID="tbFirstName" runat="server" Width="125" />
                                    <asp:RequiredFieldValidator ID="FirstNameRequired" runat="server" ErrorMessage="First name is required."
                                        ControlToValidate="tbFirstName" Text="*" Display="Dynamic" ValidationGroup="vgEditUser"
                                        ForeColor="Red" />
                                    <asp:RegularExpressionValidator ID="EditFirstNameFormatValidator" runat="server"
                                        ErrorMessage="First name must only contain alphabet characters." ControlToValidate="tbFirstName"
                                        Display="Dynamic" ForeColor="Red" ValidationExpression="[a-zA-Z]{1,}" ValidationGroup="vgEditUser">*</asp:RegularExpressionValidator>
                                </td>
                                <td>
                                    Last Name:
                                </td>
                                <td>
                                    <asp:TextBox ID="tbLastName" runat="server" Width="125" />
                                    <asp:RequiredFieldValidator ID="LastNameRequired" runat="server" ErrorMessage="Last name is required."
                                        ControlToValidate="tbLastName" Text="*" Display="Dynamic" ValidationGroup="vgEditUser"
                                        ForeColor="Red" />
                                    <asp:RegularExpressionValidator ID="EditlastNameFormatValidator" runat="server" ErrorMessage="First name must only contain alphabet characters."
                                        ControlToValidate="tbLastName" Display="Dynamic" ForeColor="Red" ValidationExpression="[a-zA-Z]{1,}"
                                        ValidationGroup="vgEditUser">*</asp:RegularExpressionValidator>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Supervisor:
                                </td>
                                <td>
                                    <asp:ListBox ID="lbSupervisors" Width="130" runat="server" />
                                    <asp:RequiredFieldValidator ID="SupervisorRequired" runat="server" ErrorMessage="A supervisor is required."
                                        ControlToValidate="lbSupervisors" Text="*" Display="Dynamic" ValidationGroup="vgEditUser"
                                        ForeColor="Red" />
                                </td>
                                <td>
                                    Timesheet Approver:
                                </td>
                                <td>
                                    <asp:ListBox ID="lbApprovers" Width="130" runat="server" />
                                    <asp:RequiredFieldValidator ID="ApproverEditRequired" runat="server" ErrorMessage="An approver is required."
                                        ControlToValidate="lbApprovers" Text="*" Display="Dynamic" ValidationGroup="vgEditUser"
                                        ForeColor="Red" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Vacation Leave:
                                </td>
                                <td>
                                    <asp:TextBox ID="tbVacation" Width="125" runat="server" />
                                    <asp:RequiredFieldValidator ID="VacationRequired" runat="server" ErrorMessage="Vacation hours are required."
                                        ControlToValidate="tbVacation" Text="*" Display="Dynamic" ValidationGroup="vgEditUser"
                                        ForeColor="Red" />
                                    <asp:CompareValidator ID="VacationTypeCheck" runat="server" ErrorMessage="Vacation time must be a number of days."
                                        ControlToValidate="tbVacation" Display="Dynamic" ForeColor="Red" Operator="DataTypeCheck"
                                        ValidationGroup="vgEditUser" Type="Double">*</asp:CompareValidator>
                                    <asp:RangeValidator ID="VacationNegativeCheck" runat="server" ErrorMessage="Vacation leave cannot be negative."
                                        ControlToValidate="tbVacation" Display="Dynamic" ForeColor="Red" ValidationGroup="vgEditUser"
                                        MinimumValue="0" MaximumValue="99999">*</asp:RangeValidator>
                                </td>
                                <td>
                                    Sick Days:
                                </td>
                                <td>
                                    <asp:TextBox ID="tbSickDays" Width="125" runat="server" />
                                    <asp:RequiredFieldValidator ID="SickDaysRequired" runat="server" ErrorMessage="Sick Days are required."
                                        ControlToValidate="tbSickDays" Text="*" Display="Dynamic" ValidationGroup="vgEditUser"
                                        ForeColor="Red" />
                                    <asp:CompareValidator ID="SickDaysTypeCheck" runat="server" ErrorMessage="Sick Days must be a number of days."
                                        ControlToValidate="tbSickDays" Display="Dynamic" ForeColor="Red" Operator="DataTypeCheck"
                                        ValidationGroup="vgEditUser" Type="Double">*</asp:CompareValidator>
                                    <asp:RangeValidator ID="SickDaysNegativeCheck" runat="server" ErrorMessage="Sick Days cannot be negative."
                                        ControlToValidate="tbSickDays" Display="Dynamic" ForeColor="Red" ValidationGroup="vgEditUser"
                                        MinimumValue="0" MaximumValue="99999">*</asp:RangeValidator>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Min. Hours per Week:
                                </td>
                                <td>
                                    <asp:TextBox ID="tbMinHours" Width="125" runat="server" />
                                    <asp:RequiredFieldValidator ID="MinHoursRequired" runat="server" ErrorMessage="Min. Hours are required."
                                        ControlToValidate="tbMinHours" Text="*" Display="Dynamic" ValidationGroup="vgEditUser"
                                        ForeColor="Red" />
                                    <asp:CompareValidator ID="MinHoursTypeCheck" runat="server" ErrorMessage="Min. hours must be a number of hours."
                                        ControlToValidate="tbMinHours" Display="Dynamic" ForeColor="Red" Operator="DataTypeCheck"
                                        ValidationGroup="vgEditUser" Type="Double">*</asp:CompareValidator>
                                    <asp:RangeValidator ID="MinHoursNegativeCheck" runat="server" ErrorMessage="Min hours cannot be negative."
                                        ControlToValidate="tbMinHours" Display="Dynamic" ForeColor="Red" ValidationGroup="vgEditUser"
                                        MinimumValue="0" MaximumValue="99999">*</asp:RangeValidator>
                                </td>
                                <td>
                                    Flex Hours:
                                </td>
                                <td>
                                    <asp:TextBox ID="tbFlexHours" Width="125" runat="server" />
                                    <asp:RequiredFieldValidator ID="FlexHoursRequired" runat="server" ErrorMessage="Flex Hours are required."
                                        ControlToValidate="tbFlexHours" Text="*" Display="Dynamic" ValidationGroup="vgEditUser"
                                        ForeColor="Red" />
                                    <asp:CompareValidator ID="FlexHoursTypeCheck" runat="server" ErrorMessage="Flex hours must be a number of hours."
                                        ControlToValidate="tbFlexHours" Display="Dynamic" ForeColor="Red" Operator="DataTypeCheck"
                                        ValidationGroup="vgEditUser" Type="Double">*</asp:CompareValidator>
                                    <asp:RangeValidator ID="FlexHoursNegativeCheck" runat="server" ErrorMessage="Flex hours cannot be negative."
                                        ControlToValidate="tbFlexHours" Display="Dynamic" ForeColor="Red" ValidationGroup="vgEditUser"
                                        MinimumValue="0" MaximumValue="99999">*</asp:RangeValidator>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Email Address:
                                </td>
                                <td>
                                    <asp:Label ID="lblEmail" runat="server" />
                                </td>
                                <td>
                                    Active User:
                                </td>
                                <td>
                                    <asp:CheckBox ID="cbActiveUser" Text="" runat="server" Checked="false" />
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td>
                        <table>
                            <tr>
                                <td>
                                    Roles:
                                </td>
                                <td>
                                    <asp:CheckBoxList ID="cblUserRoles" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label Text="P-Level:" ID="PLevelLabel" runat="server" />
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlPLevel" runat="server" Width="140" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:Button ID="buttonDetailsCancel" runat="server" Text="Cancel Editing" OnClick="buttonDetailsCancel_Click" />
                        &nbsp;<asp:Button ID="buttonDetailsSubmit" Text="Submit Changes" ValidationGroup="vgEditUser"
                            runat="server" OnClick="buttonDetailsSubmit_Click" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:Label ID="lblUserEditError" runat="server" Text=""></asp:Label>
                        <asp:ValidationSummary ID="vsEditUser" runat="server" ValidationGroup="vgEditUser"
                            DisplayMode="List" ForeColor="Red" />
                    </td>
                </tr>
            </table>
        </div>
    </div>
    </div>
</asp:Content>
