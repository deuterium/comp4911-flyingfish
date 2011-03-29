---------------------------------------------------------------------------------
-- Rainbow Motions,  March-7-2011
-- Flying Fish - Project Management Application
-- SQL Express
---------------------------------------------------------------------------------

---------------------------------------------------------------------------------
-- ***TO DO FOR DB***
-- Linq/Lambda Controller Classes
-- Automatic Operations (e.g. increment Vacation Days)
-- Automatic Backups?
	-- schedule related, SQL Server Management Studio
-- Caching for performance boost?
	-- ASP side caching on controls
---------------------------------------------------------------------------------

---------------------------------------------------------------------------------
-- Tracks PLevel rates over time.
-- PLevel rates are usually updated every fiscal year.
-- Used to calculate reports/Timesheets from previous years.
---------------------------------------------------------------------------------
CREATE TABLE PersonLevel (
	pLevel			NCHAR(2)		NOT NULL
	, rate 			DECIMAL(5, 2)	NOT NULL							-- salary($) / person-day
	, fiscalYear	INT				NOT NULL	DEFAULT YEAR(GETDATE())	-- date this value was set on
	, CONSTRAINT pk_PersonLevel PRIMARY KEY (pLevel, fiscalYear)
	, CONSTRAINT ck_PLevel_fiscalYear CHECK (fiscalYear > 2009 AND fiscalYear < 2500)
);

