using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class Timesheet_TimesheetEntry : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        CreateSessionVars();
        if (!IsPostBack)
        {
            divNewRecord.Visible = false;
        }
        renderLabels();
        addTotalRow();

    }

    private void addTotalRow()
    {
        FlyingFishClassesDataContext ff = new FlyingFishClassesDataContext();
        DateTime CurrentDate = Convert.ToDateTime(Session["CurrentDate"].ToString());
        int empIdTemp  = Convert.ToInt32(Session["CurEmpId"].ToString());

        var qry2 = from ts in ff.TimesheetEntries
                   where (ts.tsDate >= CurrentDate) && (ts.empId == Convert.ToInt32(empIdTemp))
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
        dt.Columns.Add(new DataColumn("Sat", typeof(System.String)));
        dt.Columns.Add(new DataColumn("Sun", typeof(System.String)));
        dt.Columns.Add(new DataColumn("Mon", typeof(System.String)));
        dt.Columns.Add(new DataColumn("Tue", typeof(System.String)));
        dt.Columns.Add(new DataColumn("Wed", typeof(System.String)));
        dt.Columns.Add(new DataColumn("Thur", typeof(System.String)));
        dt.Columns.Add(new DataColumn("Fri", typeof(System.String)));

       // dt.Columns.Add(new DataColumn("Notes", typeof(System.String)));
        


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
            //dr["Notes"] = row.Notes;
            

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
            var b = dt.Rows[i][4].ToString();
            totMon += Convert.ToDouble(dt.Rows[i][4].ToString());
        }

        for (int i = 0; i < dt.Rows.Count; i++)
        {
            var b = dt.Rows[i][5].ToString();
            totTue += Convert.ToDouble(dt.Rows[i][5].ToString());
        }

        for (int i = 0; i < dt.Rows.Count; i++)
        {
            var b = dt.Rows[i][6].ToString();
            totWed += Convert.ToDouble(dt.Rows[i][6].ToString());
        }
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            var b = dt.Rows[i][7].ToString();
            totThu += Convert.ToDouble(dt.Rows[i][7].ToString());
        }

        for (int i = 0; i < dt.Rows.Count; i++)
        {
            var b = dt.Rows[i][8].ToString();
            totFri += Convert.ToDouble(dt.Rows[i][8].ToString());
        }

        for (int i = 0; i < dt.Rows.Count; i++)
        {
            var b = dt.Rows[i][2].ToString();
            totSat += Convert.ToDouble(dt.Rows[i][2].ToString());
        }

        for (int i = 0; i < dt.Rows.Count; i++)
        {
            var b = dt.Rows[i][3].ToString();
            totSun += Convert.ToDouble(dt.Rows[i][3].ToString());
        }



        dt.Clear();

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

        gvTotals.DataSource = dt;
        gvTotals.DataBind();
       
    }

    private void renderLabels()
    {

        lbDate.Text = Session["CurrentDate"].ToString();
        lbEmpNo.Text = Session["CurEmpId"].ToString();
     
    }

    private void CreateSessionVars()
    {
        FlyingFishClassesDataContext ff = new FlyingFishClassesDataContext();

        try
        {
            var qry = (from o in ff.EmployeeMemberships
                       join emp in ff.aspnet_Users on o.userId equals emp.UserId
                       where emp.UserName == User.Identity.Name
                       select o.empId).Single();

            Session["CurEmpId"] = qry.ToString();
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

          


        }
        catch
        {
            Response.Redirect("~/Login.aspx");
        }
    }


    protected void btnNewRecord_Click(object sender, EventArgs e)
    {
        divNewRecord.Visible = true;
       
        populateDdl();
    }

    //-------------------------------------------------------------------------
    protected void btnCreateNewRecord_Click(object sender, EventArgs e)
    {
        FlyingFishClassesDataContext ff = new FlyingFishClassesDataContext();
        try
        {
            var qry = (from emp in ff.Employees
                       where emp.empId == Convert.ToInt32(Session["CurEmpId"])
                       select emp.approver).FirstOrDefault();


            TimesheetHeader tmp = new TimesheetHeader()
            {

                tsDate = Convert.ToDateTime(Session["CurrentDate"]),
                empId = Convert.ToInt32(Session["CurEmpId"]),
                status = "SAVED",
                approvedBy = qry,
                comments = "Comments"

            };


            var qry2 = (from th in ff.TimesheetHeaders
                        where th.empId == tmp.empId && th.tsDate == tmp.tsDate
                        select th).ToList();

            if (qry2.Count == 0)
            {
                ff.TimesheetHeaders.InsertOnSubmit(tmp);
                ff.SubmitChanges();
            }

            TimesheetEntry tmp2 = new TimesheetEntry()
            {
                tsDate = Convert.ToDateTime(Session["CurrentDate"]),
                empId = Convert.ToInt32(Session["CurEmpId"]),
                projId = Convert.ToInt32(ddlProjectId.SelectedValue),
                wpId = (ddlWpId.SelectedValue).ToString(),
                sun = Convert.ToInt32(tbSun.Text),
                sat = Convert.ToInt32(tbSat.Text),
                fri = Convert.ToInt32(tbFri.Text),
                thu = Convert.ToInt32(tbThu.Text),
                wed = Convert.ToInt32(tbWed.Text),
                tue = Convert.ToInt32(tbTue.Text),
                mon = Convert.ToInt32(tbMon.Text),
                notes = tbNote.Text

            };

            ff.TimesheetEntries.InsertOnSubmit(tmp2);
            ff.SubmitChanges();

            Label1.Text = "Sumbit has been saved.";
            divNewRecord.Visible = false;
            tbFri.Text = String.Empty;
            tbMon.Text = String.Empty;
            tbNote.Text = String.Empty;
            //tbProjectID.Text = String.Empty;
            tbSat.Text = String.Empty;
            tbSun.Text = String.Empty;
            tbThu.Text = String.Empty;
            tbTue.Text = String.Empty;
            tbWed.Text = String.Empty;
            //tbWpID.Text = String.Empty;

        }
        catch (Exception myException)
        {
            Label1.Text = myException.Message;
            // Label1.Text = "You have sumbitted the record before, Cannot insert duplicate record into the database!!!";

        }


    }
    protected void ddlProjectId_SelectedIndexChanged(object sender, EventArgs e)
    {
        FlyingFishClassesDataContext ff = new FlyingFishClassesDataContext();
        int projId = Convert.ToInt32(ddlProjectId.SelectedValue);
       
        ddlWpId.DataSource = ff.WorkPackages.Where(p => p.projId == projId).Select(p => new
        {
            text = p.wpId,
            value = p.wpId


        });
        ddlWpId.DataValueField = "value";
        ddlWpId.DataTextField = "text";
        ddlWpId.DataBind();


    }
    /// <summary>
    /// populates the drop down list 
    /// </summary>
    /// Note the session used be created here 
    private void populateDdl()
    {
        FlyingFishClassesDataContext ff = new FlyingFishClassesDataContext();
        ddlProjectId.DataSource = ff.Projects.Select(p => new
        {
            ProjID = p.projId,
            ProjectName = (p.projName + " (") + p.projId + ")"
        });
        ddlProjectId.DataValueField = "ProjId";
        ddlProjectId.DataTextField = "ProjectName";
        ddlProjectId.DataBind();

    }
}