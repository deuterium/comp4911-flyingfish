---------------------------------------------------------------------------------
-- Rainbow Motions,  March-7-2011
-- Flying Fish - Project Management Application
-- SQL Express
---------------------------------------------------------------------------------

---------------------------------------------------------------------------------
-- ***TO DO FOR DB***
-- Linq/Lambda Controller Classes
-- Research Indexing and Views
	-- PKs and FKs are auto-indexed, if using others as "keys" should index
-- Automatic Operations (e.g. increment Vacation Days)
-- Add Cascades for On Delete/On Update
-- Automatic Backups?
	-- schedule related, SQL Server Management Studio
-- Caching for performance boost?
	-- ASP side caching on controls
-- Unicode Strings for security? nchar instead of char, nvarchar instead of varchar?
	-- ALWAYS use (Chinese names)
---------------------------------------------------------------------------------

---------------------------------------------------------------------------------
-- Tracks PLevel rates over time.
-- PLevel rates are usually updated every fiscal year.
-- Used to calculate reports/timesheets from previous years.
---------------------------------------------------------------------------------
CREATE TABLE PersonLevel (
	pLevel			CHAR(2)			NOT NULL
	, rate 			DECIMAL(5, 2)	NOT NULL	-- salary($) / person-day
	, fiscalYear	DECIMAL(4, 0)	NOT NULL	-- date this value was set on
	, CONSTRAINT pk_PersonLevel PRIMARY KEY (pLevel, fiscalYear)
	, CONSTRAINT ck_PLevel_fiscalYear CHECK (fiscalYear > 2009 AND fiscalYear < 3000)
);

