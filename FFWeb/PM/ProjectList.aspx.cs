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
        try
        {
            if (Session["wpID"] != null)
                Session["wpID"] = null;
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
            if (e.CommandName == "btnDelete")
            {
                int row = Convert.ToInt32(e.CommandArgument);
                GridViewRow selectedRow = gvProjects.Rows[row];
                Project proj = ff.Projects.Where(p => p.projId ==  Convert.ToInt32(selectedRow.Cells[0].Text)).First();
                proj.isActive = 0;
                ff.SubmitChanges();
                Response.Redirect("~/PM/ProjectList.aspx");
            }
        }
        catch (Exception exception)
        {
            lblException.Text = exception.StackTrace;
        }
    }
}