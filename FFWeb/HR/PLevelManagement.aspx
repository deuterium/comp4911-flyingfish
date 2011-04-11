<%@ Page Title="" Language="C#" MasterPageFile="~/HR/HRMaster.master" AutoEventWireup="true"
    CodeFile="PLevelManagement.aspx.cs" Inherits="HR_PLevelManagement" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HRContent" runat="Server">
    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </asp:ToolkitScriptManager>
    <div>
        <br />
        <center>
            <table width="700">
                <tr>
                    <td>
                        <table>
                            <tr>
                                <td>
                                    <asp:LinqDataSource ID="ldsFiscalYear" runat="server" ContextTypeName="FlyingFishClassesDataContext"
                                        EntityTypeName="" GroupBy="fiscalYear" OrderBy="fiscalYear desc" OrderGroupsBy="key desc"
                                        Select="new (key as fiscalYear, it as PersonLevels)" TableName="PersonLevels"
                                        EnableDelete="True" EnableInsert="True" EnableUpdate="True" />
                                    Fiscal Year:
                                    <asp:DropDownList ID="ddlFiscalYear" runat="server" DataSourceID="ldsFiscalYear"
                                        DataTextField="fiscalYear" DataValueField="fiscalYear" OnSelectedIndexChanged="ddlFiscalYear_SelectedIndexChanged"
                                        AutoPostBack="True" OnDataBound="ddlFiscalYear_DataBound" />
                                    <br />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:LinqDataSource ID="ldsPLevels" runat="server" ContextTypeName="FlyingFishClassesDataContext"
                                        EnableDelete="True" EnableInsert="True" EnableUpdate="True" EntityTypeName=""
                                        OrderBy="rate" TableName="PersonLevels" Where="fiscalYear == @fiscalYear">
                                        <WhereParameters>
                                            <asp:ControlParameter ControlID="ddlFiscalYear" Name="fiscalYear" PropertyName="SelectedValue"
                                                Type="Int32" />
                                        </WhereParameters>
                                    </asp:LinqDataSource>
                                    <asp:UpdatePanel ID="upPLevels" runat="server">
                                        <ContentTemplate>
                                            <asp:GridView ID="gvPLevels" runat="server" AutoGenerateColumns="False" DataSourceID="ldsPLevels">
                                                <Columns>
                                                    <asp:BoundField DataField="pLevel" HeaderText="P-Level" ReadOnly="True" SortExpression="pLevel" />
                                                    <asp:BoundField DataField="rate" HeaderText="Rate" ReadOnly="False" SortExpression="rate" />
                                                    <asp:CommandField HeaderText="Manage" ShowEditButton="True" ShowHeader="True" ShowDeleteButton="True" />
                                                </Columns>
                                            </asp:GridView>
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="ddlFiscalYear" EventName="SelectedIndexChanged" />
                                        </Triggers>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td align="right">
                        <table width="300">
                            <tr>
                                <td>
                                    <asp:UpdatePanel runat="server">
                                        <ContentTemplate>
                                            Add a new P-Level for Fiscal Year:
                                            <asp:Label ID="lblFiscalYear" runat="server" />
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="ddlFiscalYear" EventName="SelectedIndexChanged" />
                                        </Triggers>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table>
                                        <tr>
                                            <td>
                                                P-Level ID:
                                            </td>
                                            <td>
                                                <asp:TextBox ID="tbPLevelID" runat="server"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="PLevelRequired" runat="server" ErrorMessage="A P-Level is required." Display="Dynamic" ControlToValidate="tbPLevelID"></asp:RequiredFieldValidator>
                                                <asp:CompareValidator ID="PLevelFormatRequired" runat="server" ErrorMessage="CompareValidator"></asp:CompareValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                Rate:
                                            </td>
                                            <td>
                                                <asp:TextBox ID="tbRate" runat="server"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RateRequired" runat="server" ErrorMessage="A P-Level rate is required." Display="Dynamic" ControlToValidate="tbRate"></asp:RequiredFieldValidator>
                                                <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="CompareValidator"></asp:CompareValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" align="right">
                                                <asp:Button ID="buttonPlevel" Text="Create new P-Level" runat="server" 
                                                    onclick="buttonPlevel_Click" ValidationGroup="PLevelValid"/>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </center>
    </div>
</asp:Content>
