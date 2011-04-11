﻿<%@ Page Language="C#" Title="" MasterPageFile="~/FlyingFishMasterPage.master"
    AutoEventWireup="true" CodeFile="Project.aspx.cs" Inherits="PM_Project" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="Server">
    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </asp:ToolkitScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div id="divCreateProject" runat="server" visible="true">
                <asp:Label ID="lblProjectTitle" runat="server" Font-Bold="true" Font-Size="Large"
                    Text="Project Creation" />
                <br />
                <div class="divline"></div>
                <br />
                <asp:Label ID="lblMsg" runat="server" Text="Fill in the following fields below to create a project." />
                <br /><br />
                <table>
                    <tr>
                        <td align="right">
                            <asp:Label ID="lblProjectID" runat="server" Text="Project ID: " />
                        </td>
                        <td>
                            <asp:TextBox ID="tbProjectID" runat="server" />
                            <asp:RequiredFieldValidator ID="rfvID" runat="server" ControlToValidate="tbProjectID"
                                ErrorMessage="Project ID is required" ForeColor="Red">*</asp:RequiredFieldValidator>
                            <asp:CompareValidator ID="cvID" runat="server" ErrorMessage="ID must be an integer."
                                ForeColor="Red" Operator="DataTypeCheck" Type="Integer" ControlToValidate="tbProjectID">*</asp:CompareValidator>
                            <asp:RangeValidator ID="rvID" ControlToValidate="tbProjectID" runat="server" ErrorMessage="ID must be a positive value."
                                ForeColor="Red" MinimumValue="1" MaximumValue="9999999999999999">*</asp:RangeValidator>
                        </td>
                        <td align="right">
                            <asp:Label ID="lblProjectName" runat="server" Text="Project Name: "></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="tbProjectName" runat="server" />
                            <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="tbProjectName"
                                ErrorMessage="Project name is required" ForeColor="Red">*</asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="revName" runat="server" ControlToValidate="tbProjectName"
                                ErrorMessage="Project name must only contain letters from A-Z." ForeColor="Red"
                                ValidationExpression="^[a-zA-Z\s]+$">*</asp:RegularExpressionValidator>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            <asp:Label ID="lblUnalloc" runat="server" Text="Unallocated Budget: "></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="tbUnalloc" runat="server"></asp:TextBox>
                            <asp:CompareValidator ID="cvUnalloc" runat="server" ControlToValidate="tbUnalloc"
                                ErrorMessage="Unallocated Budget must be a number." ForeColor="Red" Operator="DataTypeCheck"
                                Type="Currency">*</asp:CompareValidator>
                            <asp:RangeValidator ID="rvUnalloc" ControlToValidate="tbUnalloc" runat="server" ForeColor="Red"
                                ErrorMessage="Unallocated Budget does not have a valid currency value." MinimumValue="0"
                                MaximumValue="79228162514264337593543950335" Type="Currency">*</asp:RangeValidator>
                        </td>
                        <td>
                            <asp:Label ID="lblPM" runat="server" Text="Project Manager:"></asp:Label>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlProjectManager" runat="server" AutoPostBack="True">
                            </asp:DropDownList>
                        </td>
                    </tr>
                </table>
                <br />
                <asp:Button ID="btnCreateProject" runat="server" Text="Create Project" OnClick="btnCreateProject_Click" />
                <div>
                    <br />
                    <asp:Label ID="lblError" runat="server" Text="" ForeColor="Red" />
                    <asp:ValidationSummary ID="vsCreateProject" runat="server" ForeColor="Red" />
                </div>
            </div>
            <div id="divCreateSuccess" runat="server" visible="false">
                <asp:Label ID="lblSuccessMsg" runat="server" Text="Project is successfully created."
                    ForeColor="Blue" />
                <br />
                <br />
                <asp:Button ID="btnCreate" runat="server" Text="Manage Project" OnClick="btnCreate_Click"
                    Style="height: 26px" />
                <asp:Button ID="btnViewProjects" runat="server" Text="View Projects" OnClick="btnViewProjects_Click" />
            </div>
            <asp:Label ID="lblException" runat="server" />
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="btnCreateProject" EventName="Click" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>
