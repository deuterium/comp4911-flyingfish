using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Text.RegularExpressions;
using System.Drawing;

/* TO DO:
 * Calculate PDays and PDollars
 * Turns hours into Days
 * Create functionality
 * Improve look/layout
 * Restrict project choices to all projects (for HR) and only projects you manage (PMs)
 * Documentation
 * Validation with better user messages
 */


/// <summary>
/// Business logic (code behind) for the Work Package Status Report page.
/// </summary>
public partial class Reports_WorkPackageStatusReport : System.Web.UI.Page {

    /// <summary>
    /// The datacontext, contains all the classes created from the database.
    /// </summary>
    private FlyingFishClassesDataContext ffdb = new FlyingFishClassesDataContext();
    /// <summary>
    /// The filler for unknown columns.
    /// </summary>
    public const String UnknownValue = "Unknown";

    public static Color FailColour = Color.Red;
    public static Color SuccessColour = Color.Green;

    public const Decimal HoursPerWorkDay = 8;
    // format for 2 decimal places
    public const String decimalFormat = "{0:0.0}";
    public const String currencyFormat = "{0:C}";
    public const String percentFormat = decimalFormat + "%";

    private List<EmployeeWorkPackageETC> allEmployeeWpETCs = new List<EmployeeWorkPackageETC>();

    /// <summary>
    /// What to do when the page first loads. Dynamically populates the drop down lists from the database.
    /// </summary>
    /// <param name="sender">The object that requested the page load.</param>
    /// <param name="e">The page load event.</param>
    protected void Page_Load(object sender, EventArgs e) {
        if (!IsPostBack) {
            populateProjects();
            populateWorkpackages();
            tbCutOffDate.Text = DateTime.Now.ToString("yyyy/MM/dd");
            btnSave.Visible = true;
        }
    }

    /// <summary>
    /// Populates the Projects drop down list.
    /// If a PM visits this page, he or she only sees the projects he or she is working on.
    /// If a RE visits this page, he or she only sees the projects he or she is working as an RE on.
    /// </summary>
    private void populateProjects() {
        Employee user = getUser();

        // Get all projects where this employee is a manager or a responsible engineer
        if (User.IsInRole("ProjectManager") || User.IsInRole("ResponsibleEngineer")) {
            var qry = (from wp in ffdb.WorkPackages
                      join p in ffdb.Projects on wp.projId equals p.projId
                      join wpre in ffdb.WorkPackageResponsibleEngineers on (wp.projId + wp.wpId) equals (wpre.projId + wpre.wpId)
                      where (wpre.responsibleEngineer == user.empId) || (p.manager == user.empId)
                      select new {
                          ProjID = p.projId,
                          ProjectName = p.projName + " (" + p.projId + ")"
                      }).Distinct();
            ddlAllProjects.DataSource = qry;
            ddlAllProjects.DataValueField = "ProjID";
            ddlAllProjects.DataTextField = "ProjectName";
            ddlAllProjects.DataBind();
        } else {
            Response.Redirect("~/Login.aspx");
        }
    }

    private Employee getUser() {
        if (!(User.IsInRole("ProjectManager") || User.IsInRole("ResponsibleEngineer"))) {
            return null;
        }
        String[] tokens = Regex.Split(User.Identity.Name, "_");
        String firstName = tokens[0];
        String lastName = tokens[1];
        Employee e = (from emp in ffdb.Employees
                      where (String.Compare(firstName, emp.firstName, true) == 0)
                         && (String.Compare(lastName, emp.lastName, true) == 0)
                      select emp).FirstOrDefault();

        return e;
    }

    /// <summary>
    /// Populates the WorkPackages drop down list.
    /// If a PM visits the page, shows all WPs.
    /// If an RE visits the page, shows only the WPs he or she is an RE for.
    /// </summary>
    private void populateWorkpackages() {
        Employee user = getUser();

        // Get all projects where this employee is a manager or a responsible engineer
        if (User.IsInRole("ProjectManager") || User.IsInRole("ResponsibleEngineer")) {
            var qry = (from wp in ffdb.WorkPackages
                      join p in ffdb.Projects on wp.projId equals p.projId
                      join wpre in ffdb.WorkPackageResponsibleEngineers on (wp.projId + wp.wpId) equals (wpre.projId + wpre.wpId)
                      where (wpre.responsibleEngineer == user.empId) || (p.manager == user.empId)
                      select new {
                           WpID = wp.wpId,
                           WpName = wp.name + " (" + wp.wpId + ")"
                      }).Distinct();
            ddlWorkpackages.DataSource = qry;
            ddlWorkpackages.DataValueField = "WpID";
            ddlWorkpackages.DataTextField = "WpName";
            ddlWorkpackages.DataBind();

        } else {
            Response.Redirect("~/Login.aspx");
        }
    }

