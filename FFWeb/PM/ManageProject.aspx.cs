﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class PM_ManageProject : System.Web.UI.Page
{
    FlyingFishClassesDataContext ff = new FlyingFishClassesDataContext();
    protected void Page_Load(object sender, EventArgs e)
    {
        populateManageProject();
    }

    protected void populateManageProject()
    {
        try
        {
            if (Session["projID"] == null)
                Response.Redirect("~/PM/ProjectList.aspx");
            if (Session["wpID"] != null)
                Session["wpID"] = null;
            if (divChangeAlloc.Visible == false)
                divOriginalAlloc.Visible = true;
            divChangeAlloc.Visible = false;
            lblProjID2.Text = Session["projID"].ToString();

            //Get project name
            var proj =
                from p in ff.Projects
                where p.projId == Convert.ToInt32(Session["projID"])
                select p;
            lblProjName2.Text = proj.First().projName;
            lblProjectManager2.Text = ff.Employees
                .Where(a => a.empId == proj.First().manager).First().firstName + " " +
                ff.Employees
                .Where(a => a.empId == proj.First().manager).First().lastName;
            if (proj.First().allocated_dollars == null)
                lblAlloc2.Text = "UNDEFINED";
            else
                lblAlloc2.Text = proj.First().allocated_dollars.ToString();
            if (proj.First().unallocated_dollars == null)
                lblUnalloc2.Text = "UNDEFINED";
            else
                lblUnalloc2.Text = proj.First().unallocated_dollars.ToString();

            //Get all work packages
            var qry =
                from wp in ff.WorkPackages
                where wp.projId == Convert.ToInt32(Session["projID"]) && wp.isActive == 1
                select wp;

            gvWorkPackages.DataSource = qry;
            gvWorkPackages.DataBind();
        }
        catch (Exception exception)
        {
            lblException.Text = exception.StackTrace;
        }
    }

    protected void lbCreateWP_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/RE/WorkPackage.aspx");
    }

    protected void gvWorkPackages_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "btnView")
            {
                int row = Convert.ToInt32(e.CommandArgument);
                GridViewRow selectedRow = gvWorkPackages.Rows[row];
                Session["wpID"] = selectedRow.Cells[0].Text;
                Response.Redirect("~/RE/ManageWorkPackage.aspx");
            }

            if (e.CommandName == "btnDelete")
            {
                int row = Convert.ToInt32(e.CommandArgument);
                GridViewRow selectedRow = gvWorkPackages.Rows[row];
                WorkPackage workpackage = ff.WorkPackages.Where(wp => wp.wpId == selectedRow.Cells[0].Text).First();
                workpackage.isActive = 0;
                ff.SubmitChanges();
                populateManageProject();
            }
        }
        catch (Exception exception)
        {
            lblException.Text = exception.StackTrace;
        }
    }
    protected void lbProjectList_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/PM/ProjectList.aspx");
    }
    protected void btnChangeAlloc_Click(object sender, EventArgs e)
    {
        tbUnalloc.Text = lblUnalloc2.Text;
        tbUnalloc.Visible = true;
        lblUnalloc2.Visible = false;
        btnSaveAlloc.Visible = true;
        btnCancelAlloc.Visible = true;
        btnChangeAlloc.Visible = false;
    }

    protected void btnSaveAlloc_Click(object sender, EventArgs e)
    {
        try
        {
            if (tbUnalloc.Text == "")
                tbUnalloc.Text = "0.0";
            Project proj = ff.Projects.Where(p => p.projId == Convert.ToInt32(Session["projID"].ToString())).First();
            proj.unallocated_dollars = Convert.ToDecimal(tbUnalloc.Text);
            ff.SubmitChanges();
            lblUnalloc2.Text = proj.unallocated_dollars.ToString();
            //divOriginalAlloc.Visible = true;
            lblUnalloc2.Visible = true;
            btnSaveAlloc.Visible = false;
            btnCancelAlloc.Visible = false;
            btnChangeAlloc.Visible = true;
            tbUnalloc.Visible = false;
            populateManageProject();
        }
        catch (Exception exception)
        {
            lblException.Text = exception.StackTrace;
        }
    }
    protected void btnCancelAlloc_Click(object sender, EventArgs e)
    {
        tbUnalloc.Text = lblUnalloc2.Text;
        lblUnalloc2.Visible = true;
        btnSaveAlloc.Visible = false;
        btnCancelAlloc.Visible = false;
        btnChangeAlloc.Visible = true;
        tbUnalloc.Visible = false;
        populateManageProject();
    }
}