-- Rainbow Motions,  Mar-7-2011
-- Flying Fish - Project Management Application
-- Script used to populate the database with sample data.
-- SQL Express

---------------------------------------------------------------------------------
-- PersonLevel Table
---------------------------------------------------------------------------------
-- 2010
INSERT INTO [comp4911db].[dbo].[PersonLevel] (pLevel, rate, fiscalYear)
	VALUES ('DS', 87, 2010);
INSERT INTO [comp4911db].[dbo].[PersonLevel] (pLevel, rate, fiscalYear)
	VALUES ('JS', 100, 2010);
INSERT INTO [comp4911db].[dbo].[PersonLevel] (pLevel, rate, fiscalYear)
	VALUES ('P1', 110, 2010);
INSERT INTO [comp4911db].[dbo].[PersonLevel] (pLevel, rate, fiscalYear)
	VALUES ('P2', 135, 2010);
INSERT INTO [comp4911db].[dbo].[PersonLevel] (pLevel, rate, fiscalYear)
	VALUES ('P3', 166, 2010);
INSERT INTO [comp4911db].[dbo].[PersonLevel] (pLevel, rate, fiscalYear)
	VALUES ('P4', 220, 2010);
INSERT INTO [comp4911db].[dbo].[PersonLevel] (pLevel, rate, fiscalYear)
	VALUES ('P5', 255, 2010);
INSERT INTO [comp4911db].[dbo].[PersonLevel] (pLevel, rate, fiscalYear)
	VALUES ('P6', 275, 2010);
-- 2011
INSERT INTO [comp4911db].[dbo].[PersonLevel] (pLevel, rate, fiscalYear)
	VALUES ('DS', 97, 2011);
INSERT INTO [comp4911db].[dbo].[PersonLevel] (pLevel, rate, fiscalYear)
	VALUES ('JS', 107, 2011);
INSERT INTO [comp4911db].[dbo].[PersonLevel] (pLevel, rate, fiscalYear)
	VALUES ('P1', 115, 2011);
INSERT INTO [comp4911db].[dbo].[PersonLevel] (pLevel, rate, fiscalYear)
	VALUES ('P2', 147, 2011);
INSERT INTO [comp4911db].[dbo].[PersonLevel] (pLevel, rate, fiscalYear)
	VALUES ('P3', 179, 2011);
INSERT INTO [comp4911db].[dbo].[PersonLevel] (pLevel, rate, fiscalYear)
	VALUES ('P4', 225, 2011);
INSERT INTO [comp4911db].[dbo].[PersonLevel] (pLevel, rate, fiscalYear)
	VALUES ('P5', 266, 2011);
INSERT INTO [comp4911db].[dbo].[PersonLevel] (pLevel, rate, fiscalYear)
	VALUES ('P6', 300, DEFAULT);

---------------------------------------------------------------------------------
-- Employee Table
---------------------------------------------------------------------------------
INSERT INTO [comp4911db].[dbo].[Employee] (empId, firstName, lastName, supervisor, approver, minHoursPerWeek, vacationLeave, sickDays, flexHours, isActive)
VALUES (0, 'Bruce', 'Link', 0, 0, 10, 28, 0, 5, DEFAULT);

INSERT INTO [comp4911db].[dbo].[Employee] (empId, firstName, lastName, supervisor, approver, minHoursPerWeek, vacationLeave, sickDays, flexHours, isActive)
VALUES (1, 'Chris', 'Wood', 0, 0, 40, 20, 1, 10, DEFAULT);

INSERT INTO [comp4911db].[dbo].[Employee] (empId, firstName, lastName, supervisor, approver, minHoursPerWeek, vacationLeave, sickDays, flexHours, isActive)
VALUES (8, 'Mike', 'Anderson', 1, 1, 32, 0, 0, 5, DEFAULT);

INSERT INTO [comp4911db].[dbo].[Employee] (empId, firstName, lastName, supervisor, approver, minHoursPerWeek, vacationLeave, sickDays, flexHours, isActive)
VALUES (2, 'Jeffery', 'Wong', 1, 8, 40, 15, 0, 20, DEFAULT);

INSERT INTO [comp4911db].[dbo].[Employee] (empId, firstName, lastName, supervisor, approver, minHoursPerWeek, vacationLeave, sickDays, flexHours, isActive)
VALUES (3, 'Nicholas', 'Tagle', 1, 8, 40, 21, 4, 2, DEFAULT);

INSERT INTO [comp4911db].[dbo].[Employee] (empId, firstName, lastName, supervisor, approver, minHoursPerWeek, vacationLeave, sickDays, flexHours, isActive)
VALUES (4, 'Fausto', 'Faioli', 1, 8, 40, 21, 0, 14, DEFAULT);

INSERT INTO [comp4911db].[dbo].[Employee] (empId, firstName, lastName, supervisor, approver, minHoursPerWeek, vacationLeave, sickDays, flexHours, isActive)
VALUES (5, 'Kaldra', 'Li', 1, 8, 40, 21, 0, 0, DEFAULT);

INSERT INTO [comp4911db].[dbo].[Employee] (empId, firstName, lastName, supervisor, approver, minHoursPerWeek, vacationLeave, sickDays, flexHours, isActive)
VALUES (6, 'Saad', 'Shaharyar', 1, 8, 40, 21, 4, 0, DEFAULT);

INSERT INTO [comp4911db].[dbo].[Employee] (empId, firstName, lastName, supervisor, approver, minHoursPerWeek, vacationLeave, sickDays, flexHours, isActive)
VALUES (7, 'Kalen', 'Wessel', 1, 8, 20, 21, 11, 14, DEFAULT);

INSERT INTO [comp4911db].[dbo].[Employee] (empId, firstName, lastName, supervisor, approver, minHoursPerWeek, vacationLeave, sickDays, flexHours, isActive)
VALUES (9, 'Lindsay', 'Fester', 1, 8, 40, 21, 4, -14, DEFAULT);

---------------------------------------------------------------------------------
-- aspnet_Membership Table
---------------------------------------------------------------------------------
DECLARE @ApplicationName nvarchar(256);
DECLARE @UserName nvarchar(256);
DECLARE @Password nvarchar(128);
DECLARE @PasswordSalt nvarchar(128);
DECLARE @Email nvarchar(256);
DECLARE @PasswordQuestion nvarchar(256);
DECLARE @PasswordAnswer nvarchar(128);
DECLARE @IsApproved bit;
DECLARE @CurrentTimeUtc datetime;
DECLARE @CreateDate datetime;
DECLARE @UniqueEmail int;
DECLARE @PasswordFormat int;
DECLARE @UserId uniqueidentifier;

SET @ApplicationName = '/';
SET @UserName = 'bruce_link';
SET @Password = 'c1xoSwfOQNeXeBAuZTjj/hjaogk='; --rainbow123$
SET @PasswordSalt = 'dHfECgAbLW7ugp57rruFAA==';
SET @Email = 'blink@bcit.ca';
SET @PasswordQuestion = 'q';
SET @PasswordAnswer = 'gKq5GdACsQ3Xw8+A3dUg2T6s+vs='; -- a
SET @IsApproved = 1;
SET @CurrentTimeUtc = GETDATE();
SET @CreateDate = GETDATE();
SET @UniqueEmail = 0;
SET @PasswordFormat = 1;
SET @UserId = 'E241319F-825A-4B46-9393-C862FFC7B07C';

EXEC [comp4911db].[dbo].[aspnet_Membership_CreateUser] @ApplicationName,@UserName,@Password,@PasswordSalt,@Email,@PasswordQuestion,@PasswordAnswer,@IsApproved,@CurrentTimeUtc,@CreateDate,@UniqueEmail,@PasswordFormat,@UserId;
GO

DECLARE @ApplicationName nvarchar(256);
DECLARE @UserName nvarchar(256);
DECLARE @Password nvarchar(128);
DECLARE @PasswordSalt nvarchar(128);
DECLARE @Email nvarchar(256);
DECLARE @PasswordQuestion nvarchar(256);
DECLARE @PasswordAnswer nvarchar(128);
DECLARE @IsApproved bit;
DECLARE @CurrentTimeUtc datetime;
DECLARE @CreateDate datetime;
DECLARE @UniqueEmail int;
DECLARE @PasswordFormat int;
DECLARE @UserId uniqueidentifier;

SET @ApplicationName = '/';
SET @UserName = 'chris_wood';
SET @Password = 'c1xoSwfOQNeXeBAuZTjj/hjaogk='; --rainbow123$
SET @PasswordSalt = 'dHfECgAbLW7ugp57rruFAA==';
SET @Email = 'chris@bcit.ca';
SET @PasswordQuestion = 'q';
SET @PasswordAnswer = 'gKq5GdACsQ3Xw8+A3dUg2T6s+vs='; -- a
SET @IsApproved = 1;
SET @CurrentTimeUtc = GETDATE();
SET @CreateDate = GETDATE();
SET @UniqueEmail = 0;
SET @PasswordFormat = 1;
SET @UserId = 'D4A83BBF-9565-4CEF-8351-E22A47C5282C';

