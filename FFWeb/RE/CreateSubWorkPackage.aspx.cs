using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using FFLib;
using System.Configuration;

public partial class RE_CreateSubWorkPackage : System.Web.UI.Page
{

    string connectionString = ConfigurationManager.ConnectionStrings["ffconn"].ToString();
    FlyingFishClassesDataContext ff = new FlyingFishClassesDataContext();
    protected void Page_Load(object sender, EventArgs e)
    {
        lblProjID.Text = Session["wpID"].ToString() + ".";
    }
    protected void btnCreateWorkPackage_Click(object sender, EventArgs e)
    {
        WorkPackage wp = new WorkPackage();
        if (ff.WorkPackages.Where(te => te.wpId == Session["wpID"].ToString() + "." + tbwpID.Text).ToArray().Length > 0)
        {
            lblError.Text = "Work Package already exists";
        }
        else
        {
            wp.wpId = Session["wpID"].ToString() + "." + tbwpID.Text;
            wp.name = tbwpName.Text;
            //wp.allocated_dollars = Convert.ToInt32(tbAllocated.Text);
            //wp.unallocated_dollars = Convert.ToInt32(tbUnallocated.Text);
            wp.description = tbDescription.Text;
            wp.projId = Convert.ToInt32(Session["projID"]);
            Session["wpID2"] = wp.wpId;
            ff.WorkPackages.InsertOnSubmit(wp);
            ff.SubmitChanges();

            divCreateWorkPackage.Visible = false;
            divCreateSuccess.Visible = true;
            lblSuccessMsg.Text = "Work Package(" + wp.wpId + ") is created successfully.";
        }
    }
    protected void btnManage_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/RE/ManageSubWorkPackage.aspx");
    }
}