using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using FFLib;
using System.Configuration;

public partial class RE_ManageWorkPackage : System.Web.UI.Page
{
    bool allocClick, unallocClick, descClick = false;
    string connectionString = ConfigurationManager.ConnectionStrings["ffconn"].ToString();
    FlyingFishClassesDataContext ff = new FlyingFishClassesDataContext();

    #region Page_Load
    protected void Page_Load(object sender, EventArgs e)
    {
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
        tbDescription.Text = qry.Single().description.ToString();
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
            if (qry.ToArray().Length > 0 )
            {
                lblError.Text = "Employee is already a part of the work package.";
            }
            else
            {
                var qry2 =
                    from emp in ff.EmployeeProjects
                    where (emp.projId == ep.projId && emp.empId == ep.empId)
                    select emp;
                if(qry2.ToArray().Length == 0)
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
    protected void updategvEmployees() {
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

    #region Save Changes
    protected void btnSave_Click(object sender, EventArgs e)
    {
        /*var obj =
            (from wp in ff.WorkPackages
             where (wp.wpId == lblWPID2.Text && wp.projId == Convert.ToInt32(Session["projID"]))
             select wp).First();*/
        //WorkPackage obj = ff.WorkPackages.Where(wp => wp.wpId == Session["wpID"].ToString()).First();
        WorkPackage obj = ff.WorkPackages.Where(wp => wp.wpId == Session["wpID"].ToString()).First();
        if(unallocClick)
            obj.unallocated_dollars = Convert.ToDecimal(tbUnalloc2.Text);
        if(allocClick)
            obj.allocated_dollars = Convert.ToDecimal(tbAlloc2.Text);
        if(descClick)
            obj.description = tbDescription.Text;
        ff.SubmitChanges();
        Response.Redirect("~/RE/ManageWorkPackage.aspx");
    }
    #endregion

    #region Click events
    protected void btnAllocChange_Click(object sender, EventArgs e)
    {
        allocClick = true;
        tbAlloc2.Text = tbAlloc2.Text;
        divtbAlloc1.Visible = false;
        divtbAlloc2.Visible = true;
    }
    protected void btnUnallocChange_Click(object sender, EventArgs e)
    {
        unallocClick = true;
        tbUnalloc2.Text = tbUnalloc.Text;
        divtbUnalloc1.Visible = false;
        divtbUnalloc2.Visible = true;
    }
    protected void lbBacktoProject_Click(object sender, EventArgs e)
    {
        var obj =
            from id in ff.WorkPackages
            where id.wpId == Session["wpID"].ToString()
            select id.projId;
        Session["projID"] = obj.First().ToString();
        Response.Redirect("~/PM/ManageProject.aspx");
    }
    protected void btnDescChange_Click(object sender, EventArgs e)
    {
        descClick = true;
        tbDesc2.Text = tbDescription.Text;
        divDesc1.Visible = false;
        divDesc2.Visible = true;
    }
    #region
}