EXEC [comp4911db].[dbo].[aspnet_Membership_CreateUser] @ApplicationName,@UserName,@Password,@PasswordSalt,@Email,@PasswordQuestion,@PasswordAnswer,@IsApproved,@CurrentTimeUtc,@CreateDate,@UniqueEmail,@PasswordFormat,@UserId;
GO

DECLARE @ApplicationName nvarchar(256);
DECLARE @UserName nvarchar(256);
DECLARE @Password nvarchar(128);
DECLARE @PasswordSalt nvarchar(128);
DECLARE @Email nvarchar(256);
DECLARE @PasswordQuestion nvarchar(256);
DECLARE @PasswordAnswer nvarchar(128);
DECLARE @IsApproved bit;
DECLARE @CurrentTimeUtc datetime;
DECLARE @CreateDate datetime;
DECLARE @UniqueEmail int;
DECLARE @PasswordFormat int;
DECLARE @UserId uniqueidentifier;

SET @ApplicationName = '/';
SET @UserName = 'mike_anderson';
SET @Password = 'c1xoSwfOQNeXeBAuZTjj/hjaogk='; --rainbow123$
SET @PasswordSalt = 'dHfECgAbLW7ugp57rruFAA==';
SET @Email = 'mike@bcit.ca';
SET @PasswordQuestion = 'q';
SET @PasswordAnswer = 'gKq5GdACsQ3Xw8+A3dUg2T6s+vs='; -- a
SET @IsApproved = 1;
SET @CurrentTimeUtc = GETDATE();
SET @CreateDate = GETDATE();
SET @UniqueEmail = 0;
SET @PasswordFormat = 1;
SET @UserId = 'C6B1CF3A-1E9B-4C2A-BDBC-B7725D0F6139';

EXEC [comp4911db].[dbo].[aspnet_Membership_CreateUser] @ApplicationName,@UserName,@Password,@PasswordSalt,@Email,@PasswordQuestion,@PasswordAnswer,@IsApproved,@CurrentTimeUtc,@CreateDate,@UniqueEmail,@PasswordFormat,@UserId;
GO

DECLARE @ApplicationName nvarchar(256);
DECLARE @UserName nvarchar(256);
DECLARE @Password nvarchar(128);
DECLARE @PasswordSalt nvarchar(128);
DECLARE @Email nvarchar(256);
DECLARE @PasswordQuestion nvarchar(256);
DECLARE @PasswordAnswer nvarchar(128);
DECLARE @IsApproved bit;
DECLARE @CurrentTimeUtc datetime;
DECLARE @CreateDate datetime;
DECLARE @UniqueEmail int;
DECLARE @PasswordFormat int;
DECLARE @UserId uniqueidentifier;

SET @ApplicationName = '/';
SET @UserName = 'jeffery_wong';
SET @Password = 'c1xoSwfOQNeXeBAuZTjj/hjaogk='; --rainbow123$
SET @PasswordSalt = 'dHfECgAbLW7ugp57rruFAA==';
SET @Email = 'jeffery@bcit.ca';
SET @PasswordQuestion = 'q';
SET @PasswordAnswer = 'gKq5GdACsQ3Xw8+A3dUg2T6s+vs='; -- a
SET @IsApproved = 1;
SET @CurrentTimeUtc = GETDATE();
SET @CreateDate = GETDATE();
SET @UniqueEmail = 0;
SET @PasswordFormat = 1;
SET @UserId = '4D0A9942-0C2A-4BB4-9802-7A82980FC368';

EXEC [comp4911db].[dbo].[aspnet_Membership_CreateUser] @ApplicationName,@UserName,@Password,@PasswordSalt,@Email,@PasswordQuestion,@PasswordAnswer,@IsApproved,@CurrentTimeUtc,@CreateDate,@UniqueEmail,@PasswordFormat,@UserId;
GO

DECLARE @ApplicationName nvarchar(256);
DECLARE @UserName nvarchar(256);
DECLARE @Password nvarchar(128);
DECLARE @PasswordSalt nvarchar(128);
DECLARE @Email nvarchar(256);
DECLARE @PasswordQuestion nvarchar(256);
DECLARE @PasswordAnswer nvarchar(128);
DECLARE @IsApproved bit;
DECLARE @CurrentTimeUtc datetime;
DECLARE @CreateDate datetime;
DECLARE @UniqueEmail int;
DECLARE @PasswordFormat int;
DECLARE @UserId uniqueidentifier;

SET @ApplicationName = '/';
SET @UserName = 'nick_tagle';
SET @Password = 'c1xoSwfOQNeXeBAuZTjj/hjaogk='; --rainbow123$
SET @PasswordSalt = 'dHfECgAbLW7ugp57rruFAA==';
SET @Email = 'nick@bcit.ca';
SET @PasswordQuestion = 'q';
SET @PasswordAnswer = 'gKq5GdACsQ3Xw8+A3dUg2T6s+vs='; -- a
SET @IsApproved = 1;
SET @CurrentTimeUtc = GETDATE();
SET @CreateDate = GETDATE();
SET @UniqueEmail = 0;
SET @PasswordFormat = 1;
SET @UserId = '7283D743-B1D3-4E63-AB83-55FA41810CE3';

EXEC [comp4911db].[dbo].[aspnet_Membership_CreateUser] @ApplicationName,@UserName,@Password,@PasswordSalt,@Email,@PasswordQuestion,@PasswordAnswer,@IsApproved,@CurrentTimeUtc,@CreateDate,@UniqueEmail,@PasswordFormat,@UserId;
GO

DECLARE @ApplicationName nvarchar(256);
DECLARE @UserName nvarchar(256);
DECLARE @Password nvarchar(128);
DECLARE @PasswordSalt nvarchar(128);
DECLARE @Email nvarchar(256);
DECLARE @PasswordQuestion nvarchar(256);
DECLARE @PasswordAnswer nvarchar(128);
DECLARE @IsApproved bit;
DECLARE @CurrentTimeUtc datetime;
DECLARE @CreateDate datetime;
DECLARE @UniqueEmail int;
DECLARE @PasswordFormat int;
DECLARE @UserId uniqueidentifier;

SET @ApplicationName = '/';
SET @UserName = 'fausto_faioli';
SET @Password = 'c1xoSwfOQNeXeBAuZTjj/hjaogk='; --rainbow123$
SET @PasswordSalt = 'dHfECgAbLW7ugp57rruFAA==';
SET @Email = 'blink@bcit.ca';
SET @PasswordQuestion = 'q';
SET @PasswordAnswer = 'gKq5GdACsQ3Xw8+A3dUg2T6s+vs='; -- a
SET @IsApproved = 1;
SET @CurrentTimeUtc = GETDATE();
SET @CreateDate = GETDATE();
SET @UniqueEmail = 0;
SET @PasswordFormat = 1;
SET @UserId = 'AB91A45D-4A0C-4323-8862-560FE4BE3661';

EXEC [comp4911db].[dbo].[aspnet_Membership_CreateUser] @ApplicationName,@UserName,@Password,@PasswordSalt,@Email,@PasswordQuestion,@PasswordAnswer,@IsApproved,@CurrentTimeUtc,@CreateDate,@UniqueEmail,@PasswordFormat,@UserId;
GO

DECLARE @ApplicationName nvarchar(256);
DECLARE @UserName nvarchar(256);
DECLARE @Password nvarchar(128);
DECLARE @PasswordSalt nvarchar(128);
DECLARE @Email nvarchar(256);
DECLARE @PasswordQuestion nvarchar(256);
DECLARE @PasswordAnswer nvarchar(128);
DECLARE @IsApproved bit;
DECLARE @CurrentTimeUtc datetime;
DECLARE @CreateDate datetime;
DECLARE @UniqueEmail int;
DECLARE @PasswordFormat int;
DECLARE @UserId uniqueidentifier;

SET @ApplicationName = '/';
SET @UserName = 'kaldra_li';
SET @Password = 'c1xoSwfOQNeXeBAuZTjj/hjaogk='; --rainbow123$
SET @PasswordSalt = 'dHfECgAbLW7ugp57rruFAA==';
SET @Email = 'kaldra@bcit.ca';
SET @PasswordQuestion = 'q';
SET @PasswordAnswer = 'gKq5GdACsQ3Xw8+A3dUg2T6s+vs='; -- a
SET @IsApproved = 1;
SET @CurrentTimeUtc = GETDATE();
SET @CreateDate = GETDATE();
SET @UniqueEmail = 0;
SET @PasswordFormat = 1;
SET @UserId = '53BC1185-80AD-4C13-B81E-D3D3498CE3B3';

EXEC [comp4911db].[dbo].[aspnet_Membership_CreateUser] @ApplicationName,@UserName,@Password,@PasswordSalt,@Email,@PasswordQuestion,@PasswordAnswer,@IsApproved,@CurrentTimeUtc,@CreateDate,@UniqueEmail,@PasswordFormat,@UserId;
GO

DECLARE @ApplicationName nvarchar(256);
DECLARE @UserName nvarchar(256);
DECLARE @Password nvarchar(128);
DECLARE @PasswordSalt nvarchar(128);
DECLARE @Email nvarchar(256);
DECLARE @PasswordQuestion nvarchar(256);
DECLARE @PasswordAnswer nvarchar(128);
DECLARE @IsApproved bit;
DECLARE @CurrentTimeUtc datetime;
DECLARE @CreateDate datetime;
DECLARE @UniqueEmail int;
DECLARE @PasswordFormat int;
DECLARE @UserId uniqueidentifier;

