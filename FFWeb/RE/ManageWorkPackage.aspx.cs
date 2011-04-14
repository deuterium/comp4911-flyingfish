using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Web.Security;

public partial class RE_ManageWorkPackage : System.Web.UI.Page
{
    string connectionString = ConfigurationManager.ConnectionStrings["ffconn"].ToString();
    FlyingFishClassesDataContext ff = new FlyingFishClassesDataContext();
    static double allocOriginal;
    static double unallocOriginal;
    string parentWpID = "";
   
    #region Page_Load
    protected void Page_Load(object sender, EventArgs e)
    {
        populateManageWorkPackage();
        inspectRole();
    }
    protected void populateManageWorkPackage()
    {
        try
        {
            parentWpID = "";
            if (Session["wpID"] == null)
                Response.Redirect("~/PM/ProjectList.aspx");
            String[] wpArray = Session["wpID"].ToString().Split('.');

            if (wpArray.Length > 2)
            {
                for (int i = 0; i < wpArray.Length - 1; i++)
                {
                    parentWpID += wpArray[i];
                    if (i < wpArray.Length - 2)
                        parentWpID += ".";
                }
            }

            if (wpArray.Length == 2)
                parentWpID = null;

            ///////
            if (wpArray.Length == 2)
            {
                lbParentwp.Visible = false;
                lblWPID2.Text = Session["wpID"].ToString();
                var qry =
                        from wp in ff.WorkPackages
                        where (
                            wp.wpId == lblWPID2.Text
                        )
                        select new { wp.allocated_dollars, wp.unallocated_dollars, wp.name, wp.description, wp.projId };
                string alloc = qry.First().allocated_dollars.ToString() == "" ? "0" : qry.First().allocated_dollars.ToString();
                string unalloc = qry.First().unallocated_dollars.ToString() == "" ? "0" : qry.First().unallocated_dollars.ToString();
                tbUnalloc.Text = unalloc;
                tbAlloc.Text = alloc;
                tbAlloc2.Text = tbAlloc.Text;
                tbAlloc2.Visible = false;
                if (!IsPostBack)
                    tbDesc.Text = qry.First().description;

                if ((Convert.ToDecimal(tbUnalloc.Text) > getBudget(qry.First().projId)) &&
                    Convert.ToDecimal(tbUnalloc.Text) > Convert.ToDecimal(tbAlloc.Text))
                {
                    getTotalBudget(qry.First().projId);
                    //seAlloc.Maximum = seUnalloc.Maximum = Convert.ToDouble(tbUnalloc.Text);
                }
                else if ((Convert.ToDecimal(tbAlloc.Text) > getBudget(qry.First().projId)) &&
                  Convert.ToDecimal(tbUnalloc.Text) < Convert.ToDecimal(tbAlloc.Text))
                {
                    getTotalBudget(qry.First().projId);
                    //seAlloc.Maximum = seUnalloc.Maximum = Convert.ToDouble(tbAlloc.Text);
                }// else
                seUnalloc.Maximum = Convert.ToDouble(getTotalBudget(qry.First().projId));
                lblWPName2.Text = qry.Single().name.ToString();
                updategvEmployees();
                divAssignEmp.Visible = false;
                //divAssignRE.Visible = false;
                allocOriginal = Convert.ToDouble(tbAlloc.Text);
                unallocOriginal = Convert.ToDouble(tbUnalloc.Text);
                var subwp =
                    from wp in ff.WorkPackages
                    where (wp.wpId.ToString().Contains(Session["wpID"].ToString() + ".")&& wp.isActive == 1)
                    select new { wp.wpId, wp.name, wp.unallocated_dollars, wp.allocated_dollars, wp.description };
                gvSubWP.DataSource = subwp;
                gvSubWP.DataBind();
                getResponsibleEngineer();
                lblMaxBudget2.Text = getTotalBudget(qry.First().projId).ToString();
                if (lblError.Text != "")
                    populateUnassignEmployeeGV();
            }
            else
            {
                String[] strs = Session["wpID"].ToString().Split('.');
                if (strs.Length == 2)
                    lbParentwp.Visible = false;
                lblWPID2.Text = Session["wpID"].ToString();
                var qry =
                        from wp in ff.WorkPackages
                        where (
                            wp.wpId == lblWPID2.Text
                        )
                        select new { wp.allocated_dollars, wp.unallocated_dollars, wp.name, wp.description, wp.projId };
                string alloc = qry.First().allocated_dollars.ToString() == "" ? "0" : qry.First().allocated_dollars.ToString();
                string unalloc = qry.First().unallocated_dollars.ToString() == "" ? "0" : qry.First().unallocated_dollars.ToString();
                tbUnalloc.Text = unalloc;
                tbAlloc.Text = alloc;
                tbAlloc2.Text = tbAlloc.Text;
                tbAlloc2.Visible = false;
                if (!IsPostBack)
                    tbDesc.Text = qry.First().description;
                if ((Convert.ToDecimal(tbUnalloc.Text) > getBudget2(parentWpID) &&
                    Convert.ToDecimal(tbUnalloc.Text) > Convert.ToDecimal(tbAlloc.Text)))
                {
                    getTotalBudget2(parentWpID);
                }
                else if ((Convert.ToDecimal(tbAlloc.Text) > getBudget2(parentWpID) &&
                  Convert.ToDecimal(tbUnalloc.Text) < Convert.ToDecimal(tbAlloc.Text)))
                {
                    getTotalBudget2(parentWpID);  
                }
                seUnalloc.Maximum = Convert.ToDouble(getTotalBudget2(parentWpID));
                lblWPName2.Text = qry.Single().name.ToString();
                string desc = qry.Single().description.ToString();
                updategvEmployees();
                divAssignEmp.Visible = false;
                //divAssignRE.Visible = false;
                allocOriginal = Convert.ToDouble(tbAlloc.Text);
                unallocOriginal = Convert.ToDouble(tbUnalloc.Text);
                var subwp =
                    from wp in ff.WorkPackages
                    where (wp.wpId.ToString().Contains(Session["wpID"].ToString() + "."))
                    select new { wp.wpId, wp.name, wp.unallocated_dollars, wp.allocated_dollars, wp.description };
                gvSubWP.DataSource = subwp;
                gvSubWP.DataBind();
                lbParentwp.Visible = true;
                getResponsibleEngineer();
                lblMaxBudget2.Text = getTotalBudget2(parentWpID).ToString();
                populateParentWPs(wpArray);
                if (lblError.Text != "")
                    populateUnassignEmployeeGV();
            }
        }
        catch (Exception exception)
        {
            //lblException.Text = exception.StackTrace;
        }
    }

