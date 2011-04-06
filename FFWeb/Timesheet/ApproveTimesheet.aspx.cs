﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Timesheet_ApproveTimesheet : System.Web.UI.Page
{
    
    FlyingFishClassesDataContext ff = new FlyingFishClassesDataContext();
    protected void Page_Load(object sender, EventArgs e)
    {


        field.Visible = false;
        DropDownList1.Visible = false;
        btnSubmit.Visible = false;
        GridView2.Visible = false;

        if (!User.IsInRole("TimesheetApprover"))
        {
            Response.Redirect("~/Login.aspx");
        }

        if (!IsPostBack)
        {
            populateGridView();
            GridView1.DataBind(); 
        }
        
        
    }

    protected void populateGridView()
    {
        var qry = from th in ff.TimesheetHeaders
                  join tse in ff.TimesheetEntries on new { th.tsDate, th.empId } equals new { tse.tsDate, tse.empId }
                  where th.status != "APPROVED"
                  select new
                  {
                      EmpID = th.empId,
                      Date = th.tsDate,
                      Project = tse.projId,
                      WorkPackage = tse.wpId,
                      Mon = tse.mon,
                      Tue = tse.tue,
                      Wed = tse.wed,
                      Thu = tse.thu,
                      Fri = tse.fri,
                      Sat = tse.sat,
                      Sun = tse.sun,
                      Note = tse.notes,
                      Status = th.status,
                      Comments = th.comments
                  };
        GridView1.DataSource = qry;
        GridView1.DataBind();
    }


    protected void btnSubmit_Click(object sender, EventArgs e)
    {

        var selectedStatus = (from th in ff.TimesheetHeaders
                              join tse in ff.TimesheetEntries on new { th.tsDate, th.empId } equals new { tse.tsDate, tse.empId }
                              where th.empId == Convert.ToInt32(ViewState["empId"]) && th.tsDate == Convert.ToDateTime(ViewState["date"]) &&
                                    tse.wpId == Convert.ToString(ViewState["wp"]) && tse.projId == Convert.ToInt32(ViewState["proj"])
                              select th).Single();

        
        if (DropDownList1.SelectedValue == "Approve")
        {
            selectedStatus.status = "APPROVED";

        }
        else
        {
            selectedStatus.status = "REJECTED";
            selectedStatus.comments = tbComments.Text;
        }



        ff.SubmitChanges();

        field.Visible = false;
        DropDownList1.Visible = false;
        btnSubmit.Visible = false;
        GridView2.Visible = false;
        GridView1.Visible = true;

        populateGridView();
  
    }
    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {

        field.Visible = true;
        DropDownList1.Visible = true;
        btnSubmit.Visible = true;
        GridView2.Visible = true;

        ViewState["empId"] = GridView1.SelectedRow.Cells[1].Text;
        ViewState["date"] = GridView1.SelectedRow.Cells[2].Text;
        ViewState["proj"] = GridView1.SelectedRow.Cells[3].Text;
        ViewState["wp"] = GridView1.SelectedRow.Cells[4].Text;

        //Label1.Text = GridView1.SelectedRow.Cells[1].Text + GridView1.SelectedRow.Cells[2].Text + GridView1.SelectedRow.Cells[3].Text + GridView1.SelectedRow.Cells[4].Text; ;

        string empId = GridView1.SelectedRow.Cells[1].Text;
        DateTime date = Convert.ToDateTime(GridView1.SelectedRow.Cells[2].Text);
        string proj = GridView1.SelectedRow.Cells[3].Text;
        string wp = GridView1.SelectedRow.Cells[4].Text;

        var qry = from t in ff.TimesheetEntries
                  where t.empId.Equals(empId) && t.tsDate.Equals(date) && t.projId == Convert.ToInt32(proj) && t.wpId.Equals(wp)
                  select t;
        GridView2.DataSource = qry;
        GridView2.DataBind();

        GridView1.Visible = false;
    }
}