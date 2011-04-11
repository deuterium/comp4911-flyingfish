using System;
using System.Data;
using System.Linq;

public partial class Reports_EarnedValueReport : System.Web.UI.Page
{

    #region Global Variables
    FlyingFishClassesDataContext ffdb = new FlyingFishClassesDataContext();
    String unknownValue = "N/A";
    #endregion

    #region Events / Others
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //make and attach DataSource for Drop Down List
            populateProjects();

            //gogo make report
            GetEarnedValueReport(4911, DateTime.Today);
        }
    }

    private void GetEarnedValueReport(int projId, DateTime end)
    {
        #region Variables
        /***************************************
         * Get the list of all the workpackages
         * associated with the Project selected
         **************************************/
        var workpackages = from wp in ffdb.WorkPackages
                           where wp.projId.Equals(projId)
                           join proj in ffdb.Projects on wp.projId equals proj.projId
                           select wp;

        /*********************************************
         * Create the table template for the datagrid
         *********************************************/
        DataTable dt = makeTable();
        #endregion

        #region Magically Make Stuff
        /***********************************************
         * For each WorkPackage in Project
         * Generate the Title, PDays and PDays($) rows
         ***********************************************/
        foreach (var wp in workpackages)
        {
            #region Values
            //Days            
            string PMBudgetDays = this.getPMBudgetDays(wp.projId, wp.wpId, end);
            string REBudgetDays = this.getREBudgetDays(wp.projId, wp.wpId, end);
            string ACWPDays     = this.getACWPDays(wp.projId, wp.wpId, end);
            string REEACDays    = this.getREEACDays(wp.projId, wp.wpId, end, ACWPDays);
            string PMVarDays    = this.getVARDays(PMBudgetDays, REEACDays);
            string REVarDays    = this.getVARDays(REBudgetDays, REEACDays);
            string CompleteDays = this.getCompleteDays(REEACDays, ACWPDays);

            //Budget/Estimates
            string PMBudget = this.getPMBudget(wp.projId, wp.wpId);
            string REBudget = this.getREBudget(wp.projId, wp.wpId, end);
            string ACWP     = this.getACWP(wp.projId, wp.wpId, end);
            string REEAC    = this.getREEAC(wp.projId, wp.wpId, end, ACWP);
            string PMVar    = this.getVAR(PMBudget, REEAC);
            string REVar    = this.getVAR(REBudget, REEAC);
            string Complete = this.getComplete(REEAC, ACWP);
            #endregion

            #region WorkPackage Row
            DataRow dr = dt.NewRow();
            dr["Workpackage"] = wp.wpId + "  " + wp.name;
            dt.Rows.Add(dr);
            #endregion

            #region PDays Row
            dr = dt.NewRow();
            dr["Workpackage"]   = "PDays";
            dr["PMBudget"]      = PMBudgetDays;
            dr["REBudget"]      = REBudgetDays;
            dr["ACWP"]          = ACWPDays;
            dr["REEAC"]         = REEACDays;
            dr["PMVar"]         = PMVarDays;
            dr["REVar"]         = REVarDays;
            dr["Complete"]      = CompleteDays;
            dt.Rows.Add(dr);
            #endregion

            #region PDays($) Row
            dr = dt.NewRow();
            dr["Workpackage"]   = "PDays($)";
            dr["PMBudget"]      = PMBudget;
            dr["REBudget"]      = REBudget;
            dr["ACWP"]          = ACWP;
            dr["REEAC"]         = REEAC;
            dr["PMVar"]         = PMVar;
            dr["REVar"]         = REVar;
            dr["Complete"]      = Complete;
            dt.Rows.Add(dr);
            #endregion
        }
        
        gvEarnedValue.DataSource = dt;
        gvEarnedValue.DataBind();
        #endregion
    }

    private void populateProjects()
    {
        var qry = from a in ffdb.aspnet_Users
                  where a.UserName.Equals(User.Identity.Name)
                  join m in ffdb.EmployeeMemberships on a.UserId equals m.userId
                  join ep in ffdb.EmployeeProjects on m.empId equals ep.empId
                  join p in ffdb.Projects on ep.projId equals p.projId
                  select new { ProjID = p.projId, ProjectName = p.projName + " (" + p.projId + ")" };

        ddlAllProjects.DataSource = qry;

        //ddlAllProjects.DataSource = ffdb.Projects.Select(p => new
        //{
        //    ProjID = p.projId,
        //    ProjectName = p.projName + " (" + p.projId + ")"
        //});
        ddlAllProjects.DataValueField = "ProjId";
        ddlAllProjects.DataTextField = "ProjectName";
        ddlAllProjects.DataBind();
    }

    private DataTable makeTable()
    {
        DataTable dt = new DataTable();
        dt.Columns.Add(new DataColumn("Workpackage", typeof(System.String)));
        dt.Columns.Add(new DataColumn("PMBudget", typeof(System.String)));
        dt.Columns.Add(new DataColumn("REBudget", typeof(System.String)));
        dt.Columns.Add(new DataColumn("ACWP", typeof(System.String)));
        dt.Columns.Add(new DataColumn("REEAC", typeof(System.String)));
        dt.Columns.Add(new DataColumn("PMVar", typeof(System.String)));
        dt.Columns.Add(new DataColumn("REVar", typeof(System.String)));
        dt.Columns.Add(new DataColumn("Complete", typeof(System.String)));

        return dt;
    }

    protected void btnSubmit_Click(object sender, EventArgs e) {
        DateTime periodEnd = Convert.ToDateTime(tbPeriodEnd.Text);
        int projId = Convert.ToInt16(ddlAllProjects.SelectedValue);
        GetEarnedValueReport(projId, periodEnd);
    }
    #endregion

    #region Business Logic & Calculations

    #region Days
    private String getPMBudgetDays(int projId, String wpId, DateTime end)
    {
        try
        {
            double days = 0;

            var qry = from wp in ffdb.WorkPackageBudgetPMs
                      where (wp.projId == projId) && wp.wpId.Equals(wpId) && wp.dateUpdated <= end
                      select wp into b
                      group b by new { b.projId, b.wpId, b.pLevel } into g
                      select new { g.Key.projId, g.Key.wpId, g.Key.pLevel, Days = g.First().allocated_days, Date = g.Max(t => t.dateUpdated) };

            foreach (var i in qry)
                days += Convert.ToDouble(i.Days);

            if (days != 0)
                return days.ToString();
            else
                return unknownValue;
        }
        catch (Exception ex)
        {
            return unknownValue;
        }
    }

    private String getREBudgetDays(int projId, String wpId, DateTime end)
    {
        try
        {
            double days = 0;

            var qry = from wp in ffdb.WorkPackageEstimateREs
                      where (wp.projId == projId) && wp.wpId.Equals(wpId) && wp.dateUpdated <= end
                      select wp.estimated_days;

            foreach (var i in qry)
                days += Convert.ToDouble(i);

            if (days != 0)
                return days.ToString();
            else
                return unknownValue;
        }
        catch (Exception ex)
        {
            return unknownValue;
        }
    }

    private String getACWPDays(int projId, String wpId, DateTime end)
    {
        try
        {
            double days = 0;

            var qry = from t in ffdb.TimesheetEntries
                      join tsh in ffdb.TimesheetHeaders on (t.empId.ToString() + t.tsDate.ToString()) equals (tsh.empId.ToString() + tsh.tsDate.ToString())
                      where t.projId == projId && t.wpId == wpId && tsh.status.Equals("APPROVED")
                      select new { days = (double)t.totalHours / (double)8 };

            foreach (var i in qry)
                days += i.days;

            if (days != 0)
                return (days).ToString();
            else
                return "0";
        }
        catch (Exception ex)
        {
            return unknownValue;
        }
    }

    private String getREEACDays(int projId, String wpId, DateTime end, string acwpDays)
    {
        try
        {
            double etcDays = 0;

            var qry = from e in ffdb.EmployeeWorkPackageETCs
                      where e.projId.Equals(projId) && e.wpId.Equals(wpId) && e.dateUpdated <= end
                      group e by new { e.projId, e.wpId, e.empId } into g
                      select new
                      {
                          g.Key.projId,
                          g.Key.wpId,
                          g.Key.empId,
                          days = g.Sum(t => t.ETC_days),
                          Date = g.Max(t => t.dateUpdated)
                      };

            foreach (var i in qry)
                etcDays += Convert.ToDouble(i.days);

            if (etcDays == 0)
                return unknownValue;
            else
                return (Convert.ToDouble(acwpDays) + etcDays).ToString();
        }
        catch (Exception ex)
        {
            return unknownValue;
        }
    }

    private String getVARDays(string BAC, string EAC)
    {
        try
        {
            if (BAC == unknownValue || EAC == unknownValue)
                return unknownValue;
            else
            {
                return ((Convert.ToDouble(BAC) - Convert.ToDouble(EAC)) / Convert.ToDouble(BAC)).ToString("0.00%");
            }
        }
        catch (Exception ex)
        {
            return unknownValue;
        }
    }

    private String getCompleteDays(string EAC, string ACW)
    {
        try
        {
            if (EAC == unknownValue)
                return unknownValue;
            else
            {
                return (Convert.ToDouble(ACW) / Convert.ToDouble(EAC)).ToString("0.00%");
            }
        }
        catch (Exception ex)
        {
            return unknownValue;
        }
    }
    #endregion

    #region Budget
    private String getPMBudget(int projId, String wpId) {

        try
        {
            double estimate = 0;

            var qry = (from wp in ffdb.WorkPackageBudgetPMs
                       join p in ffdb.PersonLevels on wp.pLevel equals p.pLevel
                       where (wp.projId == projId) && wp.wpId.Equals(wpId) && p.fiscalYear.Equals(wp.fiscalYear)
                       select new { allocated_days = wp.allocated_days, rate = p.rate });

            foreach (var i in qry)
                estimate += (Convert.ToDouble(i.allocated_days * i.rate));

            if (estimate != 0)
                return "$" + estimate.ToString();
            else
            {

                var qry2 = (from wp in ffdb.WorkPackages
                            where (wp.projId == projId) && wp.wpId.Equals(wpId)
                            select wp).FirstOrDefault();

                if (qry2.unallocated_dollars == null || (qry2.unallocated_dollars + qry2.allocated_dollars) == 0)
                    return unknownValue;
                else
                    return "$" + (qry2.unallocated_dollars + qry2.allocated_dollars).ToString();
            }
        }
        catch (Exception ex)
        {
            return unknownValue;
        }
    }

    private String getREBudget(int projId, String wpId, DateTime end) {

        try
        {
            double estimate = 0;

            var data = from wp in ffdb.WorkPackageEstimateREs
                       join p in ffdb.PersonLevels on wp.pLevel equals p.pLevel
                       where (wp.projId == projId) && wp.wpId.Equals(wpId)
                             && wp.fiscalYear.Equals(p.fiscalYear)
                             && wp.dateUpdated <= end
                       select new { wp.estimated_days, p.rate, wp.pLevel, wp.dateUpdated, wp.projId, wp.wpId } into b
                       group b by new { b.projId, b.wpId, b.pLevel, b.rate } into g
                       select new { g.Key.projId, g.Key.wpId, g.Key.pLevel, g.Key.rate, Date = g.Max(t => t.dateUpdated) };

            var qry = from wp in ffdb.WorkPackageEstimateREs
                      join d in data on (wp.wpId + wp.projId + wp.pLevel + wp.dateUpdated) equals (d.wpId + d.projId + d.pLevel + d.Date)
                      select new { d.wpId, d.projId, d.pLevel, d.Date, d.rate, wp.estimated_days };

            foreach (var i in qry)
            {
                estimate += (Convert.ToDouble(i.estimated_days * i.rate));
            }

            if (estimate != 0)
                return "$" + estimate.ToString();
            else
                return unknownValue;
        }
        catch (Exception ex)
        {
            return unknownValue;
        }
    }
        
    private String getACWP(int projId, String wpId, DateTime end)
    {
        try
        {
            double ACWP = 0;

            var qry = from t in ffdb.TimesheetEntries
                      join tsh in ffdb.TimesheetHeaders on (t.empId.ToString() + t.tsDate.ToString()) equals (tsh.empId.ToString() + tsh.tsDate.ToString())
                      where t.projId == projId && t.wpId == wpId && tsh.status.Equals("APPROVED") && t.tsDate <= end
                      select new { t.empId, t.tsDate, t.projId, t.wpId, days = (double)t.totalHours / (double)8 } into t
                      join e in ffdb.EmployeePersonLevels on t.empId equals e.empId
                      join p in ffdb.PersonLevels on (e.pLevel + e.fiscalYear) equals (p.pLevel + p.fiscalYear)
                      where e.dateUpdated <= t.tsDate
                      select new { t.empId, t.tsDate, t.projId, t.wpId, t.days, p.pLevel, p.rate, e.dateUpdated } into t
                      orderby t.dateUpdated descending
                      group t by new { t.empId, t.tsDate, t.projId, t.wpId } into p
                      select new { acwp = (double)p.First().days * (double)p.First().rate };
                      //group t by new { t.empId, t.tsDate, t.projId, t.wpId } into g
                      //select new { g.Key.empId, g.Key.tsDate, g.Key.projId, g.Key.wpId, days = (double)g.Sum(s => (s.mon + s.tue + s.wed + s.thu + s.fri + s.sat + s.sun)) / (double)8 };
            foreach (var i in qry)
                ACWP += i.acwp;

            if (ACWP != 0)
                return "$" + ACWP.ToString();
            else
                return "$0";
        }
        catch (Exception ex)
        {
            return unknownValue;
        }
    }
    
    private String getREEAC(int projId, String wpId, DateTime end, string acwp)
    {
        try
        {
            double etc = 0;

            var qry = from e in ffdb.EmployeeWorkPackageETCs
                      join ep in ffdb.EmployeePersonLevels on e.empId equals ep.empId
                      join p in ffdb.PersonLevels on (ep.pLevel + ep.fiscalYear) equals (p.pLevel + p.fiscalYear)
                      where e.projId.Equals(projId) && e.wpId.Equals(wpId)
                              && ep.dateUpdated <= end && e.dateUpdated <= end
                      select new { e.empId, e.ETC_days, epDateUpdated = ep.dateUpdated, p.rate} into a
                      orderby a.epDateUpdated descending
                      group a by new { a.empId } into g
                      select new { subTotal = Convert.ToDouble(g.First().rate * g.First().ETC_days) };

            foreach (var i in qry)
                etc += i.subTotal;

            if (etc == 0)
                return unknownValue;
            else
                return "$" + (Convert.ToDouble(acwp.Substring(1)) + etc).ToString();
        }
        catch (Exception ex)
        {
            return unknownValue;
        }
    }

    private String getVAR(string BAC, string EAC )
    {
        try
        {
            if (BAC == unknownValue || EAC == unknownValue)
                return unknownValue;
            else
            {
                return ((Convert.ToDouble(BAC.Substring(1)) - Convert.ToDouble(EAC.Substring(1))) / Convert.ToDouble(BAC.Substring(1))).ToString("0.00%");
            }
        }
        catch (Exception ex)
        {
            return unknownValue;
        }
    }

    private String getComplete(string EAC, string ACW)
    {
        try
        {
            if (EAC == unknownValue )
                return unknownValue;
            else
            {
                return (Convert.ToDouble(ACW.Substring(1)) / Convert.ToDouble(EAC.Substring(1))).ToString("0.00%");
            }
        }
        catch (Exception ex)
        {
            return unknownValue;
        }
    }
    #endregion

    #endregion
        
}