SET @ApplicationName = '/';
SET @UserName = 'saad_shaharyar';
SET @Password = 'c1xoSwfOQNeXeBAuZTjj/hjaogk='; --rainbow123$
SET @PasswordSalt = 'dHfECgAbLW7ugp57rruFAA==';
SET @Email = 'saad@bcit.ca';
SET @PasswordQuestion = 'q';
SET @PasswordAnswer = 'gKq5GdACsQ3Xw8+A3dUg2T6s+vs='; -- a
SET @IsApproved = 1;
SET @CurrentTimeUtc = GETDATE();
SET @CreateDate = GETDATE();
SET @UniqueEmail = 0;
SET @PasswordFormat = 1;
SET @UserId = '8AC03EAE-7876-4807-988A-E3802E9FD441';

EXEC [comp4911db].[dbo].[aspnet_Membership_CreateUser] @ApplicationName,@UserName,@Password,@PasswordSalt,@Email,@PasswordQuestion,@PasswordAnswer,@IsApproved,@CurrentTimeUtc,@CreateDate,@UniqueEmail,@PasswordFormat,@UserId;
GO

DECLARE @ApplicationName nvarchar(256);
DECLARE @UserName nvarchar(256);
DECLARE @Password nvarchar(128);
DECLARE @PasswordSalt nvarchar(128);
DECLARE @Email nvarchar(256);
DECLARE @PasswordQuestion nvarchar(256);
DECLARE @PasswordAnswer nvarchar(128);
DECLARE @IsApproved bit;
DECLARE @CurrentTimeUtc datetime;
DECLARE @CreateDate datetime;
DECLARE @UniqueEmail int;
DECLARE @PasswordFormat int;
DECLARE @UserId uniqueidentifier;

SET @ApplicationName = '/';
SET @UserName = 'kalen_wessel';
SET @Password = 'c1xoSwfOQNeXeBAuZTjj/hjaogk='; --rainbow123$
SET @PasswordSalt = 'dHfECgAbLW7ugp57rruFAA==';
SET @Email = 'kalen@bcit.ca';
SET @PasswordQuestion = 'q';
SET @PasswordAnswer = 'gKq5GdACsQ3Xw8+A3dUg2T6s+vs='; -- a
SET @IsApproved = 1;
SET @CurrentTimeUtc = GETDATE();
SET @CreateDate = GETDATE();
SET @UniqueEmail = 0;
SET @PasswordFormat = 1;
SET @UserId = '7387AA42-C040-4958-8BF5-7A3D91B8B81D';

EXEC [comp4911db].[dbo].[aspnet_Membership_CreateUser] @ApplicationName,@UserName,@Password,@PasswordSalt,@Email,@PasswordQuestion,@PasswordAnswer,@IsApproved,@CurrentTimeUtc,@CreateDate,@UniqueEmail,@PasswordFormat,@UserId;
GO

DECLARE @ApplicationName nvarchar(256);
DECLARE @UserName nvarchar(256);
DECLARE @Password nvarchar(128);
DECLARE @PasswordSalt nvarchar(128);
DECLARE @Email nvarchar(256);
DECLARE @PasswordQuestion nvarchar(256);
DECLARE @PasswordAnswer nvarchar(128);
DECLARE @IsApproved bit;
DECLARE @CurrentTimeUtc datetime;
DECLARE @CreateDate datetime;
DECLARE @UniqueEmail int;
DECLARE @PasswordFormat int;
DECLARE @UserId uniqueidentifier;

SET @ApplicationName = '/';
SET @UserName = 'lindsay_fester';
SET @Password = 'c1xoSwfOQNeXeBAuZTjj/hjaogk='; --rainbow123$
SET @PasswordSalt = 'dHfECgAbLW7ugp57rruFAA==';
SET @Email = 'lindsay@bcit.ca';
SET @PasswordQuestion = 'q';
SET @PasswordAnswer = 'gKq5GdACsQ3Xw8+A3dUg2T6s+vs='; -- a
SET @IsApproved = 1;
SET @CurrentTimeUtc = GETDATE();
SET @CreateDate = GETDATE();
SET @UniqueEmail = 0;
SET @PasswordFormat = 1;
SET @UserId = '973217DA-C5F7-4D15-A116-5124B6E65C95';

EXEC [comp4911db].[dbo].[aspnet_Membership_CreateUser] @ApplicationName,@UserName,@Password,@PasswordSalt,@Email,@PasswordQuestion,@PasswordAnswer,@IsApproved,@CurrentTimeUtc,@CreateDate,@UniqueEmail,@PasswordFormat,@UserId;
GO

---------------------------------------------------------------------------------
-- EmployeeMember Table
---------------------------------------------------------------------------------
INSERT INTO [comp4911db].[dbo].[EmployeeMembership] (empId, userId)
	VALUES ('0', 'E241319F-825A-4B46-9393-C862FFC7B07C');
INSERT INTO [comp4911db].[dbo].[EmployeeMembership] (empId, userId)
	VALUES ('1', 'D4A83BBF-9565-4CEF-8351-E22A47C5282C');
INSERT INTO [comp4911db].[dbo].[EmployeeMembership] (empId, userId)
	VALUES ('2', '4D0A9942-0C2A-4BB4-9802-7A82980FC368');
INSERT INTO [comp4911db].[dbo].[EmployeeMembership] (empId, userId)
	VALUES ('3', '7283D743-B1D3-4E63-AB83-55FA41810CE3');
INSERT INTO [comp4911db].[dbo].[EmployeeMembership] (empId, userId)
	VALUES ('4', 'AB91A45D-4A0C-4323-8862-560FE4BE3661');
INSERT INTO [comp4911db].[dbo].[EmployeeMembership] (empId, userId)
	VALUES ('5', '53BC1185-80AD-4C13-B81E-D3D3498CE3B3');
INSERT INTO [comp4911db].[dbo].[EmployeeMembership] (empId, userId)
	VALUES ('6', '8AC03EAE-7876-4807-988A-E3802E9FD441');
INSERT INTO [comp4911db].[dbo].[EmployeeMembership] (empId, userId)
	VALUES ('7', '7387AA42-C040-4958-8BF5-7A3D91B8B81D');
INSERT INTO [comp4911db].[dbo].[EmployeeMembership] (empId, userId)
	VALUES ('8', 'C6B1CF3A-1E9B-4C2A-BDBC-B7725D0F6139');
INSERT INTO [comp4911db].[dbo].[EmployeeMembership] (empId, userId)
	VALUES ('9', '973217DA-C5F7-4D15-A116-5124B6E65C95');
	
---------------------------------------------------------------------------------
-- aspnet_UsersInRoles Table
---------------------------------------------------------------------------------
-- Employees
INSERT INTO [comp4911db].[dbo].[aspnet_UsersInRoles] (roleId, userId)
	VALUES ('67DA9471-9374-44FC-91FA-2F4EDF54EED1', 'E241319F-825A-4B46-9393-C862FFC7B07C');
INSERT INTO [comp4911db].[dbo].[aspnet_UsersInRoles] (roleId, userId)
	VALUES ('67DA9471-9374-44FC-91FA-2F4EDF54EED1', 'D4A83BBF-9565-4CEF-8351-E22A47C5282C');
INSERT INTO [comp4911db].[dbo].[aspnet_UsersInRoles] (roleId, userId)
	VALUES ('67DA9471-9374-44FC-91FA-2F4EDF54EED1', '4D0A9942-0C2A-4BB4-9802-7A82980FC368');
INSERT INTO [comp4911db].[dbo].[aspnet_UsersInRoles] (roleId, userId)
	VALUES ('67DA9471-9374-44FC-91FA-2F4EDF54EED1', '7283D743-B1D3-4E63-AB83-55FA41810CE3');
INSERT INTO [comp4911db].[dbo].[aspnet_UsersInRoles] (roleId, userId)
	VALUES ('67DA9471-9374-44FC-91FA-2F4EDF54EED1', 'AB91A45D-4A0C-4323-8862-560FE4BE3661');
INSERT INTO [comp4911db].[dbo].[aspnet_UsersInRoles] (roleId, userId)
	VALUES ('67DA9471-9374-44FC-91FA-2F4EDF54EED1', '53BC1185-80AD-4C13-B81E-D3D3498CE3B3');
INSERT INTO [comp4911db].[dbo].[aspnet_UsersInRoles] (roleId, userId)
	VALUES ('67DA9471-9374-44FC-91FA-2F4EDF54EED1', '8AC03EAE-7876-4807-988A-E3802E9FD441');
INSERT INTO [comp4911db].[dbo].[aspnet_UsersInRoles] (roleId, userId)
	VALUES ('67DA9471-9374-44FC-91FA-2F4EDF54EED1', '7387AA42-C040-4958-8BF5-7A3D91B8B81D');
