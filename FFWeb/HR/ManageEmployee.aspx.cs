using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using FFLib;
using System.Web.Security;

public partial class HR_ManageEmployee : System.Web.UI.Page
{
    //DatabaseContext
    FlyingFishClassesDataContext ff = new FlyingFishClassesDataContext();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            getAllUsers();
        }
    }

    //Binds all employees to the gridview
    protected void getAllUsers()
    {
        gvManageUsers.DataSource = ff.Employees
            .Select(emp => new { emp.empId, emp.firstName, emp.lastName, emp.vacationLeave, emp.sickDays, emp.flexHours, emp.isActive })
            .OrderBy(emp => emp.empId);
        gvManageUsers.DataBind();
    }

    //Used to page navigation on the manage users gridview
    protected void gvManageUsers_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        getAllUsers();
        gvManageUsers.PageIndex = e.NewPageIndex;
        gvManageUsers.DataBind();
    }

    #region Button_Click Methods
    //Searches for employees containing the provided last name when button clicked
    protected void buttonSearch_Click(object sender, EventArgs e)
    {
        DivUserGridView.Visible = true;
        DivUserDetails.Visible = false;
        lblUserEditError.Text = "";
        var searchQry = ff.Employees
                .Where(emp => emp.lastName.Contains(tbSearch.Text))
                .Select(emp => new { emp.empId, emp.firstName, emp.lastName, emp.vacationLeave, emp.sickDays, emp.flexHours, emp.isActive });
        if (tbSearch.Text == "" || searchQry.Count() == 0)
        {
            lblSearchError.Enabled = true;
            lblSearchError.Text = "No Employee results";
            lblSearchError.ForeColor = System.Drawing.Color.Red;
            gvManageUsers.DataSource = null;
            gvManageUsers.DataBind();
        }
        else
        {
            lblSearchError.Enabled = false;
            lblSearchError.Text = "";
            gvManageUsers.DataSource = searchQry;
            gvManageUsers.DataBind();
        }
    }

    //Displays all employees when button clicked
    protected void buttonAllUsers_Click(object sender, EventArgs e)
    {
        DivUserDetails.Visible = false;
        lblSearchError.Enabled = false;
        DivUserGridView.Visible = true;
        lblUserEditError.Text = "";
        lblSearchError.Text = "";
        getAllUsers();
    }
    //Cancels Editing of an Employee and hides the editing div
    protected void buttonDetailsCancel_Click(object sender, EventArgs e)
    {
        lblUserEditError.Text = "";
        DivUserDetails.Visible = false;
        DivUserGridView.Visible = true;
    }

    //Fills changed information into object and submits changes to DB
    protected void buttonDetailsSubmit_Click(object sender, EventArgs e)
    {
        Employee ManagedEmployee = ff.Employees.Where(em => em.empId == Convert.ToInt32(lblEmpId.Text)).First();
        ManagedEmployee.firstName = tbFirstName.Text;
        ManagedEmployee.lastName = tbLastName.Text;
        ManagedEmployee.supervisor = Convert.ToInt32(lbSupervisors.SelectedValue);
        ManagedEmployee.approver = Convert.ToInt32(lbApprovers.SelectedValue);
        ManagedEmployee.minHoursPerWeek = Convert.ToDecimal(tbMinHours.Text);
        ManagedEmployee.vacationLeave = Convert.ToInt32(tbVacation.Text);
        ManagedEmployee.sickDays = Convert.ToInt32(tbSickDays.Text);
        ManagedEmployee.flexHours = Convert.ToDecimal(tbFlexHours.Text);
        if (cbActiveUser.Checked)
        {
            ManagedEmployee.isActive = 1;
        }
        else
        {
            ManagedEmployee.isActive = 0;
        }
        #region Add/Remove Roles
        List<string> rolesToAdd = new List<string>();
        List<string> rolesToRemove = new List<string>();
        foreach (ListItem r in cblUserRoles.Items)
        {
            if (r.Selected)
            {
                rolesToAdd.Add(r.Text);
            }
            else
            {
                rolesToRemove.Add(r.Text);
            }
        }
        foreach (string r in rolesToAdd)
        {
            try
            {
                Roles.AddUserToRole(lblUsername.Text, r);
            }
            catch (Exception ex) { Trace.Write(ex.Message); }
        }
        foreach (string r in rolesToRemove)
        {
            try
            {
                Roles.RemoveUserFromRole(lblUsername.Text, r);
            }
            catch (Exception ex) { Trace.Write(ex.Message); }
        }
        #endregion
        try
        {
            ff.SubmitChanges();
        }
        catch (Exception ex)
        {
            lblUserEditError.Text = ex.Message;
            lblUserEditError.ForeColor = System.Drawing.Color.Red;
        }
        string approverUsername = ff.vw_EmployeeInRolewFirstLastNameEmpIDUserIDs
            .Where(em => em.empId == Convert.ToInt32(lbApprovers.SelectedValue))
            .Select(u => u.UserName).First();
        if (!Roles.IsUserInRole(approverUsername, "TimesheetApprover"))
        {
            Roles.AddUserToRole(approverUsername, "TimesheetApprover");
        }
        lblUserEditError.Text = "User Has been updated. Show all users to see changes.";
        lblUserEditError.ForeColor = System.Drawing.Color.ForestGreen;
    }
    #endregion

    //Brings up the editing area for when a user is selected from the gridview
    protected void gvManageUsers_SelectedIndexChanged(Object sender, EventArgs e)
    {
        lblUserEditError.Text = "";
        DivUserDetails.Visible = true;
        DivUserGridView.Visible = false;
        fillSupervisorApproverListBoxes();
        #region User Information minus Roles
        int empID = Convert.ToInt32(gvManageUsers.SelectedRow.Cells[1].Text);
        Employee ManagedEmployee = ff.Employees.Where(em => em.empId == empID).First();
        System.Guid userID = ff.EmployeeMemberships.Where(emp => emp.empId == empID).Select(emp => emp.userId).First();
        tbFirstName.Text = ManagedEmployee.firstName;
        tbLastName.Text = ManagedEmployee.lastName;
        lblEmpId.Text = ManagedEmployee.empId.ToString();
        lblUsername.Text = ff.aspnet_Users.Where(use => use.UserId == userID).Select(use => use.UserName).First();
        lblEmail.Text = ff.aspnet_Memberships.Where(use => use.UserId == userID).Select(use => use.Email).First();
        lbSupervisors.SelectedValue = ManagedEmployee.supervisor.ToString();
        lbApprovers.SelectedValue = ManagedEmployee.approver.ToString();
        tbMinHours.Text = ManagedEmployee.minHoursPerWeek.ToString();
        tbVacation.Text = ManagedEmployee.vacationLeave.ToString();
        tbSickDays.Text = ManagedEmployee.sickDays.ToString();
        tbFlexHours.Text = ManagedEmployee.flexHours.ToString();
        if (ManagedEmployee.isActive == 1) cbActiveUser.Checked = true;
        #endregion

        #region Individual User Roles
        cblUserRoles.DataSource = ff.aspnet_Roles.Select(r => new { RoleId = r.RoleId, RoleName = r.RoleName });
        cblUserRoles.DataTextField = "RoleName";
        cblUserRoles.DataValueField = "RoleId";
        cblUserRoles.DataBind();
        string[] userRoleNames = ff.vw_EmployeeInRolewFirstLastNameEmpIDUserIDs.Where(emp => emp.empId == empID).Select(r => r.RoleName).ToArray();
        for (int i = 0; i < userRoleNames.Length; i++)
        {
            for (int j = 0; j < cblUserRoles.Items.Count; j++)
            {
                if (userRoleNames[i] == cblUserRoles.Items[j].Text)
                {
                    cblUserRoles.Items[j].Selected = true;
                }
            }
        }
        #endregion
    }

    //Returns a list of all Supervisors ..... List<String> is placeholder for correct type
    protected void fillSupervisorApproverListBoxes()
    {
        var list = ff.vw_AllValid_UserName_EmpIDs
            .Select(u => new
            {
                empID = u.empId,
                tsa = ((((u.firstName + " ") + u.lastName) + " (") + u.empId + ")")
            })
            .OrderBy(u => u.tsa);

        lbApprovers.DataSource = list;
        lbApprovers.DataTextField = "tsa";
        lbApprovers.DataValueField = "empId";
        lbApprovers.DataBind();

        lbSupervisors.DataSource = list;
        lbSupervisors.DataTextField = "tsa";
        lbSupervisors.DataValueField = "empId";
        lbSupervisors.DataBind();
    }
}