    /// <summary>
    /// Called when a project is selected.
    /// Loads the WorkPackage list for that project.
    /// Filters the list based on who is logged in (their role).
    /// </summary>
    /// <param name="sender">The object that triggered the event.</param>
    /// <param name="e">The event.</param>
    protected void ddlAllProjects_SelectedIndexChanged(object sender, EventArgs e) {
        populateWorkpackages();
    }

    protected void cuvEacAcwp_ServerValidate(object source, ServerValidateEventArgs args) {
        GridViewRow row = gvStatus.Rows[gvStatus.EditIndex];
        TextBox tbEac = (TextBox)row.FindControl("tbEac");
        Label lblAcwp = (Label)row.Cells[1].Controls[1];
        String strEac = tbEac.Text;
        String strAcwp = lblAcwp.Text;
        decimal eac = 0;
        decimal acwp = 0;

        if (strEac.Equals(String.Empty) || strEac.Equals(UnknownValue)) {
            args.IsValid = false;
            return;
        }
        
        eac = Convert.ToDecimal(eac);
        
        if (strAcwp.Equals(String.Empty) || strAcwp.Equals(UnknownValue)) {
            args.IsValid = false;
            return;
        }

        acwp = Convert.ToDecimal(acwp);

        if (eac >= acwp) {
            args.IsValid = true;
        }
    }

    protected void cuvUnknownValue_ServerValidate(object source, ServerValidateEventArgs args) {
        GridViewRow row = gvStatus.Rows[gvStatus.EditIndex];
        TextBox tbEac = (TextBox)row.FindControl("tbEac");
        TextBox tbEtc = (TextBox)row.FindControl("tbEtc");
        String strEac = tbEac.Text;
        String strEtc = tbEtc.Text;

        args.IsValid = true;

        if ((strEac.Equals(UnknownValue) || strEac.Equals(String.Empty))
                && (strEtc.Equals(UnknownValue) || strEtc.Equals(String.Empty))) {
            args.IsValid = false;
        }
    }