INSERT INTO [comp4911db].[dbo].[aspnet_UsersInRoles] (roleId, userId)
	VALUES ('67DA9471-9374-44FC-91FA-2F4EDF54EED1', 'C6B1CF3A-1E9B-4C2A-BDBC-B7725D0F6139');
INSERT INTO [comp4911db].[dbo].[aspnet_UsersInRoles] (roleId, userId)
	VALUES ('67DA9471-9374-44FC-91FA-2F4EDF54EED1', '973217DA-C5F7-4D15-A116-5124B6E65C95');

-- Project Managers
INSERT INTO [comp4911db].[dbo].[aspnet_UsersInRoles] (roleId, userId)
	VALUES ('0C8981A5-A7B3-4020-86C3-E16A0FE45EC3', 'E241319F-825A-4B46-9393-C862FFC7B07C');
INSERT INTO [comp4911db].[dbo].[aspnet_UsersInRoles] (roleId, userId)
	VALUES ('0C8981A5-A7B3-4020-86C3-E16A0FE45EC3', 'D4A83BBF-9565-4CEF-8351-E22A47C5282C');

-- Timesheet Approvers
INSERT INTO [comp4911db].[dbo].[aspnet_UsersInRoles] (roleId, userId)
	VALUES ('6ABFAB3A-A484-4A16-97B3-DAE17E55ECEA', 'E241319F-825A-4B46-9393-C862FFC7B07C');
INSERT INTO [comp4911db].[dbo].[aspnet_UsersInRoles] (roleId, userId)
	VALUES ('6ABFAB3A-A484-4A16-97B3-DAE17E55ECEA', 'C6B1CF3A-1E9B-4C2A-BDBC-B7725D0F6139');
	
-- HR Staff
INSERT INTO [comp4911db].[dbo].[aspnet_UsersInRoles] (roleId, userId)
	VALUES ('CEE18FE3-BE0E-417B-A66B-94B76E328100', 'E241319F-825A-4B46-9393-C862FFC7B07C');
INSERT INTO [comp4911db].[dbo].[aspnet_UsersInRoles] (roleId, userId)
	VALUES ('CEE18FE3-BE0E-417B-A66B-94B76E328100', '7283D743-B1D3-4E63-AB83-55FA41810CE3');
INSERT INTO [comp4911db].[dbo].[aspnet_UsersInRoles] (roleId, userId)
	VALUES ('CEE18FE3-BE0E-417B-A66B-94B76E328100', 'AB91A45D-4A0C-4323-8862-560FE4BE3661');

-- Responsible Engineer
INSERT INTO [comp4911db].[dbo].[aspnet_UsersInRoles] (roleId, userId)
	VALUES ('4C33878C-860C-4D37-B4E8-02E993E7F6F3', '4D0A9942-0C2A-4BB4-9802-7A82980FC368');
INSERT INTO [comp4911db].[dbo].[aspnet_UsersInRoles] (roleId, userId)
	VALUES ('4C33878C-860C-4D37-B4E8-02E993E7F6F3', '7283D743-B1D3-4E63-AB83-55FA41810CE3');
INSERT INTO [comp4911db].[dbo].[aspnet_UsersInRoles] (roleId, userId)
	VALUES ('4C33878C-860C-4D37-B4E8-02E993E7F6F3', 'AB91A45D-4A0C-4323-8862-560FE4BE3661');
INSERT INTO [comp4911db].[dbo].[aspnet_UsersInRoles] (roleId, userId)
	VALUES ('4C33878C-860C-4D37-B4E8-02E993E7F6F3', '7387AA42-C040-4958-8BF5-7A3D91B8B81D');

-- Employee Manager (aka Supervisor)
INSERT INTO [comp4911db].[dbo].[aspnet_UsersInRoles] (roleId, userId)
	VALUES ('A00A755E-210D-4F65-A039-CE4F902307CC', 'E241319F-825A-4B46-9393-C862FFC7B07C');
INSERT INTO [comp4911db].[dbo].[aspnet_UsersInRoles] (roleId, userId)
	VALUES ('A00A755E-210D-4F65-A039-CE4F902307CC', 'D4A83BBF-9565-4CEF-8351-E22A47C5282C');

---------------------------------------------------------------------------------
-- EmployeePersonLevel Table
---------------------------------------------------------------------------------
INSERT INTO [comp4911db].[dbo].[EmployeePersonLevel] (dateUpdated, empId, pLevel, fiscalYear)
	VALUES ('2010/01/01', 0, 'P6', 2010);

INSERT INTO [comp4911db].[dbo].[EmployeePersonLevel] (dateUpdated, empId, pLevel, fiscalYear)
	VALUES ('2011/01/01', 0, 'P6', 2011);
	
INSERT INTO [comp4911db].[dbo].[EmployeePersonLevel] (dateUpdated, empId, pLevel, fiscalYear)
	VALUES ('2010/01/01', 1, 'P3', 2010);

INSERT INTO [comp4911db].[dbo].[EmployeePersonLevel] (dateUpdated, empId, pLevel, fiscalYear)
	VALUES ('2011/01/01', 1, 'P4', 2011);

INSERT INTO [comp4911db].[dbo].[EmployeePersonLevel] (dateUpdated, empId, pLevel, fiscalYear)
	VALUES ('2011/02/01', 1, 'P5', 2011);
	
INSERT INTO [comp4911db].[dbo].[EmployeePersonLevel] (dateUpdated, empId, pLevel, fiscalYear)
	VALUES ('2011/01/01', 2, 'P4', 2011);

INSERT INTO [comp4911db].[dbo].[EmployeePersonLevel] (dateUpdated, empId, pLevel, fiscalYear)
	VALUES ('2011/02/01', 2, 'P3', 2011);

INSERT INTO [comp4911db].[dbo].[EmployeePersonLevel] (dateUpdated, empId, pLevel, fiscalYear)
	VALUES ('2011/01/01', 3, 'P4', 2011);
	
INSERT INTO [comp4911db].[dbo].[EmployeePersonLevel] (dateUpdated, empId, pLevel, fiscalYear)
	VALUES ('2011/03/01', 3, 'P5', 2011);

INSERT INTO [comp4911db].[dbo].[EmployeePersonLevel] (dateUpdated, empId, pLevel, fiscalYear)
	VALUES ('2011/01/01', 4, 'P3', 2011);
	
INSERT INTO [comp4911db].[dbo].[EmployeePersonLevel] (dateUpdated, empId, pLevel, fiscalYear)
	VALUES ('2011/02/01', 4, 'P4', 2011);
	
INSERT INTO [comp4911db].[dbo].[EmployeePersonLevel] (dateUpdated, empId, pLevel, fiscalYear)
	VALUES ('2011/01/01', 5, 'P3', 2011);

INSERT INTO [comp4911db].[dbo].[EmployeePersonLevel] (dateUpdated, empId, pLevel, fiscalYear)
	VALUES ('2011/01/01', 6, 'P2', 2011);

INSERT INTO [comp4911db].[dbo].[EmployeePersonLevel] (dateUpdated, empId, pLevel, fiscalYear)
	VALUES ('2011/01/01', 7, 'P1', 2011);

INSERT INTO [comp4911db].[dbo].[EmployeePersonLevel] (dateUpdated, empId, pLevel, fiscalYear)
	VALUES ('2011/03/23', 7, 'P1', 2011);

INSERT INTO [comp4911db].[dbo].[EmployeePersonLevel] (dateUpdated, empId, pLevel, fiscalYear)
	VALUES ('2011/01/01', 8, 'P1', 2011);

INSERT INTO [comp4911db].[dbo].[EmployeePersonLevel] (dateUpdated, empId, pLevel, fiscalYear)
	VALUES ('2011/01/01', 9, 'P2', 2011);

INSERT INTO [comp4911db].[dbo].[EmployeePersonLevel] (dateUpdated, empId, pLevel, fiscalYear)
	VALUES ('2011/03/01', 9, 'P3', 2011);
	
---------------------------------------------------------------------------------
-- HumanResourcesStaff Table
---------------------------------------------------------------------------------
INSERT INTO [comp4911db].[dbo].[HumanResourcesStaff] (empId)
	VALUES (0);
INSERT INTO [comp4911db].[dbo].[HumanResourcesStaff] (empId)
	VALUES (3);
INSERT INTO [comp4911db].[dbo].[HumanResourcesStaff] (empId)
	VALUES (4);

---------------------------------------------------------------------------------
-- Project Table
---------------------------------------------------------------------------------
INSERT INTO [comp4911db].[dbo].[Project] (projID, projName, manager, allocated_dollars, unallocated_dollars)
	VALUES (4911, 'FlyingFish', 1, 5000, 5000);

---------------------------------------------------------------------------------
-- EmployeeProject
---------------------------------------------------------------------------------
INSERT INTO [comp4911db].[dbo].[EmployeeProject] (projID, empId)
	VALUES (4911, 0);

INSERT INTO [comp4911db].[dbo].[EmployeeProject] (projID, empId)
	VALUES (4911, 1);

INSERT INTO [comp4911db].[dbo].[EmployeeProject] (projID, empId)
	VALUES (4911, 2);

INSERT INTO [comp4911db].[dbo].[EmployeeProject] (projID, empId)
	VALUES (4911, 3);

