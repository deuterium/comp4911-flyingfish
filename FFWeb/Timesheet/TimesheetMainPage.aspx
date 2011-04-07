<%@ Page Title="" Language="C#" MasterPageFile="~/FlyingFishMasterPage.master" AutoEventWireup="true" CodeFile="TimesheetMainPage.aspx.cs" Inherits="Timesheet_TimesheetMainPage" %>

<asp:Content ID="ctnHeader" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="ctnBody" ContentPlaceHolderID="content" Runat="Server">

<h2>Timesheets</h2>
<p>
The timesheets are used to log hours for payment and to generate reports.
</p>

<h4>Saving and Submitting</h4>
<p>
Throughout the week, you can fill in a timesheet to log the hours you spent on each workpackage of each project. You can also log sick days, flex hours, and vacation time. You can see your spent and banked sick, flex, and vacation time by clicking on your username. If you’re taking a vacation, you can fill in timesheets for the weeks you’ll be away and fully enjoy your vacation.
After you’ve filled in a timesheet, you have 3 choices: save, submit, and use as default. Saving your timesheet will store it in the database so you can make changes to it later in the week. Submitting your timesheet sends it to your timesheet approver for approval and you are no longer able to make changes to it. The status (approved or rejected) of your current or past timesheets is shown on the timesheet page.
</p>

<h4>Viewing and Printing</h4>
<p>
You can view past timesheets by selecting a date and clicking the [Select] button, but you cannot edit these timesheets unless they have been rejected by your timesheet approver. You can print any timesheets by clicking the [Print] button.
</p>

<h4>Approving and Rejecting</h4>
<p>
If you are a Timesheet Approver, you can visit the Timesheet Approver page to approve or reject timesheets submitted by the employees you are assigned to. You can add comments to the timesheet header and select approve or reject.
</p>

</asp:Content>