---------------------------------------------------------------------------------
-- Records static employee attributes (past values not considered).
-- An employee has 1 supervisor and 1 timesheet approver.
-- The supervisor and HR staff assign approvers (default is supervisor).
-- Only approver can approve timesheet (supervisor can't).
-- For isActive, 1 is true and 0 is false.
---------------------------------------------------------------------------------
CREATE TABLE Employee (
	empId				INT				NOT NULL	UNIQUE
	, firstName			VARCHAR(30)		NOT NULL
	, lastName			VARCHAR(30)		NOT NULL
	, password			VARCHAR(20)		NOT NULL 	DEFAULT 'rainbow'
	, supervisor		INT				NOT NULL	
	, approver			INT				NOT NULL
	, minHoursPerWeek	DECIMAL(3, 1)	NOT NULL	DEFAULT 40.0
	, vacationLeave		INT				NOT NULL	DEFAULT 0
	, sickDays			INT				NOT NULL	DEFAULT 0
	, flexHours			DECIMAL(3, 1)	NOT NULL	DEFAULT 0.0
	, isActive			INT				NOT NULL	DEFAULT 1
	, CONSTRAINT pk_Employee PRIMARY KEY (empId)
	, CONSTRAINT fk_Employee_supervisor FOREIGN KEY (supervisor)
		REFERENCES Employee (empId)
	, CONSTRAINT fk_Employee_approver FOREIGN KEY (approver)
		REFERENCES Employee (empId)
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
		REFERENCES aspnet_Membership (UserId)
);

---------------------------------------------------------------------------------
-- Tracks employee's pLevel over time.
-- Used to generate reports/timesheets from past.
-- E.g. Employee may have gotten a promotion in the middle of a project.
---------------------------------------------------------------------------------
CREATE TABLE EmployeePersonLevel (
	dateUpdated		DATE	NOT NULL	DEFAULT CURRENT_TIMESTAMP
	, empId			INT		NOT NULL
	, pLevel		CHAR(2)	NOT NULL
	, fiscalYear	DECIMAL(4, 0)		NOT NULL
	, CONSTRAINT pk_EmployeePersonLevel PRIMARY KEY (empId, dateUpdated)
	, CONSTRAINT fk_EmployeePersonLevel_pLevelYear FOREIGN KEY (pLevel, fiscalYear)
		REFERENCES PersonLevel (pLevel, fiscalYear)
	, CONSTRAINT ck_dateUpdated CHECK (dateUpdated >= '2010/01/01')
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
	projId			INT			NOT NULL	UNIQUE	-- NOT ALPHANUMERIC, just a number (no periods)
	, projName		VARCHAR(30) NOT NULL
	, manager		INT			
	, CONSTRAINT pk_Project PRIMARY KEY (projId)
	, CONSTRAINT fk_Project_manager FOREIGN KEY (manager)
		REFERENCES Employee (empId)
	, CONSTRAINT ck_Project_projId CHECK (projId >= 0)
);

---------------------------------------------------------------------------------
-- Records which employees have been assigned to which project.
---------------------------------------------------------------------------------
CREATE TABLE EmployeeProject (
	projId			INT			NOT NULL
	, empId			INT			NOT NULL
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
	, wpId					VARCHAR(30) 	NOT NULL
	, name	 				VARCHAR(30)		NOT NULL
	, description			VARCHAR(MAX)
	, unallocated_dollars	DECIMAL(11, 2)	-- The budget from the PM
	, allocated_dollars		DECIMAL(11, 2)	-- The budget from the PM
	, CONSTRAINT pk_WorkPackage PRIMARY KEY (projId, wpId)
	, CONSTRAINT fk_WorkPackage_projId FOREIGN KEY (projId)
		REFERENCES Project (projId)
	, CONSTRAINT ck_WorkPackage_unallocDollars CHECK (unallocated_dollars >= 0)
	, CONSTRAINT ck_WorkPackage_allocDollars CHECK (allocated_dollars >= 0)
);

---------------------------------------------------------------------------------
-- Tracks which employees are on which work packages and the ETC.
-- The ETC_days is estimated days until an employee completes his/her work on that work package.
-- A null ETC_days means it's unknown (the employee has just started and no estimate is available yet).
---------------------------------------------------------------------------------
CREATE TABLE EmployeeWorkPackage (
	empId			INT			NOT NULL
	, projId		INT			NOT NULL
	, wpId			VARCHAR(30) NOT NULL
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
	projId					INT			NOT NULL
	, wpId					VARCHAR(30) NOT NULL
	, reportDate			DATE		NOT NULL	DEFAULT CURRENT_TIMESTAMP
	, comments				TEXT		NOT NULL
	, workAccomplished		TEXT		NOT NULL
	, workPlannedNext		TEXT		NOT NULL
	, problemsEncountered	TEXT		NOT NULL
	, problemsAnticipated	TEXT		NOT NULL
	, CONSTRAINT pk_WpStatusReport PRIMARY KEY (projId, wpId, reportDate)
	, CONSTRAINT ck_WpStatusReport_reportDate CHECK (reportDate >= '2010/01/01')
	, CONSTRAINT fk_WpStatusReport_projWp FOREIGN KEY (projId, wpId)
		REFERENCES WorkPackage (projId, wpId)
);

---------------------------------------------------------------------------------
-- Tracks which employees are on which work packages and the ETC.
-- The ETC_days is estimated days until an employee completes his/her work on that work package.
-- A null ETC_days means it's unknown (the employee has just started and no estimate is available yet).
---------------------------------------------------------------------------------
CREATE TABLE EmployeeWorkPackageETC (
	empId			INT			NOT NULL
	, projId		INT			NOT NULL
	, wpId			VARCHAR(30) NOT NULL
	, dateUpdated	DATE		NOT NULL	DEFAULT CURRENT_TIMESTAMP
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
	, wpId					VARCHAR(30) 	NOT NULL
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
	, wpId				VARCHAR(30)		NOT NULL
	, pLevel			CHAR(2)			NOT NULL
	, estimated_days 	DECIMAL(10, 2)	
	, fiscalYear		DECIMAL(4, 0)	NOT NULL
	, CONSTRAINT pk_WpBudgetRE PRIMARY KEY (dateUpdated, pLevel, projId, wpId)
	, CONSTRAINT fk_WpBudgetRE_pLevelYear FOREIGN KEY (pLevel, fiscalYear)
		REFERENCES PersonLevel (pLevel, fiscalYear)
	, CONSTRAINT fk_WpBudgetRE_projWp FOREIGN KEY (projId, wpId)
		REFERENCES WorkPackage (projId, wpId)
	, CONSTRAINT ck_WpBudgetRE_EtcDollars CHECK (estimated_days >= 0)
	, CONSTRAINT ck_WpBudgetRE_dateUpdated CHECK (dateUpdated >= '2010/01/01')
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
	, wpId				VARCHAR(30)		NOT NULL
	, pLevel			CHAR(2)			NOT NULL
	, allocated_days 	DECIMAL(10, 2)
	, fiscalYear		DECIMAL(4, 0)	NOT NULL
	, CONSTRAINT pk_WpBudgetPM PRIMARY KEY (dateUpdated, pLevel, projId, wpId)
	, CONSTRAINT fk_WpBudgetPM_pLevelYear FOREIGN KEY (pLevel, fiscalYear)
		REFERENCES PersonLevel (pLevel, fiscalYear)
	, CONSTRAINT fk_WpBudgetPM_projWp FOREIGN KEY (projId, wpId)
		REFERENCES WorkPackage (projId, wpId)
	, CONSTRAINT ck_WpBudgetPM_EtcDollars CHECK (allocated_days >= 0)
	, CONSTRAINT ck_WpBudgetPM_dateUpdated CHECK (dateUpdated >= '2010/01/01')
);

---------------------------------------------------------------------------------
-- Records attributes common to multiple time sheet entries. 
---------------------------------------------------------------------------------
CREATE TABLE TimeSheetHeader (
	empId			INT				NOT NULL
	, tsDate		DATE			NOT NULL	DEFAULT CURRENT_TIMESTAMP
	, status		VARCHAR(9)					DEFAULT 'SAVED'
	, comments		VARCHAR(MAX)				DEFAULT ''
	, approvedBy	INT							DEFAULT NULL
	, CONSTRAINT pk_TimeSheetHeader PRIMARY KEY (empId, tsDate)
	, CONSTRAINT fk_TimeSheetHeader_empId FOREIGN KEY (empId)
		REFERENCES Employee (empId)
	, CONSTRAINT fk_TimeSheetHeader_approvedBy FOREIGN KEY (approvedBy)
		REFERENCES Employee (empId)
	, CONSTRAINT ck_TimeSheetHeader_tsDate CHECK (tsDate >= '2010/01/01')
	, CONSTRAINT ck_TimeSheetHeader_status CHECK (status IN ('SAVED', 'SUBMITTED', 'APPROVED', 'REJECTED'))
);

---------------------------------------------------------------------------------
-- Records the current, default timesheet set by an employee.
-- Whenever that employee requests a new timesheet, the default is used.
-- If a default is not specified, a blank timesheet is created/used.
---------------------------------------------------------------------------------
CREATE TABLE DefaultTimeSheet (
	empId		INT		NOT NULL
	, tsDate	DATE	NOT NULL	DEFAULT CURRENT_TIMESTAMP
	, CONSTRAINT pk_DefaultTimeSheet PRIMARY KEY (empId)
	, CONSTRAINT fk_DefaultTimeSheet FOREIGN KEY (empId, tsDate)
		REFERENCES TimeSheetHeader (empId, tsDate)
);

---------------------------------------------------------------------------------
-- Records attributes specific to each time sheet entry (row).
---------------------------------------------------------------------------------
CREATE TABLE TimeSheetEntry (
	empId			INT				NOT NULL
	, tsDate		DATE			NOT NULL	DEFAULT CURRENT_TIMESTAMP
	, projId		INT		NOT NULL
	, wpId			VARCHAR(30)		NOT NULL
	, sat			DECIMAL(3, 1)	NOT NULL	DEFAULT 0.0	CHECK (sat BETWEEN 0 AND 24)
	, sun			DECIMAL(3, 1)	NOT NULL	DEFAULT 0.0	CHECK (sun BETWEEN 0 AND 24)	
	, mon			DECIMAL(3, 1)	NOT NULL	DEFAULT 0.0	CHECK (mon BETWEEN 0 AND 24)
	, tue			DECIMAL(3, 1)	NOT NULL	DEFAULT 0.0	CHECK (tue BETWEEN 0 AND 24)
	, wed			DECIMAL(3, 1)	NOT NULL	DEFAULT 0.0	CHECK (wed BETWEEN 0 AND 24)
	, thu			DECIMAL(3, 1)	NOT NULL	DEFAULT 0.0	CHECK (thu BETWEEN 0 AND 24)
	, fri			DECIMAL(3, 1)	NOT NULL	DEFAULT 0.0	CHECK (fri BETWEEN 0 AND 24)
	, notes			VARCHAR(MAX)
	, CONSTRAINT pk_TimeSheetEntry PRIMARY KEY (empId, tsDate, projId, wpId)
	, CONSTRAINT fk_TimeSheetEntry_projWP FOREIGN KEY (projId, wpId)
		REFERENCES WorkPackage (projId, wpId)
	, CONSTRAINT fk_TimeSheetEntry_TimeSheetHeader FOREIGN KEY (empId, tsDate)
		REFERENCES TimeSheetHeader (empId, tsDate)
);

---------------------------------------------------------------------------------
-- The required, initial tables.
---------------------------------------------------------------------------------
-- who should be the manager of this?????
INSERT INTO Project(projId, projName, manager)
	VALUES (10, 'System', NULL);

INSERT INTO WorkPackage (projID, wpId, name, description, unallocated_dollars, allocated_dollars)
	VALUES (10, 'SICK', 'SICK_DAYS', 'Employees charge to this package when they take a sick day.', NULL, NULL);

INSERT INTO WorkPackage (projID, wpId, name, description, unallocated_dollars, allocated_dollars)
	VALUES (10, 'FLEX', 'FLEX_HOURS', 'Employees charge their flex time to this work package.', NULL, NULL);

INSERT INTO WorkPackage (projID, wpId, name, description, unallocated_dollars, allocated_dollars)
	VALUES (10, 'VACATION', 'VACATION_LEAVE', 'Employees charge to this package when they take vacation leave.', NULL, NULL);

INSERT INTO WorkPackage (projID, wpId, name, description, unallocated_dollars, allocated_dollars)
	VALUES (10, 'HOLIDAY', 'STATUTORY_HOLIDAYS', 'Employees charge to this package when they get a stat holiday off.', NULL, NULL);
