using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using FFLib;
using System.Configuration;

public partial class RE_WorkPackage : System.Web.UI.Page
{
    string connectionString = ConfigurationManager.ConnectionStrings["ffconn"].ToString();
    FlyingFishClassesDataContext ff = new FlyingFishClassesDataContext();
    
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Session["projID"] == null)
                Response.Redirect("~/PM/ProjectList.aspx");
            if (Session["wpID"] == null)
                lblProjID.Text = Convert.ToInt32(Session["projID"]) + ".";
            else
                lblProjID.Text = Session["wpID"].ToString() + ".";
        }
        catch (Exception exception)
        {
            lblException.Text = exception.StackTrace;
        }
    }

    protected void btnCreateWorkPackage_Click(object sender, EventArgs e)
    {
        try
        {
            WorkPackage wp = new WorkPackage();
            if (ff.WorkPackages.Where(te => te.wpId == Convert.ToInt32(Session["projID"]) + "." + tbwpID.Text).ToArray().Length > 0 && Session["wpID"] == null)
            {
                lblError.Text = "Work Package already exists";
            }
            else
            {
                if (Session["wpID"] == null)
                    wp.wpId = Convert.ToInt32(Session["projID"]) + "." + tbwpID.Text;
                else
                {
                    wp.wpId = Session["wpID"].ToString() + "." + tbwpID.Text;
                    if (ff.WorkPackages.Where(te => te.wpId == Session["wpID"].ToString() + "." + tbwpID.Text).ToArray().Length > 0)
                    {
                        lblError.Text = "Work Package already exists";
                        return;
                    }
                }
                wp.name = tbwpName.Text;
                wp.description = tbDescription.Text;
                wp.projId = Convert.ToInt32(Session["projID"]);
                Session["wpID"] = wp.wpId;
                ff.WorkPackages.InsertOnSubmit(wp);
                ff.SubmitChanges();
                divCreateWorkPackage.Visible = false;
                divCreateSuccess.Visible = true;
                lblSuccessMsg.Text = "Work Package(" + wp.wpId + ") is created successfully.";

            }
        }
        catch (Exception exception)
        {
            lblException.Text = exception.StackTrace;
        }
    }
    protected void btnManage_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/RE/ManageWorkPackage.aspx");
    }
    protected void lbProjectList_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/PM/ProjectList.aspx");
    }
    protected void lbProject_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/PM/ManageProject.aspx");
    }
}