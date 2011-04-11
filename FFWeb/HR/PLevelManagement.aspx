<%@ Page Title="" Language="C#" MasterPageFile="~/HR/HRMaster.master" AutoEventWireup="true"
    CodeFile="PLevelManagement.aspx.cs" Inherits="HR_PLevelManagement" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HRContent" runat="Server">
    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </asp:ToolkitScriptManager>
    <div>
        <asp:LinqDataSource ID="ldsFiscalYear" runat="server" 
            ContextTypeName="FlyingFishClassesDataContext" EntityTypeName="" 
            GroupBy="fiscalYear" OrderGroupsBy="key desc" 
            Select="new (key as fiscalYear, it as PersonLevels)" TableName="PersonLevels">
        </asp:LinqDataSource>
        <asp:LinqDataSource ID="ldsPLevels" runat="server" 
            ContextTypeName="FlyingFishClassesDataContext" EnableDelete="True" 
            EnableInsert="True" EnableUpdate="True" EntityTypeName="" OrderBy="pLevel" 
            TableName="PersonLevels" Where="fiscalYear == @fiscalYear">
            <%--OnUpdating="ldsPLevels_Updating"--%>
            <WhereParameters>
                <asp:ControlParameter ControlID="ddlFiscalYear" Name="fiscalYear" 
                    PropertyName="SelectedValue" Type="Int32" />
            </WhereParameters>
        </asp:LinqDataSource>
        <br />
        <center>
            <table width="700">
                <tr>
                    <td>
                        <table>
                            <tr>
                                <td align="left">
                                    Fiscal Year:
                                    <asp:DropDownList ID="ddlFiscalYear" runat="server" OnSelectedIndexChanged="ddlFiscalYear_SelectedIndexChanged"
                                        AutoPostBack="True" OnDataBound="ddlFiscalYear_DataBound" 
                                        DataSourceID="ldsFiscalYear" DataTextField="fiscalYear" 
                                        DataValueField="fiscalYear" />
                                    <br />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:UpdatePanel ID="upPLevels" runat="server">
                                        <ContentTemplate>
                                            <asp:GridView ID="gvPLevels" runat="server" AutoGenerateColumns="False" 
                                                DataKeyNames="pLevel,fiscalYear" DataSourceID="ldsPLevels">
                                                <Columns>
                                                    <asp:BoundField DataField="pLevel" HeaderText="P-Level" ReadOnly="True" 
                                                        SortExpression="pLevel" />
                                                    <asp:BoundField DataField="rate" HeaderText="Rate" SortExpression="rate" />
                                                    <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                                                </Columns>
                                            </asp:GridView>
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="ddlFiscalYear" EventName="SelectedIndexChanged" />
                                            <asp:AsyncPostBackTrigger ControlID="buttonPlevel" EventName="Click" />
                                        </Triggers>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:UpdatePanel runat="server">
                                        <ContentTemplate>
                                            <asp:Label ID="lblPLevelError" runat="server" />
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="ldsPLevels" EventName="Updating" />
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
                                                <asp:RequiredFieldValidator ID="PLevelRequired" runat="server" ErrorMessage="A P-Level is required."
                                                    Display="Dynamic" Text="*" ControlToValidate="tbPLevelID" ValidationGroup="PLevelValid"
                                                    ForeColor="Red"></asp:RequiredFieldValidator>
                                                <asp:CompareValidator ID="PLevelFormatRequired" runat="server" ErrorMessage="PLevel must be letters and numbers."
                                                    Display="Dynamic" Text="*" Font-Strikeout="False" ControlToValidate="tbPLevelID"
                                                    ForeColor="Red" Operator="DataTypeCheck" ValidationGroup="PLevelValid"></asp:CompareValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                Rate:
                                            </td>
                                            <td>
                                                <asp:TextBox ID="tbRate" runat="server"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RateRequired" runat="server" ErrorMessage="A P-Level rate is required."
                                                    Display="Dynamic" Text="*" ControlToValidate="tbRate" ValidationGroup="PLevelValid"
                                                    ForeColor="Red"></asp:RequiredFieldValidator>
                                                <asp:CompareValidator ID="RateFormatRequired" runat="server" ValidationGroup="PLevelValid"
                                                    Operator="DataTypeCheck" Type="Currency" Text="*" Display="Dynamic" ErrorMessage="Rate must be a currency value."
                                                    ForeColor="Red" ControlToValidate="tbRate"></asp:CompareValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" align="right">
                                                <asp:Button ID="buttonPlevel" Text="Create new P-Level" runat="server" OnClick="buttonPlevel_Click"
                                                    ValidationGroup="PLevelValid" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <%--<asp:UpdatePanel runat="server">
                                                    <ContentTemplate>--%>
                                                        <asp:Label ID="lblError" runat="server" />
                                                    <%--</ContentTemplate>
                                                    <Triggers>
                                                        <asp:AsyncPostBackTrigger ControlID="buttonPlevel" EventName="Click" />
                                                    </Triggers>
                                                </asp:UpdatePanel>--%>
                                                <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="Red" DisplayMode="List"
                                                    ValidationGroup="PLevelValid" />
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
