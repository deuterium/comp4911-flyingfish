-- Rainbow Motions,  Mar-7-2011
-- Flying Fish - Project Management Application
-- Script used to destroy the database
-- SQL Express

DELETE FROM [comp4911db].[dbo].[aspnet_UsersInRoles];
DELETE FROM [comp4911db].[dbo].[aspnet_Roles];
DELETE FROM [comp4911db].[dbo].[aspnet_Membership];
DELETE FROM [comp4911db].[dbo].[aspnet_Users];
DELETE FROM [comp4911db].[dbo].[aspnet_Applications];
-- Sometimes there are errors, run it twice...
DELETE FROM [comp4911db].[dbo].[aspnet_Users];
DELETE FROM [comp4911db].[dbo].[aspnet_Applications];

DROP TABLE [comp4911db].[dbo].[TimeSheetEntry];
DROP TABLE [comp4911db].[dbo].[DefaultTimeSheet];
DROP TABLE [comp4911db].[dbo].[TimeSheetHeader];
DROP TABLE [comp4911db].[dbo].[WorkPackageBudgetPM];
DROP TABLE [comp4911db].[dbo].[WorkPackageEstimateRE];
DROP TABLE [comp4911db].[dbo].[WorkPackageResponsibleEngineer];
DROP TABLE [comp4911db].[dbo].[EmployeeWorkPackageETC];
DROP TABLE [comp4911db].[dbo].[WorkPackageStatusReport];
DROP TABLE [comp4911db].[dbo].[EmployeeWorkPackage];
DROP TABLE [comp4911db].[dbo].[WorkPackage];
DROP TABLE [comp4911db].[dbo].[EmployeeProject];
DROP TABLE [comp4911db].[dbo].[Project];
DROP TABLE [comp4911db].[dbo].[HumanResourcesStaff];
DROP TABLE [comp4911db].[dbo].[EmployeePersonLevel];
DROP TABLE [comp4911db].[dbo].[EmployeeMembership];
DROP TABLE [comp4911db].[dbo].[EmployeeSignature];
DROP TABLE [comp4911db].[dbo].[Employee];
DROP TABLE [comp4911db].[dbo].[PersonLevel];