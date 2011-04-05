using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using FFLib;

public partial class Reports_CustomGridView_Sample : System.Web.UI.Page
{
    // Make sure you use the SAME data context for ALL your quries
    FlyingFishClassesDataContext ffdb = new FlyingFishClassesDataContext();

    protected void Page_Load(object sender, EventArgs e)
    {
        populateGridView();
    }

    private void populateGridView() {
        
        // get qry
        var qry = from emp in ffdb.Employees
                  select new {
                      empNameNumber = emp.firstName + " " + emp.lastName + " (" + emp.empId + ")",
                      active = emp.isActive
                  };
        
        // make data table to become grid view's data source
        DataTable dt = new DataTable();
        dt.Columns.Add(new DataColumn("EmpNameNumber", typeof(System.String)));
        dt.Columns.Add(new DataColumn("Active", typeof(System.String)));
        
        // go through qry results, 1 result at a time
        foreach (var result in qry) {
            // add new row for every result
            DataRow dr = dt.NewRow();
            dr["EmpNameNumber"] = result.empNameNumber;
            dr["Active"] = result.active.ToString() + " (1 for active, 0 for inactive)";
            dt.Rows.Add(dr);
        }

        // Add a new row (not related to qry for totals or something)
        DataRow lastRow = dt.NewRow();
        lastRow["EmpNameNumber"] = "Last row, not from db";
        lastRow["Active"] = "Put totals here";
        
        gvStatus.DataSource = dt;
        gvStatus.DataBind();
    }

    protected void gvStatus_RowEditing(object sender, GridViewEditEventArgs e) {
        // Set the row's index to the event's edit index
        gvStatus.EditIndex = e.NewEditIndex;
        
        // Redraw the grid view (you can call a method that queries the db and sets/binds the data source)
        // This shows the edit templates (e.g. the Textboxes for input)
        populateGridView();
    }

    // DO NOT MAKE A CUSTOM UPDATED FUNCTION! ONLY AN UPDATING FUNCTION!

    protected void gvStatus_RowUpdating(object sender, GridViewUpdateEventArgs e) {
        // Get row being updated
        GridViewRow row = gvStatus.Rows[e.RowIndex];
        
        // Get old values (not sure this works so well so the labels)
        Object oldEtc = e.OldValues["Active"].ToString();

        // Another method to get the other, non-editable values
        String strEmployee = (((Label)row.Cells[0].Controls[1]).Text);
        
        // Get new values
        String strEtc = e.NewValues["Active"].ToString();
        
        /*
         * 
         * 
         * insert new values into db
         * 
         * 
         */
        
        // Reset the edit index (so no columns are being edited)
        gvStatus.EditIndex = -1;

        // Cancel the edit event to return grid view to normal
        e.Cancel = true;

        // Redraw the grid view (you can call a method that queries the db and sets/binds the data source)
        populateGridView();

    }

    protected void gvStatus_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e) {
        // Reset the edit index (so no columns are being edited)
        gvStatus.EditIndex = -1;
        
        // Redraw the grid view (you can call a method that queries the db and sets/binds the data source)
        populateGridView();
    }

    // Not sure I used this one...
    protected void gvStatus_RowCommand(object sender, GridViewCommandEventArgs e) {
        // Redraw the grid view (you can call a method that queries the db and sets/binds the data source)
        populateGridView();
    }
}