---------------------------------------------------------------------------------
-- Records static employee attributes (past values not considered).
-- An employee has 1 supervisor and 1 Timesheet approver.
-- The supervisor and HR staff assign approvers (default is supervisor).
-- Only approver can approve Timesheet (supervisor can't).
-- For isActive, 1 is true and 0 is false.
---------------------------------------------------------------------------------
CREATE TABLE Employee (
	empId				INT				NOT NULL	UNIQUE
	, firstName			NVARCHAR(30)	NOT NULL
	, lastName			NVARCHAR(30)	NOT NULL
	, supervisor		INT				NOT NULL	
	, approver			INT				NOT NULL
	, minHoursPerWeek	DECIMAL(3, 1)	NOT NULL	DEFAULT 40.0
	, vacationLeave		INT				NOT NULL	DEFAULT 0
	, sickDays			INT				NOT NULL	DEFAULT 0
	, flexHours			DECIMAL(3, 1)	NOT NULL	DEFAULT 0.0
	, isActive			INT				NOT NULL	DEFAULT 1
	, CONSTRAINT pk_Employee PRIMARY KEY (empId)
	, CONSTRAINT ck_Employee_empId CHECK (empId >= 0)
	, CONSTRAINT ck_Employee_vaction CHECK (vacationLeave >= 0)
	, CONSTRAINT ck_Employee_flex CHECK (flexHours >= -14)
	, CONSTRAINT ck_Employee_sick CHECK (sickDays >= 0)
	, CONSTRAINT ck_Employee_isActive CHECK (isActive = 0 OR isActive = 1)
);

---------------------------------------------------------------------------------
-- Links Employee table to Membership Services table.
---------------------------------------------------------------------------------
CREATE TABLE EmployeeMembership (
	empId		INT					NOT NULL	UNIQUE	
	, userId	UNIQUEIDENTIFIER 	NOT NULL	UNIQUE  
	, CONSTRAINT pk_EmployeeMembership PRIMARY KEY (empId)
	, CONSTRAINT fk_EmployeeMembership_empId FOREIGN KEY (empId)
		REFERENCES Employee (empId)
	, CONSTRAINT fk_EmployeeMembership_userId FOREIGN KEY (userId)
		REFERENCES aspnet_Users (UserId)
);

---------------------------------------------------------------------------------
-- Tracks employee's pLevel over time.
-- Used to generate reports/Timesheets from past.
-- E.g. Employee may have gotten a promotion in the middle of a project.
---------------------------------------------------------------------------------
CREATE TABLE EmployeePersonLevel (
	dateUpdated		DATE			NOT NULL	DEFAULT GETDATE()
	, empId			INT				NOT NULL
	, pLevel		NCHAR(2)		NOT NULL
	, fiscalYear	INT				NOT NULL
	, CONSTRAINT pk_EmployeePersonLevel PRIMARY KEY (empId, dateUpdated)
	, CONSTRAINT fk_EmployeePersonLevel_pLevelYear FOREIGN KEY (pLevel, fiscalYear)
		REFERENCES PersonLevel (pLevel, fiscalYear)
	, CONSTRAINT ck_dateUpdated CHECK (dateUpdated >= '2010/01/01' AND dateUpdated <= '2500/01/01')
);

---------------------------------------------------------------------------------
-- Records which employees are HR Staff.
---------------------------------------------------------------------------------
CREATE TABLE HumanResourcesStaff (
	empId INT		NOT NULL	UNIQUE
	, CONSTRAINT pk_HumanResourcesStaff PRIMARY KEY (empId) 
	, CONSTRAINT fk_HumanResourcesStaff_empId FOREIGN KEY (empId)
		REFERENCES Employee (empId)
);

---------------------------------------------------------------------------------
-- Records static Project attributes (past values not tracked).
---------------------------------------------------------------------------------
CREATE TABLE Project (
	projId					INT				NOT NULL	UNIQUE	-- NOT ALPHANUMERIC, just a number (no periods)
	, projName				NVARCHAR(30)	NOT NULL
	, manager				INT
	, allocated_dollars		DECIMAL(11, 2)	NOT NULL	DEFAULT 0
	, unallocated_dollars	DECIMAL(11, 2)				DEFAULT NULL
	, isActive				INT				NOT NULL	DEFAULT 1
	, CONSTRAINT pk_Project PRIMARY KEY (projId)
	, CONSTRAINT fk_Project_manager FOREIGN KEY (manager)
		REFERENCES Employee (empId)
	, CONSTRAINT ck_Project_projId CHECK (projId >= 0)
	, CONSTRAINT ck_Project_alloc CHECK (allocated_dollars >= 0)
	, CONSTRAINT ck_Project_unalloc CHECK (unallocated_dollars >= 0)
	, CONSTRAINT ck_Project_isActive CHECK (isActive = 0 OR isActive = 1)
);

---------------------------------------------------------------------------------
-- Records which employees have been assigned to which project.
---------------------------------------------------------------------------------
CREATE TABLE EmployeeProject (
	projId			INT		NOT NULL
	, empId			INT		NOT NULL
	, CONSTRAINT pk_EmployeeProject PRIMARY KEY (projId, empId)
	, CONSTRAINT fk_EmployeeProject_empId FOREIGN KEY (empId)
		REFERENCES Employee (empId)
	, CONSTRAINT fk_EmployeeProject_projId FOREIGN KEY (projId)
		REFERENCES Project (projId)
);

---------------------------------------------------------------------------------
-- Records static Work Package attributes (past values not tracked).
-- Allocated dollars is derived from WorkPackagePLevelBudget.
-- Unallocated dollars may or may not be derived from the Project budget.
-- The allocated/unallocated dollars make up the total WP budget.
-- A null budget is undefined?
---------------------------------------------------------------------------------
CREATE TABLE WorkPackage (
	projId					INT				NOT NULL
	, wpId					NVARCHAR(30) 	NOT NULL
	, name	 				NVARCHAR(30)	NOT NULL
	, description			NVARCHAR(MAX)
	, unallocated_dollars	DECIMAL(11, 2)				DEFAULT NULL -- The budget from the PM
	, allocated_dollars		DECIMAL(11, 2)	NOT NULL	DEFAULT 0	 -- The budget from the PM
	, isActive				INT				NOT NULL	DEFAULT 1	 -- 1 is true
	, CONSTRAINT pk_WorkPackage PRIMARY KEY (projId, wpId)
	, CONSTRAINT fk_WorkPackage_projId FOREIGN KEY (projId)
		REFERENCES Project (projId)
	, CONSTRAINT ck_WorkPackage_unallocDollars CHECK (unallocated_dollars >= 0)
	, CONSTRAINT ck_WorkPackage_allocDollars CHECK (allocated_dollars >= 0)
	, CONSTRAINT ck_WorkPackage_isActive CHECK (isActive = 0 OR isActive = 1)
);

---------------------------------------------------------------------------------
-- Tracks which employees are on which work packages and the ETC.
-- The ETC_days is estimated days until an employee completes his/her work on that work package.
-- A null ETC_days means it's unknown (the employee has just started and no estimate is available yet).
---------------------------------------------------------------------------------
CREATE TABLE EmployeeWorkPackage (
	empId			INT				NOT NULL	
	, projId		INT				NOT NULL
	, wpId			NVARCHAR(30)	NOT NULL
	, CONSTRAINT pk_EmployeeWorkPackage PRIMARY KEY (empId, projId, wpId)
	, CONSTRAINT fk_EmployeeWorkPackage_empId FOREIGN KEY (projId, empId)
		REFERENCES EmployeeProject (projId, empId)
	, CONSTRAINT fk_EmployeeWorkPackage_projWp FOREIGN KEY (projId, wpId)
		REFERENCES WorkPackage (projId, wpId)
);

---------------------------------------------------------------------------------
-- Records responsible engineer's notes about a work package.
---------------------------------------------------------------------------------
CREATE TABLE WorkPackageStatusReport (
	projId					INT				NOT NULL	
	, wpId					NVARCHAR(30) 	NOT NULL	
	, reportDate			DATE			NOT NULL	DEFAULT CURRENT_TIMESTAMP
	, comments				TEXT			NOT NULL
	, workAccomplished		TEXT			NOT NULL
	, workPlannedNext		TEXT			NOT NULL
	, problemsEncountered	TEXT			NOT NULL
	, problemsAnticipated	TEXT			NOT NULL
	, CONSTRAINT pk_WpStatusReport PRIMARY KEY (projId, wpId, reportDate)
	, CONSTRAINT ck_WpStatusReport_reportDate CHECK (reportDate >= '2010/01/01' AND reportDate <= '2500/01/01')
	, CONSTRAINT fk_WpStatusReport_projWp FOREIGN KEY (projId, wpId)
		REFERENCES WorkPackage (projId, wpId)
);

---------------------------------------------------------------------------------
-- Tracks which employees are on which work packages and the ETC.
-- The ETC_days is estimated days until an employee completes his/her work on that work package.
-- A null ETC_days means it's unknown (the employee has just started and no estimate is available yet).
---------------------------------------------------------------------------------
CREATE TABLE EmployeeWorkPackageETC (
	empId			INT				NOT NULL
	, projId		INT				NOT NULL
	, wpId			NVARCHAR(30)	NOT NULL
	, dateUpdated	DATE			NOT NULL	DEFAULT CURRENT_TIMESTAMP
	, ETC_days		INT
	, CONSTRAINT pk_EmployeeWorkPackageETC PRIMARY KEY (empId, projId, wpId, dateUpdated)
	, CONSTRAINT fk_EmployeeWorkPackageETC_EmpProjWp FOREIGN KEY (empId, projId, wpId)
		REFERENCES EmployeeWorkPackage (empId, projId, wpId)
	, CONSTRAINT fk_EmployeeWorkPackageETC_date FOREIGN KEY (projId, wpId, dateUpdated)
		REFERENCES WorkPackageStatusReport (projId, wpId, reportDate)
	, CONSTRAINT ck_ETCdays CHECK (ETC_days >= 0)
);

---------------------------------------------------------------------------------
-- Records which work packages have a responsible engineer.
-- Usually, only the leaf (lowest-level) work packages have responsible engineers.
---------------------------------------------------------------------------------
CREATE TABLE WorkPackageResponsibleEngineer (
	projId					INT				NOT NULL
	, wpId					NVARCHAR(30) 	NOT NULL
	, responsibleEngineer	INT 			NOT NULL
	, CONSTRAINT pk_WpResponsibleEngineer PRIMARY KEY (projId, wpId)
	, CONSTRAINT fk_WpResponsibleEngineer_RE FOREIGN KEY (responsibleEngineer, projId, wpId)
		REFERENCES EmployeeWorkPackage (empId, projId, wpId)
);

---------------------------------------------------------------------------------
-- The responsible engineer's estimated budget for the work package.
-- This is independent of the project manager's budget.
-- This budget is NOT used for the alloc/unalloc WP budget.
-- This is given initially and usually not changed (it serves as the baseline).
-- It's compared to the ETC_days in the EmployeeWorkPackage table.
---------------------------------------------------------------------------------
CREATE TABLE WorkPackageEstimateRE (
	dateUpdated			DATE			NOT NULL	DEFAULT CURRENT_TIMESTAMP -- may not need
	, projId			INT				NOT NULL
	, wpId				NVARCHAR(30)	NOT NULL
	, pLevel			NCHAR(2)		NOT NULL
	, fiscalYear		INT				NOT NULL
	, estimated_days 	DECIMAL(10, 2)
	, CONSTRAINT pk_WpBudgetRE PRIMARY KEY (dateUpdated, pLevel, projId, wpId)
	, CONSTRAINT fk_WpBudgetRE_pLevelYear FOREIGN KEY (pLevel, fiscalYear)
		REFERENCES PersonLevel (pLevel, fiscalYear)
	, CONSTRAINT fk_WpBudgetRE_projWp FOREIGN KEY (projId, wpId)
		REFERENCES WorkPackage (projId, wpId)
	, CONSTRAINT ck_WpBudgetRE_EtcDollars CHECK (estimated_days >= 0)
	, CONSTRAINT ck_WpBudgetRE_dateUpdated CHECK (dateUpdated >= '2010/01/01' AND dateUpdated <= '2500/01/01')
);

---------------------------------------------------------------------------------
-- The project manager's budget for the work package.
-- This is independent of the responsible engineer's budget.
-- This budget is the work package's allocated/unallocated budget.
-- This, like the RE's Estimate, serves as a baseline.
-- It's compared to the ETC_days in the EmployeeWorkPackage table.
---------------------------------------------------------------------------------
CREATE TABLE WorkPackageBudgetPM (
	dateUpdated			DATE			NOT NULL	DEFAULT CURRENT_TIMESTAMP -- may not need
	, projId			INT				NOT NULL
	, wpId				NVARCHAR(30)	NOT NULL
	, pLevel			NCHAR(2)		NOT NULL
	, fiscalYear		INT				NOT NULL
	, allocated_days 	DECIMAL(10, 2)
	, CONSTRAINT pk_WpBudgetPM PRIMARY KEY (dateUpdated, pLevel, projId, wpId)
	, CONSTRAINT fk_WpBudgetPM_pLevelYear FOREIGN KEY (pLevel, fiscalYear)
		REFERENCES PersonLevel (pLevel, fiscalYear)
	, CONSTRAINT fk_WpBudgetPM_projWp FOREIGN KEY (projId, wpId)
		REFERENCES WorkPackage (projId, wpId)
	, CONSTRAINT ck_WpBudgetPM_EtcDollars CHECK (allocated_days >= 0)
	, CONSTRAINT ck_WpBudgetPM_dateUpdated CHECK (dateUpdated >= '2010/01/01' AND dateUpdated <= '2500/01/01')
);

---------------------------------------------------------------------------------
-- Records attributes common to multiple time sheet entries. 
---------------------------------------------------------------------------------
CREATE TABLE TimesheetHeader (
	empId			INT				NOT NULL
	, tsDate		DATE			NOT NULL	DEFAULT CURRENT_TIMESTAMP
	, status		NVARCHAR(9)					DEFAULT 'SAVED'
	, comments		NVARCHAR(MAX)				DEFAULT ''
	, approvedBy	INT							DEFAULT NULL
	, CONSTRAINT pk_TimesheetHeader PRIMARY KEY (empId, tsDate)
	, CONSTRAINT fk_TimesheetHeader_empId FOREIGN KEY (empId)
		REFERENCES Employee (empId)
	, CONSTRAINT fk_TimesheetHeader_approvedBy FOREIGN KEY (approvedBy)
		REFERENCES Employee (empId)
	, CONSTRAINT ck_TimesheetHeader_tsDate CHECK (tsDate >= '2010/01/01' AND tsDate <= '2500/01/01')
	, CONSTRAINT ck_TimesheetHeader_status CHECK (status IN ('SAVED', 'SUBMITTED', 'APPROVED', 'REJECTED'))
);

---------------------------------------------------------------------------------
-- Records the current, default Timesheet set by an employee.
-- Whenever that employee requests a new Timesheet, the default is used.
-- If a default is not specified, a blank Timesheet is created/used.
---------------------------------------------------------------------------------
CREATE TABLE DefaultTimesheet (
	empId		INT		NOT NULL
	, tsDate	DATE	NOT NULL	DEFAULT CURRENT_TIMESTAMP
	, CONSTRAINT pk_DefaultTimesheet PRIMARY KEY (empId)
	, CONSTRAINT fk_DefaultTimesheet FOREIGN KEY (empId, tsDate)
		REFERENCES TimesheetHeader (empId, tsDate)
);

---------------------------------------------------------------------------------
-- Records attributes specific to each time sheet entry (row).
---------------------------------------------------------------------------------
CREATE TABLE TimesheetEntry (
	empId			INT				NOT NULL
	, tsDate		DATE			NOT NULL	DEFAULT CURRENT_TIMESTAMP
	, projId		INT				NOT NULL
	, wpId			NVARCHAR(30)	NOT NULL
	, sat			DECIMAL(3, 1)	NOT NULL	DEFAULT 0.0	CHECK (sat BETWEEN 0 AND 24)
	, sun			DECIMAL(3, 1)	NOT NULL	DEFAULT 0.0	CHECK (sun BETWEEN 0 AND 24)	
	, mon			DECIMAL(3, 1)	NOT NULL	DEFAULT 0.0	CHECK (mon BETWEEN 0 AND 24)
	, tue			DECIMAL(3, 1)	NOT NULL	DEFAULT 0.0	CHECK (tue BETWEEN 0 AND 24)
	, wed			DECIMAL(3, 1)	NOT NULL	DEFAULT 0.0	CHECK (wed BETWEEN 0 AND 24)
	, thu			DECIMAL(3, 1)	NOT NULL	DEFAULT 0.0	CHECK (thu BETWEEN 0 AND 24)
	, fri			DECIMAL(3, 1)	NOT NULL	DEFAULT 0.0	CHECK (fri BETWEEN 0 AND 24)
	, notes			NVARCHAR(MAX)
	, CONSTRAINT pk_TimesheetEntry PRIMARY KEY (empId, tsDate, projId, wpId)
	, CONSTRAINT fk_TimesheetEntry_projWP FOREIGN KEY (projId, wpId)
		REFERENCES WorkPackage (projId, wpId)
	, CONSTRAINT fk_TimesheetEntry_TimesheetHeader FOREIGN KEY (empId, tsDate)
		REFERENCES TimesheetHeader (empId, tsDate)
);

---------------------------------------------------------------------------------
-- Populate system data.
---------------------------------------------------------------------------------
INSERT INTO [FlyingFish_new22-26].[dbo].[Project] (projId, projName, manager)
	VALUES (10, 'System', NULL);

INSERT INTO [FlyingFish_new22-26].[dbo].[WorkPackage] (projID, wpId, name, description, unallocated_dollars, allocated_dollars)
	VALUES (10, 'SICK', 'SICK_DAYS', 'Employees charge to this package when they take a sick day.', DEFAULT, DEFAULT);

INSERT INTO [FlyingFish_new22-26].[dbo].[WorkPackage] (projID, wpId, name, description, unallocated_dollars, allocated_dollars)
	VALUES (10, 'FLEX', 'FLEX_HOURS', 'Employees charge their flex time to this work package.', DEFAULT, DEFAULT);

INSERT INTO [FlyingFish_new22-26].[dbo].[WorkPackage] (projID, wpId, name, description, unallocated_dollars, allocated_dollars)
	VALUES (10, 'VACATION', 'VACATION_LEAVE', 'Employees charge to this package when they take vacation leave.', DEFAULT, DEFAULT);

INSERT INTO [FlyingFish_new22-26].[dbo].[WorkPackage] (projID, wpId, name, description, unallocated_dollars, allocated_dollars)
	VALUES (10, 'HOLIDAY', 'STATUTORY_HOLIDAYS', 'Employees charge to this package when they get a stat holiday off.', DEFAULT, DEFAULT);

INSERT INTO [FlyingFish_new22-26].[dbo].[aspnet_Applications] (ApplicationName, LoweredApplicationName, ApplicationId, Description)
	VALUES('/', '/', '3A6237FA-1533-455A-A5A0-91418CC54F73', NULL);

INSERT INTO [FlyingFish_new22-26].[dbo].[aspnet_Roles] (ApplicationId, RoleId, RoleName, LoweredRoleName, Description)
	VALUES('3A6237FA-1533-455A-A5A0-91418CC54F73', '67DA9471-9374-44FC-91FA-2F4EDF54EED1', 'Employee', 'employee', NULL);

INSERT INTO [FlyingFish_new22-26].[dbo].[aspnet_Roles] (ApplicationId, RoleId, RoleName, LoweredRoleName, Description)
	VALUES('3A6237FA-1533-455A-A5A0-91418CC54F73', '6ABFAB3A-A484-4A16-97B3-DAE17E55ECEA', 'Timesheet Approver', 'timesheetapprover', NULL);
	
INSERT INTO [FlyingFish_new22-26].[dbo].[aspnet_Roles] (ApplicationId, RoleId, RoleName, LoweredRoleName, Description)
	VALUES('3A6237FA-1533-455A-A5A0-91418CC54F73', 'A00A755E-210D-4F65-A039-CE4F902307CC', 'Employee Manager', 'employeemanager', NULL);

INSERT INTO [FlyingFish_new22-26].[dbo].[aspnet_Roles] (ApplicationId, RoleId, RoleName, LoweredRoleName, Description)
	VALUES('3A6237FA-1533-455A-A5A0-91418CC54F73', 'CEE18FE3-BE0E-417B-A66B-94B76E328100', 'Human Resources Staff', 'hrstaff', NULL);

INSERT INTO [FlyingFish_new22-26].[dbo].[aspnet_Roles] (ApplicationId, RoleId, RoleName, LoweredRoleName, Description)
	VALUES('3A6237FA-1533-455A-A5A0-91418CC54F73', '0C8981A5-A7B3-4020-86C3-E16A0FE45EC3', 'Project Manager', 'projectmanager', NULL);

INSERT INTO [FlyingFish_new22-26].[dbo].[aspnet_Roles] (ApplicationId, RoleId, RoleName, LoweredRoleName, Description)
	VALUES('3A6237FA-1533-455A-A5A0-91418CC54F73', '4C33878C-860C-4D37-B4E8-02E993E7F6F3', 'Responsible Engineer', 'responsibleengineer', NULL);
