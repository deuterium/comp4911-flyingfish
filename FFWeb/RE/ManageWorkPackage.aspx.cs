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
    string connectionString = ConfigurationManager.ConnectionStrings["ffconn"].ToString();
    FlyingFishClassesDataContext ff = new FlyingFishClassesDataContext();
    
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
        lblWPName2.Text = qry.First().name.ToString();
        tbDescription.Text = qry.First().description.ToString();
        var employees =
            from wp in ff.WorkPackages
            join o in ff.EmployeeWorkPackages on wp.wpId equals o.wpId
            join emp in ff.Employees on o.empId equals emp.empId
            select new { emp.empId, emp.firstName, emp.lastName };

        gvEmployees.DataSource = employees;
        gvEmployees.DataBind();

        ////////////get list of users

    }
    protected void lbAssignEmp_Click(object sender, EventArgs e)
    {
        divAssignEmp.Visible = true;
        var employees =
            from emp in ff.Employees
            select new { emp.empId, emp.firstName, emp.lastName };
        gvUnassignedEmployees.DataSource = employees;
        gvUnassignedEmployees.DataBind();
    }

    protected void gvUnassignedEmployees_SelectedIndexChanged(object sender, EventArgs e)
    {
    }

    protected void gvUnassignedEmployees_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "btnAdd")
        {
            EmployeeWorkPackage ewp = new EmployeeWorkPackage();
            ewp.projId = 1;
            ewp.wpId = Session["wpID"].ToString();
            ewp.empId = Convert.ToInt32(gvUnassignedEmployees.Rows[gvUnassignedEmployees.SelectedIndex].Cells[0].Text); ;
            ff.EmployeeWorkPackages.InsertOnSubmit(ewp);
            ff.SubmitChanges();
        }
    }

}