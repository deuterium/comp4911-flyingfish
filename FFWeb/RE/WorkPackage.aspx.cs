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
        if (ff.WorkPackages.Where(te => te.wpId == tbwpID.Text).ToArray().Length > 0) 
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
            wp.projId = Convert.ToInt32(Session["projID"]);
            ff.WorkPackages.InsertOnSubmit(wp);
            ff.SubmitChanges();

            divCreateWorkPackage.Visible = false;
            divCreateSuccess.Visible = true;
        }
    }
    protected void btnCreate_Click(object sender, EventArgs e)
    {
        Session["wpID"] = tbwpID.Text;
        //loadManageWorkPackage();
        //divManageWorkPackage.Visible = true;
        Response.Redirect("~/RE/ManageWorkPackage.aspx");
    }
   /*#region MANAGING WORK PACKAGE
    /// <summary>
    /// MANAGING WORK PACKAGE
    /// </summary>
    #region "pageload" for Manage Workpackage"
    protected void loadManageWorkPackage()
    {
        divCreateSuccess.Visible = false;
        divCreateWorkPackage.Visible = false;
       
        lblWPID2.Text = Session["wpID"].ToString();

        var qry =
                from wp in ff.WorkPackages
                where (
                    wp.wpId == lblWPID2.Text
                )
                select new { wp.allocated_dollars, wp.unallocated_dollars, wp.name, wp.description };

        tbAlloc.Text = qry.First().allocated_dollars.ToString();
        tbUnalloc.Text = qry.First().unallocated_dollars.ToString();
        lblWPName2.Text = qry.Single().name.ToString();
        tbMDescription.Text = qry.Single().description.ToString();
        updategvEmployees();
        lblError.Text = "";
    }
    #endregion

    #region Assign Employee linkbutton event handler
    protected void lbAssignEmp_Click(object sender, EventArgs e)
    {
        divAssignEmp.Visible = true;
        var employees =
            from emp in ff.Employees
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
            }
        }
    }
    #endregion

    #region Updating the assigned employees gridview
    protected void updategvEmployees()
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
    #endregion
   #endregion
    * */
}