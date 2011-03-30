using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using FFLib;

public partial class Timesheet_ApproveTimesheet : System.Web.UI.Page
{
    
    FlyingFishClassesDataContext ff = new FlyingFishClassesDataContext();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!User.IsInRole("TimesheetApprover"))
        {
            Response.Redirect("~/Login.aspx");
        }

        if (!IsPostBack)
        {
            GridView1.DataBind(); 
        }
        
        
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        GridViewRow selectedRow = GridView1.SelectedRow;
        
        int selectedEmpId = Convert.ToInt16(GridView1.SelectedValue.ToString());
        DateTime date = Convert.ToDateTime(selectedRow.Cells[2].Text);
        
       
        var selectedStatus = (from c in ff.TimesheetHeaders
                              where c.empId == selectedEmpId && c.tsDate == date
                              select c).Single();
        
        if (DropDownList1.SelectedValue == "Approve")
        {
            selectedStatus.status = "APPROVED";

        }
        else
        {
            selectedStatus.status = "REJECTED";
        }

        ff.SubmitChanges();
  
    }
}