using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using FFLib;

public partial class PM_ManageProject : System.Web.UI.Page
{
    FlyingFishClassesDataContext ff = new FlyingFishClassesDataContext();
    protected void Page_Load(object sender, EventArgs e)
    {
        divChangeAlloc.Visible = false;
        lblProjID2.Text = Session["projID"].ToString();

        //Get project name
        var proj =
            from p in ff.Projects
            where p.projId == Convert.ToInt32(Session["projID"])
            select p;
        lblProjName2.Text = proj.First().projName;
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
            where wp.projId == Convert.ToInt32(Session["projID"])
            select wp;

        gvWorkPackages.DataSource = qry;
        gvWorkPackages.DataBind();
    }
    protected void lbCreateWP_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/RE/WorkPackage.aspx");
    }

    protected void gvWorkPackages_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "btnView")
        {
            int row = Convert.ToInt32(e.CommandArgument);
            GridViewRow selectedRow = gvWorkPackages.Rows[row];
            Session["wpID"] = selectedRow.Cells[0].Text;
            Response.Redirect("~/RE/ManageWorkPackage.aspx");
        }
    }
    protected void lbProjectList_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/PM/ProjectList.aspx");
    }
    protected void btnChangeAlloc_Click(object sender, EventArgs e)
    {
        tbUnalloc.Text = lblUnalloc2.Text;
        divOriginalAlloc.Visible = false;
        divChangeAlloc.Visible = true;
    }

    protected void btnSaveAlloc_Click(object sender, EventArgs e)
    {
        Project proj = ff.Projects.Where(p => p.projId == Convert.ToInt32(Session["projID"].ToString())).First();
        //proj.allocated_dollars = Convert.ToDecimal(tbAlloc.Text);
        proj.unallocated_dollars = Convert.ToDecimal(tbUnalloc.Text);
        ff.SubmitChanges();
        //lblAlloc2.Text = proj.allocated_dollars.ToString();
        lblUnalloc2.Text = proj.unallocated_dollars.ToString();
        divOriginalAlloc.Visible = true;
        Response.Redirect("~/PM/ManageProject.aspx");
    }
}