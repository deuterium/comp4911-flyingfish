using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

public partial class PM_ManageProject : System.Web.UI.Page
{
    FlyingFishClassesDataContext ff = new FlyingFishClassesDataContext();
    protected void Page_Load(object sender, EventArgs e)
    {
        populateManageProject();
        identifyRole();
    }

    protected void populateManageProject()
    {
        try
        {
            if (Session["projID"] == null)
                Response.Redirect("~/PM/ProjectList.aspx");
            if (Session["wpID"] != null)
                Session["wpID"] = null;
            if (divChangeAlloc.Visible == false)
                divOriginalAlloc.Visible = true;
            divChangeAlloc.Visible = false;
            lblProjID2.Text = Session["projID"].ToString();

            //Get project name
            var proj =
                from p in ff.Projects
                where p.projId == Convert.ToInt32(Session["projID"])
                select p;
            lblProjName2.Text = proj.First().projName;
            try
            {
                lblProjectManager2.Text = ff.Employees
                    .Where(a => a.empId == proj.First().manager).First().firstName + " " +
                    ff.Employees
                    .Where(a => a.empId == proj.First().manager).First().lastName;
            }
            catch (Exception e)
            {
                lblProjectManager2.Text = "";
            }
            if (proj.First().allocated_dollars == null)
                lblAlloc2.Text = "UNDEFINED";
            else
                lblAlloc2.Text = proj.First().allocated_dollars.ToString();
            if (proj.First().unallocated_dollars == null)
                lblUnalloc2.Text = "UNDEFINED";
            else
                lblUnalloc2.Text = proj.First().unallocated_dollars.ToString();

            getAllActiveWP();
            getAllUnactiveWP();

            string[] name = lblProjectManager2.Text.Split(' ');
            var query =
                (from emp in ff.Employees
                    where emp.firstName == name[0] && emp.lastName == name[1]
                    select new { emp.empId }).First();
            try
            {
            Roles.AddUserToRole(name[0].ToLower() + "_" + name[1].ToLower(), "ProjectManager");
            }
            catch (Exception exception)
            {
            }
            try
            {
                EmployeeProject ep = new EmployeeProject();
                ep.projId = Convert.ToInt32(lblProjID2.Text);
                ep.empId = query.empId;
                ff.EmployeeProjects.InsertOnSubmit(ep);
                ff.SubmitChanges();
            }
            catch (Exception exception) {
            }

        }
        catch (Exception exception)
        {
            lblException.Text = exception.StackTrace;
        }
    }

    protected void getAllActiveWP()
    {
        var qry =
            from wp in ff.WorkPackages
            where wp.projId == Convert.ToInt32(Session["projID"]) && wp.isActive == 1
            select wp;

        gvWorkPackages.DataSource = qry;
        gvWorkPackages.DataBind();
    }

    protected void getAllUnactiveWP()
    {
        var qry =
            from wp in ff.WorkPackages
            where wp.projId == Convert.ToInt32(Session["projID"]) && wp.isActive == 0
            select wp;

        gvUnactiveWP.DataSource = qry;
        gvUnactiveWP.DataBind();
    }