    /// <summary>
    /// Populates the GridView.
    /// Calculates two sets of data for each employee on the selected WorkPackage (the days and the dollars).
    /// </summary>
    public void GetWorkPackageStatusReport() {
        // Store the ACWP for each employee
        List<KeyValuePair<int, decimal>> acwpForAll = getAcwpForAll();
        // Store the ETC for each employee
        allEmployeeWpETCs = getEtcForAll();

        SetResults(String.Empty, false, SuccessColour);

        // Get the WP's responsible engineer
        Employee respEng = (Employee)
                           (from re in ffdb.WorkPackageResponsibleEngineers
                            join e in ffdb.Employees on re.responsibleEngineer equals e.empId
                            where (re.projId == Convert.ToInt32(ViewState["projId"]))
                                && re.wpId.Equals(ViewState["wpId"])
                            select e).FirstOrDefault();

        // Get the Project's project manager
        var projMan = (Employee)
                      (from pm in ffdb.Projects
                       join e in ffdb.Employees on pm.manager equals e.empId
                       where (pm.projId == Convert.ToInt32(ViewState["projId"]))
                       select e).FirstOrDefault();

        // Get the data for each employee who's worked on the timesheet at some point
        var qry = (from tse in ffdb.TimesheetEntries
                   join e in ffdb.Employees on tse.empId equals e.empId
                   where (tse.projId == Convert.ToInt32(ViewState["projId"]))
                           && (tse.wpId.Equals(ViewState["wpId"]))
                   select new {
                       e.firstName,
                       e.lastName,
                       e.empId,
                       ACWP = getAcwpForEmployee(tse.empId, acwpForAll),
                       ETC = getEtcForEmployee(tse.empId, allEmployeeWpETCs)
                   }).Distinct();

        if (qry.Count() == 0) {
            SetResults("No employees are assigned to this workpackage.", false, FailColour);
        }

        // Format the data for the Grid View
        DataTable dt = new DataTable();
        dt.Columns.Add(new DataColumn("Employee", typeof(System.String)));
        dt.Columns.Add(new DataColumn("ACWP", typeof(System.String)));
        dt.Columns.Add(new DataColumn("ETC", typeof(System.String)));
        dt.Columns.Add(new DataColumn("EAC", typeof(System.String)));
        dt.Columns.Add(new DataColumn("PercentComplete", typeof(System.String)));

        // Generate rows for each employee
        foreach (var employee in qry) {
            // Employee
            DataRow drEmployee = dt.NewRow();
            drEmployee["Employee"] = employee.firstName + " " + employee.lastName + " (" + employee.empId + ")";
            dt.Rows.Add(drEmployee);
            // P-Days
            DataRow drDays = dt.NewRow();
            drDays["Employee"] = "Days:";
            drDays["ACWP"] = employee.ACWP;
            drDays["ETC"] = employee.ETC;
            drDays["EAC"] = calculateEac(employee.ACWP.ToString(), employee.ETC.ToString(), "{0:0.0}");
            drDays["PercentComplete"] = getPercentComplete(employee.ACWP, drDays["EAC"].ToString());
            dt.Rows.Add(drDays);
            // P-Dollars
            DataRow drDollars = dt.NewRow();
            drDollars["Employee"] = "Dollars:";
            drDollars["ACWP"] = getAcwpDollars(employee.empId);
            drDollars["ETC"] = calculatePDollars(employee.ETC.ToString(), getMaxPLvl(employee.empId).ToString());
            drDollars["EAC"] = calculateEac(drDollars["ACWP"].ToString(), drDollars["ETC"].ToString(), "{0:C}");
            drDollars["PercentComplete"] = getPercentComplete(drDollars["ACWP"].ToString(), drDollars["EAC"].ToString());
            dt.Rows.Add(drDollars);
        }

        decimal totalAcwpDays = 0;
        decimal totalEtcDays = 0;
        decimal totalEacDays = 0;
        decimal totalPercentCompleteDays = 0;

        decimal totalAcwpDollars = 0;
        decimal totalEtcDollars = 0;
        decimal totalEacDollars = 0;
        decimal totalPercentCompleteDollars = 0;

        int temp = gvStatus.Rows.Count;

        for (int i = 2; i <= dt.Rows.Count; ) {
            String acwp = dt.Rows[i - 1][1].ToString();
            String etc = dt.Rows[i - 1][2].ToString();
            String eac = dt.Rows[i - 1][3].ToString();
            String pc = dt.Rows[i - 1][4].ToString();

            if (!(acwp.Equals(String.Empty) || acwp.Equals(UnknownValue))) {
                totalAcwpDays += Convert.ToDecimal(acwp);
            }
            if (!(etc.Equals(String.Empty) || etc.Equals(UnknownValue))) {
                totalEtcDays += Convert.ToDecimal(etc);
            }
            if (!(eac.Equals(String.Empty) || eac.Equals(UnknownValue))) {
                totalEacDays += Convert.ToDecimal(eac);
            }
            if (!(pc.Equals(String.Empty) || pc.Equals(UnknownValue))) {
                totalPercentCompleteDays += Convert.ToDecimal(stripFormatting(pc));
            }

            acwp = dt.Rows[i][1].ToString();
            etc = dt.Rows[i][2].ToString();
            eac = dt.Rows[i][3].ToString();
            pc = dt.Rows[i][4].ToString();

            if (!(acwp.Equals(String.Empty) || acwp.Equals(UnknownValue))) {
                totalAcwpDollars += Convert.ToDecimal(stripFormatting(acwp));
            }
            if (!(etc.Equals(String.Empty) || etc.Equals(UnknownValue))) {
                totalEtcDollars += Convert.ToDecimal(stripFormatting(etc));
            }
            if (!(eac.Equals(String.Empty) || eac.Equals(UnknownValue))) {
                totalEacDollars += Convert.ToDecimal(stripFormatting(eac));
            }
            if (!(pc.Equals(String.Empty) || pc.Equals(UnknownValue))) {
                totalPercentCompleteDollars += Convert.ToDecimal(stripFormatting(pc));
            }

            i += 3;
        }

        if (dt.Rows.Count > 0) {
            totalPercentCompleteDays = totalPercentCompleteDays / dt.Rows.Count;
            totalPercentCompleteDollars = totalPercentCompleteDollars / dt.Rows.Count;
        } else {
            totalPercentCompleteDays = 0;
            totalPercentCompleteDollars = 0;
        }

        DataRow drTotalHeader = dt.NewRow();
        drTotalHeader["Employee"] = "Total";
        dt.Rows.Add(drTotalHeader);

        // P-Days
        DataRow drTotalDays = dt.NewRow();
        drTotalDays["Employee"] = "Days:";
        drTotalDays["ACWP"] = String.Format(decimalFormat, totalAcwpDays);
        drTotalDays["ETC"] = String.Format(decimalFormat, totalEtcDays);
        drTotalDays["EAC"] = String.Format(decimalFormat, totalEacDays);
        drTotalDays["PercentComplete"] = String.Format(percentFormat, totalPercentCompleteDays);
        dt.Rows.Add(drTotalDays);

        // P-Dollars
        DataRow drTotalDollars = dt.NewRow();
        drTotalDollars["Employee"] = "Dollars:";
        drTotalDollars["ACWP"] = String.Format(currencyFormat, totalAcwpDollars);
        drTotalDollars["ETC"] = String.Format(currencyFormat, totalEtcDollars);
        drTotalDollars["EAC"] = String.Format(currencyFormat, totalEacDollars);
        drTotalDollars["PercentComplete"] = String.Format(percentFormat, totalPercentCompleteDollars);
        dt.Rows.Add(drTotalDollars);

        // Populate the Grid View with the formatted data
        gvStatus.DataSource = dt;
        gvStatus.DataBind();

        // Customize the views
        for (int i = 1; i <= gvStatus.Rows.Count; ) {
            gvStatus.Rows[i - 1].Cells[1].Visible = false;
            gvStatus.Rows[i - 1].Cells[2].Visible = false;
            gvStatus.Rows[i - 1].Cells[3].Visible = false;
            gvStatus.Rows[i - 1].Cells[4].Visible = false;

            gvStatus.Rows[i - 1].Cells[5].Text = String.Empty;
            gvStatus.Rows[i - 1].Cells[5].Enabled = false;

            gvStatus.Rows[i - 1].Cells[0].ColumnSpan = 5;

            gvStatus.Rows[i + 1].Cells[5].Text = String.Empty;
            gvStatus.Rows[i + 1].Cells[5].Enabled = false;

            i += 3; // skip 3 rows
        }
               
        // Populate the Report Details
        lblProject.Text = ViewState["Project"].ToString();
        lblWp.Text = ViewState["WorkPackage"].ToString();
        lblRe.Text = respEng.firstName + " " + respEng.lastName + " (" + respEng.empId + ")";
        lblPm.Text = projMan.firstName + " " + projMan.lastName + " (" + projMan.empId + ")";
        lblReportPeriod.Text = ((DateTime)ViewState["cutOffDate"]).ToString("yyyy/MM/dd");
        lblPmBac.Text = String.Format("{0:C}", this.getPMBudget());

        // Get most recent RE budget for this workpackage.
        lblReBac.Text = getResponsibleEngineerBudget();
        
        // Get the WorkPackageStatusReport details
        WorkPackageStatusReport wpsr = getExistingReportDetails();

        // Create empty WorkPackageStatusReport
        if (wpsr == null) {
            tbComments.Text = "";
            tbWorkAccomplished.Text = "";
            tbWorkPlannedNext.Text = "";
            tbProblemsEncountered.Text = "";
            tbProblemsAncticipatedNext.Text = "";
            SetResults("This report does not exist. Creating a blank report for you.\n", true, SuccessColour);
        }
        // Populate WorkPackageStatusReport details
        else {
            tbComments.Text = wpsr.comments;
            tbWorkAccomplished.Text = wpsr.workAccomplished;
            tbWorkPlannedNext.Text = wpsr.workPlannedNext;
            tbProblemsEncountered.Text = wpsr.problemsEncountered;
            tbProblemsAncticipatedNext.Text = wpsr.problemsAnticipated;
        }

        // Show the report
        divReportData.Visible = true;
        btnSave.Visible = true;
    }

