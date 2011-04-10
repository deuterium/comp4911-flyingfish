﻿using System;
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
        populateProjectList();
    }

    protected void populateProjectList()
    {
        if (Session["wpID"] != null)
            Session["wpID"] = null;
        populateActiveProj();
        populateInactiveProj();
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
            lblException.Text = exception.StackTrace;
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
            lblException.Text = exception.StackTrace;
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
            lblException.Text = exception.StackTrace;
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
            lblException.Text = exception.StackTrace;
        }
    }
}