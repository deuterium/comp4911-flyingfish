<%@ Page Title="" Language="C#" MasterPageFile="~/FlyingFishMasterPage.master" AutoEventWireup="true" CodeFile="ManageSubWorkPackage.aspx.cs" Inherits="RE_ManageSubWorkPackage" %>


<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content2" ContentPlaceHolderID="content" Runat="Server">
    <asp:ScriptManager ID="sm" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>

    <div id="divCreateWorkPackage" runat="server">
        <table>
            <tr>
                <td align="right">
                    <asp:Label ID="lblWPName" runat="server" Text="Work Package: "></asp:Label>
                </td>
                <td>
                    <asp:Label ID="lblWPName2" runat="server" Text=""></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="right">
                    <asp:Label ID="lblWPID" runat="server" Text="Work Package ID: "></asp:Label>
                </td>
                <td>
                    <asp:Label ID="lblWPID2" runat="server" Text=""></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="right">
                    <asp:Label ID="lblAlloc" runat="server" Text="Allocated Budget: "></asp:Label>
                </td>
                <td>
                    <div id="divtbAlloc1" runat="server">
                        <asp:TextBox ID="tbAlloc" runat="server" ReadOnly="True"></asp:TextBox>
                        <asp:SliderExtender ID="seAlloc" runat="server" TargetControlID="tbAlloc" 
                            BoundControlID="tbAlloc2" Decimals="2" BehaviorID="tbAlloc2" />
                        <asp:TextBox ID="tbAlloc2" runat="server" style="margin-bottom: 0px"></asp:TextBox>
                    </div>
                </td>
            </tr>
            <tr>
                <td align="right">
                    <asp:Label ID="lblUnalloc" runat="server" Text="Unallocated Budget: "></asp:Label>
                </td>
                <td>
                    <div id="divtbUnalloc1" runat="server"><asp:TextBox ID="tbUnalloc" runat="server" ReadOnly="True"></asp:TextBox>
                    </div>
                    <asp:SliderExtender ID="seUnalloc" runat="server" TargetControlID="tbUnalloc" 
                        BoundControlID="tbUnalloc2" Decimals="2">
                    </asp:SliderExtender>
                    <asp:TextBox ID="tbUnalloc2" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="right">
                    <asp:Label ID="lblDescription" runat="server" Text="Description: "></asp:Label>
                </td>
                <td>
                    <div id="divDesc1" runat="server">
                            <asp:TextBox ID="tbDescription" Width="125" runat="server" 
                        TextMode="MultiLine" />
                    </div>
                        
                </td>
            </tr>
            <tr>
                <td align="right">
                    <asp:Label ID="lblEmployeeList" runat="server" Text="Assigned Employees: "></asp:Label>
                </td>
                <td>
                    <asp:GridView ID="gvEmployees" runat="server">
                    </asp:GridView>
                    <asp:Button ID="btnSave" runat="server" Text="Save Changes" 
                            onclick="btnSave_Click" PostBackUrl="~/RE/ManageWorkPackage.aspx" />
                            <br />


                </td>
            <tr>
                <td>
                    <asp:Label ID="lblError" runat="server" Text=""></asp:Label>
                </td>
                <td>
                    <asp:Label ID="lblBudgetError" runat="server" Text=""></asp:Label>
                </td>
            </tr>
            </tr>
            </table>
            <asp:LinkButton ID="lbAssignEmp" runat="server" onclick="lbAssignEmp_Click">Assign a Employee</asp:LinkButton>
            <asp:LinkButton ID="lbAssignRE" runat="server">Assign a Responsible Engineer</asp:LinkButton>

        <asp:LinkButton ID="lbBacktoProject" runat="server" 
            onclick="lbBacktoProject_Click">Go to Project</asp:LinkButton>

        <asp:LinkButton ID="lbCreateSubWorkPackage" runat="server" 
            onclick="lbCreateSubWorkPackage_Click">Create a Sub-WorkPackage</asp:LinkButton>

    </div>
    <div id="divAssignEmp" runat="server" visible="false">
        <asp:Label ID="lblAEmp" runat="server" Text="Choose an employee to add to work package:"></asp:Label>
        <asp:GridView ID="gvUnassignedEmployees" runat="server" 
            onselectedindexchanged="gvUnassignedEmployees_SelectedIndexChanged" 
            OnRowCommand="gvUnassignedEmployees_RowCommand" style="margin-left: 0px">
            <Columns>
                <asp:ButtonField ButtonType="Button" Text="Add" CommandName="btnAdd" />
            </Columns>
        </asp:GridView>
    </div>
    </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>