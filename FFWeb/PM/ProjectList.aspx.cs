using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using FFLib;

public partial class PM_ProjectList : System.Web.UI.Page
{
    FlyingFishClassesDataContext ff = new FlyingFishClassesDataContext();
    protected void Page_Load(object sender, EventArgs e)
    {
        var qry =
            from projs in ff.Projects
            select projs;
        gvProjects.DataSource = qry;
        gvProjects.DataBind();
    }

    protected void gvProjects_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "btnView")
        {
            int row = Convert.ToInt32(e.CommandArgument);
            GridViewRow selectedRow = gvProjects.Rows[row];
            Session["projID"] = Convert.ToInt32(selectedRow.Cells[1].Text);
            Response.Redirect("~/PM/ManageProject.aspx");
        }
    }
}