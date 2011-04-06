<%@ Page Title="" Language="C#" MasterPageFile="~/HR/HRMaster.master" AutoEventWireup="true"
    CodeFile="AssignEmployee.aspx.cs" Inherits="HR_AssignEmployee" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HRContent" runat="Server">
    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </asp:ToolkitScriptManager>
    <div id="DivAssignUsers" runat="server">
        <br />
        This page is for assigning unassigned Employees to a project. Please select the
        project you wish to manage, then select one or more employees in the list of unassigned
        employees. Once you have confirmed they are the correct Employees, use the <i>&quot;Assign
            to Project&quot;</i> button to assign the selected Employee(s) to the Project.
        The opposite can be done with the <i>&quot;Unassign from Project&quot;</i> button.
        <br />
        <br />
        Note: Removing an Employee from a project automatically removes them from any Work
        Packages they&#39;ve been assigned to. Responsible Engineers cannot be removed from
        a Project; change the RE first before Employee can be removed from Project.<br />
        <br />
        <table style="background-color: #EFF3FB; border-color: #B5C7DE; border-width: 1px;
            border-style: Solid; font-family: Verdana; font-size: 0.8em; border-collapse: collapse;
            margin-left: auto; margin-right: auto;">
            <tr>
                <td colspan="3">
                    Select a project to manage:
                    <asp:DropDownList ID="ddlAllProjects" runat="server" 
                        oninit="ddlAllProjects_Init" />
                    &nbsp;<asp:Button ID="buttonSelectProject" runat="server" Text="Select Project" OnClick="buttonSelectProject_Click" />
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
                    <asp:UpdatePanel ID="UnassignedUsersUpdatePanel" runat="server">
                        <ContentTemplate>
                            <asp:ListBox ID="lbUnassignedUsers" runat="server" Rows="15" Width="200" SelectionMode="Multiple" />
                            <asp:RequiredFieldValidator ID="SelectAssignUserRequired" runat="server" ErrorMessage="Please select an Employee."
                                ControlToValidate="lbUnassignedUsers" Display="Dynamic" ForeColor="Red" ValidationGroup="vgAssignUser">*</asp:RequiredFieldValidator>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="buttonAssignUser" EventName="Click" />
                            <asp:AsyncPostBackTrigger ControlID="buttonUnassignUser" EventName="Click" />
                            <asp:AsyncPostBackTrigger ControlID="buttonSelectProject" EventName="Click" />
                        </Triggers>
                    </asp:UpdatePanel>
                </td>
                <td width="50">
                </td>
                <td align="right">
                    <asp:UpdatePanel ID="AssignedUsersUpdatePanel" runat="server">
                        <ContentTemplate>
                            <asp:ListBox ID="lbAssignedEmployees" runat="server" Rows="15" Width="200" SelectionMode="Multiple" />
                            <asp:RequiredFieldValidator ID="SelectUnassignUserRequired" runat="server" ErrorMessage="Please select an Employee."
                                ControlToValidate="lbAssignedEmployees" Display="Dynamic" ForeColor="Red" ValidationGroup="vgUnassignUser">*</asp:RequiredFieldValidator>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="buttonAssignUser" EventName="Click" />
                            <asp:AsyncPostBackTrigger ControlID="buttonUnassignUser" EventName="Click" />
                            <asp:AsyncPostBackTrigger ControlID="buttonSelectProject" EventName="Click" />
                        </Triggers>
                    </asp:UpdatePanel>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Button ID="buttonAssignUser" Text="Assign to Project" runat="server" ValidationGroup="vgAssignUser"
                        OnClick="buttonAssignUser_Click" />
                </td>
                <td width="50">
                </td>
                <td align="right">
                    <asp:Button ID="buttonUnassignUser" Text="Unassign from Project" runat="server" ValidationGroup="vgUnassignUser"
                        OnClick="buttonUnassignUser_Click" />
                </td>
            </tr>
            <tr>
                <td colspan="3" align="right">
                    <asp:UpdatePanel ID="AssignLabelUpdatePanel" runat="server">
                        <ContentTemplate>
                            <asp:Label ID="AssignLabel" runat="server" Text=""></asp:Label>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="buttonAssignUser" EventName="Click" />
                            <asp:AsyncPostBackTrigger ControlID="buttonUnassignUser" EventName="Click" />
                            <asp:AsyncPostBackTrigger ControlID="buttonSelectProject" EventName="Click" />
                        </Triggers>
                    </asp:UpdatePanel>
                </td>
            </tr>
        </table>
        <br />
        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                <div id="DivAssignPM" runat="server" visible="false">
                    <table style="background-color: #EFF3FB; border-color: #B5C7DE; border-width: 1px;
                        border-style: Solid; font-family: Verdana; font-size: 0.8em; border-collapse: collapse;
                        margin-left: auto; margin-right: auto;" width="300">
                        <tr>
                            <td>
                                Project:
                            </td>
                            <td align="right">
                                <asp:Label ID="labelProject" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Project Manager:
                            </td>
                            <td align="right">
                                <asp:DropDownList ID="ddlProjectManager" runat="server" Width="150">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" align="right">
                                <asp:Button ID="buttonChangePM" runat="server" Text="Change Project Manager" 
                                    onclick="buttonChangePM_Click" />
                            </td>
                        </tr>
                        <tr>
                        <td colspan="2" align="right">
                            <asp:Label ID="AssignPMLabel" runat="server"></asp:Label>
                        </td>
                        </tr>
                    </table>
                </div>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="buttonSelectProject" EventName="Click" />
            </Triggers>
        </asp:UpdatePanel>
    </div>
</asp:Content>
