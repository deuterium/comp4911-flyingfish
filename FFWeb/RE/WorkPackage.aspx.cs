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

    }
    protected void btnCreateWorkPackage_Click(object sender, EventArgs e)
    {
        WorkPackage wp = new WorkPackage();
        if (ff.WorkPackages.Where(te => te.wpId == tbwpID.Text).ToArray().Length > 0) //LOGIC ERROR in database, wpID shud be int not string
        {
            lblError.Text = "Work Package already exists";
        }
        else
        {
            wp.wpId = tbwpID.Text;
            wp.name = tbwpName.Text;
            wp.allocated_dollars = Convert.ToInt32(tbAllocated.Text);
            wp.unallocated_dollars = Convert.ToInt32(tbUnallocated.Text);
            wp.description = tbDescription.Text;
            wp.projId = 1; //project ID will be grabbed from the project used to create the work package later on using the foriegn key
            ff.WorkPackages.InsertOnSubmit(wp);
            ff.SubmitChanges();

            divCreateWorkPackage.Visible = false;
            divCreateSuccess.Visible = true;
        }
    }
    protected void btnCreate_Click(object sender, EventArgs e)
    {
        Session["wpID"] = tbwpID.Text;
        Response.Redirect("~/RE/ManageWorkPackage.aspx");
    }
}