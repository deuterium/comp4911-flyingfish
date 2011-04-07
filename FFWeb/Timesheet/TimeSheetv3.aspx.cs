using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class Timesheet_TimeSheetv3 : System.Web.UI.Page
{

    FlyingFishClassesDataContext ff = new FlyingFishClassesDataContext();

    protected void Page_Load(object sender, EventArgs e)
    {
        populategridview();

    }



    private void populategridview()
    {
        string empIdTemp = "";
        var qry = (from o in ff.EmployeeMemberships
                   join emp in ff.aspnet_Users on o.userId equals emp.UserId
                   where emp.UserName == User.Identity.Name
                   select o.empId).Single();

        Session["CurEmpId"] = qry.ToString();
        empIdTemp = qry.ToString();
        //Label1.Text += "\t" + Convert.ToString(Session["CurEmpId"]);

        System.DateTime currentDate = System.DateTime.Now;
        System.DateTime actualQryDate = currentDate;
        System.DayOfWeek dayOfWeek = currentDate.DayOfWeek;

        // trying to get the sunday of the week picked by the user
        switch (dayOfWeek.ToString())
        {
            case "Monday": actualQryDate = currentDate.AddDays(-1); break;
            case "Tuesday": actualQryDate = currentDate.AddDays(-2); break;
            case "Wednesday": actualQryDate = currentDate.AddDays(-3); break;
            case "Thursday": actualQryDate = currentDate.AddDays(-4); break;
            case "Friday": actualQryDate = currentDate.AddDays(-5); break;
            case "Saturday": actualQryDate = currentDate.AddDays(-6); break;
            default: break;
        }
        Session["CurrentDate"] = actualQryDate;

        var qry2 = from ts in ff.TimesheetEntries
                   where (ts.tsDate >= actualQryDate) && (ts.empId == Convert.ToInt32(empIdTemp))
                   select new
                   {
                       ProjID = ts.projId,
                       WpId = ts.wpId,
                       tsdate = ts.tsDate,
                       Sun = ts.sun,
                       Mon = ts.mon,
                       Tue = ts.tue,
                       Wed = ts.wed,
                       Thu = ts.thu,
                       Fri = ts.fri,
                       Sat = ts.sat,
                       Notes = ts.notes

                   };


        if (qry2.Count() == 0)
        {
            //gvStatus.DataSource = null;
            //gvStatus.DataBind();
            //lblResults.Visible = true;
            //divReportData.Visible = false;
            //return;
        }

        DataTable dt = new DataTable();
        dt.Columns.Add(new DataColumn("ProjID", typeof(System.String)));
        dt.Columns.Add(new DataColumn("WpID", typeof(System.String)));
        dt.Columns.Add(new DataColumn("Mon", typeof(System.String)));
        dt.Columns.Add(new DataColumn("Tue", typeof(System.String)));
        dt.Columns.Add(new DataColumn("Wed", typeof(System.String)));
        dt.Columns.Add(new DataColumn("Thur", typeof(System.String)));
        dt.Columns.Add(new DataColumn("Fri", typeof(System.String)));
        dt.Columns.Add(new DataColumn("Sat", typeof(System.String)));
        dt.Columns.Add(new DataColumn("Sun", typeof(System.String)));
        dt.Columns.Add(new DataColumn("Notes", typeof(System.String)));
        dt.Columns.Add(new DataColumn("Date", typeof(System.String)));


        foreach (var row in qry2)
        {
            DataRow dr = dt.NewRow();
            dr["ProjID"] = row.ProjID;
            dr["WpID"] = row.WpId;
            dr["Mon"] = row.Mon;
            dr["Tue"] = row.Tue;
            dr["Wed"] = row.Wed;
            dr["Thur"] = row.Thu;
            dr["Fri"] = row.Thu;
            dr["Sat"] = row.Sat;
            dr["Sun"] = row.Sun;
            dr["Notes"] = row.Notes;
            dr["Date"] = row.tsdate;

            dt.Rows.Add(dr);
        }

        double totMon = 0;
        double totTue = 0;
        double totWed = 0;
        double totThu = 0;
        double totFri = 0;
        double totSat = 0;
        double totSun = 0;


        for (int i = 0; i < dt.Rows.Count; i++)
        {
            var b = dt.Rows[i][2].ToString();
            totMon += Convert.ToDouble(dt.Rows[i][2].ToString());
        }

        for (int i = 0; i < dt.Rows.Count; i++)
        {
            var b = dt.Rows[i][3].ToString();
            totTue += Convert.ToDouble(dt.Rows[i][3].ToString());
        }

        for (int i = 0; i < dt.Rows.Count; i++)
        {
            var b = dt.Rows[i][4].ToString();
            totWed += Convert.ToDouble(dt.Rows[i][4].ToString());
        }
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            var b = dt.Rows[i][5].ToString();
            totThu += Convert.ToDouble(dt.Rows[i][5].ToString());
        }

        for (int i = 0; i < dt.Rows.Count; i++)
        {
            var b = dt.Rows[i][6].ToString();
            totFri += Convert.ToDouble(dt.Rows[i][6].ToString());
        }

        for (int i = 0; i < dt.Rows.Count; i++)
        {
            var b = dt.Rows[i][7].ToString();
            totSat += Convert.ToDouble(dt.Rows[i][7].ToString());
        }

        for (int i = 0; i < dt.Rows.Count; i++)
        {
            var b = dt.Rows[i][8].ToString();
            totSun += Convert.ToDouble(dt.Rows[i][8].ToString());
        }





        // add the total row
        DataRow totalRow = dt.NewRow();
        totalRow["ProjID"] = "Total";
        totalRow["Mon"] = totMon;
        totalRow["Tue"] = totThu;
        totalRow["wed"] = totWed;
        totalRow["Thur"] = totThu;
        totalRow["Fri"] = totFri;
        totalRow["Sat"] = totSat;
        totalRow["Sun"] = totSun;

        dt.Rows.Add(totalRow);

        dvTimeSheet.DataSource = dt;
        dvTimeSheet.DataBind();
    }

    protected void dvTimeSheet_RowEditing(object sender, GridViewEditEventArgs e)
    {
        //stackoverflow.com/questions/2429864/gridviews-newvalues-and-oldvalues-empty-in-the-onrowupdating-event
        GridView gv = (GridView)sender;
        gv.EditIndex = e.NewEditIndex;
        gv.DataBind();

        // Set the row's index to the event's edit index
        dvTimeSheet.EditIndex = e.NewEditIndex;

        // Redraw the grid view (you can call a method that queries the db and sets/binds the data source)
        // This shows the edit templates (e.g. the Textboxes for input)
        populategridview();
    }

    // DO NOT MAKE A CUSTOM UPDATED FUNCTION! ONLY AN UPDATING FUNCTION!

    protected void dvTimeSheet_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {

        
      
        //GridView gv = (GridView)sender;
        //for (int i = 0; i < dvTimeSheet.Columns.Count; i++)
        //{
        //    DataControlFieldCell cell = gv.Rows[e.RowIndex].Cells[i] as DataControlFieldCell;
        //    gv.Columns[i].ExtractValuesFromCell(e.NewValues, cell, DataControlRowState.Edit, true);
        //}
        
        //// Get row being updated
        GridViewRow row = dvTimeSheet.Rows[e.RowIndex];
        Object tmp1 = e.NewValues["Mon"];

       // String strEmployee0 = (((Label)row.Cells[3].Controls[1]).Text);
        //String strEmployee1 = (((Label)row.Cells[4].Controls[1]).Text);
        String strEmployee2 = (((Label)row.Cells[3].Controls[0]).Text);
        String strEmployee3 = (((Label)row.Cells[3].Controls[1]).Text);


        Object tmp2 = e.OldValues["Mon"];
        string ProjID = e.OldValues["ProjID "].ToString();
        string WPID = e.OldValues["WpID"].ToString();
        DateTime Date = Convert.ToDateTime(row.Cells[10].Controls[1].ToString());
        // Another method to get the other, non-editable values
        String strEmployee = (((Label)row.Cells[0].Controls[1]).Text);

        // Get new values
        String strEtc = e.NewValues["Active"].ToString();

        var qryUpdate = (from tse in ff.TimesheetEntries
                         where (tse.projId == Convert.ToInt32(ProjID)) &&
                         (tse.wpId.Equals(WPID)) &&
                         (tse.tsDate == Date) &&
                         (tse.empId == Convert.ToInt32(Session["CurEmpId"]))
                         select tse).FirstOrDefault();
        string NewSat = "";
        string NewSun = "";
        string NewMon = "";
        string NewTue = "";
        string NewWed = "";
        string NewThur = "";
        string NewFri = "";

        //  qryUpdate.sat = newSat;

        /*
         * 
         * 
         * insert new values into db
         * 
         * 
         */

        // Reset the edit index (so no columns are being edited)
        //   dvTimeSheet.EditIndex = -1;

        // Cancel the edit event to return grid view to normal
        e.Cancel = true;

        // Redraw the grid view (you can call a method that queries the db and sets/binds the data source)
        populategridview();

    }

    protected void dvTimeSheet_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        // Reset the edit index (so no columns are being edited)
        dvTimeSheet.EditIndex = -1;

        // Redraw the grid view (you can call a method that queries the db and sets/binds the data source)
        populategridview();
    }

    // Not sure I used this one...
    protected void dvTimeSheet_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        // Redraw the grid view (you can call a method that queries the db and sets/binds the data source)
      //  populategridview();
    }
}