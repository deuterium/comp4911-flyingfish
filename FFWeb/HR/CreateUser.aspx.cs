using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using FFLib;

public partial class CreateUser : System.Web.UI.Page
{
    //DatabaseContext
    FlyingFishClassesDataContext ff = new FlyingFishClassesDataContext();

    //PageLoad Method
    protected void Page_Load(object sender, EventArgs e)
    {
    }

}