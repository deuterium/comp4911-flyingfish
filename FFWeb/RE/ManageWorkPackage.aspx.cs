using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

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
    }
    protected void populateManageWorkPackage()
    {
        try
        {
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
                seAlloc.Maximum = seUnalloc.Maximum = Convert.ToDouble(getTotalBudget(qry.First().projId));
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
                seAlloc.Maximum = seUnalloc.Maximum = Convert.ToDouble(getTotalBudget2(parentWpID));
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
                if (lblError.Text != "")
                    populateUnassignEmployeeGV();
            }
        }
        catch (Exception exception)
        {
            lblException.Text = exception.StackTrace;
        }
    }

    #endregion

    #region Assign Employee linkbutton event handler
    protected void lbAssignEmp_Click(object sender, EventArgs e)
    {
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
            lblException.Text = exception.StackTrace;
            lblError.Text = exception.StackTrace;
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
            lblException.Text = exception.StackTrace;
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
                    lblBudgetError.Text = "Please change the values of Allocated Budget and Unallocated Budget to have a sum below " + getTotalBudget(qry.First().projId);
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
                    lblBudgetError.Text = "Please change the values of Allocated Budget and Unallocated Budget to have a sum below " + getTotalBudget2(parentWpID);
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
            lblException.Text = exception.StackTrace;
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
            lblException.Text = exception.StackTrace;
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
                populateManageWorkPackage();
            }

            if (e.CommandName == "btnDelete")
            {
                int row = Convert.ToInt32(e.CommandArgument);
                GridViewRow selectedRow = gvSubWP.Rows[row];
                WorkPackage workpackage = ff.WorkPackages.Where(wp => wp.wpId == selectedRow.Cells[0].Text).First();
                workpackage.isActive = 0;
                ff.SubmitChanges();
                populateManageWorkPackage();
            }
        }
        catch (Exception exception)
        {
            lblException.Text = exception.StackTrace;
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
            lblException.Text = exception.StackTrace;
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
            lblException.Text = exception.StackTrace;
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
            lblException.Text = exception.StackTrace;
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
            lblException.Text = exception.StackTrace;
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
            lblException.Text = exception.StackTrace;
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
            lblException.Text = exception.StackTrace;
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
            for (int i = 0; i < wp.Length - 1; i++)
            {
                subID += wp[i];
                if (i < wp.Length - 2)
                {
                    subID += ".";
                    parentWpID += wp[i];
                }
                if (i < wp.Length - 3)
                    parentWpID += ".";
            }
            Session["wpID"] = parentWpID;
            //Response.Redirect("~/RE/ManageWorkPackage.aspx");
            populateManageWorkPackage();
            return;
        }
        catch (Exception exception)
        {
            lblException.Text = exception.StackTrace;
        }
    }
}