INSERT INTO [comp4911db].[dbo].[EmployeeProject] (projID, empId)
	VALUES (4911, 4);

INSERT INTO [comp4911db].[dbo].[EmployeeProject] (projID, empId)
	VALUES (4911, 5);

INSERT INTO [comp4911db].[dbo].[EmployeeProject] (projID, empId)
	VALUES (4911, 6);

INSERT INTO [comp4911db].[dbo].[EmployeeProject] (projID, empId)
	VALUES (4911, 7);

INSERT INTO [comp4911db].[dbo].[EmployeeProject] (projID, empId)
	VALUES (4911, 8);

INSERT INTO [comp4911db].[dbo].[EmployeeProject] (projID, empId)
	VALUES (4911, 9);

-- System Table (for Sick Days, Vacation Leave, Flex Hours, Holidays)
INSERT INTO [comp4911db].[dbo].[EmployeeProject] (projID, empId)
	VALUES (10, 0);

INSERT INTO [comp4911db].[dbo].[EmployeeProject] (projID, empId)
	VALUES (10, 1);

INSERT INTO [comp4911db].[dbo].[EmployeeProject] (projID, empId)
	VALUES (10, 2);

INSERT INTO [comp4911db].[dbo].[EmployeeProject] (projID, empId)
	VALUES (10, 3);

INSERT INTO [comp4911db].[dbo].[EmployeeProject] (projID, empId)
	VALUES (10, 4);

INSERT INTO [comp4911db].[dbo].[EmployeeProject] (projID, empId)
	VALUES (10, 5);

INSERT INTO [comp4911db].[dbo].[EmployeeProject] (projID, empId)
	VALUES (10, 6);

INSERT INTO [comp4911db].[dbo].[EmployeeProject] (projID, empId)
	VALUES (10, 7);

INSERT INTO [comp4911db].[dbo].[EmployeeProject] (projID, empId)
	VALUES (10, 8);

INSERT INTO [comp4911db].[dbo].[EmployeeProject] (projID, empId)
	VALUES (10, 9);

---------------------------------------------------------------------------------
-- WorkPackage Table
---------------------------------------------------------------------------------
INSERT INTO [comp4911db].[dbo].[WorkPackage] (projID, wpId, name, description, unallocated_dollars, allocated_dollars)
	VALUES (4911, '1', 'Inception', 'No description', 0, 1000);

INSERT INTO [comp4911db].[dbo].[WorkPackage] (projID, wpId, name, description, unallocated_dollars, allocated_dollars)
	VALUES (4911, '2', 'Ellaboration', 'No description', 0, 500);

INSERT INTO [comp4911db].[dbo].[WorkPackage] (projID, wpId, name, description, unallocated_dollars, allocated_dollars)
	VALUES (4911, '3', 'Construction 1', 'No description', 500, 500);
	
INSERT INTO [comp4911db].[dbo].[WorkPackage] (projID, wpId, name, description, unallocated_dollars, allocated_dollars)
	VALUES (4911, '4', 'Construction 2', 'No description', 750, 250);

INSERT INTO [comp4911db].[dbo].[WorkPackage] (projID, wpId, name, description, unallocated_dollars, allocated_dollars)
	VALUES (4911, '5', 'Construction 3', 'No description', 1500, 0);

---------------------------------------------------------------------------------
-- EmployeeWorkPackage Table
---------------------------------------------------------------------------------
INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackage] (empId, projId, wpId)
	VALUES (0, 4911, '1');

INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackage] (empId, projId, wpId)
	VALUES (0, 4911, '2');

INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackage] (empId, projId, wpId)
	VALUES (0, 4911, '3');

INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackage] (empId, projId, wpId)
	VALUES (0, 4911, '4');

INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackage] (empId, projId, wpId)
	VALUES (1, 4911, '1');

INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackage] (empId, projId, wpId)
	VALUES (1, 4911, '2');

INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackage] (empId, projId, wpId)
	VALUES (1, 4911, '3');

INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackage] (empId, projId, wpId)
	VALUES (1, 4911, '4');

INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackage] (empId, projId, wpId)
	VALUES (2, 4911, '1');

INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackage] (empId, projId, wpId)
	VALUES (2, 4911, '2');

INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackage] (empId, projId, wpId)
	VALUES (2, 4911, '3');

INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackage] (empId, projId, wpId)
	VALUES (2, 4911, '4');

INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackage] (empId, projId, wpId)
	VALUES (3, 4911, '1');

INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackage] (empId, projId, wpId)
	VALUES (3, 4911, '2');

INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackage] (empId, projId, wpId)
	VALUES (3, 4911, '3');

INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackage] (empId, projId, wpId)
	VALUES (3, 4911, '4');

INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackage] (empId, projId, wpId)
	VALUES (4, 4911, '1');

INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackage] (empId, projId, wpId)
	VALUES (4, 4911, '2');

INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackage] (empId, projId, wpId)
	VALUES (4, 4911, '3');

INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackage] (empId, projId, wpId)
	VALUES (4, 4911, '4');

INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackage] (empId, projId, wpId)
	VALUES (5, 4911, '1');

INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackage] (empId, projId, wpId)
	VALUES (5, 4911, '2');

INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackage] (empId, projId, wpId)
	VALUES (5, 4911, '3');

INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackage] (empId, projId, wpId)
	VALUES (5, 4911, '4');

INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackage] (empId, projId, wpId)
	VALUES (6, 4911, '1');

INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackage] (empId, projId, wpId)
	VALUES (6, 4911, '2');

INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackage] (empId, projId, wpId)
	VALUES (6, 4911, '3');

INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackage] (empId, projId, wpId)
	VALUES (6, 4911, '4');

INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackage] (empId, projId, wpId)
	VALUES (7, 4911, '1');

INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackage] (empId, projId, wpId)
	VALUES (7, 4911, '2');

INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackage] (empId, projId, wpId)
	VALUES (7, 4911, '3');

INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackage] (empId, projId, wpId)
	VALUES (7, 4911, '4');

INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackage] (empId, projId, wpId)
	VALUES (8, 4911, '1');

INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackage] (empId, projId, wpId)
	VALUES (8, 4911, '2');

INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackage] (empId, projId, wpId)
	VALUES (8, 4911, '3');

INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackage] (empId, projId, wpId)
	VALUES (8, 4911, '4');

INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackage] (empId, projId, wpId)
	VALUES (9, 4911, '1');

INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackage] (empId, projId, wpId)
	VALUES (9, 4911, '2');

INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackage] (empId, projId, wpId)
	VALUES (9, 4911, '3');

INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackage] (empId, projId, wpId)
	VALUES (9, 4911, '4');

-- System SICK
INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackage] (empId, projId, wpId)
	VALUES (0, 10, 'SICK');
INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackage] (empId, projId, wpId)
	VALUES (1, 10, 'SICK');	
INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackage] (empId, projId, wpId)
	VALUES (2, 10, 'SICK');	
INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackage] (empId, projId, wpId)
	VALUES (3, 10, 'SICK');	
INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackage] (empId, projId, wpId)
	VALUES (4, 10, 'SICK');	
INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackage] (empId, projId, wpId)
	VALUES (5, 10, 'SICK');	
INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackage] (empId, projId, wpId)
	VALUES (6, 10, 'SICK');	
INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackage] (empId, projId, wpId)
	VALUES (7, 10, 'SICK');	
INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackage] (empId, projId, wpId)
	VALUES (8, 10, 'SICK');	
INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackage] (empId, projId, wpId)
	VALUES (9, 10, 'SICK');	

-- System FLEX
INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackage] (empId, projId, wpId)
	VALUES (0, 10, 'FLEX');
INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackage] (empId, projId, wpId)
	VALUES (1, 10, 'FLEX');	
INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackage] (empId, projId, wpId)
	VALUES (2, 10, 'FLEX');	
INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackage] (empId, projId, wpId)
	VALUES (3, 10, 'FLEX');	
INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackage] (empId, projId, wpId)
	VALUES (4, 10, 'FLEX');	
INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackage] (empId, projId, wpId)
	VALUES (5, 10, 'FLEX');	
INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackage] (empId, projId, wpId)
	VALUES (6, 10, 'FLEX');	
INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackage] (empId, projId, wpId)
	VALUES (7, 10, 'FLEX');	
INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackage] (empId, projId, wpId)
	VALUES (8, 10, 'FLEX');	
INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackage] (empId, projId, wpId)
	VALUES (9, 10, 'FLEX');	
	
-- System VACATION
INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackage] (empId, projId, wpId)
	VALUES (0, 10, 'VACATION');
INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackage] (empId, projId, wpId)
	VALUES (1, 10, 'VACATION');	
INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackage] (empId, projId, wpId)
	VALUES (2, 10, 'VACATION');	
INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackage] (empId, projId, wpId)
	VALUES (3, 10, 'VACATION');	
INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackage] (empId, projId, wpId)
	VALUES (4, 10, 'VACATION');	
INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackage] (empId, projId, wpId)
	VALUES (5, 10, 'VACATION');	
INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackage] (empId, projId, wpId)
	VALUES (6, 10, 'VACATION');	
INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackage] (empId, projId, wpId)
	VALUES (7, 10, 'VACATION');	
INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackage] (empId, projId, wpId)
	VALUES (8, 10, 'VACATION');	
INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackage] (empId, projId, wpId)
	VALUES (9, 10, 'VACATION');	

-- System HOLIDAY
INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackage] (empId, projId, wpId)
	VALUES (0, 10, 'HOLIDAY');
INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackage] (empId, projId, wpId)
	VALUES (1, 10, 'HOLIDAY');	
INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackage] (empId, projId, wpId)
	VALUES (2, 10, 'HOLIDAY');	
INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackage] (empId, projId, wpId)
	VALUES (3, 10, 'HOLIDAY');	
INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackage] (empId, projId, wpId)
	VALUES (4, 10, 'HOLIDAY');	
INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackage] (empId, projId, wpId)
	VALUES (5, 10, 'HOLIDAY');	
INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackage] (empId, projId, wpId)
	VALUES (6, 10, 'HOLIDAY');	
INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackage] (empId, projId, wpId)
	VALUES (7, 10, 'HOLIDAY');	
INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackage] (empId, projId, wpId)
	VALUES (8, 10, 'HOLIDAY');	
INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackage] (empId, projId, wpId)
	VALUES (9, 10, 'HOLIDAY');

---------------------------------------------------------------------------------
-- WorkPackageStatusReport
---------------------------------------------------------------------------------
INSERT INTO [comp4911db].[dbo].[WorkPackageStatusReport] (projId, wpId, startDate, endDate, comments, workAccomplished, workPlannedNext, problemsEncountered, problemsAnticipated)
	VALUES (4911, '1', '2011/01/01', '2011/03/01', 'No comment...', 'Lots was accomplished in Inception', 'Elaboration is the next phase',  'no problems', 'subversion problems');

INSERT INTO [comp4911db].[dbo].[WorkPackageStatusReport] (projId, wpId, startDate, endDate, comments, workAccomplished, workPlannedNext, problemsEncountered, problemsAnticipated)
	VALUES (4911, '2', '2011/01/01', '2011/03/01', 'No comment...', 'Lots was accomplished in Elaboration', 'Construction 1 is the next phase',  'changed subversion to GIT', 'database behind schedule');

INSERT INTO [comp4911db].[dbo].[WorkPackageStatusReport] (projId, wpId, startDate, endDate, comments, workAccomplished, workPlannedNext, problemsEncountered, problemsAnticipated)
	VALUES (4911, '3', '2011/01/01', '2011/03/01', 'No comment...', 'Lots was accomplished in Construction 1', 'Construction 2 is the next phase',  'subversion  problems', 'subversion problems');

---------------------------------------------------------------------------------
-- EmployeeWorkPackageETC Table
---------------------------------------------------------------------------------
INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackageETC] (empId, projId, wpId, dateUpdated, ETC_days)
	VALUES (0, 4911, '1', '2011/01/03', 0);

INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackageETC] (empId, projId, wpId, dateUpdated, ETC_days)
	VALUES (0, 4911, '2', '2011/01/10', 0);

INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackageETC] (empId, projId, wpId, dateUpdated, ETC_days)
	VALUES (0, 4911, '3', '2011/01/17', 20);

INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackageETC] (empId, projId, wpId, dateUpdated, ETC_days)
	VALUES (1, 4911, '1', '2011/01/03', 0);

INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackageETC] (empId, projId, wpId, dateUpdated, ETC_days)
	VALUES (1, 4911, '2', '2011/01/10', 0);

INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackageETC] (empId, projId, wpId, dateUpdated, ETC_days)
	VALUES (1, 4911, '3', '2011/01/17', 15);

INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackageETC] (empId, projId, wpId, dateUpdated, ETC_days)
	VALUES (2, 4911, '1', '2011/01/03', 0);

INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackageETC] (empId, projId, wpId, dateUpdated, ETC_days)
	VALUES (2, 4911, '2', '2011/01/10', 0);

INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackageETC] (empId, projId, wpId, dateUpdated, ETC_days)
	VALUES (2, 4911, '3', '2011/01/17', 15);

INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackageETC] (empId, projId, wpId, dateUpdated, ETC_days)
	VALUES (3, 4911, '1', '2011/01/03', 0);

INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackageETC] (empId, projId, wpId, dateUpdated, ETC_days)
	VALUES (3, 4911, '2', '2011/01/10', 0);

INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackageETC] (empId, projId, wpId, dateUpdated, ETC_days)
	VALUES (3, 4911, '3', '2011/01/17', 15);

INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackageETC] (empId, projId, wpId, dateUpdated, ETC_days)
	VALUES (4, 4911, '1', '2011/01/03', 0);

INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackageETC] (empId, projId, wpId, dateUpdated, ETC_days)
	VALUES (4, 4911, '2', '2011/01/10', 0);

INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackageETC] (empId, projId, wpId, dateUpdated, ETC_days)
	VALUES (4, 4911, '3', '2011/01/17', 15);

INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackageETC] (empId, projId, wpId, dateUpdated, ETC_days)
	VALUES (5, 4911, '1', '2011/01/03', 0);

INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackageETC] (empId, projId, wpId, dateUpdated, ETC_days)
	VALUES (5, 4911, '2', '2011/01/10', 0);

INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackageETC] (empId, projId, wpId, dateUpdated, ETC_days)
	VALUES (5, 4911, '3', '2011/01/17', 15);

INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackageETC] (empId, projId, wpId, dateUpdated, ETC_days)
	VALUES (6, 4911, '1', '2011/01/03', 0);

INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackageETC] (empId, projId, wpId, dateUpdated, ETC_days)
	VALUES (6, 4911, '2', '2011/01/10', 0);

INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackageETC] (empId, projId, wpId, dateUpdated, ETC_days)
	VALUES (6, 4911, '3', '2011/01/17', 15);

INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackageETC] (empId, projId, wpId, dateUpdated, ETC_days)
	VALUES (7, 4911, '1', '2011/01/03', 0);

INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackageETC] (empId, projId, wpId, dateUpdated, ETC_days)
	VALUES (7, 4911, '2', '2011/01/10', 0);

INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackageETC] (empId, projId, wpId, dateUpdated, ETC_days)
	VALUES (7, 4911, '3', '2011/01/17', 15);

INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackageETC] (empId, projId, wpId, dateUpdated, ETC_days)
	VALUES (8, 4911, '1', '2011/01/03', 0);

INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackageETC] (empId, projId, wpId, dateUpdated, ETC_days)
	VALUES (8, 4911, '2', '2011/01/10', 0);

INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackageETC] (empId, projId, wpId, dateUpdated, ETC_days)
	VALUES (8, 4911, '3', '2011/01/17', 15);

INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackageETC] (empId, projId, wpId, dateUpdated, ETC_days)
	VALUES (9, 4911, '1', '2011/01/03', 0);

INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackageETC] (empId, projId, wpId, dateUpdated, ETC_days)
	VALUES (9, 4911, '2', '2011/01/10', 0);

INSERT INTO [comp4911db].[dbo].[EmployeeWorkPackageETC] (empId, projId, wpId, dateUpdated, ETC_days)
	VALUES (9, 4911, '3', '2011/01/17', 15);

---------------------------------------------------------------------------------
-- WorkPackageResponsibleEngineer Table
---------------------------------------------------------------------------------
INSERT INTO [comp4911db].[dbo].[WorkPackageResponsibleEngineer] (projId, wpId, responsibleEngineer)
	VALUES (4911, '1', 2);

INSERT INTO [comp4911db].[dbo].[WorkPackageResponsibleEngineer] (projId, wpId, responsibleEngineer)
	VALUES (4911, '2', 3);

INSERT INTO [comp4911db].[dbo].[WorkPackageResponsibleEngineer] (projId, wpId, responsibleEngineer)
	VALUES (4911, '3', 4);

INSERT INTO [comp4911db].[dbo].[WorkPackageResponsibleEngineer] (projId, wpId, responsibleEngineer)
	VALUES (4911, '4', 7);

---------------------------------------------------------------------------------
-- WorkPackageEstimateRE
---------------------------------------------------------------------------------
INSERT INTO [comp4911db].[dbo].[WorkPackageEstimateRE] (dateUpdated, projId, wpId, pLevel, estimated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '1', 'P6', 0, 2011);

INSERT INTO [comp4911db].[dbo].[WorkPackageEstimateRE] (dateUpdated, projId, wpId, pLevel, estimated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '2', 'P6', 0, 2011);

INSERT INTO [comp4911db].[dbo].[WorkPackageEstimateRE] (dateUpdated, projId, wpId, pLevel, estimated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '3', 'P6', 48, 2011);

