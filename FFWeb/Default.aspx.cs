using System;
using System.Web.Security;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using FFLib;
using System.Text;
using System.Security.Cryptography;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (User.Identity.IsAuthenticated)
        {
            if (!hasKey())
            {
                ajaxkeygen.Visible = true;
                ajaxkeygenwindow.Visible = true;
            }
        }
    }

    protected void btnDownload_Click(object sender, EventArgs e)
    {
        download();
    }

    private string getFilename()
    {
        string txtDir = ConfigurationManager.AppSettings["TempDir"];
        string txtPath = MapPath("~/") + txtDir;
        string filename = txtPath + @"\" + "PrivateKey-" + User.Identity.Name + ".fpk";
        return filename;
    }

    private void download()
    {
        Response.Redirect("~/Temp/PrivateKey-" + User.Identity.Name + ".fpk");
        Session["keyDownloaded"] = true;
    }

    private bool hasKey()
    {
        FlyingFishClassesDataContext ff = new FlyingFishClassesDataContext();
        try
        {
            var empId = ff.EmployeeMemberships
                .Where(a => a.userId == (Guid)Membership.GetUser().ProviderUserKey).Select(a => a.empId).Single();

            var empKey = ff.EmployeeSignatures
                .Where(x => x.empId == empId)
                .Single();

            if (empKey == null)
                return false;
            else
                return true;
        }
        catch (Exception e1)
        {
            Console.WriteLine(e1.Message);
        }
        return false;
    }

    protected void bdlFeatures_Click(object sender, BulletedListEventArgs e)
    {
        ajaxkeygenwindow.Visible = false;
        ajaxkeygen.Visible = false;
    }

    static public string GetMd5Sum(string str)
    {
        Encoder enc = System.Text.Encoding.Unicode.GetEncoder();

        byte[] unicodeText = new byte[str.Length * 2];
        enc.GetBytes(str.ToCharArray(), 0, str.Length, unicodeText, 0, true);

        MD5 md5 = new MD5CryptoServiceProvider();
        byte[] result = md5.ComputeHash(unicodeText);

        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < result.Length; i++)
        {
            sb.Append(result[i].ToString("X2"));
        }

        return sb.ToString();
    }

    protected void btnPasswordConfirm_Click(object sender, EventArgs e)
    {
        string key = DateTime.Now.ToFileTime().ToString();
        StreamWriter srtr = new StreamWriter(getFilename());
        srtr.Write(key);
        srtr.Close();
        FlyingFishClassesDataContext ff = new FlyingFishClassesDataContext();
        EmployeeSignature es = new EmployeeSignature();
        var empId = ff.EmployeeMemberships
            .Where(a => a.userId == (Guid)Membership.GetUser().ProviderUserKey).Select(a => a.empId).Single();
        es.empId = (int)empId;
        es.passphrase = tbPassword.Text;
        es.publicKey = GetMd5Sum(key);
        ff.EmployeeSignatures.InsertOnSubmit(es);
        ff.SubmitChanges();

        tblKeygenForm.Visible = false;
        btnClose.Visible = true;
        btnDownload.Visible = true;
        btnPasswordConfirm.Visible = false;
        lblKey.Text = "Your key is ready.";
    }
    protected void btnClose_Click(object sender, EventArgs e)
    {
        ajaxkeygenwindow.Visible = false;
        ajaxkeygen.Visible = false;
    }
}