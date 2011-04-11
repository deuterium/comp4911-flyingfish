using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Text.RegularExpressions;


// NOT GETTING LINDSAY! ERROR! WTF!



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

    public const Decimal HoursPerWorkDay = 8;
    // format for 2 decimal places
    public const String decimalFormat = "{0:0.0}";
    public const String currencyFormat = "{0:C}";
    public const String percentFormat = "{0:0.0}%";

    private decimal subtotalAcwpDays = 0;
    private decimal subtotalEtcDays = 0;
    private decimal subtotalEacDays = 0;
    private decimal subtotalPercentCompleteDays = 0;

    private decimal subtotalAcwpDollars = 0;
    private decimal subtotalEtcDollars = 0;
    private decimal subtotalEacDollars = 0;
    private decimal subtotalPercentCompleteDollars = 0;

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
        }
    }

    /// <summary>
    /// Populates the Projects drop down list.
    /// If a PM visits this page, he or she only sees the projects he or she is working on.
    /// If a RE visits this page, he or she only sees the projects he or she is working as an RE on.
    /// </summary>
    private void populateProjects() {
        Employee e = getUser();

        if (User.IsInRole("ProjectManager")) {
            ddlAllProjects.DataSource = from p in ffdb.Projects
                                        where (p.manager == e.empId)
                                        select new {
                                            ProjID = p.projId,
                                            ProjectName = p.projName + " (" + p.projId + ")"
                                        };
        } else if (User.IsInRole("ResponsibleEngineer")) {
            ddlAllProjects.DataSource = from re in ffdb.WorkPackageResponsibleEngineers
                                        join p in ffdb.Projects on re.projId equals p.projId
                                        where (re.responsibleEngineer == e.empId)
                                        select new {
                                            ProjID = p.projId,
                                            ProjectName = p.projName + " (" + p.projId + ")"
                                        };
        } else {
            // Load all projects for now.
            ddlAllProjects.DataSource = from p in ffdb.Projects
                                        select new {
                                            ProjID = p.projId,
                                            ProjectName = p.projName + " (" + p.projId + ")"
                                        };
        }

        ddlAllProjects.DataValueField = "ProjId";
        ddlAllProjects.DataTextField = "ProjectName";
        ddlAllProjects.DataBind();
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
        Employee e = getUser();

        if (User.IsInRole("ProjectManager")) {
            ddlWorkpackages.DataSource = ffdb.WorkPackages
                                         .Where(wp => wp.projId == Convert.ToInt16(ddlAllProjects.SelectedValue))
                                         .Select(wp => new {
                                             WpID = wp.wpId,
                                             WpName = wp.name + " (" + wp.wpId + ")"
                                         });
        } else if (User.IsInRole("ResponsibleEngineer")) {
            ddlWorkpackages.DataSource = from re in ffdb.WorkPackageResponsibleEngineers
                                         join wp in ffdb.WorkPackages on (re.projId + re.wpId) equals (wp.projId + wp.wpId)
                                         where (re.responsibleEngineer == e.empId)
                                         select new {
                                             WpID = wp.wpId,
                                             WpName = wp.name + " (" + wp.wpId + ")"
                                         };
        } else {
            // Load all workpackages for now.
            ddlWorkpackages.DataSource = ffdb.WorkPackages
                                         .Where(wp => wp.projId == Convert.ToInt16(ddlAllProjects.SelectedValue))
                                         .Select(wp => new {
                                             WpID = wp.wpId,
                                             WpName = wp.name + " (" + wp.wpId + ")"
                                         });
        }
      
        ddlWorkpackages.DataValueField = "WpID";
        ddlWorkpackages.DataTextField = "WpName";
        ddlWorkpackages.DataBind();
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

    /// <summary>
    /// Populates the GridView.
    /// Calculates two sets of data for each employee on the selected WorkPackage (the days and the dollars).
    /// </summary>
    public void GetWorkPackageStatusReport() {
        // Store the ACWP for each employee
        List<KeyValuePair<int, decimal>> acwpForAll = getAcwpForAll();
        // Store the ETC for each employee
        allEmployeeWpETCs = getEtcForAll();

        // Get the WP's responsible engineer
        Employee respEng = (Employee)
                           (from re in ffdb.WorkPackageResponsibleEngineers
                            join e in ffdb.Employees on re.responsibleEngineer equals e.empId
                            where (re.projId == Convert.ToInt16(ViewState["projId"]))
                                && re.wpId.Equals(ViewState["wpId"])
                            select e).FirstOrDefault();
        
        // Get the Project's project manager
        var projMan = (Employee)
                      (from pm in ffdb.Projects
                       join e in ffdb.Employees on pm.manager equals e.empId
                       where (pm.projId == Convert.ToInt16(ViewState["projId"]))
                       select e).FirstOrDefault();

        // Get the data for each employee
        var qry = (from ewp in ffdb.EmployeeWorkPackages
                  join e in ffdb.Employees on ewp.empId equals e.empId
                  select new {
                      e.firstName,
                      e.lastName,
                      e.empId,
                      ACWP = getAcwpForEmployee(ewp.empId, acwpForAll),
                      ETC = getEtcForEmployee(ewp.empId, allEmployeeWpETCs)
                  }).Distinct();

        // Check if no results found
        if (qry.Count() == 0) {
            gvStatus.DataSource = null;
            gvStatus.DataBind();
            lblResults.Visible = true;
            divReportData.Visible = false;
            return;
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

        
        
        // Populate the Grid View with the formatted data
        gvStatus.DataSource = dt;
        gvStatus.DataBind();

        // skip header row
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
        //lblProject.Text = ViewState["Project"].ToString();
        lblWp.Text = ViewState["WorkPackage"].ToString();
        lblRe.Text = respEng.firstName + " " + respEng.lastName + " (" + respEng.empId + ")";
        lblPm.Text = projMan.firstName + " " + projMan.lastName + " (" + projMan.empId + ")";
        lblReportPeriod.Text = ((DateTime)ViewState["cutOffDate"]).ToString("yyyy/MM/dd");
        lblPmBac.Text = String.Format("{0:C}", this.getPMBudget());

        // Get most recent RE budget for this workpackage.
        lblReBac.Text = getResponsibleEngineerBudget();

        //// Calculate the Total ACWP for the WorkPackage
        //foreach (var item in qry) {
        //    if (!(item.EAC.Equals(UnknownValue))) {
        //        reBAC += Convert.ToDecimal(item.EAC);
        //    }
        //}

        //// Get the RE's estimated budget
        //lblReBac.Text = reBAC.ToString();
        //if (reBAC == 0) {
        //    lblReBac.Text = UnknownValue;
        //}

        //decimal totalAcwp = 0;

        //foreach (var item in qry) {
        //    if (!(item.ACWP.Equals(UnknownValue))) {
        //        totalAcwp += Convert.ToDecimal(item.ACWP);
        //    }
        //}


        //lblTotalAcwp.Text = totalAcwp.ToString() + " hours";
        //if (totalAcwp == 0) {
        //    lblTotalAcwp.Text = UnknownValue;
        //}

        // Get the WorkPackageStatusReport details
        WorkPackageStatusReport wpsr = getExistingReportDetails();
        ViewState["isNewReport"] = false;

        // Create empty WorkPackageStatusReport
        if (wpsr == null) {
            tbComments.Text = "";
            tbWorkAccomplished.Text = "";
            tbWorkPlannedNext.Text = "";
            tbProblemsEncountered.Text = "";
            tbProblemsAncticipatedNext.Text = "";
            ViewState["isNewReport"] = true;
        }
        // Populate WorkPackageStatusReport details
        else {
            tbComments.Text = wpsr.comments;
            tbWorkAccomplished.Text = wpsr.workAccomplished;
            tbWorkPlannedNext.Text = wpsr.workPlannedNext;
            tbProblemsEncountered.Text = wpsr.problemsEncountered;
            tbProblemsAncticipatedNext.Text = wpsr.problemsAnticipated;
        }

        // Hide any error messages
        lblResults.Visible = false;
        // Show the report
        divReportData.Visible = true;
    }

    // NOT TESTED
    private String getResponsibleEngineerBudget() {
        decimal totalDays = 0;

        var reBudget = from ree in ffdb.WorkPackageEstimateREs
                       join p in ffdb.PersonLevels on (ree.pLevel + ree.fiscalYear) equals (p.pLevel + p.fiscalYear)
                       where (ree.projId == Convert.ToInt16(ViewState["projId"]))
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
                            && (t.projId == Convert.ToInt16(ViewState["projId"]))
                            && (t.wpId.Equals(ViewState["wpId"]))
                            && (tsh.status.Equals("APPROVED"))
                  join empPlvl in ffdb.EmployeePersonLevels on t.empId equals empPlvl.empId
                  join plvl in ffdb.PersonLevels on (empPlvl.pLevel + empPlvl.fiscalYear) equals (plvl.pLevel + plvl.fiscalYear)
                  where (t.projId == (Convert.ToInt16(ViewState["projId"])))
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
                   where (wp.projId == (Convert.ToInt16(ViewState["projId"]))) && wp.wpId.Equals(ViewState["wpId"])
                   select wp).FirstOrDefault();
        return (decimal)(qry.unallocated_dollars + qry.allocated_dollars);
    }

    private decimal getREBudget() {
        var qry = (from wp in ffdb.WorkPackages
                   where (wp.projId == (Convert.ToInt16(ViewState["projId"]))) && wp.wpId.Equals(ViewState["wpId"])
                   select wp).FirstOrDefault();
        return (decimal)(qry.unallocated_dollars + qry.allocated_dollars);
    }



    private WorkPackageStatusReport getExistingReportDetails() {
        WorkPackageStatusReport wpsr = (from sr in ffdb.WorkPackageStatusReports
                                        where sr.cutOffDate.Equals((DateTime)ViewState["cutOffDate"])
                                            && (sr.projId == (Convert.ToInt16(ViewState["projId"])))
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
                        && (t.projId == Convert.ToInt16(ViewState["projId"]))
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
                  where (etc.projId == (Convert.ToInt16(ViewState["projId"])))
                           && (etc.wpId.Equals(ViewState["wpId"]))
                           && (etc.dateUpdated <= ((DateTime)ViewState["cutOffDate"]))
                           && (etc.dateUpdated ==
                                   (from du in ffdb.EmployeeWorkPackageETCs
                                    select du.dateUpdated).Max())
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
        if (!((s == null) || s.Equals(""))) {
            acwp = Convert.ToDecimal(s);
            subtotalAcwpDays += acwp;
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
        subtotalEtcDays += etc;
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

            if (format.Equals(decimalFormat)) {
                subtotalEacDays += eac;
            } else if (format.Equals(currencyFormat)) {
                subtotalEacDollars += eac;
            } else if (format == null) {
                subtotalEacDays += etc;
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

            if (format.Equals(decimalFormat)) {
                subtotalEtcDays += eac;
            }
            else if (format.Equals(currencyFormat)) {
                subtotalEtcDollars += etc;
            }
            else if (format == null) {
                subtotalEtcDays += etc;
                return eac.ToString();
            }

            return String.Format(format, etc);
        }
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
        ViewState["projId"] = Convert.ToInt16(ddlAllProjects.SelectedValue);
        ViewState["wpId"] = ddlWorkpackages.SelectedValue;
        ViewState["cutOffDate"] = Convert.ToDateTime(tbCutOffDate.Text);
        ViewState["WorkPackage"] = ddlWorkpackages.SelectedItem.Text;
        ViewState["Project"] = ddlAllProjects.SelectedItem.Text;
        GetWorkPackageStatusReport();
    }

    protected void btnNewReport_Click(object sender, EventArgs e) {
        ViewState["projId"] = Convert.ToInt16(ddlAllProjects.SelectedValue);
        ViewState["wpId"] = ddlWorkpackages.SelectedValue;
        ViewState["cutOffDate"] = Convert.ToDateTime(tbCutOffDate.Text);
        GetWorkPackageStatusReport();
    }

    protected void gvStatus_RowEditing(object sender, GridViewEditEventArgs e) {
        gvStatus.EditIndex = e.NewEditIndex;
        GetWorkPackageStatusReport();
    }

    private void UpdateETC(String strEtc, String strEac, decimal acwp, EmployeeWorkPackageETC empWpEtc) {
        decimal etc = 0;
        decimal eac = 0;

        if (!strEtc.Equals(UnknownValue)) {
            try {
                etc = Convert.ToDecimal(strEtc);
                if (etc <= 0) {
                    strEtc = UnknownValue;
                }
            }
            catch (Exception ex) {
                ex.ToString();
                strEtc = UnknownValue;
            }
        }

        if (!strEac.Equals(UnknownValue)) {
            try {
                eac = Convert.ToDecimal(strEac);
                if (eac <= 0) {
                    strEac = UnknownValue;
                }
                if (eac < (etc + acwp)) {
                    strEac = UnknownValue;
                }
            }
            catch (Exception ex) {
                ex.ToString();
                strEac = UnknownValue;
            }
        }

        // Calculate missing value
        if (strEac.Equals(UnknownValue)) {
            if (strEtc.Equals(UnknownValue)) {
                empWpEtc.ETC_days = null;
            }
            else {
                etc = Convert.ToDecimal(strEtc);
                empWpEtc.ETC_days = (decimal)etc;
            }
        }
        else {
            eac = Convert.ToDecimal(strEac);
            empWpEtc.ETC_days = (decimal)(eac - acwp);
        }

        ffdb.SubmitChanges();
    }

    protected void gvStatus_RowUpdating(object sender, GridViewUpdateEventArgs e) {
        // Get the row that's changing.
        GridViewRow row = gvStatus.Rows[e.RowIndex];
        GridViewRow empRow = null;

        // Get the new values.
        String strEtc = e.NewValues["ETC"].ToString();
        String strEac = e.NewValues["EAC"].ToString();
        String strAcwp = ((Label)row.Cells[1].Controls[1]).Text;
        decimal acwp = 0;
        decimal etc = 0;
        decimal eac = 0;
        int empId = -1;
        String format = "{0:0.0}";
        String result = "";

        // Find out which row we're dealing with (empty employee, days, or dollars)
        if (strAcwp.StartsWith("$")) {
            // Dollars
            empRow = gvStatus.Rows[e.RowIndex - 2];
        } else {
            // Days
            empRow = gvStatus.Rows[e.RowIndex - 1];
        }

        // Extract the empId.
        empId = extractEmpId(((Label)empRow.Cells[0].Controls[1]).Text);

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
        } else {
            // Error, exit method and redraw grid view normally
            ffdb.SubmitChanges();
            gvStatus.EditIndex = -1;
            e.Cancel = true;
            GetWorkPackageStatusReport();
        }

        // If ETC exists, update it
        if (empWpEtc != null) {
            empWpEtc.ETC_days = etc;
        } else {
            // If ETC doesn't exist, create one
            empWpEtc = new EmployeeWorkPackageETC();

            empWpEtc.ETC_days = etc;
            empWpEtc.empId = empId;
            empWpEtc.projId = Convert.ToInt16(ViewState["projId"]);
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
            empId = Convert.ToInt16(strEmpId);
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
            lblResults.Text = "";
            lblResults.Visible = true;
            Boolean isNewReport = false;

            WorkPackageStatusReport wpsr = getExistingReportDetails();

            if (wpsr == null) {
                wpsr = new WorkPackageStatusReport();
                wpsr.projId = Convert.ToInt16(ViewState["projId"]);
                wpsr.wpId = ddlWorkpackages.SelectedValue;
                wpsr.cutOffDate.Equals(ViewState["cutOffDate"]);
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
                lblResults.ForeColor = System.Drawing.Color.Green;
                lblResults.Text = "Report successfully saved!<br />";
            }
            catch (Exception ex) {
                lblResults.ForeColor = System.Drawing.Color.Red;
                lblResults.Text = "Unable to save report at this time.<br />";
                Trace.Write(ex.Message);
            }

        }
    }
}