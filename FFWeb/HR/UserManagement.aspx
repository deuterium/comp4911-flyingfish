<%@ Page Title="" Language="C#" MasterPageFile="~/FlyingFishMasterPage.master" AutoEventWireup="true"
    CodeFile="UserManagement.aspx.cs" Inherits="UserManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="Server">
    <div id="DivUserManagement">
        <div id="DivUserManagementMenu" runat="server">
            <br />
            <asp:LinkButton ID="CreateUserLabel" runat="server" OnClick="lbCreateUser_Click">Create New User</asp:LinkButton>
            &nbsp;
            <asp:LinkButton ID="ManageUserLabel" runat="server" OnClick="ManageUserLabel_Click">Manage Existing Users</asp:LinkButton>
        </div>
        <div id="DivNewUser" runat="server" visible="false">
            <br />
            <asp:CreateUserWizard ID="cuwCreateUser" runat="server" BackColor="#EFF3FB" BorderColor="#B5C7DE"
                BorderStyle="Solid" BorderWidth="1px" Font-Names="Verdana" Font-Size="0.8em"
                CreateUserButtonText="Create New User" OnCreatedUser="cuwCreateUser_CreatedUser"
                LoginCreatedUser="False" OnCreatingUser="cuwCreateUser_CreatingUser" 
                oncontinuebuttonclick="cuwCreateUser_ContinueButtonClick" 
                CompleteSuccessText="The account has been successfully created." 
                ContinueButtonText="Create another User" EnableViewState="False">
                <ContinueButtonStyle BackColor="White" BorderColor="#507CD1" BorderStyle="Solid"
                    BorderWidth="1px" Font-Names="Verdana" ForeColor="#284E98" />
                <CreateUserButtonStyle BackColor="White" BorderColor="#507CD1" BorderStyle="Solid"
                    BorderWidth="1px" Font-Names="Verdana" ForeColor="#284E98" />
                <TitleTextStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <WizardSteps>
                    <asp:CreateUserWizardStep ID="wsEmployeeAccountInfo" runat="server" Title="New Employee Account Information">
                        <ContentTemplate>
                            <table>
                                <tr>
                                    <td align="center" colspan="2">
                                        Enter new Employee Infomation to create User
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        <asp:Label ID="FirstNameLabel" runat="server" AssociatedControlID="FirstName">First Name:</asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="FirstName" runat="server" Width="146"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="FirstNameRequired" runat="server" ControlToValidate="FirstName"
                                            ErrorMessage="First Name is required." ToolTip="First Name is required." ValidationGroup="cuwCreateUser"
                                            ForeColor="Red">*</asp:RequiredFieldValidator>
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
                                        <asp:Label ID="RoleLabel" runat="server">Role:</asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="RoleList" runat="server" DataSourceID="RoleSource" DataTextField="RoleName"
                                            DataValueField="RoleId">
                                        </asp:DropDownList>
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
                                    <td align="center" colspan="2">
                                        <asp:CompareValidator ID="PasswordCompare" runat="server" ControlToCompare="Password"
                                            ControlToValidate="ConfirmPassword" Display="Dynamic" ErrorMessage="The Password and Confirmation Password must match."
                                            ValidationGroup="cuwCreateUser"></asp:CompareValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center" colspan="2" style="color: Red;">
                                        <asp:Literal ID="ErrorMessage" runat="server" EnableViewState="False"></asp:Literal>
                                    </td>
                                </tr>
                            </table>
                        </ContentTemplate>
                    </asp:CreateUserWizardStep>
                    <asp:CompleteWizardStep ID="wsEmployeeComplete" runat="server">
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
            <asp:LinqDataSource ID="RoleSource" runat="server" ContextTypeName="FFLib.FlyingFishDataContext"
                EntityTypeName="" Select="new (RoleId, RoleName)" TableName="aspnet_Roles">
            </asp:LinqDataSource>
        </div>
        <div id="DivManageUsers" runat="server" visible="false">
            <br />
            <asp:GridView ID="gvManageUsers" runat="server">
            </asp:GridView>
        </div>
    </div>
</asp:Content>
