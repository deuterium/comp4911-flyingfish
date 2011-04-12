using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class PM_ProjectList : System.Web.UI.Page
{
    FlyingFishClassesDataContext ff = new FlyingFishClassesDataContext();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (User.Identity.IsAuthenticated == false)
            Response.Redirect("~/Default.aspx");
        populateProjectList();
    }

    protected void populateProjectList()
    {
        if (Session["wpID"] != null)
            Session["wpID"] = null;
        identifyRole();
    }

    protected void populateActiveProj()
    {
        try
        {
            var qry =
                from projs in ff.Projects
                where projs.isActive == 1
                select projs;
            gvProjects.DataSource = qry;
            gvProjects.DataBind();
        }
        catch (Exception exception)
        {
            //lblException.Text = exception.StackTrace;
        }
    }

    protected void populateInactiveProj()
    {
        try
        {
            var qry =
                from projs in ff.Projects
                where projs.isActive == 0
                select projs;
            gvUnassignedProj.DataSource = qry;
            gvUnassignedProj.DataBind();
        }
        catch (Exception exception)
        {
            //lblException.Text = exception.StackTrace;
        }
    }

    protected void gvProjects_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "btnView")
            {
                int row = Convert.ToInt32(e.CommandArgument);
                GridViewRow selectedRow = gvProjects.Rows[row];
                Session["projID"] = Convert.ToInt32(selectedRow.Cells[0].Text);
                Response.Redirect("~/PM/ManageProject.aspx");
            }
            if (e.CommandName == "btnDeactivate")
            {
                int row = Convert.ToInt32(e.CommandArgument);
                GridViewRow selectedRow = gvProjects.Rows[row];
                Project proj = ff.Projects.Where(p => p.projId ==  Convert.ToInt32(selectedRow.Cells[0].Text)).First();
                proj.isActive = 0;
                ff.SubmitChanges();
                //Response.Redirect("~/PM/ProjectList.aspx");
                populateProjectList();
            }
        }
        catch (Exception exception)
        {
            //lblException.Text = exception.StackTrace;
        }
    }

    protected void gvUnassignedProj_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "btnView")
            {
                int row = Convert.ToInt32(e.CommandArgument);
                GridViewRow selectedRow = gvUnassignedProj.Rows[row];
                Session["projID"] = Convert.ToInt32(selectedRow.Cells[0].Text);
                Response.Redirect("~/PM/ManageProject.aspx");
            }
            if (e.CommandName == "btnActivate")
            {
                int row = Convert.ToInt32(e.CommandArgument);
                GridViewRow selectedRow = gvUnassignedProj.Rows[row];
                Project proj = ff.Projects.Where(p => p.projId == Convert.ToInt32(selectedRow.Cells[0].Text)).First();
                proj.isActive = 1;
                ff.SubmitChanges();
                //Response.Redirect("~/PM/ProjectList.aspx");
                populateProjectList();
            }
        }
        catch (Exception exception)
        {
            //lblException.Text = exception.StackTrace;
        }
    }

    protected void identifyRole()
    {
        gvProjects.DataSource = null;
        gvProjects.DataBind();
        gvUnassignedProj.DataSource = null;
        gvUnassignedProj.DataBind();
        if (User.IsInRole("ProjectManager") || User.IsInRole("Employee"))
        {
            var active =
                from proj in ff.Projects
                join ep in ff.EmployeeProjects on proj.projId equals ep.projId
                join em in ff.EmployeeMemberships on ep.empId equals em.empId
                join username in ff.aspnet_Users on em.userId equals username.UserId
                where username.UserName == User.Identity.Name && proj.isActive == 1
                select proj;
            gvProjects.DataSource = active;
            gvProjects.DataBind();

            var inactive =
                from proj in ff.Projects
                join ep in ff.EmployeeProjects on proj.projId equals ep.projId
                join em in ff.EmployeeMemberships on ep.empId equals em.empId
                join username in ff.aspnet_Users on em.userId equals username.UserId
                where username.UserName == User.Identity.Name && proj.isActive == 0
                select proj;
            gvUnassignedProj.DataSource = inactive;
            gvUnassignedProj.DataBind();
            gvUnassignedProj.Columns[3].Visible = false;
            gvProjects.Columns[4].Visible = false;
        }

        if (User.IsInRole("HRStaff"))
        {
            populateActiveProj();
            populateInactiveProj();
            gvUnassignedProj.Columns[3].Visible = true;
            gvProjects.Columns[4].Visible = true;
        }

    }
}