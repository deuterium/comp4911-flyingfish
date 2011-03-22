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
        lblProjID2.Text = Session["projID"].ToString();

        //Get project name
        var proj =
            from p in ff.Projects
            where p.projId == Convert.ToInt32(Session["projID"])
            select p;
        lblProjName2.Text = proj.First().projName;

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
            Session["wpID"] = selectedRow.Cells[2].Text;
            Response.Redirect("~/RE/ManageWorkPackage.aspx");
        }
    }
}