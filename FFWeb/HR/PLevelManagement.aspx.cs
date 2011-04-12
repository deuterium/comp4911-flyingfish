using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class HR_PLevelManagement : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e) {}

    //Clears Error messages on selecting a new FiscalYear and changes Label for create new P-Level
    protected void ddlFiscalYear_SelectedIndexChanged(object sender, EventArgs e)
    {
        lblPLevelError.Text = "";
        lblError.Text = "";
        lblFiscalYear.Text = ddlFiscalYear.SelectedValue.ToString();
        lblFiscalYear.ForeColor = System.Drawing.Color.BlueViolet;
    }

    //Sets Fiscal Year Label for initial load of Create new P-Level
    protected void ddlFiscalYear_DataBound(object sender, EventArgs e)
    {
        lblFiscalYear.Text = ddlFiscalYear.SelectedValue.ToString();
        lblFiscalYear.ForeColor = System.Drawing.Color.BlueViolet;
    }

    //Saves new P-Level to the Database
    protected void buttonPlevel_Click(object sender, EventArgs e)
    {
        using (FlyingFishClassesDataContext ff = new FlyingFishClassesDataContext()) {
            PersonLevel pl = new PersonLevel() 
            { 
                rate = Convert.ToInt32(tbRate.Text),
                pLevel = tbPLevelID.Text,
                fiscalYear = Convert.ToInt32(lblFiscalYear.Text)
            };
            ff.PersonLevels.InsertOnSubmit(pl);
            try
            {
                ff.SubmitChanges();
            }
            catch (Exception ex) {
                ex.ToString();
                lblError.Text = "PLevel ID already exists.";
                lblError.ForeColor = System.Drawing.Color.Red;
                return;
            }
            lblError.Text = "P-Level added. Refresh page to see changes.";
            lblError.ForeColor = System.Drawing.Color.Green;
        }
    }

    //Catches FK Deletion errors for in use P-Levels
    protected void gvPLevels_RowDeleted(object sender, GridViewDeletedEventArgs e)
    {
        if (e.Exception != null)
        {
            lblPLevelError.Text = "P-Level cannot be deleted, it is currently being used.";
            e.ExceptionHandled = true;
            lblPLevelError.ForeColor = System.Drawing.Color.Red;
        }
    }
}