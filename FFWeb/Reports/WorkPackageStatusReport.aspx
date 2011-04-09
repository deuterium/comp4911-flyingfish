<%@ Page Title="" Language="C#" MasterPageFile="~/FlyingFishMasterPage.master" AutoEventWireup="true" CodeFile="WorkPackageStatusReport.aspx.cs" Inherits="Reports_WorkPackageStatusReport" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" Runat="Server">
    <center>
    <div id="divInputForm" runat="server">
        <asp:ToolkitScriptManager ID="tsmManager" runat="server">
        </asp:ToolkitScriptManager>
        <table cellpadding="5px" >
            <tr>
                <td>
                    <asp:Label ID="lblChooseProjId" runat="server" Text="Choose a Project:"></asp:Label>
                </td>
                <td>
                    <asp:DropDownList ID="ddlAllProjects" runat="server" AutoPostBack="True" Width="180"
                        onselectedindexchanged="ddlAllProjects_SelectedIndexChanged" >
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblChooseWp" runat="server" Text="Choose a Workpackage:"></asp:Label>
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
                    Cut-off Date:
                </td>
                <td>
                    <asp:TextBox ID="tbCutOffDate" runat="server" Width="80"></asp:TextBox>
                    <asp:CalendarExtender ID="cexCutOffDate" runat="server" Format="yyyy/MM/dd" TargetControlID="tbCutOffDate" >
                    </asp:CalendarExtender>
                    <asp:RequiredFieldValidator ID="rfvCutOffDate" runat="server" Text="*" ControlToValidate="tbCutOffDate"
                        ErrorMessage="Please specifiy an end date." ForeColor="Red">
                    </asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ForeColor="Red" ID="revCutOffDate" runat="server" 
                        ValidationExpression="^[0-9]{4}/{1}[0-9]{2}/{1}[0-9]{2}$" ControlToValidate="tbCutOffDate"
                        ErrorMessage="End date must be in format 'YYYY/MM/DD'" >*</asp:RegularExpressionValidator>
                    <asp:RangeValidator ForeColor="Red" ID="rgvCutOffDate" runat="server" ControlToValidate="tbCutOffDate"
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
    
    <asp:UpdatePanel ID="udpReportResults" runat="server">
    <ContentTemplate>

    <asp:Label ID="lblResults" runat="server" Text="No reports found." Visible="false" ></asp:Label>                        
    <div id="divReportData" runat="server" visible="false">
        <asp:Table ID="tblResults" runat="server" Visible="true" Cellpadding="10">
            <asp:TableRow>

            <asp:TableCell>
                    <table>
                        <tr>
                            <td>
                                <b>Report Info:</b>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Workpackage: 
                            </td>
                            <td>
                                <asp:Label ID="lblWp" runat="server" Text=""></asp:Label>
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
                                Report Cut-off Date: 
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

                <asp:TableCell>
                
                   <asp:GridView ID="gvStatus" runat="server" AutoGenerateColumns="False" OnRowCancelingEdit="gvStatus_RowCancelingEdit"
                            OnRowCommand="gvStatus_RowCommand" OnRowEditing="gvStatus_RowEditing" OnRowUpdating="gvStatus_RowUpdating">
                        <Columns>
                            <asp:TemplateField HeaderText="Employee">
                                <EditItemTemplate>
                                    <asp:Label ID="lblEmployee1" runat="server" Text='<%# Bind("Employee") %>'></asp:Label>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblEmployee2" runat="server" Text='<%# Bind("Employee") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="ACWP">
                                <EditItemTemplate>
                                    <asp:Label ID="lblAcwp1" runat="server" Text='<%# Bind("ACWP") %>'></asp:Label>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblAcwp2" runat="server" Text='<%# Bind("ACWP") %>'></asp:Label>
                                </ItemTemplate>
                                <ControlStyle Width="75px" />
                                <ItemStyle Width="75px" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="ETC">
                                <EditItemTemplate>
                                    <asp:TextBox ID="tbEtc" Width="60px" runat="server" Text='<%# Bind("ETC") %>' />
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblEtc" runat="server" Text='<%# Bind("ETC") %>'></asp:Label>
                                </ItemTemplate>
                                <ControlStyle Width="75px" />
                                <ItemStyle Width="75px" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="EAC">
                                <EditItemTemplate>
                                    <asp:TextBox ID="tbEac" Width="60px" runat="server" Text='<%# Bind("EAC") %>' />
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblEac" runat="server" Text='<%# Bind("EAC") %>'></asp:Label>
                                </ItemTemplate>
                                <ControlStyle Width="75px" />
                                <ItemStyle Width="75px" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Percent Complete">
                                <EditItemTemplate>
                                    <asp:Label ID="lblPercentComplete1" runat="server" Text='<%# Bind("PercentComplete") %>'></asp:Label>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblPercentComplete2" runat="server" Text='<%# Bind("PercentComplete") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:CommandField ButtonType="Button" ShowEditButton="True" UpdateText="Save">
                                <ItemStyle HorizontalAlign="Center" Wrap="False" />
                            </asp:CommandField>
                        </Columns>
                    </asp:GridView>
                
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
    </div>

    </ContentTemplate>
    <Triggers>
        <asp:AsyncPostBackTrigger ControlID="btnSubmit" EventName="Click" />
        <asp:AsyncPostBackTrigger ControlID="btnSave" EventName="Click" />
    </Triggers>
    </asp:UpdatePanel>
    
    </center>
</asp:Content>
