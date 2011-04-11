<%@ Page Language="C#" Title="" MasterPageFile="~/FlyingFishMasterPage.master" AutoEventWireup="true" CodeFile="ManageWorkPackage.aspx.cs" Inherits="RE_ManageWorkPackage" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content2" ContentPlaceHolderID="content" Runat="Server">
    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </asp:ToolkitScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>

        <div id="divCreateWorkPackage" runat="server">
            <table>
                <tr>
                    <td align="right">
                        <asp:Label ID="lblWPName" runat="server" Text="Work Package: " Font-Bold="True"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblWPName2" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <asp:Label ID="lblWPID" runat="server" Text="Work Package ID: " 
                            Font-Bold="True"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblWPID2" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <asp:Label ID="lblMaxBudget" runat="server" Font-Bold="True" Text="Maximum Budget: "></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblMaxBudget2" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <asp:Label ID="lblAlloc" runat="server" Text="Allocated Budget: " 
                            Font-Bold="True"></asp:Label>
                    </td>
                    <td>
                        <div id="divtbAlloc1" runat="server">
                            <asp:TextBox ID="tbAlloc" runat="server" ReadOnly="True"></asp:TextBox>
                        </div>
                        <asp:TextBox ID="tbAlloc2" runat="server" style="margin-bottom: 0px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <asp:Label ID="lblUnalloc" runat="server" Text="Unallocated Budget: " 
                            Font-Bold="True"></asp:Label>
                    </td>
                    <td>
                        <div id="divtbUnalloc1" runat="server"><asp:TextBox ID="tbUnalloc" runat="server" ReadOnly="True"></asp:TextBox>
                            <asp:SliderExtender ID="seUnalloc" runat="server" TargetControlID="tbUnalloc" 
                            BoundControlID="tbUnalloc2" Decimals="2">
                            </asp:SliderExtender>
                        </div>
                        <asp:TextBox ID="tbUnalloc2" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <asp:Label ID="lblDescription" runat="server" Text="Description: " 
                            Font-Bold="True"></asp:Label>
                    </td>
                    <td>
                        <div id="divDesc1" runat="server">
                                <asp:TextBox ID="tbDesc" runat="server" TextMode="MultiLine" />
                        </div>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <asp:Label ID="lblRE" runat="server" Text="Responsible Engineer: " 
                            Font-Bold="True"></asp:Label>
                    </td>
                    <td>
                        <div id="divREisAssigned" runat="server" visible="false">
                            <asp:Label ID="lblRE2" runat="server" Text=""></asp:Label>
                        </div>
                        <div id="divREnotAssigned" runat="server" visible="false">
                            <asp:Label ID="lblREnotAssigned" runat="server" Visible="false" Text="No Responsible Engineer assigned."></asp:Label>
                            <div id="divREnotAssigned2" runat="server">
                            <font color="#000066"  >There is no Responsible Engineer assigned to this work package.
                            <br />
                            If you want to assign a responsible engineer click
                            <asp:LinkButton ID="lbAssignRE" runat="server" onclick="lbAssignRE_Click">here.</asp:LinkButton></font>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <asp:Label ID="lblEmployeeList" runat="server" Text="Assigned Employees: " 
                            Font-Bold="True"></asp:Label>
                    </td>
                    <td>
                        <div id="divAssignEmpLink" runat="server">
                            <br />
                            <font color="#000066">Click <asp:LinkButton ID="lbAssignEmp" runat="server" onclick="lbAssignEmp_Click">here</asp:LinkButton> to assign employees to this work package.</font>
                            <br />
                        </div>
                        <asp:GridView ID="gvEmployees" runat="server" AutoGenerateColumns="False" 
                            OnRowCommand="gvEmployees_RowCommand" CellPadding="4" ForeColor="#333333" 
                            GridLines="None">
                            <AlternatingRowStyle BackColor="White" />
                            <Columns>
                                <asp:BoundField DataField="empId" HeaderText="ID" SortExpression="empId" />
                                <asp:BoundField DataField="firstName" HeaderText="First Name" 
                                    SortExpression="firstName" />
                                <asp:BoundField DataField="lastName" HeaderText="Last Name" 
                                    SortExpression="lastName" />
                                <asp:ButtonField ButtonType="Button" CommandName="btnDelete" Text="Delete" />
                            </Columns>
                            <EditRowStyle BackColor="#2461BF" />
                            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                            <RowStyle BackColor="#EFF3FB" />
                            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                            <SortedAscendingCellStyle BackColor="#F5F7FB" />
                            <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                            <SortedDescendingCellStyle BackColor="#E9EBEF" />
                            <SortedDescendingHeaderStyle BackColor="#4870BE" />
                        </asp:GridView>
                        <br />
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <asp:Label ID="lblParentsWP" runat="server" Text="Preceding Workpackages: " Font-Bold="true" ></asp:Label>
                    </td>
                    <td>
                        <asp:GridView ID="gvParentsWP" runat="server" AutoGenerateColumns="False" OnRowCommand="gvParentsWP_RowCommand"
                            CellPadding="4" ForeColor="#333333" GridLines="None">
                            <AlternatingRowStyle BackColor="White" />
                            <Columns>
                                <asp:BoundField DataField="wpId" HeaderText="Work Package ID" 
                                    SortExpression="wpId" />
                                <asp:BoundField DataField="name" HeaderText="Name" SortExpression="name" />
                                <asp:BoundField DataField="unallocated_dollars" HeaderText="Unallocated Budget" 
                                    SortExpression="unallocated_dollars" />
                                <asp:BoundField DataField="allocated_dollars" HeaderText="Allocated Budget" 
                                    SortExpression="allocated_dollars" />
                                <asp:BoundField DataField="description" HeaderText="Description" 
                                    SortExpression="description" />
                                <asp:ButtonField ButtonType="Button" CommandName="btnView" Text="View" />
                            </Columns>
                            <EditRowStyle BackColor="#2461BF" />
                            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                            <RowStyle BackColor="#EFF3FB" />
                            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                            <SortedAscendingCellStyle BackColor="#F5F7FB" />
                            <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                            <SortedDescendingCellStyle BackColor="#E9EBEF" />
                            <SortedDescendingHeaderStyle BackColor="#4870BE" />
                        </asp:GridView>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <asp:Label ID="lblSubWP" runat="server" Text="Sub-Workpackages: " 
                            Font-Bold="True"></asp:Label>
                    </td>
                    <td>
                        <asp:GridView ID="gvSubWP" runat="server" AutoGenerateColumns="False" OnRowCommand="gvSubWP_RowCommand"
                            CellPadding="4" ForeColor="#333333" GridLines="None">
                            <AlternatingRowStyle BackColor="White" />
                            <Columns>
                                <asp:BoundField DataField="wpId" HeaderText="Work Package ID" 
                                    SortExpression="wpId" />
                                <asp:BoundField DataField="name" HeaderText="Name" SortExpression="name" />
                                <asp:BoundField DataField="unallocated_dollars" HeaderText="Unallocated Budget" 
                                    SortExpression="unallocated_dollars" />
                                <asp:BoundField DataField="allocated_dollars" HeaderText="Allocated Budget" 
                                    SortExpression="allocated_dollars" />
                                <asp:BoundField DataField="description" HeaderText="Description" 
                                    SortExpression="description" />
                                <asp:ButtonField ButtonType="Button" CommandName="btnView" Text="View" />
                                <asp:ButtonField ButtonType="Button" CommandName="btnDelete" Text="Delete" />
                            </Columns>
                            <EditRowStyle BackColor="#2461BF" />
                            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                            <RowStyle BackColor="#EFF3FB" />
                            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                            <SortedAscendingCellStyle BackColor="#F5F7FB" />
                            <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                            <SortedDescendingCellStyle BackColor="#E9EBEF" />
                            <SortedDescendingHeaderStyle BackColor="#4870BE" />
                        </asp:GridView>

                    </td>
                </tr>
                <tr>

                    <td>
                        &nbsp;</td>
                    <td>
                        <asp:Label ID="lblBudgetError" runat="server" ForeColor="Red"></asp:Label>
                    </td>
                </tr>
                </tr>
                </table>
                
                

            <asp:LinkButton ID="lbParentwp" runat="server" onclick="lbParentwp_Click">Go to parent Work Package</asp:LinkButton>
            <br />
            <asp:LinkButton ID="lbBacktoProject" runat="server" 
                onclick="lbBacktoProject_Click">Go to Project</asp:LinkButton>
            <br />
            <asp:LinkButton ID="lbCreateSubWorkPackage" runat="server" 
                onclick="lbCreateSubWorkPackage_Click">Create a sub-Work Package</asp:LinkButton>
            <br />
        </div>
        <div id="divAssignEmp" runat="server" visible="false">
            <asp:Label ID="lblAEmp" runat="server" Text="Choose an employee to add to work package:"></asp:Label>
            <br />
            <font color="#000066"  >***If no employees appear, there is no employees assigned to project. Go to 
            <asp:LinkButton ID="lbUM1" runat="server" PostBackUrl="~/HR/AssignEmployee.aspx">User Management</asp:LinkButton> to assign employees to the project.</font>
            
            <asp:GridView ID="gvUnassignedEmployees" runat="server" 
                onselectedindexchanged="gvUnassignedEmployees_SelectedIndexChanged" 
                OnRowCommand="gvUnassignedEmployees_RowCommand" style="margin-left: 0px" 
                CellPadding="4" ForeColor="#333333" GridLines="None">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:ButtonField ButtonType="Button" Text="Add" CommandName="btnAdd" />
                </Columns>
                <EditRowStyle BackColor="#2461BF" />
                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#EFF3FB" />
                <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#F5F7FB" />
                <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                <SortedDescendingCellStyle BackColor="#E9EBEF" />
                <SortedDescendingHeaderStyle BackColor="#4870BE" />
            </asp:GridView>
            <br />
        </div>
        <div id="divAssignRE" visible="false" runat="server" >
            <asp:Label ID="lblAssignRE" runat="server" Text="Assign any of the employees listed below to be a Responsible Engineer:"></asp:Label>
            <br />
            <font color="#000066"  >***If no employees appear, there is no employees assigned to project. Go to 
            <asp:LinkButton ID="lbUM2" runat="server" PostBackUrl="~/HR/AssignEmployee.aspx">User Management</asp:LinkButton> to assign employees to the project.</font>
            <br />
            <asp:GridView ID="gvAssignRE" runat="server" 
                OnRowCommand="gvAssignRE_RowCommand" AutoGenerateColumns="False" 
                CellPadding="4" ForeColor="#333333" GridLines="None">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:BoundField DataField="empId" HeaderText="ID" SortExpression="empId" />
                    <asp:BoundField DataField="firstName" HeaderText="First Name" 
                        SortExpression="firstName" />
                    <asp:BoundField DataField="lastName" HeaderText="Last Name" 
                        SortExpression="lastName" />
                    <asp:ButtonField ButtonType="Button" CommandName="btnAssign" Text="Assign" />
                </Columns>
                <EditRowStyle BackColor="#2461BF" />
                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#EFF3FB" />
                <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#F5F7FB" />
                <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                <SortedDescendingCellStyle BackColor="#E9EBEF" />
                <SortedDescendingHeaderStyle BackColor="#4870BE" />
            </asp:GridView>
            <br />
        </div>
        <div align="center">
            <asp:Button ID="btnSave" runat="server" Text="Save Changes" onclick="btnSave_Click" PostBackUrl="~/RE/ManageWorkPackage.aspx" />
        </div>
        <br />                        
        <asp:Label ID="lblException" runat="server" ForeColor="Red"></asp:Label>
        <br />
        <asp:Label ID="lblError" runat="server" ForeColor="Red"></asp:Label>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
