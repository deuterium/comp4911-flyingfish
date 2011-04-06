<%@ Page Title="Account" Language="C#" MasterPageFile="~/FlyingFishMasterPage.master" AutoEventWireup="true" CodeFile="Account.aspx.cs" Inherits="Account" %>

<asp:Content ID="Content2" ContentPlaceHolderID="content" Runat="Server">
<p class="cent">
This is your account page. Here, you can view the sick days and vacation 
leave days you have available as well as change your password. It is 
recommended that you change your password once in a while to maintain 
security for your account.
</p>
<table class="cent">
    <tr>
        <td>
            <asp:Label ID="lblSickDays" runat="server" Text="Sick days:"></asp:Label>
        </td>
        <td>
            <asp:Label ID="lblSickDaysAmount" runat="server" Text=""></asp:Label>
        </td>
        <td rowspan="2" style="padding-left: 30px; width: 500px;">
            <asp:ChangePassword ID="ChangePassword1" runat="server" CssClass="cent">
                <LabelStyle HorizontalAlign="Left" />
                <SuccessTemplate>
                    <table cellpadding="1" cellspacing="0" style="border-collapse:collapse;">
                        <tr>
                            <td>
                                <table cellpadding="0">
                                    <tr>
                                        <td align="center" colspan="2">
                                            Change Password Complete</td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Your password has been changed!</td>
                                    </tr>
                                    <tr>
                                        <td align="right" colspan="2">
                                            <asp:Button ID="ContinuePushButton" runat="server" CausesValidation="False" 
                                                CommandName="Continue" oncommand="ContinuePushButton_Command" Text="Continue" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </SuccessTemplate>
            </asp:ChangePassword>
        </td>
    </tr>
    <tr>
        <td>
            <asp:Label ID="lblVacationDays" runat="server" Text="Vacation days:"></asp:Label>
        </td>
        <td>
            <asp:Label ID="lblVacationDaysAmount" runat="server" Text=""></asp:Label>
        </td>
    </tr>
</table>
</asp:Content>

