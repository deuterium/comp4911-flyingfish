using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

public partial class HR_CreateEmployee : System.Web.UI.Page
{

    FlyingFishClassesDataContext ff = new FlyingFishClassesDataContext();

    protected void Page_Load(object sender, EventArgs e){}

    //Populates the Supervisor && Approver lists
    protected void SupervisorList_Init(object sender, EventArgs e)
    {
        var validUsers = ff.vw_AllValid_UserName_EmpIDs
            .Select(u => new
            {
                empID = u.empId,
                approver = ((((u.firstName + " ") + u.lastName) + " (") + u.empId + ")")
            })
            .OrderBy(u => u.approver);
        ((ListBox)wsEmployeeAccountInfo.ContentTemplateContainer.FindControl("SupervisorList")).DataSource = validUsers;
        ((ListBox)wsEmployeeAccountInfo.ContentTemplateContainer.FindControl("SupervisorList")).DataValueField = "empId";
        ((ListBox)wsEmployeeAccountInfo.ContentTemplateContainer.FindControl("SupervisorList")).DataTextField = "approver";
        ((ListBox)wsEmployeeAccountInfo.ContentTemplateContainer.FindControl("SupervisorList")).DataBind();
        ((ListBox)wsEmployeeAccountInfo.ContentTemplateContainer.FindControl("SupervisorList")).Rows = 3;

        ((ListBox)wsEmployeeAccountInfo.ContentTemplateContainer.FindControl("ApproverList")).DataSource = validUsers;
        ((ListBox)wsEmployeeAccountInfo.ContentTemplateContainer.FindControl("ApproverList")).DataValueField = "empId";
        ((ListBox)wsEmployeeAccountInfo.ContentTemplateContainer.FindControl("ApproverList")).DataTextField = "approver";
        ((ListBox)wsEmployeeAccountInfo.ContentTemplateContainer.FindControl("ApproverList")).DataBind();
        ((ListBox)wsEmployeeAccountInfo.ContentTemplateContainer.FindControl("ApproverList")).Rows = 3;
    }

    //Adds the newly created user to the Employee table and links them together in EmployeeMembership
    protected void cuwCreateUser_CreatedUser(object sender, EventArgs e)
    {
        string tmpFirstName = ((TextBox)wsEmployeeAccountInfo.ContentTemplateContainer.FindControl("FirstName")).Text;
        string tmpLastName = ((TextBox)wsEmployeeAccountInfo.ContentTemplateContainer.FindControl("LastName")).Text;
        string tmpSupervisor = ((ListBox)wsEmployeeAccountInfo.ContentTemplateContainer.FindControl("SupervisorList")).SelectedValue;
        string tmpApprover = ((ListBox)wsEmployeeAccountInfo.ContentTemplateContainer.FindControl("ApproverList")).SelectedValue;
        string tmpEmpID = ((TextBox)wsEmployeeAccountInfo.ContentTemplateContainer.FindControl("EmployeeID")).Text;
        CheckBoxList tempCheck = (CheckBoxList)wsEmployeeAccountInfo.ContentTemplateContainer.FindControl("RoleList");
        for (int i = 0; i < tempCheck.Items.Count; i++)
        {
            if (tempCheck.Items[i].Selected)
            {
                Roles.AddUserToRole(((TextBox)wsEmployeeAccountInfo.ContentTemplateContainer.FindControl("UserName")).Text
                  , tempCheck.Items[i].Text);
            }
        }

        Employee emp = new Employee()
        {
            firstName = tmpFirstName,
            lastName = tmpLastName,
            empId = Convert.ToInt32(tmpEmpID),
            supervisor = Convert.ToInt32(tmpSupervisor),
            approver = Convert.ToInt32(tmpApprover),
            minHoursPerWeek = 0,
            vacationLeave = 0,
            sickDays = 0,
            flexHours = 0,
            isActive = 1
        };
        //Employee table updated
        ff.Employees.InsertOnSubmit(emp);

        //EmployeeMembership updated (link created here)
        ff.EmployeeMemberships.InsertOnSubmit(new EmployeeMembership
        {
            empId = Convert.ToInt32(tmpEmpID),
            userId = ff.aspnet_Users
                .Where(u => u.UserName == ((TextBox)wsEmployeeAccountInfo.ContentTemplateContainer.FindControl("UserName")).Text)
                .ToArray()[0].UserId
        });
        ff.SubmitChanges();

        //Adds selected Approver to the TSApprover Role if they are not in it already
        string approverUsername = ff.vw_EmployeeInRolewFirstLastNameEmpIDUserIDs.Where(em => em.empId == Convert.ToInt32(tmpApprover)).Select(u => u.UserName).First();
        if (!Roles.IsUserInRole(approverUsername, "TimesheetApprover"))
        {
            Roles.AddUserToRole(approverUsername, "TimesheetApprover");
        }
    }

    //Checks to see an en employee is already created with an EmpID
    protected void cuwCreateUser_CreatingUser(object sender, LoginCancelEventArgs e)
    {
        string tmpEmpID = ((TextBox)wsEmployeeAccountInfo.ContentTemplateContainer.FindControl("EmployeeID")).Text;
        if (ff.Employees.Where(te => te.empId == Convert.ToInt32(tmpEmpID)).ToArray().Length > 0)
        {
            ((Label)wsEmployeeAccountInfo.ContentTemplateContainer.FindControl("lblUserWizardError")).Enabled = true;
            ((Label)wsEmployeeAccountInfo.ContentTemplateContainer.FindControl("lblUserWizardError")).Text
                = "Employee Number already exists.";
            e.Cancel = true;
        }
        else
        {
            ((Label)wsEmployeeAccountInfo.ContentTemplateContainer.FindControl("lblUserWizardError")).Text = "";
            ((Label)wsEmployeeAccountInfo.ContentTemplateContainer.FindControl("lblUserWizardError")).Enabled = false;
            e.Cancel = false;
        }
    }

    //Restarts the created user wizard when the button is clicked
    protected void cuwCreateUser_ContinueButtonClick(object sender, EventArgs e)
    {
        cuwCreateUser.ActiveStepIndex = 0;
    }
}