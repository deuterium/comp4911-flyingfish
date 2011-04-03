-- Rainbow Motions,  Mar-7-2011
-- Flying Fish - Project Management Application
-- Script used to flush all data from the database
-- SQL Express

DELETE FROM [comp4911db].[dbo].[aspnet_UsersInRoles];
DELETE FROM [comp4911db].[dbo].[aspnet_Roles];
DELETE FROM [comp4911db].[dbo].[aspnet_Membership];
DELETE FROM [comp4911db].[dbo].[aspnet_Users];
DELETE FROM [comp4911db].[dbo].[aspnet_Applications];
DELETE FROM [comp4911db].[dbo].[TimeSheetEntry];
DELETE FROM [comp4911db].[dbo].[DefaultTimeSheet];
DELETE FROM [comp4911db].[dbo].[TimeSheetHeader];
DELETE FROM [comp4911db].[dbo].[WorkPackageBudgetPM];
DELETE FROM [comp4911db].[dbo].[WorkPackageEstimateRE];
DELETE FROM [comp4911db].[dbo].[WorkPackageResponsibleEngineer];
DELETE FROM [comp4911db].[dbo].[EmployeeWorkPackageETC];
DELETE FROM [comp4911db].[dbo].[WorkPackageStatusReport];
DELETE FROM [comp4911db].[dbo].[EmployeeWorkPackage];
DELETE FROM [comp4911db].[dbo].[WorkPackage];
DELETE FROM [comp4911db].[dbo].[EmployeeProject];
DELETE FROM [comp4911db].[dbo].[Project];
DELETE FROM [comp4911db].[dbo].[HumanResourcesStaff];
DELETE FROM [comp4911db].[dbo].[EmployeePersonLevel];
DELETE FROM [comp4911db].[dbo].[EmployeeMembership];
DELETE FROM [comp4911db].[dbo].[EmployeeSignature];
DELETE FROM [comp4911db].[dbo].[Employee];
DELETE FROM [comp4911db].[dbo].[PersonLevel];
