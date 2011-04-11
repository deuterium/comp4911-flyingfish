﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class HR_PLevelManagement : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
       
    }
    protected void ddlFiscalYear_SelectedIndexChanged(object sender, EventArgs e)
    {
        lblFiscalYear.Text = ddlFiscalYear.SelectedValue.ToString();
        lblFiscalYear.ForeColor = System.Drawing.Color.BlueViolet;
    }
    protected void ddlFiscalYear_DataBound(object sender, EventArgs e)
    {
        lblFiscalYear.Text = ddlFiscalYear.SelectedValue.ToString();
        lblFiscalYear.ForeColor = System.Drawing.Color.BlueViolet;
    }
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
            ff.SubmitChanges();

            lblError.Text = "P-Level added. Refresh page to see changes.";
            lblError.ForeColor = System.Drawing.Color.Green;
        }
    }

    protected void gvPLevels_RowUpdated(object sender, GridViewUpdatedEventArgs e)
    {
        if (e.Exception != null) {
            lblError.Text = "An exception occurred. " +
                "Please correct any invalid data " +
                "and try again.<br /><br />" +
                "Message: " + e.Exception.Message;
            e.ExceptionHandled = true;
            e.KeepInEditMode = true;
        } else if (e.AffectedRows == 0)
            lblError.Text = "No rows were updated. " +
                "Another user may have updated that category." +
                "<br />Please try again.";
        lblPLevelError.ForeColor = System.Drawing.Color.Red;
    }
}