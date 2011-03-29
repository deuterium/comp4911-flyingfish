<%@ Page Title="User Management" Language="C#" MasterPageFile="~/FlyingFishMasterPage.master"
    AutoEventWireup="true" CodeFile="UserManagement.aspx.cs" Inherits="UserManagement" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="Server">
    <div id="DivUserManagement">
        <asp:ToolkitScriptManager ID="ToolkitScriptManager" runat="server">
        </asp:ToolkitScriptManager>
        <asp:Timer ID="ErrorTimer" runat="server" OnTick="ErrorTimer_Tick" Interval="3000">
        </asp:Timer>
        <div id="DivUserManagementMenu" runat="server">
            <asp:LinkButton CssClass="DivUserManagementMenu" Width="33%" ID="CreateUserLabel"
                runat="server" OnClick="lbCreateUser_Click">Create New Employee</asp:LinkButton>
            <asp:LinkButton CssClass="DivUserManagementMenu" Width="33%" ID="ManageUserLabel"
                runat="server" OnClick="ManageUserLabel_Click">Edit Employee Information</asp:LinkButton>
            <asp:LinkButton CssClass="DivUserManagementMenu" Width="33%" ID="AssignUserLabel"
                runat="server" OnClick="AssignUserLabel_Click">Assign Employee to Project</asp:LinkButton>
        </div>
        <div id="DivUserMain" runat="server">
            <br />
            Welcome to the user Management page. Here will be some blabber on what you can do
            here and etc.<br />
            Welcome to the user Management page. Here will be some blabber on what you can do
            here and etc.<br />
            Welcome to the user Management page. Here will be some blabber on what you can do
            here and etc.<br />
            Welcome to the user Management page. Here will be some blabber on what you can do
            here and etc.<br />
            <br />
            Welcome to the user Management page. Here will be some blabber on what you can do
            here and etc.
            <br />
            Welcome to the user Management page. Here will be some blabber on what you can do
            here and etc.<br />
            Welcome to the user Management page. Here will be some blabber on what you can do
            here and etc.<br />
            Welcome to the user Management page. Here will be some blabber on what you can do
            here and etc.
        </div>
        <div id="DivNewUser" class="DivNewUser" runat="server" visible="false">
            <br />
            <asp:CreateUserWizard ID="cuwCreateUser" runat="server" BackColor="#EFF3FB" BorderColor="#B5C7DE"
                BorderStyle="Solid" BorderWidth="1px" Font-Names="Verdana" Font-Size="0.8em"
                CreateUserButtonText="Create New Employee" OnCreatedUser="cuwCreateUser_CreatedUser"
                LoginCreatedUser="False" OnCreatingUser="cuwCreateUser_CreatingUser" OnContinueButtonClick="cuwCreateUser_ContinueButtonClick"
                CompleteSuccessText="The account has been successfully created." ContinueButtonText="Create another Employee"
                EnableViewState="False" DuplicateUserNameErrorMessage="Username is already in use."
                Width="750px">
                <ContinueButtonStyle BackColor="White" BorderColor="#507CD1" BorderStyle="Solid"
                    BorderWidth="1px" Font-Names="Verdana" ForeColor="#284E98" />
                <CreateUserButtonStyle BackColor="White" BorderColor="#507CD1" BorderStyle="Solid"
                    BorderWidth="1px" Font-Names="Verdana" ForeColor="#284E98" />
                <TitleTextStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <WizardSteps>
                    <asp:CreateUserWizardStep ID="wsEmployeeAccountInfo" runat="server" Title="New Employee Account Information">
                        <ContentTemplate>
                            <asp:Label CssClass="lblcreatenewemp" runat="server" Text="Enter new employee infomation to create new user account" />
                            <table>
                                <tr>
                                    <td>
                                        <table>
                                            <tr>
                                                <td align="right">
                                                    <asp:Label ID="FirstNameLabel" runat="server" AssociatedControlID="FirstName">First Name:</asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="FirstName" runat="server" Width="146"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="FirstNameRequired" runat="server" ControlToValidate="FirstName"
                                                        ErrorMessage="First Name is required." ToolTip="First Name is required." ValidationGroup="cuwCreateUser"
                                                        ForeColor="Red" Display="Dynamic">*</asp:RequiredFieldValidator>
                                                    <asp:RegularExpressionValidator ID="FirstNameFormatValidator" runat="server" ErrorMessage="First name must only contain alphabet characters."
                                                        ControlToValidate="FirstName" Display="Dynamic" ForeColor="Red" ValidationExpression="[a-zA-Z]{1,}"
                                                        ValidationGroup="cuwCreateUser">*</asp:RegularExpressionValidator>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right">
                                                    <asp:Label ID="LastNameEmail" runat="server" AssociatedControlID="LastName">Last Name:</asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="LastName" runat="server" Width="146"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="LastNameRequired" runat="server" ControlToValidate="LastName"
                                                        ErrorMessage="Last Name is required." ToolTip="LastName is required." ValidationGroup="cuwCreateUser"
                                                        ForeColor="Red">*</asp:RequiredFieldValidator>
                                                    <asp:RegularExpressionValidator ID="LastNameFormatValidator" runat="server" ErrorMessage="Last name must only contain alphabet characters."
                                                        ControlToValidate="LastName" Display="Dynamic" ForeColor="Red" ValidationExpression="[a-zA-Z]{1,}"
                                                        ValidationGroup="cuwCreateUser">*</asp:RegularExpressionValidator>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right">
                                                    <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName">User Name:</asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="UserName" runat="server" Width="146"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName"
                                                        ErrorMessage="User Name is required." ToolTip="User Name is required." ValidationGroup="cuwCreateUser"
                                                        ForeColor="Red">*</asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right">
                                                    <asp:Label ID="EmployeeIDLabel" runat="server" AssociatedControlID="EmployeeID">Employee ID:</asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="EmployeeID" runat="server" Width="146"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="EmployeeIDRequired" runat="server" ControlToValidate="EmployeeID"
                                                        ErrorMessage="Employee ID is required." ToolTip="Employee ID is required." ValidationGroup="cuwCreateUser"
                                                        ForeColor="Red" Display="Dynamic">*</asp:RequiredFieldValidator>
                                                    <asp:CompareValidator ID="EmployeeIDInteger" runat="server" ErrorMessage="Employee ID must be a number."
                                                        ControlToValidate="EmployeeID" Display="Dynamic" ForeColor="Red" Operator="DataTypeCheck"
                                                        ToolTip="Employee ID must be a number." Type="Integer" ValidationGroup="cuwCreateUser">*</asp:CompareValidator>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right">
                                                    <asp:Label ID="EmailLabel" runat="server" AssociatedControlID="Email">Email:</asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="Email" runat="server" Width="146"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="EmailRequired" runat="server" ControlToValidate="Email"
                                                        ErrorMessage="Email is required." ToolTip="Email is required." ValidationGroup="cuwCreateUser"
                                                        ForeColor="Red">*</asp:RequiredFieldValidator>
                                                    <asp:RegularExpressionValidator ID="EmailFormatValidator" runat="server" ErrorMessage="Please enter a correctly formatted email address."
                                                        Text="*" Display="Dynamic" ControlToValidate="Email" ForeColor="Red" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                                        ValidationGroup="cuwCreateUser" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right">
                                                    <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password">Password:</asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="Password" runat="server" Width="146" TextMode="Password"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password"
                                                        ErrorMessage="Password is required." ToolTip="Password is required." ValidationGroup="cuwCreateUser"
                                                        ForeColor="Red">*</asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right">
                                                    <asp:Label ID="ConfirmPasswordLabel" runat="server" AssociatedControlID="ConfirmPassword">Confirm Password:</asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="ConfirmPassword" runat="server" Width="146" TextMode="Password"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="ConfirmPasswordRequired" runat="server" ControlToValidate="ConfirmPassword"
                                                        ErrorMessage="Confirm Password is required." ToolTip="Confirm Password is required."
                                                        ValidationGroup="cuwCreateUser" ForeColor="Red">*</asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right">
                                                    <asp:Label ID="QuestionLabel" runat="server" AssociatedControlID="Question">Security Question:</asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="Question" runat="server" Width="146"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="QuestionRequired" runat="server" ControlToValidate="Question"
                                                        ErrorMessage="Security question is required." ToolTip="Security question is required."
                                                        ValidationGroup="cuwCreateUser" ForeColor="Red">*</asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right">
                                                    <asp:Label ID="AnswerLabel" runat="server" AssociatedControlID="Answer">Security Answer:</asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="Answer" runat="server" Width="146"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="AnswerRequired" runat="server" ControlToValidate="Answer"
                                                        ErrorMessage="Security answer is required." ToolTip="Security answer is required."
                                                        ValidationGroup="cuwCreateUser" ForeColor="Red">*</asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">
                                                    <asp:CompareValidator ID="PasswordCompare" runat="server" ControlToCompare="Password"
                                                        ControlToValidate="ConfirmPassword" Display="Dynamic" ErrorMessage="The Password and Confirmation Password must match."
                                                        ValidationGroup="cuwCreateUser" ForeColor="Red"></asp:CompareValidator>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td>
                                        <table>
                                            <tr>
                                                <td align="left">
                                                    <asp:Label ID="SupervisorLabel" runat="server">Supervisor:</asp:Label>
                                                </td>
                                                <td>
                                                    <asp:ListBox ID="SupervisorList" runat="server" OnInit="SupervisorApproverList_Load" />
                                                    <asp:RequiredFieldValidator ID="SupervisorRequired" runat="server" ErrorMessage="A suprvisor is required."
                                                        ValidationGroup="cuwCreateUser" ControlToValidate="SupervisorList" ForeColor="Red">*</asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="left">
                                                    <asp:Label ID="ApproverLabel" runat="server">Approver:</asp:Label>
                                                </td>
                                                <td>
                                                    <asp:ListBox ID="ApproverList" runat="server" OnInit="SupervisorApproverList_Load" />
                                                    <asp:RequiredFieldValidator ID="ApproverRequired" runat="server" ErrorMessage="A timesheet approver is required."
                                                        ValidationGroup="cuwCreateUser" ControlToValidate="ApproverList" ForeColor="Red">*</asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right">
                                                    <asp:Label ID="RoleLabel" runat="server">Role:</asp:Label>
                                                </td>
                                                <td>
                                                    <asp:CheckBoxList ID="RoleList" runat="server" DataSourceID="RoleSource" DataTextField="RoleName"
                                                        DataValueField="RoleId">
                                                    </asp:CheckBoxList>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td>
                                        <table>
                                            <tr>
                                                <td align="center">
                                                    <asp:ValidationSummary ID="CreateUserValidationSummary" runat="server" ValidationGroup="cuwCreateUser"
                                                        DisplayMode="List" ForeColor="Red" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="center" style="color: Red;">
                                                    <asp:Label ID="lblUserWizardError" Enabled="false" Text="" runat="server" />
                                                    <asp:Literal ID="ErrorMessage" runat="server" EnableViewState="False"></asp:Literal>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </ContentTemplate>
                        <CustomNavigationTemplate>
                            <table border="0" cellspacing="5" style="width: 100%; height: 100%;">
                                <tr align="right">
                                    <td align="left" colspan="0">
                                        <asp:Button ID="StepNextButton" runat="server" BackColor="White" BorderColor="#507CD1"
                                            BorderStyle="Solid" BorderWidth="1px" CommandName="MoveNext" Font-Names="Verdana"
                                            ForeColor="#284E98" Text="Create New Employee" ValidationGroup="cuwCreateUser" />
                                    </td>
                                </tr>
                            </table>
                        </CustomNavigationTemplate>
                    </asp:CreateUserWizardStep>
                    <asp:CompleteWizardStep ID="wsEmployeeComplete" runat="server">
                        <ContentTemplate>
                            <table style="font-family: Verdana; font-size: 100%;">
                                <tr>
                                    <td align="center" style="color: White; background-color: #507CD1; font-weight: bold;">
                                        Complete
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        The account has been successfully created.
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        <asp:Button ID="ContinueButton" runat="server" BackColor="White" BorderColor="#507CD1"
                                            BorderStyle="Solid" BorderWidth="1px" CausesValidation="False" CommandName="Continue"
                                            Font-Names="Verdana" ForeColor="#284E98" Text="Create another Employee" ValidationGroup="cuwCreateUser" />
                                    </td>
                                </tr>
                            </table>
                        </ContentTemplate>
                    </asp:CompleteWizardStep>
                </WizardSteps>
                <HeaderStyle BackColor="#284E98" BorderColor="#EFF3FB" BorderStyle="Solid" BorderWidth="2px"
                    Font-Bold="True" Font-Size="0.9em" ForeColor="White" HorizontalAlign="Center" />
                <NavigationButtonStyle BackColor="White" BorderColor="#507CD1" BorderStyle="Solid"
                    BorderWidth="1px" Font-Names="Verdana" ForeColor="#284E98" />
                <SideBarButtonStyle BackColor="#507CD1" Font-Names="Verdana" ForeColor="White" />
                <SideBarStyle BackColor="#507CD1" Font-Size="0.9em" VerticalAlign="Top" />
                <StepStyle Font-Size="0.8em" />
            </asp:CreateUserWizard>
            <asp:LinqDataSource ID="RoleSource" runat="server" ContextTypeName="FFLib.FlyingFishClassesDataContext"
                EntityTypeName="" Select="new (RoleId, RoleName)" TableName="aspnet_Roles">
            </asp:LinqDataSource>
        </div>
        <div id="DivManageUsers" runat="server" visible="false">
            <br />
            <asp:Label runat="server" Text="Search for an Employee (Last Name): " />
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
                        <asp:CommandField ShowSelectButton="True" />
                        <asp:BoundField DataField="empId" HeaderText="Employee ID" SortExpression="empId" />
                        <asp:BoundField DataField="firstName" HeaderText="First Name" SortExpression="firstName" />
                        <asp:BoundField DataField="lastName" HeaderText="Last Name" SortExpression="lastName" />
                        <asp:BoundField DataField="vacationLeave" HeaderText="Vacation Leave" SortExpression="vacationLeave" />
                        <asp:BoundField DataField="sickDays" HeaderText="Sick Days" SortExpression="sickDays" />
                        <asp:BoundField DataField="flexHours" HeaderText="Flex Hours" SortExpression="flexHours" />
                        <asp:BoundField DataField="isActive" HeaderText="Active" SortExpression="isActive" />
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
                                        <asp:ListBox ID="lbSupervisors" Width="125" runat="server" />
                                        <asp:RequiredFieldValidator ID="SupervisorRequired" runat="server" ErrorMessage="A supervisor is required."
                                            ControlToValidate="lbSupervisors" Text="*" Display="Dynamic" ValidationGroup="vgEditUser"
                                            ForeColor="Red" />
                                    </td>
                                    <td>
                                        Timesheet Approver:
                                    </td>
                                    <td>
                                        <asp:ListBox ID="lbApprovers" Width="125" runat="server" />
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
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            <asp:Button ID="buttonDetailsCancel" runat="server" Text="Cancel Editing" OnClick="buttonDetailsCancel_Click" />
                            &nbsp;<asp:Button ID="buttonDetailsSubmit" Text="Submit Changes" ValidationGroup="vgEditUser"
                                runat="server" OnClick="buttonDetailsSubmit_Click" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            <asp:UpdatePanel ID="EditUpdatePanel" runat="server">
                                <ContentTemplate>
                                    <asp:Label ID="lblUserEditError" runat="server" Text=""></asp:Label>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="ErrorTimer" EventName="Tick" />
                                </Triggers>
                            </asp:UpdatePanel>
                            <asp:ValidationSummary ID="vsEditUser" runat="server" ValidationGroup="vgEditUser"
                                DisplayMode="List" ForeColor="Red" />
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
    <div id="DivAssignUsers" runat="server" visible="false">
        <br />
        This page is for assigning unassigned Employees to a project. Please select the
        project you wish to manage, then select one or more employees in the list of unassigned
        employees. Once you have confirmed they are the correct Employees, use the <i>&quot;Assign
            to Project&quot;</i> button to assign the selected Employee(s) to the Project.
        The opposite can be done with the <i>&quot;Unassign from Project&quot;</i> button.
        <br />
        <br />
        <table style="background-color: #EFF3FB; border-color: #B5C7DE; border-width: 1px;
            border-style: Solid; font-family: Verdana; font-size: 0.8em; border-collapse: collapse;
            margin-left: auto; margin-right: auto;">
            <tr>
                <td colspan="4">
                    Select a project to manage:
                    <asp:DropDownList ID="ddlAllProjects" runat="server" />
                </td>
            </tr>
            <tr>
                <td>
                    Unassigned Employees:
                </td>
                <td width="50">
                </td>
                <td>
                    Employees in selected project:
                </td>
            </tr>
            <tr>
                <td>
                    <asp:ListBox ID="lbUnassignedUsers" runat="server" Rows="6" Width="200" SelectionMode="Multiple" />
                    <asp:RequiredFieldValidator ID="SelectAssignUserRequired" runat="server" ErrorMessage="Please select an Employee."
                        ControlToValidate="lbUnassignedUsers" Display="Dynamic" ForeColor="Red" ValidationGroup="vgAssignUser">*</asp:RequiredFieldValidator>
                </td>
                <td width="50">
                </td>
                <td align="right">
                    <asp:ListBox ID="lbAssignedEmployees" runat="server" Rows="6" Width="200" SelectionMode="Multiple" />
                    <asp:RequiredFieldValidator ID="SelectUnassignUserRequired" runat="server" ErrorMessage="Please select an Employee."
                        ControlToValidate="lbAssignedEmployees" Display="Dynamic" ForeColor="Red" ValidationGroup="vgUnassignUser">*</asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <asp:Button ID="buttonAssignUser" Text="Assign to Project" runat="server" ValidationGroup="vgAssignUser" />
                </td>
                <td align="right">
                    <asp:Button ID="buttonUnassignUser" Text="Unassign from Project" runat="server" ValidationGroup="vgUnassignUser" />
                </td>
            </tr>
            <tr>
                <td colspan="4" align="right">
                    <asp:UpdatePanel ID="UpdatePanel_AssignUser" runat="server">
                        <ContentTemplate>
                            <asp:Label ID="AssignLabel" runat="server" Text=""></asp:Label>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="ErrorTimer" EventName="Tick" />
                        </Triggers>
                    </asp:UpdatePanel>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