    #endregion

    protected void populateParentWPs(String[] wpArray)
    {
        try
        {
            List<WorkPackage> l = new List<WorkPackage>();
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
                            from wp in ff.WorkPackages
                            where (wp.wpId.ToString() == s && !wp.wpId.ToString().Contains(Session["wpID"].ToString()) && wp.isActive == 1)
                            select new { wp.wpId, wp.name, wp.unallocated_dollars, wp.allocated_dollars, wp.description };
                WorkPackage temp = new WorkPackage();
                temp.wpId = s;
                temp.unallocated_dollars = subwp.First().unallocated_dollars;
                temp.allocated_dollars = subwp.First().allocated_dollars;
                temp.name = subwp.First().name;
                l.Add(temp);
                s = "";
            }
            l.Reverse();
            gvParentsWP.DataSource = l;
            gvParentsWP.DataBind();
        }
        catch (Exception e)
        {
            //They are in an inactive workpackage
        }
        
    }
    #region Assign Employee linkbutton event handler
    protected void lbAssignEmp_Click(object sender, EventArgs e)
    {
        divAssignRE.Visible = false;
        populateUnassignEmployeeGV();
    }

    protected void populateUnassignEmployeeGV()
    {
        lblError.Text = "";
        var qry =
            from wp in ff.WorkPackages
            where (
                wp.wpId == lblWPID2.Text
            )
            select new { wp.allocated_dollars, wp.unallocated_dollars, wp.name, wp.description, wp.projId };
        divAssignEmp.Visible = true;
        var employees =
            from emp in ff.Employees
            join ep in ff.EmployeeProjects on emp.empId equals ep.empId
            where ep.projId == qry.First().projId
            select new { emp.empId, emp.firstName, emp.lastName };
        gvUnassignedEmployees.DataSource = employees;
        gvUnassignedEmployees.DataBind();
    }
    #endregion

    protected void gvEmployees_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "btnDelete")
        {
            ff.Refresh(System.Data.Linq.RefreshMode.OverwriteCurrentValues);
            int row = Convert.ToInt32(e.CommandArgument);
            GridViewRow selectedRow = gvEmployees.Rows[row];
            EmployeeWorkPackage empwp = ff.EmployeeWorkPackages.Where(emp => emp.empId == (Convert.ToInt32(selectedRow.Cells[0].Text)) && emp.wpId ==lblWPID2.Text).First();
            ff.EmployeeWorkPackages.DeleteOnSubmit(empwp);
            ff.SubmitChanges();
            populateManageWorkPackage();
        }
    }

    protected void gvUnassignedEmployees_SelectedIndexChanged(object sender, EventArgs e)
    {
    }

    #region Assign Employee gridview add button event handler
    protected void gvUnassignedEmployees_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        lblBudgetError.Text = "";
        try
        {
            if (parentWpID == null)
            {
                if (e.CommandName == "btnAdd")
                {
                    int row = Convert.ToInt32(e.CommandArgument);
                    GridViewRow selectedRow = gvUnassignedEmployees.Rows[row];
                    EmployeeWorkPackage ewp = new EmployeeWorkPackage();
                    EmployeeProject ep = new EmployeeProject();
                    ep.projId = Convert.ToInt32(Session["projID"]);

                    ewp.projId = Convert.ToInt32(Session["projID"]);
                    ewp.wpId = Session["wpID"].ToString();
                    ewp.empId = Convert.ToInt32(selectedRow.Cells[1].Text);
                    ep.empId = ewp.empId;

                    var qry =
                        from emp in ff.EmployeeWorkPackages
                        where (emp.empId == ewp.empId && emp.wpId == Session["wpID"].ToString())
                        select emp;
                    if (qry.ToArray().Length > 0)
                    {
                        lblError.Text = "Employee is already a part of the work package.";
                    }
                    else
                    {
                        var qry2 =
                            from emp in ff.EmployeeProjects
                            where (emp.projId == ep.projId && emp.empId == ep.empId)
                            select emp;
                        if (qry2.ToArray().Length == 0)
                            ff.EmployeeProjects.InsertOnSubmit(ep);
                        ff.EmployeeWorkPackages.InsertOnSubmit(ewp);
                        ff.SubmitChanges();
                        updategvEmployees();
                        lblError.Text = "";
                        divAssignEmp.Visible = true;
                    }
                }
            }
            else
            {
                if (e.CommandName == "btnAdd")
                {
                    int row = Convert.ToInt32(e.CommandArgument);
                    GridViewRow selectedRow = gvUnassignedEmployees.Rows[row];
                    EmployeeWorkPackage ewp = new EmployeeWorkPackage();
                    EmployeeProject ep = new EmployeeProject();
                    ep.projId = Convert.ToInt32(Session["projID"]);

                    ewp.projId = Convert.ToInt32(Session["projID"]);
                    ewp.wpId = Session["wpID"].ToString();
                    ewp.empId = Convert.ToInt32(selectedRow.Cells[1].Text);
                    ep.empId = ewp.empId;

                    var qry =
                        from emp in ff.EmployeeWorkPackages
                        where (emp.empId == ewp.empId && emp.wpId == Session["wpID"].ToString())
                        select emp;
                    if (qry.ToArray().Length > 0)
                    {
                        lblError.Text = "Employee is already a part of the work package.";
                        divAssignEmp.Visible = true;
                    }
                    else
                    {
                        var qry2 =
                            from emp in ff.EmployeeProjects
                            where (emp.projId == ep.projId && emp.empId == ep.empId)
                            select emp;
                        if (qry2.ToArray().Length == 0)
                            ff.EmployeeProjects.InsertOnSubmit(ep);
                        ff.EmployeeWorkPackages.InsertOnSubmit(ewp);
                        ff.SubmitChanges();
                        updategvEmployees();
                        lblError.Text = "";
                    }
                }
            }
        }
        catch (Exception exception)
        {
            //lblException.Text = exception.StackTrace;
            //lblError.Text = exception.StackTrace;
        }
    }
    #endregion

    #region Updating the assigned employees gridview
    protected void updategvEmployees()
    {
        try
        {
            var employees =
                from wp in ff.WorkPackages
                join o in ff.EmployeeWorkPackages on wp.wpId equals o.wpId
                join emp in ff.Employees on o.empId equals emp.empId
                where o.wpId == lblWPID2.Text
                select new { emp.empId, emp.firstName, emp.lastName };
            gvEmployees.DataSource = employees;
            gvEmployees.DataBind();
        }
        catch (Exception exception)
        {
            //lblException.Text = exception.StackTrace;
        }
    }
    #endregion

    #region Save Changes
    protected void btnSave_Click(object sender, EventArgs e)
    {
        lblError.Text = "";
        try
        {
            if (parentWpID == null)
            {
                var qry =
                        from wp in ff.WorkPackages
                        where (
                            wp.wpId == Session["wpID"].ToString()
                        )
                        select new { wp.projId };
                if ((Convert.ToDecimal(tbUnalloc2.Text) + Convert.ToDecimal(tbAlloc2.Text)) > getTotalBudget(qry.First().projId))
                    lblBudgetError.Text = "Please change the values of the Unallocated Budget to have a sum with the allocated budget to be between 0 and  " + getTotalBudget(qry.First().projId);
                else
                {
                    lblBudgetError.Text = "";
                    WorkPackage obj = ff.WorkPackages.Where(wp => wp.wpId == Session["wpID"].ToString()).First();
                    obj.unallocated_dollars = Convert.ToDecimal(tbUnalloc2.Text);
                    obj.allocated_dollars = Convert.ToDecimal(tbAlloc2.Text);
                    obj.description = tbDesc.Text;

                    ff.SubmitChanges();
                    updateProject(Convert.ToInt32(qry.First().projId), Convert.ToDecimal(tbUnalloc2.Text), Convert.ToDecimal(tbAlloc2.Text));
                    tbAlloc.Text = tbAlloc2.Text;
                    tbUnalloc.Text = tbUnalloc2.Text;
                    //Response.Redirect("~/RE/ManageWorkPackage.aspx");
                    populateManageWorkPackage();
                }
            }
            else
            {
                if ((Convert.ToDecimal(tbUnalloc2.Text) + Convert.ToDecimal(tbAlloc2.Text)) > getTotalBudget2(parentWpID))
                    lblBudgetError.Text = "Please change the values of the Unallocated Budget to have a sum with the allocated budget to be between 0 and  " + getTotalBudget2(parentWpID);
                else
                {
                    lblBudgetError.Text = "";
                    WorkPackage obj = ff.WorkPackages.Where(wp => wp.wpId == Session["wpID"].ToString()).First();
                    obj.unallocated_dollars = Convert.ToDecimal(tbUnalloc2.Text);
                    obj.allocated_dollars = Convert.ToDecimal(tbAlloc2.Text);
                    obj.description = tbDesc.Text;

                    ff.SubmitChanges();
                    updateWorkPackage(parentWpID, Convert.ToDecimal(tbUnalloc2.Text), Convert.ToDecimal(tbAlloc2.Text));
                    tbAlloc.Text = tbAlloc2.Text;
                    tbUnalloc.Text = tbUnalloc2.Text;
                    //Response.Redirect("~/RE/ManageWorkPackage.aspx");
                    populateManageWorkPackage();
                }
            }
        }
        catch (Exception exception)
        {
            //lblException.Text = exception.StackTrace;
        }
    }
    #endregion

    #region Click events
    protected void lbBacktoProject_Click(object sender, EventArgs e)
    {
        try
        {
            var obj =
                from id in ff.WorkPackages
                where id.wpId == Session["wpID"].ToString()
                select id.projId;
            Session["projID"] = obj.First().ToString();
            Response.Redirect("~/PM/ManageProject.aspx");
        }
        catch (Exception exception)
        {
            //lblException.Text = exception.StackTrace;
        }
    }
    #endregion

    protected void gvSubWP_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "btnView")
            {
                int row = Convert.ToInt32(e.CommandArgument);
                GridViewRow selectedRow = gvSubWP.Rows[row];
                Session["wpID"] = selectedRow.Cells[0].Text;
                parentWpID = "";
                populateManageWorkPackage();
            }

            if (e.CommandName == "btnDelete")
            {
                int row = Convert.ToInt32(e.CommandArgument);
                GridViewRow selectedRow = gvSubWP.Rows[row];
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
                populateManageWorkPackage();
            }
        }
        catch (Exception exception)
        {
            //lblException.Text = exception.StackTrace;
        }
    }

    protected decimal getTotalBudget(int id)
    {
        try
        {
            return Convert.ToDecimal(tbUnalloc.Text) + Convert.ToDecimal(tbAlloc.Text) + getBudget(id);
        }
        catch (Exception exception)
        {
            //lblException.Text = exception.StackTrace;
            return 0;
        }
    }

    protected decimal getBudget(int id)
    {
        try
        {
            var budget =
                from b in ff.Projects
                where b.projId == id
                select b;
            return Convert.ToDecimal(budget.First().unallocated_dollars);
        }
        catch (Exception exception)
        {
            //lblException.Text = exception.StackTrace;
            return 0;
        }
    }

    protected void updateProject(int projID, decimal allocBudget, decimal unallocBudget)
    {
        try
        {
            Project proj = ff.Projects.Where(p => p.projId == projID).First();
            if (allocBudget > Convert.ToDecimal(allocOriginal))
            {
                proj.unallocated_dollars = proj.unallocated_dollars - (allocBudget - Convert.ToDecimal(allocOriginal));
                proj.allocated_dollars = proj.allocated_dollars + (allocBudget - Convert.ToDecimal(allocOriginal));
            }
            else if (allocBudget < Convert.ToDecimal(allocOriginal))
            {
                proj.unallocated_dollars = proj.unallocated_dollars + (Convert.ToDecimal(allocOriginal) - allocBudget);
                proj.allocated_dollars = proj.allocated_dollars - (Convert.ToDecimal(allocOriginal) - allocBudget);
            }
            if (unallocBudget > Convert.ToDecimal(unallocOriginal))
            {
                proj.unallocated_dollars = proj.unallocated_dollars - (unallocBudget - Convert.ToDecimal(unallocOriginal));
                proj.allocated_dollars = proj.allocated_dollars + (unallocBudget - Convert.ToDecimal(unallocOriginal));
            }
            else if (unallocBudget < Convert.ToDecimal(unallocOriginal))
            {
                proj.unallocated_dollars = proj.unallocated_dollars + (Convert.ToDecimal(unallocOriginal) - unallocBudget);
                proj.allocated_dollars = proj.allocated_dollars - (Convert.ToDecimal(unallocOriginal) - unallocBudget);
            }

            ff.SubmitChanges();
        }
        catch (Exception exception)
        {
            //lblException.Text = exception.StackTrace;
        }
    }

    protected void lbCreateSubWorkPackage_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/RE/WorkPackage.aspx");
    }

    #region WorkPackage Region
    protected decimal getTotalBudget2(string id)
    {
        try
        {
            return Convert.ToDecimal(tbUnalloc.Text) + Convert.ToDecimal(tbAlloc.Text) + getBudget2(id);
        }
        catch (Exception exception)
        {
            //lblException.Text = exception.StackTrace;
            return 0;
        }
    }

    protected decimal getBudget2(string id)
    {
        try
        {
            var budget =
                from b in ff.WorkPackages
                where b.wpId == id
                select b;
            
            string unalloc = budget.First().unallocated_dollars.ToString() == "" ? "0" : budget.First().unallocated_dollars.ToString();
            return Convert.ToDecimal(unalloc);
        }
        catch (Exception exception)
        {
            //lblException.Text = exception.StackTrace;
            return 0;
        }
    }

    protected void updateWorkPackage(string workpackID, decimal allocBudget, decimal unallocBudget)
    {
        try
        {
            WorkPackage workpackage = ff.WorkPackages.Where(wp => wp.wpId == workpackID).First();
            if (allocBudget > Convert.ToDecimal(allocOriginal))
            {
                workpackage.unallocated_dollars = workpackage.unallocated_dollars - (allocBudget - Convert.ToDecimal(allocOriginal));
                workpackage.allocated_dollars = workpackage.allocated_dollars + (allocBudget - Convert.ToDecimal(allocOriginal));
            }
            else if (allocBudget < Convert.ToDecimal(allocOriginal))
            {
                workpackage.unallocated_dollars = workpackage.unallocated_dollars + (Convert.ToDecimal(allocOriginal) - allocBudget);
                workpackage.allocated_dollars = workpackage.allocated_dollars - (Convert.ToDecimal(allocOriginal) - allocBudget);
            }
            if (unallocBudget > Convert.ToDecimal(unallocOriginal))
            {
                workpackage.unallocated_dollars = workpackage.unallocated_dollars - (unallocBudget - Convert.ToDecimal(unallocOriginal));
                workpackage.allocated_dollars = workpackage.allocated_dollars + (unallocBudget - Convert.ToDecimal(unallocOriginal));
            }
            else if (unallocBudget < Convert.ToDecimal(unallocOriginal))
            {
                workpackage.unallocated_dollars = workpackage.unallocated_dollars + (Convert.ToDecimal(unallocOriginal) - unallocBudget);
                workpackage.allocated_dollars = workpackage.allocated_dollars - (Convert.ToDecimal(unallocOriginal) - unallocBudget);
            }

            ff.SubmitChanges();
        }
        catch (Exception exception)
        {
            //lblException.Text = exception.StackTrace;
        }
    }
    #endregion

    protected void lbParentwp_Click(object sender, EventArgs e)
    {
        try
        {
            String[] wp = Session["wpID"].ToString().Split('.');
            String subID = "";
            String parentWpID = "";
            if (wp.Length == 3)
            {
                Session["wpID"] = null;
                for (int i = 0; i < wp.Length - 1; i++)
                {
                    parentWpID += wp[i];
                    if (i < wp.Length - 2)
                        parentWpID += ".";
                }
                Session["wpID"] = parentWpID;
                //Response.Redirect("~/RE/ManageWorkPackage.aspx");
                populateManageWorkPackage();
                return;
            }
            for (int i = 0; i < wp.Length; i++)
            {
                //subID += wp[i];
                if (i < wp.Length - 2)
                {
                    //subID += ".";
                    parentWpID += wp[i] + ".";
                }
                if (i == wp.Length - 2)
                {
                    parentWpID += wp[i];
                }
            }
            Session["wpID"] = parentWpID;
            //Response.Redirect("~/RE/ManageWorkPackage.aspx");
            populateManageWorkPackage();
            return;
        }
        catch (Exception exception)
        {
            //lblException.Text = exception.StackTrace;
        }
    }
    protected void lbAssignRE_Click(object sender, EventArgs e)
    {
        lblError.Text = "";
        var qry =
            from wp in ff.WorkPackages
            where (
                wp.wpId == lblWPID2.Text
            )
            select new { wp.projId };
        var employees =
            from emp in ff.Employees
            join ep in ff.EmployeeProjects on emp.empId equals ep.empId
            where ep.projId == qry.First().projId
            select new { emp.empId, emp.firstName, emp.lastName };
        gvAssignRE.DataSource = employees;
        gvAssignRE.DataBind();
        divAssignRE.Visible = true;
    }
    
    protected void gvAssignRE_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "btnAssign")
            {
                var qry =
                    from wp in ff.WorkPackages
                    where (
                        wp.wpId == lblWPID2.Text
                    )
                    select new { wp.projId };

                int row = Convert.ToInt32(e.CommandArgument);
                GridViewRow selectedRow = gvAssignRE.Rows[row];

                EmployeeWorkPackage ewp = new EmployeeWorkPackage();
                ewp.empId = Convert.ToInt32(selectedRow.Cells[0].Text);
                ewp.projId = qry.First().projId;
                ewp.wpId = lblWPID2.Text;
                
                var qry2 =
                    from emp in ff.EmployeeWorkPackages
                    where (emp.projId == qry.First().projId && emp.empId == ewp.empId)
                    select emp;
                if (qry2.ToArray().Length == 0)
                {
                    ff.EmployeeWorkPackages.InsertOnSubmit(ewp);
                }
                string username = selectedRow.Cells[1].Text + "_" + selectedRow.Cells[2].Text;
                WorkPackageResponsibleEngineer wpre = new WorkPackageResponsibleEngineer();
                wpre.projId = qry.First().projId;
                wpre.wpId = lblWPID2.Text;
                wpre.responsibleEngineer = Convert.ToInt32(selectedRow.Cells[0].Text);
                ff.WorkPackageResponsibleEngineers.InsertOnSubmit(wpre);
                ff.SubmitChanges();
                divAssignRE.Visible = false;
                try
                {
                    Roles.AddUserToRole(username, "ResponsibleEngineer");
                }
                catch (Exception exception)
                {
                }
                populateManageWorkPackage();
            }
        }
        catch (Exception exception)
        {
          //  lblException.Text = exception.StackTrace;
        }
    }

    protected void getResponsibleEngineer()
    {
        var qry =
            from re in ff.WorkPackageResponsibleEngineers
            where re.wpId == lblWPID2.Text
            select new { re.responsibleEngineer};
        if (qry.Count() > 0)
        {
            var qry2 =
                from emp in ff.Employees
                where emp.empId == qry.First().responsibleEngineer
                select emp;
            lblRE2.Text = qry2.First().firstName + " " + qry2.First().lastName;
            divREisAssigned.Visible = true;
            divREnotAssigned.Visible = false;
        }
        else
        {
            divREisAssigned.Visible = false;
            divREnotAssigned.Visible = true;
        }
    }

    protected void gvParentsWP_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "btnView")
            {
                int row = Convert.ToInt32(e.CommandArgument);
                GridViewRow selectedRow = gvParentsWP.Rows[row];
                Session["wpID"] = selectedRow.Cells[0].Text;
                parentWpID = "";
                populateManageWorkPackage();
            }

            if (e.CommandName == "btnDelete")// should not delete because it would make the workpackage they are currently looking at inactive.
            {
                int row = Convert.ToInt32(e.CommandArgument);
                GridViewRow selectedRow = gvParentsWP.Rows[row];
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
                populateManageWorkPackage();
            }
        }
        catch (Exception exception)
        {
            //lblException.Text = exception.StackTrace;
        }
    }

    protected void employeeRoleFunctionality()
    {
        divtbUnalloc1.Visible = false;
        tbUnalloc2.Text = tbUnalloc.Text;
        tbUnalloc2.ReadOnly = true;
        tbDesc.ReadOnly = true;
        lblREnotAssigned.Visible = true;
        divREnotAssigned2.Visible = false;
        divAssignEmpLink.Visible = false;
        lbCreateSubWorkPackage.Visible = false;
        gvEmployees.Columns[3].Visible = false;
        gvSubWP.Columns[6].Visible = false;
        btnSave.Visible = false;
    }

    protected void pmRoleFunctionality()
    {
        divtbUnalloc1.Visible = true;
        tbUnalloc2.ReadOnly = false;
        tbDesc.ReadOnly = false;
        lblREnotAssigned.Visible = false;
        divREnotAssigned2.Visible = true;
        divAssignEmpLink.Visible = true;
        lbCreateSubWorkPackage.Visible = true;
        gvEmployees.Columns[3].Visible = true;
        gvSubWP.Columns[6].Visible = false;
        btnSave.Visible = true;
    }

    protected void inspectRole()
    {
        if (User.IsInRole("HRStaff"))
        {
            User.Identity.Name.ToString();
            employeeRoleFunctionality();
        }

        if (User.IsInRole("Employee") && !User.IsInRole("HRStaff") && !User.IsInRole("ProjectManager"))
        {
            var qry =
                from username in ff.aspnet_Users
                join em in ff.EmployeeMemberships on username.UserId equals em.userId
                join ep in ff.EmployeeProjects on em.empId equals ep.empId
                where username.UserName == User.Identity.Name.ToString() && ep.projId == Convert.ToInt32(Session["projID"])
                select username;
            if(qry.ToList().Count > 0)
                employeeRoleFunctionality();
            else
                Response.Redirect(Request.UrlReferrer.ToString());
        }

        if (User.IsInRole("ProjectManager"))
        {
            pmRoleFunctionality();
        }

        if(User.Identity.IsAuthenticated == false)
            Response.Redirect(Request.UrlReferrer.ToString());

    }
    protected void btnRemove_Click(object sender, EventArgs e)
    {
        var qry =
            from re in ff.WorkPackageResponsibleEngineers
            where re.wpId == lblWPID2.Text
            select re;
        if (qry.Count() > 0)
        {
            ff.WorkPackageResponsibleEngineers.DeleteOnSubmit(qry.First());
            ff.SubmitChanges();
            divREisAssigned.Visible = false;
            divREnotAssigned.Visible = true;
        }
    }
}