<%@ Page Title="" Language="C#" MasterPageFile="~/FlyingFishMasterPage.master" AutoEventWireup="true" CodeFile="WorkpackageStatusReport.aspx.cs" Inherits="Reports_WorkpackageStatusReport" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" Runat="Server">
    <center><div id="divInputForm" runat="server">
        <asp:ToolkitScriptManager ID="tsmManager" runat="server">
        </asp:ToolkitScriptManager>
        <table cellpadding="5px" >
            <tr>
                <td>
                    <asp:Label ID="lblProjId" runat="server" Text="Choose a Project:"></asp:Label>
                </td>
                <td>
                    <asp:DropDownList ID="ddlAllProjects" runat="server" AutoPostBack="True" Width="180"
                        onselectedindexchanged="ddlAllProjects_SelectedIndexChanged" >
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblWp" runat="server" Text="Choose a Workpackage:"></asp:Label>
                </td>
                <td>
                    <asp:UpdatePanel ID="udpWorkpackageList" runat="server">
                        <ContentTemplate>
                            <asp:DropDownList ID="ddlWorkpackages" runat="server" AutoPostBack="True" Width="180" >
                            </asp:DropDownList>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="ddlAllProjects" EventName="SelectedIndexChanged" />
                        </Triggers>
                    </asp:UpdatePanel>
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
                    <asp:RegularExpressionValidator ForeColor="Red" ID="revEndDate" runat="server" 
                        ValidationExpression="^[0-9]{4}/{1}[0-9]{2}/{1}[0-9]{2}$" ControlToValidate="tbPeriodEnd"
                        ErrorMessage="End date must be in format 'YYYY/MM/DD'" >*</asp:RegularExpressionValidator>
                    <asp:RangeValidator ForeColor="Red" ID="rgvEndDate" runat="server" ControlToValidate="tbPeriodEnd"
                        ErrorMessage="End date must be between 2010/01/01 and 2500/01/01."
                        MaximumValue="2500/01/01" MinimumValue="2010/01/01" Text="*">
                    </asp:RangeValidator>
                </td>
            </tr>
            <tr>
                <td align="right">
                    <asp:Button ID="btnNewReport" runat="server" Text="Create New Report" 
                        onclick="btnNewReport_Click" />
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
    <asp:Label ID="lblResults" runat="server" Text="No reports found." Visible="false" ></asp:Label>
    <div id="divReportData" runat="server" visible="false">
        <asp:Table ID="tblResults" runat="server" Visible="true" Cellpadding="10">
            <asp:TableRow>
                <asp:TableCell>
                  
                   <asp:GridView ID="gvStatus" runat="server" AutoGenerateColumns="False" OnRowCancelingEdit="gvStatus_RowCancelingEdit"
                            OnRowCommand="gvStatus_RowCommand" OnRowEditing="gvStatus_RowEditing" OnRowUpdated="gvStatus_RowUpdated">
                        <Columns>
                            <asp:TemplateField HeaderText="Employee">
                                <EditItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("Employee") %>'></asp:Label>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("Employee") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="ACWP">
                                <EditItemTemplate>
                                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("ACWP") %>'></asp:Label>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label4" runat="server" Text='<%# Bind("ACWP") %>'></asp:Label>
                                </ItemTemplate>
                                <ControlStyle Width="60px" />
                                <ItemStyle Width="60px" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="ETC">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox1" Width="60px" runat="server" Text='<%# Bind("ETC") %>' />
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label5" runat="server" Text='<%# Bind("ETC") %>'></asp:Label>
                                </ItemTemplate>
                                <ControlStyle Width="60px" />
                                <ItemStyle Width="60px" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="EAC">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox2" Width="60px" runat="server" Text='<%# Bind("EAC") %>' />
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label6" runat="server" Text='<%# Bind("EAC") %>'></asp:Label>
                                </ItemTemplate>
                                <ControlStyle Width="60px" />
                                <ItemStyle Width="60px" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Percent Complete">
                                <EditItemTemplate>
                                    <asp:Label ID="Label7" runat="server" Text='<%# Bind("PercentComplete") %>'></asp:Label>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label8" runat="server" Text='<%# Bind("PercentComplete") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:CommandField ButtonType="Button" ShowEditButton="True" UpdateText="Save">
                                <ItemStyle HorizontalAlign="Center" Wrap="False" />
                            </asp:CommandField>
                        </Columns>
                    </asp:GridView>

                </asp:TableCell>
                <asp:TableCell>
                    <table>
                        <tr>
                            <td>
                                <b>Report Info:</b>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Workpackage Id: 
                            </td>
                            <td>
                                <asp:Label ID="lblWpId" runat="server" Text=""></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Workpackage Name: 
                            </td>
                            <td>
                                <asp:Label ID="lblWpName" runat="server" Text=""></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Responsible Engineer: 
                            </td>
                            <td>
                                 <asp:Label ID="lblRe" runat="server" Text=""></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                 Project Manager: 
                            </td>
                            <td>
                                 <asp:Label ID="lblPm" runat="server" Text=""></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                 Report No: 
                            </td>
                            <td>
                                <asp:Label ID="lblReportNo" runat="server" Text=""></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Reporting Period: 
                            </td>
                            <td>
                                <asp:Label ID="lblReportPeriod" runat="server" Text=""></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                PM BAC:
                            </td>
                            <td>
                                <asp:Label ID="lblPmBac" runat="server" Text=""></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                RE BAC: 
                            </td>
                            <td>
                                <asp:Label ID="lblReBac" runat="server" Text=""></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Total ACWP: 
                            </td>
                            <td>
                                <asp:Label ID="lblTotalAcwp" runat="server" Text=""></asp:Label>
                            </td>
                        </tr>
                    </table>
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>
        <br />
        <fieldset>
            <legend>Comments</legend>
            <center>
                <asp:TextBox ID="tbComments" runat="server" TextMode="MultiLine" BorderWidth="0px" Width="925" Rows="3" MaxLength="255" ></asp:TextBox>
            </center>
        </fieldset>
        <fieldset>
        <legend>Work Accomplished this Period</legend>
            <center>
                <asp:TextBox ID="tbWorkAccomplished" runat="server" TextMode="MultiLine" BorderWidth="0px" Width="925" Rows="3" MaxLength="255" ></asp:TextBox>
            </center>
        </fieldset>
        <fieldset>
            <legend>Work Planned Next Period</legend>
            <center>
                <asp:TextBox ID="tbWorkPlannedNext" runat="server" TextMode="MultiLine" BorderWidth="0px" Width="925" Rows="3" MaxLength="255" ></asp:TextBox>
            </center>
        </fieldset>
        <fieldset>
            <legend>Problems this Period</legend>
            <center>
                <asp:TextBox ID="tbProblemsEncountered" runat="server" TextMode="MultiLine" BorderWidth="0px" Width="925" Rows="3" MaxLength="255" ></asp:TextBox>
            </center>
        </fieldset>
        <fieldset>
        <legend>Problems Anticipated Next</legend>
            <center>
                <asp:TextBox ID="tbProblemsAncticipatedNext" runat="server" TextMode="MultiLine" BorderWidth="0px" Width="925" Rows="3" MaxLength="255" ></asp:TextBox>
            </center>
        </fieldset>
            <br />
        <asp:Button ID="btnSave" runat="server" Text="Save Report" 
            onclick="btnSave_Click" />
        </center>
    </div>
    </center>
</asp:Content>

