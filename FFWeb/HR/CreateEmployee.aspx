<%@ Page Title="" Language="C#" MasterPageFile="~/HR/HRMaster.master" AutoEventWireup="true"
    CodeFile="CreateEmployee.aspx.cs" Inherits="HR_CreateEmployee" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HRContent" runat="Server">
    <div id="DivNewUser" class="DivNewUser" runat="server">
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
                        <asp:Label ID="Label1" CssClass="lblcreatenewemp" runat="server" Text="Enter new employee infomation to create new user account" />
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
                                                <asp:ListBox ID="SupervisorList" runat="server" oninit="SupervisorList_Init" />
                                                <asp:RequiredFieldValidator ID="SupervisorRequired" runat="server" ErrorMessage="A suprvisor is required."
                                                    ValidationGroup="cuwCreateUser" ControlToValidate="SupervisorList" ForeColor="Red">*</asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left">
                                                <asp:Label ID="ApproverLabel" runat="server">Approver:</asp:Label>
                                            </td>
                                            <td>
                                                <asp:ListBox ID="ApproverList" runat="server" />
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
</asp:Content>