INSERT INTO [comp4911db].[dbo].[WorkPackageEstimateRE] (dateUpdated, projId, wpId, pLevel, estimated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '4', 'P6', NULL, 2011);

INSERT INTO [comp4911db].[dbo].[WorkPackageEstimateRE] (dateUpdated, projId, wpId, pLevel, estimated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '1', 'P5', 0, 2011);

INSERT INTO [comp4911db].[dbo].[WorkPackageEstimateRE] (dateUpdated, projId, wpId, pLevel, estimated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '2', 'P5', 0, 2011);

INSERT INTO [comp4911db].[dbo].[WorkPackageEstimateRE] (dateUpdated, projId, wpId, pLevel, estimated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '3', 'P5', 48, 2011);

INSERT INTO [comp4911db].[dbo].[WorkPackageEstimateRE] (dateUpdated, projId, wpId, pLevel, estimated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '4', 'P5', NULL, 2011);

INSERT INTO [comp4911db].[dbo].[WorkPackageEstimateRE] (dateUpdated, projId, wpId, pLevel, estimated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '1', 'P4', 0, 2011);

INSERT INTO [comp4911db].[dbo].[WorkPackageEstimateRE] (dateUpdated, projId, wpId, pLevel, estimated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '2', 'P4', 0, 2011);

INSERT INTO [comp4911db].[dbo].[WorkPackageEstimateRE] (dateUpdated, projId, wpId, pLevel, estimated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '3', 'P4', 64, 2011);

INSERT INTO [comp4911db].[dbo].[WorkPackageEstimateRE] (dateUpdated, projId, wpId, pLevel, estimated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '4', 'P4', NULL, 2011);
	
INSERT INTO [comp4911db].[dbo].[WorkPackageEstimateRE] (dateUpdated, projId, wpId, pLevel, estimated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '1', 'P3', 0, 2011);

INSERT INTO [comp4911db].[dbo].[WorkPackageEstimateRE] (dateUpdated, projId, wpId, pLevel, estimated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '2', 'P3', 0, 2011);

INSERT INTO [comp4911db].[dbo].[WorkPackageEstimateRE] (dateUpdated, projId, wpId, pLevel, estimated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '3', 'P3', 64, 2011);

INSERT INTO [comp4911db].[dbo].[WorkPackageEstimateRE] (dateUpdated, projId, wpId, pLevel, estimated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '4', 'P3', NULL, 2011);

INSERT INTO [comp4911db].[dbo].[WorkPackageEstimateRE] (dateUpdated, projId, wpId, pLevel, estimated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '1', 'P2', 0, 2011);

INSERT INTO [comp4911db].[dbo].[WorkPackageEstimateRE] (dateUpdated, projId, wpId, pLevel, estimated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '2', 'P2', 0, 2011);

INSERT INTO [comp4911db].[dbo].[WorkPackageEstimateRE] (dateUpdated, projId, wpId, pLevel, estimated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '3', 'P2', 24, 2011);

INSERT INTO [comp4911db].[dbo].[WorkPackageEstimateRE] (dateUpdated, projId, wpId, pLevel, estimated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '4', 'P2', NULL, 2011);

INSERT INTO [comp4911db].[dbo].[WorkPackageEstimateRE] (dateUpdated, projId, wpId, pLevel, estimated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '1', 'P1', 0, 2011);

INSERT INTO [comp4911db].[dbo].[WorkPackageEstimateRE] (dateUpdated, projId, wpId, pLevel, estimated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '2', 'P1', 0, 2011);

INSERT INTO [comp4911db].[dbo].[WorkPackageEstimateRE] (dateUpdated, projId, wpId, pLevel, estimated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '3', 'P1', 42, 2011);

INSERT INTO [comp4911db].[dbo].[WorkPackageEstimateRE] (dateUpdated, projId, wpId, pLevel, estimated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '4', 'P1', NULL, 2011);

---------------------------------------------------------------------------------
-- WorkPackageBudgetPM
---------------------------------------------------------------------------------
INSERT INTO [comp4911db].[dbo].[WorkPackageBudgetPM] (dateUpdated, projId, wpId, pLevel, allocated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '1', 'P6', 0, 2011);

INSERT INTO [comp4911db].[dbo].[WorkPackageBudgetPM] (dateUpdated, projId, wpId, pLevel, allocated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '2', 'P6', 0, 2011);

INSERT INTO [comp4911db].[dbo].[WorkPackageBudgetPM] (dateUpdated, projId, wpId, pLevel, allocated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '3', 'P6', 48, 2011);

INSERT INTO [comp4911db].[dbo].[WorkPackageBudgetPM] (dateUpdated, projId, wpId, pLevel, allocated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '4', 'P6', NULL, 2011);

INSERT INTO [comp4911db].[dbo].[WorkPackageBudgetPM] (dateUpdated, projId, wpId, pLevel, allocated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '1', 'P5', 0, 2011);

INSERT INTO [comp4911db].[dbo].[WorkPackageBudgetPM] (dateUpdated, projId, wpId, pLevel, allocated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '2', 'P5', 0, 2011);

INSERT INTO [comp4911db].[dbo].[WorkPackageBudgetPM] (dateUpdated, projId, wpId, pLevel, allocated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '3', 'P5', 40, 2011);

INSERT INTO [comp4911db].[dbo].[WorkPackageBudgetPM] (dateUpdated, projId, wpId, pLevel, allocated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '4', 'P5', NULL, 2011);

INSERT INTO [comp4911db].[dbo].[WorkPackageBudgetPM] (dateUpdated, projId, wpId, pLevel, allocated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '1', 'P4', 0, 2011);

INSERT INTO [comp4911db].[dbo].[WorkPackageBudgetPM] (dateUpdated, projId, wpId, pLevel, allocated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '2', 'P4', 0, 2011);

INSERT INTO [comp4911db].[dbo].[WorkPackageBudgetPM] (dateUpdated, projId, wpId, pLevel, allocated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '3', 'P4', 40, 2011);

INSERT INTO [comp4911db].[dbo].[WorkPackageBudgetPM] (dateUpdated, projId, wpId, pLevel, allocated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '4', 'P4', NULL, 2011);

INSERT INTO [comp4911db].[dbo].[WorkPackageBudgetPM] (dateUpdated, projId, wpId, pLevel, allocated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '1', 'P3', 0, 2011);

INSERT INTO [comp4911db].[dbo].[WorkPackageBudgetPM] (dateUpdated, projId, wpId, pLevel, allocated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '2', 'P3', 0, 2011);

INSERT INTO [comp4911db].[dbo].[WorkPackageBudgetPM] (dateUpdated, projId, wpId, pLevel, allocated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '3', 'P3', 48, 2011);

INSERT INTO [comp4911db].[dbo].[WorkPackageBudgetPM] (dateUpdated, projId, wpId, pLevel, allocated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '4', 'P3', NULL, 2011);

INSERT INTO [comp4911db].[dbo].[WorkPackageBudgetPM] (dateUpdated, projId, wpId, pLevel, allocated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '1', 'P2', 0, 2011);

INSERT INTO [comp4911db].[dbo].[WorkPackageBudgetPM] (dateUpdated, projId, wpId, pLevel, allocated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '2', 'P2', 0, 2011);

INSERT INTO [comp4911db].[dbo].[WorkPackageBudgetPM] (dateUpdated, projId, wpId, pLevel, allocated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '3', 'P2', 24, 2011);

INSERT INTO [comp4911db].[dbo].[WorkPackageBudgetPM] (dateUpdated, projId, wpId, pLevel, allocated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '4', 'P2', NULL, 2011);

INSERT INTO [comp4911db].[dbo].[WorkPackageBudgetPM] (dateUpdated, projId, wpId, pLevel, allocated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '1', 'P1', 0, 2011);

INSERT INTO [comp4911db].[dbo].[WorkPackageBudgetPM] (dateUpdated, projId, wpId, pLevel, allocated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '2', 'P1', 0, 2011);

INSERT INTO [comp4911db].[dbo].[WorkPackageBudgetPM] (dateUpdated, projId, wpId, pLevel, allocated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '3', 'P1', 36, 2011);

INSERT INTO [comp4911db].[dbo].[WorkPackageBudgetPM] (dateUpdated, projId, wpId, pLevel, allocated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '4', 'P1', NULL, 2011);
	
---------------------------------------------------------------------------------
-- TimesheetHeader Table
---------------------------------------------------------------------------------
INSERT INTO [comp4911db].[dbo].[TimesheetHeader] (empId, tsDate, status, comments, approvedBy)
	VALUES(0, '2011/01/01', 'APPROVED', 'Bruce could have worked harder this weekend', 0);

INSERT INTO [comp4911db].[dbo].[TimesheetHeader] (empId, tsDate, status, comments, approvedBy)
	VALUES(1, '2011/01/01', 'APPROVED', '', 0);

INSERT INTO [comp4911db].[dbo].[TimesheetHeader] (empId, tsDate, status, comments, approvedBy)
	VALUES(2, '2011/01/01', 'APPROVED', 'Good job!', 8);