    // NOT TESTED
    private String getResponsibleEngineerBudget() {
        decimal totalDays = 0;

        var reBudget = from ree in ffdb.WorkPackageEstimateREs
                       join p in ffdb.PersonLevels on (ree.pLevel + ree.fiscalYear) equals (p.pLevel + p.fiscalYear)
                       where (ree.projId == Convert.ToInt32(ViewState["projId"]))
                                && ree.wpId.Equals(ViewState["wpId"].ToString())
                                && ree.dateUpdated.Equals(
                                        (DateTime)
                                        (from mostRecent in ffdb.WorkPackageEstimateREs
                                         where (mostRecent.projId == ree.projId)
                                             && mostRecent.wpId.Equals(ree.wpId)
                                             && mostRecent.dateUpdated <= (DateTime)ViewState["cutOffDate"]
                                         select mostRecent.dateUpdated).Max())
                       select ree.estimated_days * p.rate;

        var pRate = (from p in ffdb.PersonLevels
                     where p.fiscalYear.Equals(((DateTime)ViewState["cutOffDate"]).Year)
                     select p.rate);

        foreach (var pLvlBudget in reBudget) {
            totalDays += pLvlBudget.Value;
        }

        if (totalDays == 0) {
            return UnknownValue;
        }
        return String.Format("{0:C}", totalDays);
    }

    /// <summary>
    /// Calculates the dollars for the given days and given rate.
    /// Handles the case where either days or the rate is Unknown.
    /// Returns a String of formatted currency or the UnknownValue.
    /// </summary>
    /// <param name="strDays">The person days to calculate.</param>
    /// <param name="strRate">The person level rate to use.</param>
    /// <returns></returns>
    private String calculatePDollars(String strDays, String strRate) {
        decimal days = 0;
        decimal rate = 0;
        if (strDays.Equals(UnknownValue) || strDays.Equals("") || strDays == null) {
            return UnknownValue;
        }
        if (strRate.Equals(UnknownValue) || strRate.Equals("") || strRate == null) {
            return UnknownValue;
        }
        days = Convert.ToDecimal(strDays);
        rate = Convert.ToDecimal(strRate);
        return String.Format("{0:C}", (days * rate));
    }

    /// <summary>
    /// Gets the most recent p-level rate (up to the cutt off date) for an employee.
    /// </summary>
    /// <param name="empId">The employee ID.</param>
    /// <returns>The p-level rate or 0 if nothing found.</returns>
    private decimal getMaxPLvl(int empId) {
        DateTime mostRecentEmpPLevel = (from ep in ffdb.EmployeePersonLevels
                                        where ep.dateUpdated <= Convert.ToDateTime(ViewState["cutOffDate"])
                                            && (ep.empId == empId)
                                            && (ep.fiscalYear == Convert.ToDateTime(ViewState["cutOffDate"]).Year)
                                        select ep.dateUpdated).Max();

        var qry = (from p in ffdb.PersonLevels
                   join ep in ffdb.EmployeePersonLevels on (p.pLevel + p.fiscalYear) equals (ep.pLevel + ep.fiscalYear)
                   where (ep.empId == empId) && ep.dateUpdated.Equals(mostRecentEmpPLevel)
                   select p.rate);

        return qry.FirstOrDefault();
    }

