using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class FlyingFishMasterPage : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Page.User.Identity.IsAuthenticated)
        {
            divLogin.Visible = false;
            LoginStatus.Visible = true;
        }
        else
        {
            divLogin.Visible = true;
            LoginStatus.Visible = false;
        }
    }
}
