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
    }
    protected void lbCreateUser_Click(object sender, EventArgs e)
    {
        if (DivManageUsers.Visible) DivManageUsers.Visible = false;
        DivNewUser.Visible = true;

    }
    protected void ManageUserLabel_Click(object sender, EventArgs e)
    {
        if (DivNewUser.Visible) DivNewUser.Visible = false;
        DivManageUsers.Visible = true;

    }
    protected void ldsRole_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {

    }
}