INSERT INTO [comp4911db].[dbo].[TimesheetHeader] (empId, tsDate, status, comments, approvedBy)
	VALUES(3, '2011/01/01', 'REJECTED', 'You only stayed for 4 hours on Fri', 8);

INSERT INTO [comp4911db].[dbo].[TimesheetHeader] (empId, tsDate, status, comments, approvedBy)
	VALUES(4, '2011/01/01', 'SUBMITTED', '', NULL);

INSERT INTO [comp4911db].[dbo].[TimesheetHeader] (empId, tsDate, status, comments, approvedBy)
	VALUES(5, '2011/01/01', 'SUBMITTED', '', NULL);

INSERT INTO [comp4911db].[dbo].[TimesheetHeader] (empId, tsDate, status, comments, approvedBy)
	VALUES(6, '2011/01/01', 'APPROVED', 'Good job!', 8);

INSERT INTO [comp4911db].[dbo].[TimesheetHeader] (empId, tsDate, status, comments, approvedBy)
	VALUES(7, '2011/01/01', 'APPROVED', 'Good job!', 8);

INSERT INTO [comp4911db].[dbo].[TimesheetHeader] (empId, tsDate, status, comments, approvedBy)
	VALUES(8, '2011/01/01', 'APPROVED', 'Good job!', 8);

INSERT INTO [comp4911db].[dbo].[TimesheetHeader] (empId, tsDate, status, comments, approvedBy)
	VALUES(9, '2011/01/01', 'APPROVED', '', 8);

INSERT INTO [comp4911db].[dbo].[TimesheetHeader] (empId, tsDate, status, comments, approvedBy)
	VALUES(0, '2011/02/01', 'APPROVED', DEFAULT, 0);

INSERT INTO [comp4911db].[dbo].[TimesheetHeader] (empId, tsDate, status, comments, approvedBy)
	VALUES(1, '2011/02/01', 'APPROVED', DEFAULT, 0);

INSERT INTO [comp4911db].[dbo].[TimesheetHeader] (empId, tsDate, status, comments, approvedBy)
	VALUES(2, '2011/02/01', DEFAULT, DEFAULT, 0);

INSERT INTO [comp4911db].[dbo].[TimesheetHeader] (empId, tsDate, status, comments, approvedBy)
	VALUES(3, '2011/02/01', DEFAULT, DEFAULT, 0);

INSERT INTO [comp4911db].[dbo].[TimesheetHeader] (empId, tsDate, status, comments, approvedBy)
	VALUES(4, '2011/02/01', DEFAULT, DEFAULT, 0);

INSERT INTO [comp4911db].[dbo].[TimesheetHeader] (empId, tsDate, status, comments, approvedBy)
	VALUES(5, '2011/02/01', DEFAULT, DEFAULT, 0);

INSERT INTO [comp4911db].[dbo].[TimesheetHeader] (empId, tsDate, status, comments, approvedBy)
	VALUES(6, '2011/02/01', 'APPROVED', DEFAULT, 0);

INSERT INTO [comp4911db].[dbo].[TimesheetHeader] (empId, tsDate, status, comments, approvedBy)
	VALUES(7, '2011/02/01', 'APPROVED', 'No comments.', 0);

INSERT INTO [comp4911db].[dbo].[TimesheetHeader] (empId, tsDate, status, comments, approvedBy)
	VALUES(8, '2011/02/01', 'APPROVED', 'Great work!', 0);

INSERT INTO [comp4911db].[dbo].[TimesheetHeader] (empId, tsDate, status, comments, approvedBy)
	VALUES(9, '2011/02/01', 'APPROVED', 'Keep it up!', 0);

---------------------------------------------------------------------------------
-- DefaultTimesheet Table
---------------------------------------------------------------------------------
INSERT INTO [comp4911db].[dbo].[DefaultTimesheet] (empId, tsDate)
	VALUES (0, '2011/01/01');

INSERT INTO [comp4911db].[dbo].[DefaultTimesheet] (empId, tsDate)
	VALUES (9, '2011/01/01');

INSERT INTO [comp4911db].[dbo].[DefaultTimesheet] (empId, tsDate)
	VALUES (3, '2011/01/01');

INSERT INTO [comp4911db].[dbo].[DefaultTimesheet] (empId, tsDate)
	VALUES (4, '2011/01/01');

---------------------------------------------------------------------------------
-- TimesheetEntry Table
---------------------------------------------------------------------------------
INSERT INTO [comp4911db].[dbo].[TimesheetEntry]
VALUES(0, '2011/01/01', 4911, '1', 8, 8, 8, 8, DEFAULT, DEFAULT, DEFAULT, '');

INSERT INTO [comp4911db].[dbo].[TimesheetEntry]
VALUES(1, '2011/01/01', 4911, '1', 8, 8, 8, 8, 8, 8, 8, 'Visual Studio 2010 is awesome!');

INSERT INTO [comp4911db].[dbo].[TimesheetEntry]
VALUES(2, '2011/01/01', 4911, '1', 8, 8, 8, 8, 8, 8, 8, 'I hate Timesheets');

INSERT INTO [comp4911db].[dbo].[TimesheetEntry]
VALUES(3, '2011/01/01', 4911, '1', 8, 8, 8, 8, 8, 8, 8, 'I love Timesheets');

INSERT INTO [comp4911db].[dbo].[TimesheetEntry]
VALUES(4, '2011/01/01', 4911, '1', 8, 8, 8, 8, 8, 8, 8, 'Why do cows wear bells? Their horns don''t work.');

INSERT INTO [comp4911db].[dbo].[TimesheetEntry]
VALUES(5, '2011/01/01', 4911, '1', 8, 8, 8, 8, 8, 8, 8, 'A man walks into a bar... ouch');

INSERT INTO [comp4911db].[dbo].[TimesheetEntry]
VALUES(6, '2011/01/01', 4911, '1', 8, 8, 8, 8, 8, 8, 8, 'What did one snowman say to the other snowman? Smells like carrots.');

INSERT INTO [comp4911db].[dbo].[TimesheetEntry]
VALUES(7, '2011/01/01', 4911, '1', 8, 8, 8, 8, 8, 8, 8, 'What''s red and smells like blue paint? Red paint.');

INSERT INTO [comp4911db].[dbo].[TimesheetEntry]
VALUES(8, '2011/01/01', 4911, '1', 8, 8, 8, 8, 8, 8, 8, 'What did one wall say to the other wall? Lets meet up in the corner.');

INSERT INTO [comp4911db].[dbo].[TimesheetEntry]
VALUES(9, '2011/01/01', 4911, '1', 8, 8, 8, 8, 8, 8, 8, 'Why do seagulls live by the sea? Cause if they lived by the bay they''d be baygulls (bagels) :P');

INSERT INTO [comp4911db].[dbo].[TimesheetEntry]
VALUES(0, '2011/02/01', 4911, '2', 8, 7, 6, 5, 4, 3, 7, 'How do you make Lady Gaga cry? Poke/her/face.');

INSERT INTO [comp4911db].[dbo].[TimesheetEntry]
VALUES(1, '2011/02/01', 4911, '2', 8, 7, 6, 5, 4, 3, 7, 'Why did the man driving the train get hit by lightening? He was a good conductor.');

INSERT INTO [comp4911db].[dbo].[TimesheetEntry]
VALUES(2, '2011/02/01', 4911, '2', 8, 7, 6, 5, 4, 3, 7, 'What happened to the magical tractor? It turned into a field.');

INSERT INTO [comp4911db].[dbo].[TimesheetEntry]
VALUES(3, '2011/02/01', 4911, '2', 8, 7, 6, 5, 4, 3, 7, 'What do vampire zombies say? Veeeiiins...');

INSERT INTO [comp4911db].[dbo].[TimesheetEntry]
VALUES(4, '2011/02/01', 4911, '2', 8, 7, 6, 5, 4, 3, 7, 'Why did the fungus and the algee get married? They took a lichen to each other.');

INSERT INTO [comp4911db].[dbo].[TimesheetEntry]
VALUES(5, '2011/02/01', 4911, '2', 8, 7, 6, 5, 4, 3, 7, 'What do you get when you put a sheep on a trampoline? A woolie jumper.');

INSERT INTO [comp4911db].[dbo].[TimesheetEntry]
VALUES(6, '2011/02/01', 4911, '2', 8, 7, 6, 5, 4, 3, 7, 'Why did the tomato blush? Cause it saw the salad dressing.');

INSERT INTO [comp4911db].[dbo].[TimesheetEntry]
VALUES(7, '2011/02/01', 4911, '2', 8, 7, 6, 5, 4, 3, 7, 'Did you hear about the red ship and the blue ship that collided? All the sailors were marooned...');

INSERT INTO [comp4911db].[dbo].[TimesheetEntry]
VALUES(8, '2011/02/01', 4911, '2', 8, 7, 6, 5, 4, 3, 7, 'Why did Kalen eat his homework? Bruce said it was a piece of cake.');

INSERT INTO [comp4911db].[dbo].[TimesheetEntry]
VALUES(9, '2011/02/01', 4911, '2', 8, 7, 6, 5, 4, 3, 7, 'The calendar''s days are numbers');
