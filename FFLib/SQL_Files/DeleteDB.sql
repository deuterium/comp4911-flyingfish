-- Rainbow Motions,  Mar-7-2011
-- Flying Fish - Project Management Application
-- Script used to destroy the database
-- SQL Express

DELETE FROM [FlyingFish_new22-26].[dbo].[aspnet_UsersInRoles];
DELETE FROM [FlyingFish_new22-26].[dbo].[aspnet_Roles];
DELETE FROM [FlyingFish_new22-26].[dbo].[aspnet_Membership];
DELETE FROM [FlyingFish_new22-26].[dbo].[aspnet_Users];
DELETE FROM [FlyingFish_new22-26].[dbo].[aspnet_Applications];
DROP TABLE [FlyingFish_new22-26].[dbo].[TimeSheetEntry];
DROP TABLE [FlyingFish_new22-26].[dbo].[DefaultTimeSheet];
DROP TABLE [FlyingFish_new22-26].[dbo].[TimeSheetHeader];
DROP TABLE [FlyingFish_new22-26].[dbo].[WorkPackageBudgetPM];
DROP TABLE [FlyingFish_new22-26].[dbo].[WorkPackageEstimateRE];
DROP TABLE [FlyingFish_new22-26].[dbo].[WorkPackageResponsibleEngineer];
DROP TABLE [FlyingFish_new22-26].[dbo].[EmployeeWorkPackageETC];
DROP TABLE [FlyingFish_new22-26].[dbo].[WorkPackageStatusReport];
DROP TABLE [FlyingFish_new22-26].[dbo].[EmployeeWorkPackage];
DROP TABLE [FlyingFish_new22-26].[dbo].[WorkPackage];
DROP TABLE [FlyingFish_new22-26].[dbo].[EmployeeProject];
DROP TABLE [FlyingFish_new22-26].[dbo].[Project];
DROP TABLE [FlyingFish_new22-26].[dbo].[HumanResourcesStaff];
DROP TABLE [FlyingFish_new22-26].[dbo].[EmployeePersonLevel];
DROP TABLE [FlyingFish_new22-26].[dbo].[EmployeeMembership];
DROP TABLE [FlyingFish_new22-26].[dbo].[Employee];
DROP TABLE [FlyingFish_new22-26].[dbo].[PersonLevel];