    protected void lbCreateWP_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/RE/WorkPackage.aspx");
    }

    protected void gvWorkPackages_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "btnView")
            {
                int row = Convert.ToInt32(e.CommandArgument);
                GridViewRow selectedRow = gvWorkPackages.Rows[row];
                Session["wpID"] = selectedRow.Cells[0].Text;
                Response.Redirect("~/RE/ManageWorkPackage.aspx");
            }

            if (e.CommandName == "btnDeactivate")
            {
                int row = Convert.ToInt32(e.CommandArgument);
                GridViewRow selectedRow = gvWorkPackages.Rows[row];
                WorkPackage workpackage = ff.WorkPackages.Where(wp => wp.wpId == selectedRow.Cells[0].Text).First();
                workpackage.isActive = 0;
                var wps =
                    from wp in ff.WorkPackages
                    where (wp.wpId.ToString().Contains(workpackage.wpId))
                    select wp;
                foreach (var wp in wps)
                {
                    wp.isActive = 0;
                    string s2 = wp.wpId;
                    ff.SubmitChanges();
                }
                ff.SubmitChanges();
                populateManageProject();
            }
        }
        catch (Exception exception)
        {
            lblException.Text = exception.StackTrace;
        }
    }

    protected void gvUnactiveWP_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "btnView")
            {
                int row = Convert.ToInt32(e.CommandArgument);
                GridViewRow selectedRow = gvUnactiveWP.Rows[row];
                Session["wpID"] = selectedRow.Cells[0].Text;
                Response.Redirect("~/RE/ManageWorkPackage.aspx");
            }

            if (e.CommandName == "btnActivate")
            {
                int row = Convert.ToInt32(e.CommandArgument);
                GridViewRow selectedRow = gvUnactiveWP.Rows[row];
                WorkPackage workpackage = ff.WorkPackages.Where(wp => wp.wpId == selectedRow.Cells[0].Text).First();
                workpackage.isActive = 1;

                string[] wpArray = workpackage.wpId.Split('.');
                string s = "";
                for (int j = wpArray.Length - 1; j > 1; j--)
                {
                    for (int i = 0; i < j; i++)
                    {
                        if (i == j - 1)
                            s += wpArray[i];
                        else
                            s += wpArray[i] + ".";
                    }
                    var subwp =
                                (from wp in ff.WorkPackages
                                where (wp.wpId == s)
                                 select wp);
                    string s2 = subwp.First().wpId;
                    subwp.First().isActive = 1;
                    ff.SubmitChanges();
                    s = "";
                }
                ff.SubmitChanges();
                populateManageProject();
            }
        }
        catch (Exception exception)
        {
            //lblException.Text = exception.StackTrace;
        }
    }

    protected void lbProjectList_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/PM/ProjectList.aspx");
    }
    protected void btnChangeAlloc_Click(object sender, EventArgs e)
    {
        tbUnalloc.Text = lblUnalloc2.Text;
        tbUnalloc.Visible = true;
        lblUnalloc2.Visible = false;
        btnSaveAlloc.Visible = true;
        btnCancelAlloc.Visible = true;
        btnChangeAlloc.Visible = false;
    }

    protected void btnSaveAlloc_Click(object sender, EventArgs e)
    {
        try
        {
            if (tbUnalloc.Text == "")
                tbUnalloc.Text = "0.0";
            Project proj = ff.Projects.Where(p => p.projId == Convert.ToInt32(Session["projID"].ToString())).First();
            proj.unallocated_dollars = Convert.ToDecimal(tbUnalloc.Text);
            ff.SubmitChanges();
            lblUnalloc2.Text = proj.unallocated_dollars.ToString();
            //divOriginalAlloc.Visible = true;
            lblUnalloc2.Visible = true;
            btnSaveAlloc.Visible = false;
            btnCancelAlloc.Visible = false;
            btnChangeAlloc.Visible = true;
            tbUnalloc.Visible = false;
            populateManageProject();
        }
        catch (Exception exception)
        {
            lblException.Text = exception.StackTrace;
        }
    }
    protected void btnCancelAlloc_Click(object sender, EventArgs e)
    {
        tbUnalloc.Text = lblUnalloc2.Text;
        lblUnalloc2.Visible = true;
        btnSaveAlloc.Visible = false;
        btnCancelAlloc.Visible = false;
        btnChangeAlloc.Visible = true;
        tbUnalloc.Visible = false;
        populateManageProject();
    }

    protected void pmRoleFunctionality()
    {
        gvUnactiveWP.Columns[5].Visible = true;
        gvWorkPackages.Columns[6].Visible = true;
        lbCreateWP.Visible = true;
    }

    protected void hrRoleFunctionality()
    {
        gvUnactiveWP.Columns[5].Visible = false;
        gvWorkPackages.Columns[6].Visible = false;
        lbCreateWP.Visible = false;
    }

    protected void identifyRole()
    {
        if(User.IsInRole("HRStaff"))
            hrRoleFunctionality();

        if (User.IsInRole("ProjectManager"))
        {

            var qry =
                            from username in ff.aspnet_Users
                            join em in ff.EmployeeMemberships on username.UserId equals em.userId
                            join ep in ff.EmployeeProjects on em.empId equals ep.empId
                            where username.UserName == User.Identity.Name && ep.projId == Convert.ToInt32(lblProjID2.Text)
                            select ep ;

            if (qry.ToList().Count > 0)
                pmRoleFunctionality();
            else
                Response.Redirect(Request.UrlReferrer.ToString());
        }

        if (User.Identity.IsAuthenticated == false)
            Response.Redirect(Request.UrlReferrer.ToString());
    }
}