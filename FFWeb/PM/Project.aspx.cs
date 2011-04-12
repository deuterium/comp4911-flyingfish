using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Web.Security;

public partial class PM_Project : System.Web.UI.Page
{
    string connectionString = ConfigurationManager.ConnectionStrings["ffconn"].ToString();
    FlyingFishClassesDataContext ff = new FlyingFishClassesDataContext();
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!User.IsInRole("HRStaff"))
            Response.Redirect("~/Default.aspx");

        if (!IsPostBack)
            populateProjectManagerUsers();
    }

    protected void populateProjectManagerUsers()
    {
        ddlProjectManager.DataSource = ff.vw_AllValid_UserName_EmpIDs
            .Select(u => new
            {
                empID = u.empId,
                tsa = ((((u.firstName + " ") + u.lastName) + " (") + u.empId + ")")
            })
            .OrderBy(u => u.tsa);
        ddlProjectManager.DataTextField = "tsa";
        ddlProjectManager.DataValueField = "empID";
        ddlProjectManager.DataBind();
    }

    protected void btnCreateProject_Click(object sender, EventArgs e)
    {
        try
        {
            Project proj = new Project();

            if (ff.Projects.Where(te => te.projId == Convert.ToInt32(tbProjectID.Text)).ToArray().Length > 0)
            {
                lblError.Text = "Project ID already exists.";
            }
            else
            {
                proj.projId = Convert.ToInt32(tbProjectID.Text);
                proj.projName = tbProjectName.Text;
                proj.manager = Convert.ToInt32(ddlProjectManager.SelectedValue);
                proj.allocated_dollars = 0;
                proj.unallocated_dollars = Convert.ToDecimal(tbUnalloc.Text);
                proj.isActive = 1;
                ff.Projects.InsertOnSubmit(proj);
                ff.SubmitChanges();

                Session["projID"] = proj.projId;

                divCreateSuccess.Visible = true;
                divCreateProject.Visible = false;

                try
                {
                    Roles.AddUserToRole(
                        ff.Employees.Where(a => a.empId == Convert.ToInt32(ddlProjectManager.SelectedValue))
                        .Select(a => a.firstName).Single().ToString() + "_" + 
                        ff.Employees.Where(a => a.empId == Convert.ToInt32(ddlProjectManager.SelectedValue))
                        .Select(a => a.lastName).Single().ToString(), "ProjectManager");
                }
                catch (Exception alreadyPM)
                {
                }
            }
        }
        catch (Exception exception)
        {
            //lblException.Text = exception.StackTrace;
        }
            
    }

    protected void btnCreate_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/PM/ManageProject.aspx");
    }

    protected void btnViewProjects_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/PM/ProjectList.aspx");
    }
}