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
        /*
        if (!IsPostBack)
        {
            defalutLoad();
            approveTimeSheet();
        }
         * */
     
    }

    /*
    public void defalutLoad()
    {
        var qry = from tsh in ff.TimeSheetHeaders
                  where tsh.status != "APPROVED"
                  select new
                  {
                      EmpID = tsh.empId,
                      Date = tsh.tsDate,
                      Status = tsh.status,
                      Comments = tsh.comments

                  };

        gv1.DataSource = qry;
        gv1.DataBind();
    }

    public void approveTimeSheet()
    {
        
    }
     * */
    protected void Button1_Click(object sender, EventArgs e)
    {

    }
}