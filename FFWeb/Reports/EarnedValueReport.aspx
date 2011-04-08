<%@ Page Title="" Language="C#" MasterPageFile="~/FlyingFishMasterPage.master" AutoEventWireup="true" CodeFile="EarnedValueReport.aspx.cs" Inherits="Reports_EarnedValueReport" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" Runat="Server">
    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server"></asp:ToolkitScriptManager>   
    <center>

    <div id="divInputForm" runat="server">
        <table cellpadding="5px" >
            <tr>
              
                <td>
                    <asp:Label ID="lblProjId" runat="server" Text="Choose a Project:"></asp:Label>
                </td>
                <td>
                    <asp:DropDownList ID="ddlAllProjects" runat="server" Width="180" >
                    </asp:DropDownList>
                </td>
            </tr>

            <tr>
                <td>
                    Reporting Period From:
                </td>
                <td>
                    <asp:TextBox ID="tbPeriodStart" runat="server" Width="80"></asp:TextBox>
                    <asp:CalendarExtender ID="cexPeriodStart" runat="server" Format="yyyy/MM/dd" TargetControlID="tbPeriodStart" >
                    </asp:CalendarExtender>
                     to 
                    <asp:TextBox ID="tbPeriodEnd" runat="server" Width="80"></asp:TextBox>
                    <asp:CalendarExtender ID="cexPeriodEnd" runat="server" Format="yyyy/MM/dd" TargetControlID="tbPeriodEnd" >
                    </asp:CalendarExtender>
                    <asp:RegularExpressionValidator ForeColor="Red" ID="revStartDate" runat="server" 
                        ValidationExpression="^[0-9]{4}/{1}[0-9]{2}/{1}[0-9]{2}$" ControlToValidate="tbPeriodStart"
                        ErrorMessage="Start date must be in format 'YYYY/MM/DD'" >*</asp:RegularExpressionValidator>
                    <asp:RangeValidator ForeColor="Red" ID="rgvStartDate" runat="server" ControlToValidate="tbPeriodStart"
                        ErrorMessage="Start date must be between 2010/01/01 and 2500/01/01."
                        MaximumValue="2500/01/01" MinimumValue="2010/01/01" Text="*">
                    </asp:RangeValidator>
                    <asp:RequiredFieldValidator ID="rfvStartDate" runat="server" 
                        ControlToValidate="tbPeriodStart" ErrorMessage="Start date not selected" 
                        ForeColor="Red">*</asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ForeColor="Red" ID="revEndDate" runat="server" 
                        ValidationExpression="^[0-9]{4}/{1}[0-9]{2}/{1}[0-9]{2}$" ControlToValidate="tbPeriodEnd"
                        ErrorMessage="End date must be in format 'YYYY/MM/DD'" >*</asp:RegularExpressionValidator>
                    <asp:RequiredFieldValidator ID="rfvEndtDate" runat="server" 
                        ControlToValidate="tbPeriodEnd" ErrorMessage="End date not selected" 
                        ForeColor="Red">*</asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td align="right">
                </td>
                <td align="left">
                    <asp:Button ID="btnSubmit" runat="server" Text="Submit" 
                        onclick="btnSubmit_Click" />
                </td>
            </tr>
            <tr>
                <td colspan="2" >
                    <asp:ValidationSummary ForeColor="Red" ID="vsyWpStatusReport" runat="server" />
                </td>
            </tr>
            
        </table>
    </div>

    <br />

        <asp:GridView ID="gvEarnedValue" runat="server" AutoGenerateColumns="False">
        <Columns>
            <asp:TemplateField HeaderText="Workpackage">
                <EditItemTemplate>
                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("Workpackage") %>'></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label4" runat="server" Text='<%# Bind("Workpackage") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="PM-Budget">
                <EditItemTemplate>
                    <asp:Label ID="Label13" runat="server" Text='<%# Bind("PMBudget") %>'></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label14" runat="server" Text='<%# Bind("PMBudget") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="RE-Estimate">
                <EditItemTemplate>
                    <asp:Label ID="Label15" runat="server" Text='<%# Bind("REBudget") %>'></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label16" runat="server" Text='<%# Bind("REBudget") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="ACWP">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" Width="60px" runat="server" Text='<%# Bind("ACWP") %>' />
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label5" runat="server" Text='<%# Bind("ACWP") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="RE-EAC">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox2" Width="60px" runat="server" Text='<%# Bind("REEAC") %>' />
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label6" runat="server" Text='<%# Bind("REEAC") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="PM-VAR">
                <EditItemTemplate>
                    <asp:Label ID="Label7" runat="server" Text='<%# Bind("PMVAR") %>'></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label8" runat="server" Text='<%# Bind("PMVAR") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="RE-VAR">
                <EditItemTemplate>
                    <asp:Label ID="Label9" runat="server" Text='<%# Bind("REVAR") %>'></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label10" runat="server" Text='<%# Bind("REVAR") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Complete">
                <EditItemTemplate>
                    <asp:Label ID="Label11" runat="server" Text='<%# Bind("Complete") %>'></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label12" runat="server" Text='<%# Bind("Complete") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    </center>
</asp:Content>

