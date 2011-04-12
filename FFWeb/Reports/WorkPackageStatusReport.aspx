<%@ Page Title="" Language="C#" MasterPageFile="~/FlyingFishMasterPage.master" AutoEventWireup="true"
    CodeFile="WorkPackageStatusReport.aspx.cs" Inherits="Reports_WorkPackageStatusReport" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        function validateEtc(source, args) {
            var strEac = document.getElementById("tbEac");
            var strEtc = document.getElementById("tbEtc");

            // if both have a value
            if (strEtc && strEac) {
                // if at least 1 is the Unknown Value
                if (((strEtc == "Unknown") || (strEac == "Unknown"))
                        || ((strEtc == "unknown") || (strEac == "unknown"))) {
                    args.IsValid = true;
                } else {
                    args.IsValid = false;
                }
            }

            // etc can't be greater than eac    X
            // eac can't be less than acwp      X 
            // eac can't be less than 0         X
            // etc can't be less than 0         X
            // only 1 can be blank

        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="Server">
    <div id="divInputForm" runat="server">
        <asp:ToolkitScriptManager ID="tsmManager" runat="server">
        </asp:ToolkitScriptManager>
        <asp:Label ID="lblwprTitle" runat="server" Text="Work Package Report" Font-Bold="true"
            Font-Size="Large" />
        <br />
        <div class="divline">
        </div>
        <br />
        <table>
            <tr>
                <td>
                    <asp:Label ID="lblChooseProjId" runat="server" Text="Choose a Project:"></asp:Label>
                </td>
                <td>
                    <asp:DropDownList ID="ddlAllProjects" runat="server" AutoPostBack="True" Width="180"
                        OnSelectedIndexChanged="ddlAllProjects_SelectedIndexChanged">
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
                            <asp:DropDownList ID="ddlWorkpackages" runat="server" AutoPostBack="True" Width="180">
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
                    <asp:CalendarExtender ID="cexCutOffDate" runat="server" Format="yyyy/MM/dd" TargetControlID="tbCutOffDate">
                    </asp:CalendarExtender>
                    <asp:RequiredFieldValidator ID="rfvCutOffDate" runat="server" Text="*" ControlToValidate="tbCutOffDate"
                        ErrorMessage="Please specifiy an end date." ForeColor="Red">
                    </asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ForeColor="Red" ID="revCutOffDate" runat="server"
                        ValidationExpression="^[0-9]{4}/{1}[0-9]{2}/{1}[0-9]{2}$" ControlToValidate="tbCutOffDate"
                        ErrorMessage="End date must be in format 'YYYY/MM/DD'">*</asp:RegularExpressionValidator>
                    <asp:RangeValidator ForeColor="Red" ID="rgvCutOffDate" runat="server" ControlToValidate="tbCutOffDate"
                        ErrorMessage="End date must be between 2010/01/01 and 2500/01/01." MaximumValue="2500/01/01"
                        MinimumValue="2010/01/01" Text="*">
                    </asp:RangeValidator>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <asp:ValidationSummary ForeColor="Red" ID="vsyWpStatusReport" runat="server" />
                </td>
            </tr>
        </table>
        <br />
        <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" />
        <asp:Button ID="btnNewReport" runat="server" Text="Create New Report" OnClick="btnNewReport_Click" />
    </div>
    <br />
    <asp:UpdatePanel ID="udpReportResults" runat="server">
        <ContentTemplate>
            <asp:Label ID="lblResults" runat="server" Text="No reports found." Visible="false"></asp:Label>
            <div id="divReportData" runat="server" visible="false">

            <asp:Label ID="lblwprSubmenuReportTitle" runat="server" Text="Report Info" Font-Bold="true" />
            <br />
            <div class="divline"></div>
            <br />
                <center>
                <table>
                    <tr>
                        <td>
                            <asp:Label Text="Workpackage: " ID="lblwprWP" runat="server" Font-Bold="true" />
                        </td>
                        <td>
                            <asp:Label ID="lblWp" runat="server" Text=""></asp:Label>
                        </td>
                        <td>
                            &nbsp&nbsp&nbsp&nbsp&nbsp
                        </td>
                        <td>
                            <asp:Label Text="Report Cut-off Date: " ID="lblwprCutoff" runat="server" Font-Bold="true" />
                        </td>
                        <td>
                            <asp:Label ID="lblReportPeriod" runat="server" Text=""></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label Text="Responsible Engineer: " ID="lblwprRE" runat="server" Font-Bold="true" />
                        </td>
                        <td>
                            <asp:Label ID="lblRe" runat="server" Text=""></asp:Label>
                        </td>
                        <td>
                            &nbsp&nbsp&nbsp&nbsp&nbsp
                        </td>
                        <td>
                            <asp:Label Text="Project Manager: " ID="lblwprPM" runat="server" Font-Bold="true" />
                        </td>
                        <td>
                            <asp:Label ID="lblPm" runat="server" Text=""></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label Text="PM BAC: " ID="lblwprPMBAC" runat="server" Font-Bold="true" />
                        </td>
                        <td>
                            <asp:Label ID="lblPmBac" runat="server" Text=""></asp:Label>
                        </td>
                        <td>
                            &nbsp&nbsp&nbsp&nbsp&nbsp
                        </td>
                        <td>
                            <asp:Label Text="RE BAC: " ID="lblwprREBAC" runat="server" Font-Bold="true" />
                        </td>
                        <td>
                            <asp:Label ID="lblReBac" runat="server" Text=""></asp:Label>
                        </td>
                        <td>
                            &nbsp&nbsp&nbsp&nbsp&nbsp
                        </td>
                        </tr>
                        <tr>
                        <td>
                            <asp:Label Text="Total ACWP: " ID="lblwprACWP" runat="server" Font-Bold="true" />
                        </td>
                        <td>
                            <asp:Label ID="lblTotalAcwp" runat="server" Text=""></asp:Label>
                        </td>
                    </tr>
                </table>
                </center>
                <br />
                <center>
                    <asp:GridView ID="gvStatus" runat="server" AutoGenerateColumns="False" OnRowCancelingEdit="gvStatus_RowCancelingEdit"
                        OnRowCommand="gvStatus_RowCommand" OnRowEditing="gvStatus_RowEditing" OnRowUpdating="gvStatus_RowUpdating"
                        BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px"
                        CellPadding="3">
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
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="ETC">
                                <EditItemTemplate>
                                    <asp:TextBox ID="tbEtc" Width="75px" MaxLength="11" runat="server" Text='<%# Bind("ETC") %>' />
                                    <asp:RegularExpressionValidator ID="revEtc" runat="server" ErrorMessage="ETC can only contain a dollar sign, comma, period, and positive numbers."
                                        ControlToValidate="tbEtc" ValidationExpression="^([Uu]{1}[n]{1}[k]{1}[n]{1}[o]{1}[w]{1}[n]{1})|[0-9]*([.]+[0-9]*)?$"
                                        Text="*" ForeColor="Red">
                                    </asp:RegularExpressionValidator>
                                    <asp:CompareValidator ID="cpvEtcEac" runat="server" ErrorMessage="ETC must be less than EAC."
                                        ForeColor="Red" ControlToValidate="tbEtc" ControlToCompare="tbEac" Text="*" Operator="LessThanEqual">
                                    </asp:CompareValidator>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblEtc" runat="server" Text='<%# Bind("ETC") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="EAC">
                                <EditItemTemplate>
                                    <asp:TextBox ID="tbEac" Width="75px" MaxLength="11" runat="server" Text='<%# Bind("EAC") %>' />
                                    <%--                                    <asp:CustomValidator ID="cuvEac" runat="server" ErrorMessage="One value must be blank or 'Unknown'."
                                        Text="*" OnServerValidate="cuvEac_ServerValidate" ClientValidationFunction="validateEtc"
                                        ControlToValidate="tbEac" ForeColor="Red" ValidateEmptyText="False">
                                    </asp:CustomValidator>
                                    <asp:RegularExpressionValidator ID="revEac" runat="server" ErrorMessage="EAC can only contain a dollar sign, comma, period, and numbers."
                                            ControlToValidate="tbEac" ValidationExpression="^([Uu]{1}[n]{1}[k]{1}[n]{1}[o]{1}[w]{1}[n]{1})|[0-9]*([.]+[0-9]*)?$" Text="*"
                                            ForeColor="Red" >
                                    </asp:RegularExpressionValidator>
                                    <asp:CompareValidator ID="cpvEacZero" runat="server" ErrorMessage="EAC must be greater than 0."
                                        Text="*" ForeColor="Red" ValueToCompare="0" Operator="GreaterThan" ControlToValidate="tbEac">
                                    </asp:CompareValidator>--%>
                                    <%--<asp:CompareValidator ID="cpvEacAcwp" runat="server" ErrorMessage="EAC must be greater than or equal to ACWP."
                                        Text="*" ForeColor="Red" ControlToValidate="tbEac" ControlToCompare="lblAcwp2" Operator="GreaterThanEqual">
                                    </asp:CompareValidator>
                                    --%>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblEac" runat="server" Text='<%# Bind("EAC") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Complete">
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
                <fieldset>
                    <legend>Comments</legend>
                    <center>
                        <asp:TextBox ID="tbComments" runat="server" TextMode="MultiLine" BorderWidth="0px"
                            Width="925" Rows="3" MaxLength="255"></asp:TextBox>
                    </center>
                </fieldset>
                <fieldset>
                    <legend>Work Accomplished this Period</legend>
                    <center>
                        <asp:TextBox ID="tbWorkAccomplished" runat="server" TextMode="MultiLine" BorderWidth="0px"
                            Width="925" Rows="3" MaxLength="255"></asp:TextBox>
                    </center>
                </fieldset>
                <fieldset>
                    <legend>Work Planned Next Period</legend>
                    <center>
                        <asp:TextBox ID="tbWorkPlannedNext" runat="server" TextMode="MultiLine" BorderWidth="0px"
                            Width="925" Rows="3" MaxLength="255"></asp:TextBox>
                    </center>
                </fieldset>
                <fieldset>
                    <legend>Problems this Period</legend>
                    <center>
                        <asp:TextBox ID="tbProblemsEncountered" runat="server" TextMode="MultiLine" BorderWidth="0px"
                            Width="925" Rows="3" MaxLength="255"></asp:TextBox>
                    </center>
                </fieldset>
                <fieldset>
                    <legend>Problems Anticipated Next</legend>
                    <center>
                        <asp:TextBox ID="tbProblemsAncticipatedNext" runat="server" TextMode="MultiLine"
                            BorderWidth="0px" Width="925" Rows="3" MaxLength="255"></asp:TextBox>
                    </center>
                </fieldset>
                <br />
                <asp:Button ID="btnSave" runat="server" Text="Save Report" OnClick="btnSave_Click" />
            </div>
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="btnSubmit" EventName="Click" />
            <asp:AsyncPostBackTrigger ControlID="btnSave" EventName="Click" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>
