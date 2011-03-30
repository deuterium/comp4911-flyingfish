<%@ Page Title="" Language="C#" MasterPageFile="~/FlyingFishMasterPage.master" AutoEventWireup="true" CodeFile="TimeSheetStatusReport.aspx.cs" Inherits="Reports_TimeSheetStatusReport" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" Runat="Server">
    <asp:ToolkitScriptManager ID="tsmManager" runat="server">
    </asp:ToolkitScriptManager>
    <table>
        <tr>
            <td>
                <asp:Label ID="lblProjId" runat="server" Text="Choose a Project:"></asp:Label>
            </td>
            <td>
                <asp:DropDownList ID="ddlAllProjects" runat="server" AutoPostBack="True"
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
                        <asp:DropDownList ID="ddlWorkpackages" runat="server" AutoPostBack="True" >
                        </asp:DropDownList>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="ddlAllProjects" EventName="SelectedIndexChanged" />
                    </Triggers>
                </asp:UpdatePanel>
            </td>
        </tr>
        </tr>
    </table>
    Reporting period from
    <asp:TextBox ID="tbPeriodStart" runat="server"></asp:TextBox>
    <asp:CalendarExtender ID="cexPeriodStart" runat="server" Format="yyyy/MM/dd" TargetControlID="tbPeriodStart" >
    </asp:CalendarExtender>
     to 
    <asp:TextBox ID="tbPeriodEnd" runat="server"></asp:TextBox>
    <asp:CalendarExtender ID="cexPeriodEnd" runat="server" Format="yyyy/MM/dd" TargetControlID="tbPeriodEnd" >
    </asp:CalendarExtender>
    <br />
    <br />

    <asp:Button ID="btnSubmit" runat="server" Text="Submit" 
        onclick="btnSubmit_Click" />
    <br />

    <table cellpadding="10px">
        <tr>
            <td>
                <asp:GridView ID="gvStatus" runat="server">
                </asp:GridView>
            </td>
            <td>
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
            </td>
        </tr>
    </table>


    <center>
    <br />
    <div>
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
    </div>
    <br />
    <asp:Button ID="btnSave" runat="server" Text="Save Report" />
    </center>
</asp:Content>