    /// <summary>
    /// Calculates the actual cost of work an employee has done in dollars up to the cut-off date.
    /// This is based on their p-level at the time the work was done.
    /// </summary>
    /// <param name="empId">The Employee's ID</param>
    /// <returns>The total dollar value of the employee's work, up to the cut off date, as a decimal</returns>
    private String getAcwpDollars(int empId) {
        var qry = from t in ffdb.TimesheetEntries
                  join tsh in ffdb.TimesheetHeaders on (t.empId + t.tsDate.ToString()) equals (tsh.empId + tsh.tsDate.ToString())
                  where (t.tsDate <= (DateTime)ViewState["cutOffDate"])
                            && (t.projId == Convert.ToInt32(ViewState["projId"]))
                            && (t.wpId.Equals(ViewState["wpId"]))
                            && (tsh.status.Equals("APPROVED"))
                  join empPlvl in ffdb.EmployeePersonLevels on t.empId equals empPlvl.empId
                  join plvl in ffdb.PersonLevels on (empPlvl.pLevel + empPlvl.fiscalYear) equals (plvl.pLevel + plvl.fiscalYear)
                  where (t.projId == (Convert.ToInt32(ViewState["projId"])))
                            && (t.wpId.Equals(ViewState["wpId"]))
                            && (t.tsDate <= ((DateTime)ViewState["cutOffDate"]))
                            && (t.tsDate.Year == empPlvl.fiscalYear)
                            && (t.tsDate.Year == plvl.fiscalYear)
                            && (t.empId == empId)
                            && (empPlvl.dateUpdated.Equals(
                                        (DateTime)
                                        (from ep in ffdb.EmployeePersonLevels
                                         where ep.dateUpdated <= t.tsDate && ep.empId == empId
                                         select ep.dateUpdated).Max()))

                  select new {
                      ID = t.empId,
                      t.totalHours,
                      plvl.rate
                  };
        decimal totalPDollars = 0;
        foreach (var result in qry) {
            totalPDollars += (decimal)((result.totalHours / HoursPerWorkDay) * result.rate);
        }

        return String.Format("{0:C}", totalPDollars);
    }

    /// <summary>
    /// 
    /// </summary>
    /// <returns></returns>
    private decimal getPMBudget() {
        var qry = (from wp in ffdb.WorkPackages
                   where (wp.projId == (Convert.ToInt32(ViewState["projId"]))) && wp.wpId.Equals(ViewState["wpId"])
                   select wp).FirstOrDefault();
        return (decimal)(qry.unallocated_dollars + qry.allocated_dollars);
    }

    private decimal getREBudget() {
        var qry = (from wp in ffdb.WorkPackages
                   where (wp.projId == (Convert.ToInt32(ViewState["projId"]))) && wp.wpId.Equals(ViewState["wpId"])
                   select wp).FirstOrDefault();
        return (decimal)(qry.unallocated_dollars + qry.allocated_dollars);
    }



    private WorkPackageStatusReport getExistingReportDetails() {
        WorkPackageStatusReport wpsr = (from sr in ffdb.WorkPackageStatusReports
                                        where sr.cutOffDate.Equals((DateTime)ViewState["cutOffDate"])
                                            && (sr.projId == (Convert.ToInt32(ViewState["projId"])))
                                            && (sr.wpId.Equals(ViewState["wpId"]))
                                        select sr).FirstOrDefault();

        return wpsr;
    }

    /// <summary>
    /// Gets the total Actual Cost of Work Completed in days for each employee on the project.
    /// </summary>
    /// <returns>A list of key value pairs, employee ID to days worked.</returns>
    private List<KeyValuePair<int, decimal>> getAcwpForAll() {
        var qry = from t in ffdb.TimesheetEntries
                  join tsh in ffdb.TimesheetHeaders on (t.empId + t.tsDate.ToString()) equals (tsh.empId + tsh.tsDate.ToString())
                  where (t.tsDate <= (DateTime)ViewState["cutOffDate"])
                        && (t.projId == Convert.ToInt32(ViewState["projId"]))
                        && (t.wpId.Equals(ViewState["wpId"]))
                        && (tsh.status.Equals("APPROVED"))
                  group t by new { t.projId, t.wpId, ID = t.empId } into g
                  select new {
                      empId = g.Key.ID,
                      hours = (decimal)g.Sum(s => (s.mon + s.tue + s.wed + s.thu + s.fri + s.sat + s.sun))
                  };
        List<KeyValuePair<int, decimal>> listAcwp = new List<KeyValuePair<int, decimal>>();
        foreach (var acwp in qry) {
            listAcwp.Add(new KeyValuePair<int, decimal>(acwp.empId, acwp.hours / HoursPerWorkDay));
        }
        return listAcwp;
    }

