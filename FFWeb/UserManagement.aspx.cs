using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class UserManagement : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //if (Request.UrlReferrer == null) Response.Redirect("~/Default.aspx");
        if (!User.IsInRole("HRStaff")) Response.Redirect(Request.UrlReferrer.ToString());
    }
    protected void lbCreateUser_Click(object sender, EventArgs e)
    {
        divCreateNewUser.Visible = true;
    }
}