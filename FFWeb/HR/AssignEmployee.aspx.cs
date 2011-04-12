using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

public partial class HR_AssignEmployee : System.Web.UI.Page
{

    //DatabaseContext
    FlyingFishClassesDataContext ff = new FlyingFishClassesDataContext();

    protected void Page_Load(object sender, EventArgs e) { }

    //Fills the projects dropdown list; this is done where instead of pageload due to ajax
    protected void ddlAllProjects_Init(object sender, EventArgs e)
    {
        popluateProjectsDropdown();
    }

    //Populates DDL and LB with all unassigned emplpoyees and valid projects
    protected void popluateProjectsDropdown()
    {
        ddlAllProjects.DataSource = ff.Projects.Select(p => new
        {
            ProjID = p.projId,
            ProjectName = (p.projName + " (") + p.projId + ")"
        });
        ddlAllProjects.DataValueField = "ProjId";
        ddlAllProjects.DataTextField = "ProjectName";
        ddlAllProjects.DataBind();
    }

    //When a new project is selected populates unassigned and assigned users as well as sets the index of the PM ddl
    protected void buttonSelectProject_Click(object sender, EventArgs e)
        {
        AssignLabel.Text = "";
        populateListBoxes();
        //populateProjectManagerUsers();

        //ddlProjectManager.SelectedIndex = (int)ff.Projects
        //    .Where(p => p.projId == Convert.ToInt32(ddlAllProjects.SelectedValue))
        //    .Select(em => em.manager).First();
    }

    //Populates the PM DDL and
    //protected void populateProjectManagerUsers()
    //{
    //    DivAssignPM.Visible = true;
    //    ddlProjectManager.DataSource = ff.vw_AllValid_UserName_EmpIDs
    //        .Select(u => new
    //        {
    //            empID = u.empId,
    //            tsa = ((((u.firstName + " ") + u.lastName) + " (") + u.empId + ")")
    //        })
    //        .OrderBy(u => u.tsa);
    //    ddlProjectManager.DataTextField = "tsa";
    //    ddlProjectManager.DataValueField = "empID";
    //    ddlProjectManager.DataBind();
    //    labelProject.Text = ddlAllProjects.SelectedValue;
    //}

    //Fills the LBs with unassigned and assigned users as per the selected project
    protected void populateListBoxes()
    {
        //fills assigned users in a proj
        var assignedList = ff.EmployeeProjects
            .Join(ff.Employees, em => em.empId, c => c.empId, (em, c) => new { em = em, c = c })
            .Where(x => (x.em.projId == Convert.ToInt32(ddlAllProjects.SelectedValue)))
            .Select(y => new { EmpID = y.em.empId, EmployeeName = (((((y.c.firstName + " ") + y.c.lastName) + " (") + y.em.empId) + ")") })
            .ToList();
        lbAssignedEmployees.DataSource = assignedList;
        lbAssignedEmployees.DataTextField = "EmployeeName";
        lbAssignedEmployees.DataValueField = "EmpID";
        lbAssignedEmployees.DataBind();

        //fills unassigned users with (allusers minus assignedusers)
        lbUnassignedUsers.DataSource = ff.vw_AllValid_UserName_EmpIDs
            .Select(y => new { EmpID = y.empId, EmployeeName = (((((y.firstName + " ") + y.lastName) + " (") + y.empId) + ")") })
            .ToList()
            .Except(assignedList);
        lbUnassignedUsers.DataTextField = "EmployeeName";
        lbUnassignedUsers.DataValueField = "EmpID";
        lbUnassignedUsers.DataBind();
    }

    //Adds selected users to a project
    protected void buttonAssignUser_Click(object sender, EventArgs e)
    {
        AssignLabel.Text = "";
        foreach (ListItem l in lbUnassignedUsers.Items)
        {
            if (l.Selected)
            {
                EmployeeProject ep = new EmployeeProject()
                {
                    empId = Convert.ToInt32(l.Value),
                    projId = Convert.ToInt32(ddlAllProjects.SelectedValue)
                };
                try
                {
                    ff.EmployeeProjects.InsertOnSubmit(ep);
                    ff.SubmitChanges();
                }
                catch (Exception ex)
                {
                    AssignLabel.Text = "An error has occured: " + ex.Message;
                    AssignLabel.ForeColor = System.Drawing.Color.Red;
                }
            }
        }
        populateListBoxes();
    }

