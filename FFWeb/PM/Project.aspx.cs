﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using FFLib;

public partial class PM_Project : System.Web.UI.Page
{
    string connectionString = ConfigurationManager.ConnectionStrings["ffconn"].ToString();
    FlyingFishClassesDataContext ff = new FlyingFishClassesDataContext();
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnCreateProject_Click(object sender, EventArgs e)
    {
        Project proj = new Project();
        
        if (ff.Projects.Where(te => te.projId == Convert.ToInt32(tbProjectID.Text)).ToArray().Length > 0)
        {
            lblError.Text = "Project already exists.";
        }
        else
        {
            proj.projId = Convert.ToInt32(tbProjectID.Text);
            proj.projName = tbProjectName.Text;
            proj.manager = 1; //it will be the manager that is logged in but for now default is 1
            proj.allocated_dollars = Convert.ToDecimal(tbAlloc.Text);
            proj.unallocated_dollars = Convert.ToDecimal(tbUnalloc.Text);
            ff.Projects.InsertOnSubmit(proj);
            ff.SubmitChanges();

            Session["projID"] = proj.projId;
            
            divCreateSuccess.Visible = true;
            divCreateProject.Visible = false;
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