    /// <summary>
    /// Gets the most recent ETC for all employees (up to the cut-off date) on the project/workpackage.
    /// </summary>
    /// <returns>A list of the most recent ETC in days, for all employees, up to the cut-off date.</returns>
    private List<EmployeeWorkPackageETC> getEtcForAll() {
        var qry = from etc in ffdb.EmployeeWorkPackageETCs
                  where (etc.projId == (Convert.ToInt32(ViewState["projId"])))
                           && (etc.wpId.Equals(ViewState["wpId"]))
                           && (etc.dateUpdated <= ((DateTime)ViewState["cutOffDate"]))
                           && (etc.dateUpdated.Equals(
                                   (from du in ffdb.EmployeeWorkPackageETCs
                                    where (etc.projId == (Convert.ToInt32(ViewState["projId"])))
                                           && (du.wpId.Equals(ViewState["wpId"]))
                                           && (du.dateUpdated <= ((DateTime)ViewState["cutOffDate"]))
                                    select du.dateUpdated).Max()))
                  select etc;

        List<EmployeeWorkPackageETC> listEtc = new List<EmployeeWorkPackageETC>();
        foreach (var etc in qry) {
            listEtc.Add(etc);
        }
        return listEtc;
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="empId"></param>
    /// <param name="list"></param>
    /// <returns></returns>
    private String getAcwpForEmployee(int empId, List<KeyValuePair<int, decimal>> list) {
        decimal acwp = 0;
        String s = (from afa in list
                    where afa.Key == empId
                    select afa.Value).FirstOrDefault().ToString();
        if ((s != null) && !(s.Equals(String.Empty))) {
            acwp = Convert.ToDecimal(s);
        }
        return String.Format(decimalFormat, acwp);
    }

    /// <summary>
    /// Gets the ETC in days for a specific employee from the provided list.
    /// </summary>
    /// <param name="empId">The employee who's ETC in days you want.</param>
    /// <param name="list">A filtered list of EmployeeWorkPackageETCs to choose from.</param>
    /// <returns>A string representation of that employee's ETC in days.</returns>
    private String getEtcForEmployee(int empId, List<EmployeeWorkPackageETC> list) {
        decimal etc = 0;
        String s = (from afa in list
                    where afa.empId == empId
                    select afa.ETC_days).FirstOrDefault().ToString();
        if ((s == null) || s.Equals(String.Empty)) {
            return UnknownValue;
        }
        etc = Convert.ToDecimal(s);
        return String.Format(decimalFormat, etc);
    }

    /// <summary>
    /// Removes any number formatting ($ , %) from a String.
    /// Used before attempting to convert that String to a decimal.
    /// </summary>
    /// <param name="str">The string that needs formatting removed.</param>
    /// <returns>The same string without any dollar signs, percent signs, or commas.</returns>
    private String stripFormatting(String str) {
        str = str.Replace("$", String.Empty);
        str = str.Replace(",", String.Empty);
        str = str.Replace("%", String.Empty);
        return str;
    }

    /// <summary>
    /// Gets the EAC using the given ACWP and ETC.
    /// Returns a formatted string (according to format param) or the Unknown Value.
    /// </summary>
    /// <param name="strEtc">A string representing the Estimate to Complete.</param>
    /// <param name="strAcwp">A string representing the Actual Cost of Work Complete.</param>
    /// <returns>A formatted String for the EAC or the Unknown Value.</returns>
    private String calculateEac(String strAcwp, String strEtc, String format) {
        decimal acwp = 0;
        decimal etc = 0;
        decimal eac = 0;

        if (strEtc.Equals(UnknownValue) || strEtc == null || strEtc.Equals(String.Empty)) {
            return UnknownValue;
        } else {
            strEtc = this.stripFormatting(strEtc);
            strAcwp = this.stripFormatting(strAcwp);
            etc = Convert.ToDecimal(strEtc);
            acwp = Convert.ToDecimal(strAcwp);
            eac = acwp + etc;

            if (format == null) {
                return eac.ToString();
            }

            return String.Format(format, eac);
        }
    }

    private String calculateEtc(String strAcwp, String strEac, String format) {
        decimal acwp = 0;
        decimal etc = 0;
        decimal eac = 0;

        if (strEac.Equals(UnknownValue) || strEac == null || strEac.Equals(String.Empty)) {
            return UnknownValue;
        } else {
            strEac = this.stripFormatting(strEac);
            strAcwp = this.stripFormatting(strAcwp);
            eac = Convert.ToDecimal(strEac);
            acwp = Convert.ToDecimal(strAcwp);
            etc = eac - acwp;

            if (format == null) {
                return eac.ToString();
            }

            return String.Format(format, etc);
        }
    }

    private void SetResults(String newResults, Boolean append, System.Drawing.Color fontColour) {
        lblResults.Visible = true;
        if (append) {
            lblResults.Text += newResults;
        } else {
            lblResults.Text = newResults;
        }
        lblResults.ForeColor = fontColour;
    }

    /// <summary>
    /// Get the percent complete of the two String parameters, how much has been done given the ACWP and EAC.
    /// The percent complete (formatted String to 1 decimal place)
    /// or the Unknown value if unable to calculate the percent.
    /// </summary>
    /// <param name="empAcwp">The actual cost of the work done.</param>
    /// <param name="empEac">The estimated amount of work at completion.</param>
    /// <returns>The percent complete (formatted String to 1 decimal place)
    /// or the Unknown value, if unable to calculate.</returns>
    private String getPercentComplete(String strAcwp, String strEac) {
        decimal acwp = 0;
        decimal eac = 0;
        decimal pc = 0;

        // If ACWP is known, convert it to a decimal
        // If not, use the 0 value
        if (!strAcwp.Equals(UnknownValue)) {
            strAcwp = this.stripFormatting(strAcwp);
            acwp = Convert.ToDecimal(strAcwp);
        }

        // If EAC is not known, can't calulate percent so return unknown
        if (strEac.Equals(UnknownValue)) {
            return UnknownValue;
        }

        strEac = this.stripFormatting(strEac);

        // Convert EAC to a decimal
        eac = Convert.ToDecimal(strEac);

        // Calculate, round, format and return the percent complete
        pc = (acwp / eac) * 100;
        pc = Math.Round(pc, 1);
        return String.Format("{0:0.0}%", pc);
    }

    protected void btnSubmit_Click(object sender, EventArgs e) {
        ViewState["projId"] = Convert.ToInt32(ddlAllProjects.SelectedValue);
        ViewState["wpId"] = ddlWorkpackages.SelectedValue;
        ViewState["cutOffDate"] = Convert.ToDateTime(tbCutOffDate.Text);
        ViewState["WorkPackage"] = ddlWorkpackages.SelectedItem.Text;
        ViewState["Project"] = ddlAllProjects.SelectedItem.Text;
        GetWorkPackageStatusReport();
        btnSave.Visible = true;
    }

    protected void gvStatus_RowEditing(object sender, GridViewEditEventArgs e) {
        gvStatus.EditIndex = e.NewEditIndex;
        GetWorkPackageStatusReport();
    }

    protected void gvStatus_RowUpdating(object sender, GridViewUpdateEventArgs e) {
        // Get the row that's changing.
        GridViewRow row = gvStatus.Rows[e.RowIndex];
        GridViewRow empRow = gvStatus.Rows[e.RowIndex - 1];
        int empId = extractEmpId(((Label)empRow.Cells[0].Controls[1]).Text);
        String strEtc = UnknownValue;
        String strEac = UnknownValue;
        String strAcwp = ((Label)row.Cells[1].Controls[1]).Text;
        decimal acwp = 0;
        decimal etc = 0;
        decimal eac = 0;
        String format = "{0:0.0}";
        String result = "";

        // Get the new values.
        if (e.NewValues["ETC"] != null) {
            if (!(e.NewValues["ETC"].Equals(String.Empty))) {
                strEtc = e.NewValues["ETC"].ToString();
            }
        }

        if (e.NewValues["EAC"] != null) {
            if (!(e.NewValues["EAC"].Equals(String.Empty))) {
                strEac = e.NewValues["EAC"].ToString();
            }
        }

        if (Regex.IsMatch(strEac, "^(^[U]{1}[n]{1}[k]{1}[n]{1}[o]{1}[w]{1}[n]{1}$)|(^[0-9]*([.]+[0-9]*)*)$")) {
            SetResults("* EAC can only contain a dollar sign, comma, period, positive numbers, or 'Unknown'.", false, FailColour);
            return;
        }

        if (Regex.IsMatch(strEtc, "^(^[U]{1}[n]{1}[k]{1}[n]{1}[o]{1}[w]{1}[n]{1}$)|(^[0-9]*([.]+[0-9]*)*)$")) {
            SetResults("* ETC can only contain a dollar sign, comma, period, positive numbers, or 'Unknown'.", false, FailColour);
            return;
        }
        
        if (!(strEac.Equals(UnknownValue) && strEtc.Equals(UnknownValue))) {
            SetResults("* At least one value must be 'Unknown' or blank. Please change one value to 'Unknown' or blank.", false, FailColour);
            return;
        }

        // Check for existing empWPEtc for the cut off date.
        EmployeeWorkPackageETC empWpEtc = (from ewetc in ffdb.EmployeeWorkPackageETCs
                                           where ewetc.empId == empId
                                                && ewetc.dateUpdated.Equals(Convert.ToDateTime(ViewState["cutOffDate"]))
                                           select ewetc).FirstOrDefault();

        if (!((result = calculateEac(strAcwp, strEtc, format)).Equals(UnknownValue))) {
            eac = Convert.ToDecimal(result);
            strAcwp = this.stripFormatting(strAcwp);
            acwp = Convert.ToDecimal(strAcwp);
            etc = eac - acwp;
        } else if (!((result = calculateEtc(strAcwp, strEac, format)).Equals(UnknownValue))) {
            etc = Convert.ToDecimal(result);
            strAcwp = this.stripFormatting(strAcwp);
            acwp = Convert.ToDecimal(strAcwp);
            eac = etc + acwp;
            if (eac < acwp) {
                SetResults("* The EAC '" + strEac + "' is less than the ACWP. Please use a higher EAC or click cancel.", false, FailColour);
                return;
            }
            if (eac == 0) {
                SetResults("* The EAC must be greater than 0. Please use a different EAC or click cancel.", false, FailColour);
                return;
            }
        } else {
            if (empWpEtc != null) {
                SetResults("* Cannot set both existing estimates to 'Unknown' or blank values. Please give at least 1 value.", false, FailColour);
                return;
            }
            // Error, exit method and redraw grid view normally
            gvStatus.EditIndex = -1;
            e.Cancel = true;
            GetWorkPackageStatusReport();
            SetResults("* An error has occured, we've exited edit mode.", false, FailColour);
            return;
        }

        // If ETC exists, update it
        if (empWpEtc != null) {
            empWpEtc.ETC_days = etc;
        }
        else {
            // If ETC doesn't exist, create one
            empWpEtc = new EmployeeWorkPackageETC();

            empWpEtc.ETC_days = etc;
            empWpEtc.empId = empId;
            empWpEtc.projId = Convert.ToInt32(ViewState["projId"]);
            empWpEtc.wpId = (String)ViewState["wpId"];

            // If the current date is earlier than the cut off date, use the current date
            // Otherwise, use the cut-off date
            if (DateTime.Now <= Convert.ToDateTime(ViewState["cutOffDate"])) {
                empWpEtc.dateUpdated = DateTime.Now;
            } else {
                empWpEtc.dateUpdated = Convert.ToDateTime(ViewState["cutOffDate"]);
            }

            ffdb.EmployeeWorkPackageETCs.InsertOnSubmit(empWpEtc);
        }

        // Persist the changes, exit edit mode, redraw the grid
        ffdb.SubmitChanges();
        gvStatus.EditIndex = -1;
        e.Cancel = true;
        GetWorkPackageStatusReport();
        SetResults("The report updated successfully.", false, SuccessColour);

    }

    /// <summary>
    /// Extracts an employee ID from a string, if that string is in the form "FirstName LastName (EmpId)".
    /// </summary>
    /// <param name="emp">String that represents an employee and is in the form "FirstName LastName (EmpId)".</param>
    /// <returns>Int employee ID</returns>
    private int extractEmpId(String emp) {
        int empId = -1;
        String[] tokens = Regex.Split(emp, " ");
        String strEmpId = tokens[2].TrimEnd(')').TrimStart('(');
        try {
            empId = Convert.ToInt32(strEmpId);
        }
        catch (Exception e) {
            return -1;
        }
        return empId;

    }

    protected void gvStatus_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e) {
        gvStatus.EditIndex = -1;
        GetWorkPackageStatusReport();
    }