    //Removes selected users to a project
    protected void buttonUnassignUser_Click(object sender, EventArgs e)
    {
        AssignLabel.Text = "";
        foreach (ListItem l in lbAssignedEmployees.Items)
        {
            if (l.Selected)
            {
                EmployeeProject ep = new EmployeeProject()
                {
                    empId = Convert.ToInt32(l.Value),
                    projId = Convert.ToInt32(ddlAllProjects.SelectedValue)
                };
                try
                {
                    ff.EmployeeProjects.Attach(ep);
                    ff.EmployeeProjects.DeleteOnSubmit(ep);
                    ff.SubmitChanges();
                }
                catch (System.Data.SqlClient.SqlException sx)
                {
                    Trace.Write("An error has occured: " + sx.Message);
                    AssignLabel.Text = "An error has occured: Is a selected user a Responsible Engineer?";
                    AssignLabel.ForeColor = System.Drawing.Color.Red;
                }
                catch (Exception ex)
                {
                    Trace.Write("An error has occured: " + ex.Message);
                    AssignLabel.Text = "An error has occured; Please check server log";
                    AssignLabel.ForeColor = System.Drawing.Color.Red;
                }
            }
        }
        populateListBoxes();
    }

    //Updates the PM for the selected project when the button is clicked
    //Also adds selected PM to project if current not in it as well as to PM Role
    //protected void buttonChangePM_Click(object sender, EventArgs e)
    //{
    //    int oldManager = (int)ff.Projects
    //        .Where(p => p.projId == Convert.ToInt32(ddlAllProjects.SelectedValue))
    //        .Select(em => em.manager).First();
    //    int newManager = Convert.ToInt32(ddlProjectManager.SelectedValue);

    //    #region Add New Manager
    //    if ((ff.EmployeeProjects
    //        .Where(p => (p.projId == Convert.ToInt32(ddlAllProjects.SelectedValue) && (p.empId == newManager)))
    //        .Select(q => q).Count()) == 0)
    //    {
    //        //Create new EmployeeProject table entry
    //        EmployeeProject ep = new EmployeeProject()
    //        {
    //            projId = Convert.ToInt32(ddlAllProjects.SelectedValue),
    //            empId = newManager
    //        };

    //        ff.EmployeeProjects.InsertOnSubmit(ep);

    //        //Update Project table Manager
    //        Project proj = ff.Projects.Where(p => p.projId == Convert.ToInt32(ddlAllProjects.SelectedValue)).First();
    //        proj.manager = newManager;

    //        //try
    //        //{
    //            ff.SubmitChanges();
    //            Roles.AddUserToRole(ff.aspnet_Users.Where(u => u.UserId == ff.EmployeeMemberships.Where(em => em.empId == newManager).Select(q => q.userId).First()).Select(u => u.UserName).First()
    //                , "ProjectManager");
    //        //}
    //        //catch (Exception ex)
    //        //{
    //        //    AssignPMLabel.Text = ex.Message;
    //        //    AssignPMLabel.ForeColor = System.Drawing.Color.Red;
    //        //}
    //    }
    //    #endregion

    //    #region Remove Old Manager
    //    //try
    //    //{
    //        Roles.RemoveUserFromRole(ff.aspnet_Users.Where(u => u.UserId == ff.EmployeeMemberships.Where(em => em.empId == oldManager).Select(q => q.userId).First()).Select(u => u.UserName).First()
    //            , "ProjectManager");
    //    //}
    //    //catch (Exception ex)
    //    //{
    //    //    AssignPMLabel.Text = ex.Message;
    //    //    AssignPMLabel.ForeColor = System.Drawing.Color.Red;
    //    //}
        
    //    EmployeeProject oep = ff.EmployeeProjects
    //        .Where(p => (p.projId == Convert.ToInt32(ddlAllProjects.SelectedValue) && (p.empId == oldManager)))
    //        .First();
    //    ff.EmployeeProjects.DeleteOnSubmit(oep);

    //    #endregion
    //}
}