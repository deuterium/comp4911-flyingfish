using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

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

            Label1.Text = Session["CurrentDate"].ToString();


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
        Label1.Text += projId + " ";
        ddlWpId.DataSource = ff.WorkPackages.Where(p => p.projId == projId).Select(p => new
        {
            text = p.wpId,
            value = p.wpId


        });
        ddlWpId.DataValueField = "value";
        ddlWpId.DataTextField = "text";
        ddlWpId.DataBind();


    }
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
        // verifies if the user has logged in. If the
        try
        {


            var qry = (from o in ff.EmployeeMemberships
                       join emp in ff.aspnet_Users on o.userId equals emp.UserId
                       where emp.UserName == User.Identity.Name
                       select o.empId).Single();

            Session["CurEmpId"] = qry.ToString();

            System.DateTime currentDate = System.DateTime.Now;

            Session["CurrentDate"] = currentDate;

        }
        catch
        {
            Response.Redirect("~/Login.aspx");
        }
    }
}