    protected void gvStatus_RowCommand(object sender, GridViewCommandEventArgs e) {
        GetWorkPackageStatusReport();
    }

    /// <summary>
    /// Saves the report details into the database.
    /// Tests for validity.
    /// Checks if it's a new report or an existing report.
    /// Persists report.
    /// </summary>
    /// <param name="sender">The object that generated the event.</param>
    /// <param name="e">The event.</param>
    protected void btnSave_Click(object sender, EventArgs e) {
        if (Page.IsValid) {
            Boolean isNewReport = false;

            WorkPackageStatusReport wpsr = getExistingReportDetails();

            if (wpsr == null) {
                wpsr = new WorkPackageStatusReport();
                wpsr.projId = Convert.ToInt32(ViewState["projId"]);
                wpsr.wpId = ddlWorkpackages.SelectedValue;
                wpsr.cutOffDate = (DateTime)(ViewState["cutOffDate"]);
                isNewReport = true;
            }

            wpsr.comments = tbComments.Text;
            wpsr.workAccomplished = tbWorkAccomplished.Text;
            wpsr.workPlannedNext = tbWorkPlannedNext.Text;
            wpsr.problemsEncountered = tbProblemsEncountered.Text;
            wpsr.problemsAnticipated = tbProblemsAncticipatedNext.Text;

            if (isNewReport) {
                ffdb.WorkPackageStatusReports.InsertOnSubmit(wpsr);
            }

            try {
                ffdb.SubmitChanges();
                SetResults("The report details were successfully saved.", false, SuccessColour);
            }
            catch (Exception ex) {
                SetResults("The report details could not be saved at this time.", false, FailColour);
                Trace.Write(ex.Message);
                return;
            }
            GetWorkPackageStatusReport();
        }
    }
}