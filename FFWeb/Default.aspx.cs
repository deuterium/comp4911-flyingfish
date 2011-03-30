using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }
    protected void btnajaxtest_Click(object sender, EventArgs e)
    {
        ajaxkeygen.Visible = true;
        ajaxkeygenwindow.Visible = true;
    }
    protected void btnPasswordConfirm_Click(object sender, EventArgs e)
    {
        lblPubKeyGen.Visible = true;
        btnAjaxContinue.Visible = true;
        tblKeygenForm.Visible = false;
        btnPasswordConfirm.Visible = false;
        ajaxblurb.Visible = false;

        test.Text = DateTime.Now.ToFileTime().ToString();
    }
    protected void btnAjaxContinue_Click(object sender, EventArgs e)
    {
        ajaxkeygenwindow.Visible = false;
        ajaxkeygen.Visible = false;
        lblPubKeyGen.Visible = false;
        btnPasswordConfirm.Visible = false;
        tblKeygenForm.Visible = true;
        ajaxblurb.Visible = true;
    }
}