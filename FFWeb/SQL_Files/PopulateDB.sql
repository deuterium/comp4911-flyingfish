-- Rainbow Motions,  Mar-7-2011
-- Flying Fish - Project Management Application
-- Script used to populate the database with sample data.
-- SQL Express

---------------------------------------------------------------------------------
-- PersonLevel Table
---------------------------------------------------------------------------------
-- 2010
INSERT INTO PersonLevel (pLevel, rate, fiscalYear)
	VALUES ('DS', 87, 2010);
INSERT INTO PersonLevel (pLevel, rate, fiscalYear)
	VALUES ('JS', 100, 2010);
INSERT INTO PersonLevel (pLevel, rate, fiscalYear)
	VALUES ('P1', 110, 2010);
INSERT INTO PersonLevel (pLevel, rate, fiscalYear)
	VALUES ('P2', 135, 2010);
INSERT INTO PersonLevel (pLevel, rate, fiscalYear)
	VALUES ('P3', 166, 2010);
INSERT INTO PersonLevel (pLevel, rate, fiscalYear)
	VALUES ('P4', 220, 2010);
INSERT INTO PersonLevel (pLevel, rate, fiscalYear)
	VALUES ('P5', 255, 2010);
INSERT INTO PersonLevel (pLevel, rate, fiscalYear)
	VALUES ('P6', 275, 2010);
-- 2011
INSERT INTO PersonLevel (pLevel, rate, fiscalYear)
	VALUES ('DS', 97, 2011);
INSERT INTO PersonLevel (pLevel, rate, fiscalYear)
	VALUES ('JS', 107, 2011);
INSERT INTO PersonLevel (pLevel, rate, fiscalYear)
	VALUES ('P1', 115, 2011);
INSERT INTO PersonLevel (pLevel, rate, fiscalYear)
	VALUES ('P2', 147, 2011);
INSERT INTO PersonLevel (pLevel, rate, fiscalYear)
	VALUES ('P3', 179, 2011);
INSERT INTO PersonLevel (pLevel, rate, fiscalYear)
	VALUES ('P4', 225, 2011);
INSERT INTO PersonLevel (pLevel, rate, fiscalYear)
	VALUES ('P5', 266, 2011);
INSERT INTO PersonLevel (pLevel, rate, fiscalYear)
	VALUES ('P6', 300, 2011);

---------------------------------------------------------------------------------
-- Employee Table
---------------------------------------------------------------------------------
INSERT INTO Employee (empId, firstName, lastName, password, supervisor, approver, minHoursPerWeek, vacationLeave, sickDays, flexHours, isActive)
VALUES (0, 'Bruce', 'Link', DEFAULT, 0, 0, 10, 28, 0, 5, DEFAULT);

INSERT INTO Employee (empId, firstName, lastName, password, supervisor, approver, minHoursPerWeek, vacationLeave, sickDays, flexHours, isActive)
VALUES (1, 'Chris', 'Wood', DEFAULT, 0, 0, 40, 20, 1, 10, DEFAULT);

INSERT INTO Employee (empId, firstName, lastName, password, supervisor, approver, minHoursPerWeek, vacationLeave, sickDays, flexHours, isActive)
VALUES (8, 'Mike', 'Anderson', DEFAULT, 1, 1, 32, 0, 0, 5, DEFAULT);

INSERT INTO Employee (empId, firstName, lastName, password, supervisor, approver, minHoursPerWeek, vacationLeave, sickDays, flexHours, isActive)
VALUES (2, 'Jeffery', 'Wong', DEFAULT, 1, 8, 40, 15, 0, 20, DEFAULT);

INSERT INTO Employee (empId, firstName, lastName, password, supervisor, approver, minHoursPerWeek, vacationLeave, sickDays, flexHours, isActive)
VALUES (3, 'Nicholas', 'Tagle', DEFAULT, 1, 8, 40, 21, 4, 2, DEFAULT);

INSERT INTO Employee (empId, firstName, lastName, password, supervisor, approver, minHoursPerWeek, vacationLeave, sickDays, flexHours, isActive)
VALUES (4, 'Fausto', 'Faioli', DEFAULT, 1, 8, 40, 21, 0, 14, DEFAULT);

INSERT INTO Employee (empId, firstName, lastName, password, supervisor, approver, minHoursPerWeek, vacationLeave, sickDays, flexHours, isActive)
VALUES (5, 'Kaldra', 'Li', DEFAULT, 1, 8, 40, 21, 0, 0, DEFAULT);

INSERT INTO Employee (empId, firstName, lastName, password, supervisor, approver, minHoursPerWeek, vacationLeave, sickDays, flexHours, isActive)
VALUES (6, 'Saad', 'Shaharyar', DEFAULT, 1, 8, 40, 21, 4, 0, DEFAULT);

INSERT INTO Employee (empId, firstName, lastName, password, supervisor, approver, minHoursPerWeek, vacationLeave, sickDays, flexHours, isActive)
VALUES (7, 'Kalen', 'Wessel', DEFAULT, 1, 8, 20, 21, 11, 14, DEFAULT);

INSERT INTO Employee (empId, firstName, lastName, password, supervisor, approver, minHoursPerWeek, vacationLeave, sickDays, flexHours, isActive)
VALUES (9, 'Lindsay', 'Fester', DEFAULT, 1, 8, 40, 21, 4, -14, DEFAULT);

INSERT INTO Employee (empId, firstName, lastName, password, supervisor, approver, minHoursPerWeek, vacationLeave, sickDays, flexHours, isActive)
VALUES (0123456789, 'Rob', 'Bor', DEFAULT, 0, 0, 40, 21, 999, 2, DEFAULT);

INSERT INTO Employee (empId, firstName, lastName, password, supervisor, approver, minHoursPerWeek, vacationLeave, sickDays, flexHours, isActive)
VALUES (123, 'Jane', 'Doe', DEFAULT, 1, 9, 40, 21, 4, 2, DEFAULT);

INSERT INTO Employee (empId, firstName, lastName, password, supervisor, approver, minHoursPerWeek, vacationLeave, sickDays, flexHours, isActive)
VALUES (000010, 'John', 'Doe', DEFAULT, 1, 1, 40, 21, 4, 2, DEFAULT);

INSERT INTO Employee (empId, firstName, lastName, password, supervisor, approver, minHoursPerWeek, vacationLeave, sickDays, flexHours, isActive)
VALUES (321, 'Derp', 'Duplicate', DEFAULT, 1, 5, 40, 21, 4, 2, DEFAULT);

INSERT INTO Employee (empId, firstName, lastName, password, supervisor, approver, minHoursPerWeek, vacationLeave, sickDays, flexHours, isActive)
VALUES (320, 'Derp', 'Duplicate', DEFAULT, 1, 2, 40, 21, 4, 2, DEFAULT);

INSERT INTO Employee (empId, firstName, lastName, password, supervisor, approver, minHoursPerWeek, vacationLeave, sickDays, flexHours, isActive)
VALUES (322, 'Bob', 'Nologin', DEFAULT, 1, 2, 40, 21, 4, 2, 0);

---------------------------------------------------------------------------------
-- EmployeePersonLevel Table
---------------------------------------------------------------------------------
INSERT INTO EmployeePersonLevel (dateUpdated, empId, pLevel, fiscalYear)
	VALUES ('2010/01/01', 0, 'P6', 2010);

INSERT INTO EmployeePersonLevel (dateUpdated, empId, pLevel, fiscalYear)
	VALUES ('2011/01/01', 0, 'P6', 2011);
	
INSERT INTO EmployeePersonLevel (dateUpdated, empId, pLevel, fiscalYear)
	VALUES ('2010/01/01', 1, 'P3', 2010);

INSERT INTO EmployeePersonLevel (dateUpdated, empId, pLevel, fiscalYear)
	VALUES ('2011/01/01', 1, 'P4', 2011);

INSERT INTO EmployeePersonLevel (dateUpdated, empId, pLevel, fiscalYear)
	VALUES ('2011/02/01', 1, 'P5', 2011);
	
INSERT INTO EmployeePersonLevel (dateUpdated, empId, pLevel, fiscalYear)
	VALUES ('2011/01/01', 2, 'P4', 2011);

INSERT INTO EmployeePersonLevel (dateUpdated, empId, pLevel, fiscalYear)
	VALUES ('2011/02/01', 2, 'P3', 2011);

INSERT INTO EmployeePersonLevel (dateUpdated, empId, pLevel, fiscalYear)
	VALUES ('2011/01/01', 3, 'P4', 2011);
	
INSERT INTO EmployeePersonLevel (dateUpdated, empId, pLevel, fiscalYear)
	VALUES ('2011/03/01', 3, 'P5', 2011);

INSERT INTO EmployeePersonLevel (dateUpdated, empId, pLevel, fiscalYear)
	VALUES ('2011/01/01', 4, 'P3', 2011);
	
INSERT INTO EmployeePersonLevel (dateUpdated, empId, pLevel, fiscalYear)
	VALUES ('2011/02/01', 4, 'P4', 2011);
	
INSERT INTO EmployeePersonLevel (dateUpdated, empId, pLevel, fiscalYear)
	VALUES ('2011/01/01', 5, 'P3', 2011);

INSERT INTO EmployeePersonLevel (dateUpdated, empId, pLevel, fiscalYear)
	VALUES ('2011/01/01', 6, 'P2', 2011);

INSERT INTO EmployeePersonLevel (dateUpdated, empId, pLevel, fiscalYear)
	VALUES ('2011/01/01', 7, 'P1', 2011);

INSERT INTO EmployeePersonLevel (dateUpdated, empId, pLevel, fiscalYear)
	VALUES ('2011/03/23', 7, 'P1', 2011);

INSERT INTO EmployeePersonLevel (dateUpdated, empId, pLevel, fiscalYear)
	VALUES ('2011/01/01', 8, 'P1', 2011);

INSERT INTO EmployeePersonLevel (dateUpdated, empId, pLevel, fiscalYear)
	VALUES ('2011/01/01', 9, 'P2', 2011);

INSERT INTO EmployeePersonLevel (dateUpdated, empId, pLevel, fiscalYear)
	VALUES ('2011/03/01', 9, 'P3', 2011);

INSERT INTO EmployeePersonLevel (dateUpdated, empId, pLevel, fiscalYear)
	VALUES ('2011/01/01', 0123456789, 'JS', 2011);

INSERT INTO EmployeePersonLevel (dateUpdated, empId, pLevel, fiscalYear)
	VALUES ('2011/01/01', 123, 'DS', 2011);

INSERT INTO EmployeePersonLevel (dateUpdated, empId, pLevel, fiscalYear)
	VALUES ('2011/01/01', 000010, 'DS', 2011);

INSERT INTO EmployeePersonLevel (dateUpdated, empId, pLevel, fiscalYear)
	VALUES ('2011/01/01', 321, 'DS', 2011);

INSERT INTO EmployeePersonLevel (dateUpdated, empId, pLevel, fiscalYear)
	VALUES ('2011/01/01', 320, 'DS', 2011);
	
---------------------------------------------------------------------------------
-- HumanResourcesStaff Table
---------------------------------------------------------------------------------
INSERT INTO HumanResourcesStaff (empId)
	VALUES (0);
INSERT INTO HumanResourcesStaff (empId)
	VALUES (3);
INSERT INTO HumanResourcesStaff (empId)
	VALUES (4);
INSERT INTO HumanResourcesStaff (empId)
	VALUES (123);

---------------------------------------------------------------------------------
-- Project Table
---------------------------------------------------------------------------------
INSERT INTO Project (projID, projName, manager)
	VALUES (4911, 'FlyingFish', 9);
INSERT INTO Project (projID, projName, manager)
	VALUES (12345, 'CountingApp', 321);
INSERT INTO Project (projID, projName, manager)
	VALUES (4735, 'Operating Systems', 0123456789);
INSERT INTO Project (projID, projName, manager)
	VALUES (4915, 'MIS', 9);
	
---------------------------------------------------------------------------------
-- EmployeeProject
---------------------------------------------------------------------------------
INSERT INTO EmployeeProject (projID, empId)
	VALUES (4911, 0);

INSERT INTO EmployeeProject (projID, empId)
	VALUES (4911, 1);

INSERT INTO EmployeeProject (projID, empId)
	VALUES (4911, 2);

INSERT INTO EmployeeProject (projID, empId)
	VALUES (4911, 3);

INSERT INTO EmployeeProject (projID, empId)
	VALUES (4911, 4);

INSERT INTO EmployeeProject (projID, empId)
	VALUES (4911, 5);

INSERT INTO EmployeeProject (projID, empId)
	VALUES (4911, 6);

INSERT INTO EmployeeProject (projID, empId)
	VALUES (4911, 7);

INSERT INTO EmployeeProject (projID, empId)
	VALUES (4911, 8);

INSERT INTO EmployeeProject (projID, empId)
	VALUES (4911, 9);

INSERT INTO EmployeeProject (projID, empId)
	VALUES (12345, 320);

INSERT INTO EmployeeProject (projID, empId)
	VALUES (12345, 321);

-- System Table (for Sick Days, Vacation Leave, Flex Hours, Holidays)
INSERT INTO EmployeeProject (projID, empId)
	VALUES (10, 0);

INSERT INTO EmployeeProject (projID, empId)
	VALUES (10, 1);

INSERT INTO EmployeeProject (projID, empId)
	VALUES (10, 2);

INSERT INTO EmployeeProject (projID, empId)
	VALUES (10, 3);

INSERT INTO EmployeeProject (projID, empId)
	VALUES (10, 4);

INSERT INTO EmployeeProject (projID, empId)
	VALUES (10, 5);

INSERT INTO EmployeeProject (projID, empId)
	VALUES (10, 6);

INSERT INTO EmployeeProject (projID, empId)
	VALUES (10, 7);

INSERT INTO EmployeeProject (projID, empId)
	VALUES (10, 8);

INSERT INTO EmployeeProject (projID, empId)
	VALUES (10, 9);

INSERT INTO EmployeeProject (projID, empId)
	VALUES (10, 320);

INSERT INTO EmployeeProject (projID, empId)
	VALUES (10, 321);

INSERT INTO EmployeeProject (projID, empId)
	VALUES (10, 0123456789);
	
INSERT INTO EmployeeProject (projID, empId)
	VALUES (10, 123);
	
INSERT INTO EmployeeProject (projID, empId)
	VALUES (10, 000010);

INSERT INTO EmployeeProject (projID, empId)
	VALUES (10, 322);

---------------------------------------------------------------------------------
-- WorkPackage Table
---------------------------------------------------------------------------------
INSERT INTO WorkPackage (projID, wpId, name, description, unallocated_dollars, allocated_dollars)
	VALUES (4911, '1', 'Inception', 'No description', 0, 3000);

INSERT INTO WorkPackage (projID, wpId, name, description, unallocated_dollars, allocated_dollars)
	VALUES (4911, '2', 'Ellaboration', 'No description', 1000, 3000);

INSERT INTO WorkPackage (projID, wpId, name, description, unallocated_dollars, allocated_dollars)
	VALUES (4911, '3', 'Construction 1', 'No description', 500, 5000);
	
INSERT INTO WorkPackage (projID, wpId, name, description, unallocated_dollars, allocated_dollars)
	VALUES (4911, '4', 'Construction 2', 'No description', 1000, 10000);

INSERT INTO WorkPackage (projID, wpId, name, description, unallocated_dollars, allocated_dollars)
	VALUES (4911, '5', 'Construction 3', 'No description', 6000, 4500);

INSERT INTO WorkPackage (projID, wpId, name, description, unallocated_dollars, allocated_dollars)
	VALUES (12345, 'A1', 'Do Stuff', 'No description', 1000, 2000);

INSERT INTO WorkPackage (projID, wpId, name, description, unallocated_dollars, allocated_dollars)
	VALUES (12345, 'A2', 'Do More Stuff', 'No description', 1000, 0);

INSERT INTO WorkPackage (projID, wpId, name, description, unallocated_dollars, allocated_dollars)
	VALUES (12345, 'B1', 'Keep doing stuff', 'No description', 1000, 0);

INSERT INTO WorkPackage (projID, wpId, name, description, unallocated_dollars, allocated_dollars)
	VALUES (12345, 'B2', 'Testing the counter.', 'No description', 1000, 0);

INSERT INTO WorkPackage (projID, wpId, name, description,unallocated_dollars, allocated_dollars)
	VALUES (4735, 'Term1', 'Intro to Linux', 'No description', 0, 2000);

INSERT INTO WorkPackage (projID, wpId, name, description, unallocated_dollars, allocated_dollars)
	VALUES (4735, 'Term2', 'Advanced Linux', 'No description', 1000, 2000);

INSERT INTO WorkPackage (projID, wpId, name, description, unallocated_dollars, allocated_dollars)
	VALUES (4915, 'Term1', 'Intro to Linux', 'No description', 333333333, 33333333); 

---------------------------------------------------------------------------------
-- EmployeeWorkPackage Table
---------------------------------------------------------------------------------
INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (0, 4911, '1');

INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (0, 4911, '2');

INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (0, 4911, '3');

INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (0, 4911, '4');

INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (1, 4911, '1');

INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (1, 4911, '2');

INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (1, 4911, '3');

INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (1, 4911, '4');

INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (2, 4911, '1');

INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (2, 4911, '2');

INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (2, 4911, '3');

INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (2, 4911, '4');

INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (3, 4911, '1');

INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (3, 4911, '2');

INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (3, 4911, '3');

INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (3, 4911, '4');

INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (4, 4911, '1');

INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (4, 4911, '2');

INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (4, 4911, '3');

INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (4, 4911, '4');

INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (5, 4911, '1');

INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (5, 4911, '2');

INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (5, 4911, '3');

INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (5, 4911, '4');

INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (6, 4911, '1');

INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (6, 4911, '2');

INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (6, 4911, '3');

INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (6, 4911, '4');

INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (7, 4911, '1');

INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (7, 4911, '2');

INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (7, 4911, '3');

INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (7, 4911, '4');

INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (8, 4911, '1');

INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (8, 4911, '2');

INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (8, 4911, '3');

INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (8, 4911, '4');

INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (9, 4911, '1');

INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (9, 4911, '2');

INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (9, 4911, '3');

INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (9, 4911, '4');

INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (320, 12345, 'A1');

INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (320, 12345, 'A2');

INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (321, 12345, 'B1');

INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (321, 12345, 'B2');

-- System SICK
INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (0, 10, 'SICK');
INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (1, 10, 'SICK');	
INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (2, 10, 'SICK');	
INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (3, 10, 'SICK');	
INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (4, 10, 'SICK');	
INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (5, 10, 'SICK');	
INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (6, 10, 'SICK');	
INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (7, 10, 'SICK');	
INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (8, 10, 'SICK');	
INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (9, 10, 'SICK');	
INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (0123456789, 10, 'SICK');	
INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (123, 10, 'SICK');	
INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (000010, 10, 'SICK');	
INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (321, 10, 'SICK');	
INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (320, 10, 'SICK');	
INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (322, 10, 'SICK');

-- System FLEX
INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (0, 10, 'FLEX');
INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (1, 10, 'FLEX');	
INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (2, 10, 'FLEX');	
INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (3, 10, 'FLEX');	
INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (4, 10, 'FLEX');	
INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (5, 10, 'FLEX');	
INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (6, 10, 'FLEX');	
INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (7, 10, 'FLEX');	
INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (8, 10, 'FLEX');	
INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (9, 10, 'FLEX');	
INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (0123456789, 10, 'FLEX');	
INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (123, 10, 'FLEX');	
INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (000010, 10, 'FLEX');	
INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (321, 10, 'FLEX');	
INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (320, 10, 'FLEX');	
INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (322, 10, 'FLEX');
	
-- System VACATION
INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (0, 10, 'VACATION');
INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (1, 10, 'VACATION');	
INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (2, 10, 'VACATION');	
INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (3, 10, 'VACATION');	
INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (4, 10, 'VACATION');	
INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (5, 10, 'VACATION');	
INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (6, 10, 'VACATION');	
INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (7, 10, 'VACATION');	
INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (8, 10, 'VACATION');	
INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (9, 10, 'VACATION');	
INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (0123456789, 10, 'VACATION');	
INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (123, 10, 'VACATION');	
INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (000010, 10, 'VACATION');	
INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (321, 10, 'VACATION');	
INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (320, 10, 'VACATION');	
INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (322, 10, 'VACATION');

-- System HOLIDAY
INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (0, 10, 'HOLIDAY');
INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (1, 10, 'HOLIDAY');	
INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (2, 10, 'HOLIDAY');	
INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (3, 10, 'HOLIDAY');	
INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (4, 10, 'HOLIDAY');	
INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (5, 10, 'HOLIDAY');	
INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (6, 10, 'HOLIDAY');	
INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (7, 10, 'HOLIDAY');	
INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (8, 10, 'HOLIDAY');	
INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (9, 10, 'HOLIDAY');	
INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (0123456789, 10, 'HOLIDAY');	
INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (123, 10, 'HOLIDAY');	
INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (000010, 10, 'HOLIDAY');	
INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (321, 10, 'HOLIDAY');	
INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (320, 10, 'HOLIDAY');	
INSERT INTO EmployeeWorkPackage (empId, projId, wpId)
	VALUES (322, 10, 'HOLIDAY');

---------------------------------------------------------------------------------
-- WorkPackageStatusReport
---------------------------------------------------------------------------------
INSERT INTO WorkPackageStatusReport (projId, wpId, reportDate, comments, workAccomplished, workPlannedNext, problemsEncountered, problemsAnticipated)
	VALUES (4911, '1', '2011/01/03', 'No comment...', 'Lots was accomplished in Inception', 'Elaboration is the next phase',  'no problems', 'subversion problems');

INSERT INTO WorkPackageStatusReport (projId, wpId, reportDate, comments, workAccomplished, workPlannedNext, problemsEncountered, problemsAnticipated)
	VALUES (4911, '2', '2011/01/10', 'No comment...', 'Lots was accomplished in Elaboration', 'Construction 1 is the next phase',  'changed subversion to GIT', 'database behind schedule');

INSERT INTO WorkPackageStatusReport (projId, wpId, reportDate, comments, workAccomplished, workPlannedNext, problemsEncountered, problemsAnticipated)
	VALUES (4911, '3', '2011/01/17', 'No comment...', 'Lots was accomplished in Inception', 'Elaboration is the next phase',  'no problems', 'subversion problems');

INSERT INTO WorkPackageStatusReport (projId, wpId, reportDate, comments, workAccomplished, workPlannedNext, problemsEncountered, problemsAnticipated)
	VALUES (12345, 'A1', '2011/01/03', 'This is a comment.', 'Not much was accomplished this phase, just a basic R&A.', 'We''l work harder next period.',  '', 'We don''t know what to expect');

---------------------------------------------------------------------------------
-- EmployeeWorkPackageETC Table
---------------------------------------------------------------------------------
INSERT INTO EmployeeWorkPackageETC (empId, projId, wpId, dateUpdated, ETC_days)
	VALUES (0, 4911, '1', '2011/01/03', 0);

INSERT INTO EmployeeWorkPackageETC (empId, projId, wpId, dateUpdated, ETC_days)
	VALUES (0, 4911, '2', '2011/01/10', 0);

INSERT INTO EmployeeWorkPackageETC (empId, projId, wpId, dateUpdated, ETC_days)
	VALUES (0, 4911, '3', '2011/01/17', 20);

INSERT INTO EmployeeWorkPackageETC (empId, projId, wpId, dateUpdated, ETC_days)
	VALUES (1, 4911, '1', '2011/01/03', 0);

INSERT INTO EmployeeWorkPackageETC (empId, projId, wpId, dateUpdated, ETC_days)
	VALUES (1, 4911, '2', '2011/01/10', 0);

INSERT INTO EmployeeWorkPackageETC (empId, projId, wpId, dateUpdated, ETC_days)
	VALUES (1, 4911, '3', '2011/01/17', 15);

INSERT INTO EmployeeWorkPackageETC (empId, projId, wpId, dateUpdated, ETC_days)
	VALUES (2, 4911, '1', '2011/01/03', 0);

INSERT INTO EmployeeWorkPackageETC (empId, projId, wpId, dateUpdated, ETC_days)
	VALUES (2, 4911, '2', '2011/01/10', 0);

INSERT INTO EmployeeWorkPackageETC (empId, projId, wpId, dateUpdated, ETC_days)
	VALUES (2, 4911, '3', '2011/01/17', 15);

INSERT INTO EmployeeWorkPackageETC (empId, projId, wpId, dateUpdated, ETC_days)
	VALUES (3, 4911, '1', '2011/01/03', 0);

INSERT INTO EmployeeWorkPackageETC (empId, projId, wpId, dateUpdated, ETC_days)
	VALUES (3, 4911, '2', '2011/01/10', 0);

INSERT INTO EmployeeWorkPackageETC (empId, projId, wpId, dateUpdated, ETC_days)
	VALUES (3, 4911, '3', '2011/01/17', 15);

INSERT INTO EmployeeWorkPackageETC (empId, projId, wpId, dateUpdated, ETC_days)
	VALUES (4, 4911, '1', '2011/01/03', 0);

INSERT INTO EmployeeWorkPackageETC (empId, projId, wpId, dateUpdated, ETC_days)
	VALUES (4, 4911, '2', '2011/01/10', 0);

INSERT INTO EmployeeWorkPackageETC (empId, projId, wpId, dateUpdated, ETC_days)
	VALUES (4, 4911, '3', '2011/01/17', 15);

INSERT INTO EmployeeWorkPackageETC (empId, projId, wpId, dateUpdated, ETC_days)
	VALUES (5, 4911, '1', '2011/01/03', 0);

INSERT INTO EmployeeWorkPackageETC (empId, projId, wpId, dateUpdated, ETC_days)
	VALUES (5, 4911, '2', '2011/01/10', 0);

INSERT INTO EmployeeWorkPackageETC (empId, projId, wpId, dateUpdated, ETC_days)
	VALUES (5, 4911, '3', '2011/01/17', 15);

INSERT INTO EmployeeWorkPackageETC (empId, projId, wpId, dateUpdated, ETC_days)
	VALUES (6, 4911, '1', '2011/01/03', 0);

INSERT INTO EmployeeWorkPackageETC (empId, projId, wpId, dateUpdated, ETC_days)
	VALUES (6, 4911, '2', '2011/01/10', 0);

INSERT INTO EmployeeWorkPackageETC (empId, projId, wpId, dateUpdated, ETC_days)
	VALUES (6, 4911, '3', '2011/01/17', 15);

INSERT INTO EmployeeWorkPackageETC (empId, projId, wpId, dateUpdated, ETC_days)
	VALUES (7, 4911, '1', '2011/01/03', 0);

INSERT INTO EmployeeWorkPackageETC (empId, projId, wpId, dateUpdated, ETC_days)
	VALUES (7, 4911, '2', '2011/01/10', 0);

INSERT INTO EmployeeWorkPackageETC (empId, projId, wpId, dateUpdated, ETC_days)
	VALUES (7, 4911, '3', '2011/01/17', 15);

INSERT INTO EmployeeWorkPackageETC (empId, projId, wpId, dateUpdated, ETC_days)
	VALUES (8, 4911, '1', '2011/01/03', 0);

INSERT INTO EmployeeWorkPackageETC (empId, projId, wpId, dateUpdated, ETC_days)
	VALUES (8, 4911, '2', '2011/01/10', 0);

INSERT INTO EmployeeWorkPackageETC (empId, projId, wpId, dateUpdated, ETC_days)
	VALUES (8, 4911, '3', '2011/01/17', 15);

INSERT INTO EmployeeWorkPackageETC (empId, projId, wpId, dateUpdated, ETC_days)
	VALUES (9, 4911, '1', '2011/01/03', 0);

INSERT INTO EmployeeWorkPackageETC (empId, projId, wpId, dateUpdated, ETC_days)
	VALUES (9, 4911, '2', '2011/01/10', 0);

INSERT INTO EmployeeWorkPackageETC (empId, projId, wpId, dateUpdated, ETC_days)
	VALUES (9, 4911, '3', '2011/01/17', 15);

INSERT INTO EmployeeWorkPackageETC (empId, projId, wpId, dateUpdated, ETC_days)
	VALUES (320, 12345, 'A1', '2011/01/03', 25);

---------------------------------------------------------------------------------
-- WorkPackageResponsibleEngineer Table
---------------------------------------------------------------------------------
INSERT INTO WorkPackageResponsibleEngineer (projId, wpId, responsibleEngineer)
	VALUES (4911, '1', 2);

INSERT INTO WorkPackageResponsibleEngineer (projId, wpId, responsibleEngineer)
	VALUES (4911, '2', 3);

INSERT INTO WorkPackageResponsibleEngineer (projId, wpId, responsibleEngineer)
	VALUES (4911, '3', 4);

INSERT INTO WorkPackageResponsibleEngineer (projId, wpId, responsibleEngineer)
	VALUES (4911, '4', 7);

INSERT INTO WorkPackageResponsibleEngineer (projId, wpId, responsibleEngineer)
	VALUES (12345, 'A1', 320);

INSERT INTO WorkPackageResponsibleEngineer (projId, wpId, responsibleEngineer)
	VALUES (12345, 'A2', 320);

INSERT INTO WorkPackageResponsibleEngineer (projId, wpId, responsibleEngineer)
	VALUES (12345, 'B1', 321);

INSERT INTO WorkPackageResponsibleEngineer (projId, wpId, responsibleEngineer)
 	VALUES (12345, 'B2', 321);

---------------------------------------------------------------------------------
-- WorkPackageEstimateRE
---------------------------------------------------------------------------------
INSERT INTO WorkPackageEstimateRE (dateUpdated, projId, wpId, pLevel, estimated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '1', 'P6', 0, 2011);

INSERT INTO WorkPackageEstimateRE (dateUpdated, projId, wpId, pLevel, estimated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '2', 'P6', 0, 2011);

INSERT INTO WorkPackageEstimateRE (dateUpdated, projId, wpId, pLevel, estimated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '3', 'P6', 48, 2011);

INSERT INTO WorkPackageEstimateRE (dateUpdated, projId, wpId, pLevel, estimated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '4', 'P6', NULL, 2011);

INSERT INTO WorkPackageEstimateRE (dateUpdated, projId, wpId, pLevel, estimated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '1', 'P5', 0, 2011);

INSERT INTO WorkPackageEstimateRE (dateUpdated, projId, wpId, pLevel, estimated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '2', 'P5', 0, 2011);

INSERT INTO WorkPackageEstimateRE (dateUpdated, projId, wpId, pLevel, estimated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '3', 'P5', 48, 2011);

INSERT INTO WorkPackageEstimateRE (dateUpdated, projId, wpId, pLevel, estimated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '4', 'P5', NULL, 2011);

INSERT INTO WorkPackageEstimateRE (dateUpdated, projId, wpId, pLevel, estimated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '1', 'P4', 0, 2011);

INSERT INTO WorkPackageEstimateRE (dateUpdated, projId, wpId, pLevel, estimated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '2', 'P4', 0, 2011);

INSERT INTO WorkPackageEstimateRE (dateUpdated, projId, wpId, pLevel, estimated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '3', 'P4', 64, 2011);

INSERT INTO WorkPackageEstimateRE (dateUpdated, projId, wpId, pLevel, estimated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '4', 'P4', NULL, 2011);
	
INSERT INTO WorkPackageEstimateRE (dateUpdated, projId, wpId, pLevel, estimated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '1', 'P3', 0, 2011);

INSERT INTO WorkPackageEstimateRE (dateUpdated, projId, wpId, pLevel, estimated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '2', 'P3', 0, 2011);

INSERT INTO WorkPackageEstimateRE (dateUpdated, projId, wpId, pLevel, estimated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '3', 'P3', 64, 2011);

INSERT INTO WorkPackageEstimateRE (dateUpdated, projId, wpId, pLevel, estimated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '4', 'P3', NULL, 2011);

INSERT INTO WorkPackageEstimateRE (dateUpdated, projId, wpId, pLevel, estimated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '1', 'P2', 0, 2011);

INSERT INTO WorkPackageEstimateRE (dateUpdated, projId, wpId, pLevel, estimated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '2', 'P2', 0, 2011);

INSERT INTO WorkPackageEstimateRE (dateUpdated, projId, wpId, pLevel, estimated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '3', 'P2', 24, 2011);

INSERT INTO WorkPackageEstimateRE (dateUpdated, projId, wpId, pLevel, estimated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '4', 'P2', NULL, 2011);

INSERT INTO WorkPackageEstimateRE (dateUpdated, projId, wpId, pLevel, estimated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '1', 'P1', 0, 2011);

INSERT INTO WorkPackageEstimateRE (dateUpdated, projId, wpId, pLevel, estimated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '2', 'P1', 0, 2011);

INSERT INTO WorkPackageEstimateRE (dateUpdated, projId, wpId, pLevel, estimated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '3', 'P1', 42, 2011);

INSERT INTO WorkPackageEstimateRE (dateUpdated, projId, wpId, pLevel, estimated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '4', 'P1', NULL, 2011);

INSERT INTO WorkPackageEstimateRE (dateUpdated, projId, wpId, pLevel, estimated_days, fiscalYear)
	VALUES ('2011/02/02', 12345, 'A1', 'DS', 24, 2011);

INSERT INTO WorkPackageEstimateRE (dateUpdated, projId, wpId, pLevel, estimated_days, fiscalYear)
	VALUES ('2011/02/02', 12345, 'A2', 'DS', 64, 2011);

INSERT INTO WorkPackageEstimateRE (dateUpdated, projId, wpId, pLevel, estimated_days, fiscalYear)
	VALUES ('2011/02/02', 12345, 'B1', 'DS', 87, 2011);

INSERT INTO WorkPackageEstimateRE (dateUpdated, projId, wpId, pLevel, estimated_days, fiscalYear)
	VALUES ('2011/02/02', 12345, 'B2', 'DS', 120, 2011);

---------------------------------------------------------------------------------
-- WorkPackageBudgetPM
---------------------------------------------------------------------------------
INSERT INTO WorkPackageBudgetPM (dateUpdated, projId, wpId, pLevel, allocated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '1', 'P6', 0, 2011);

INSERT INTO WorkPackageBudgetPM (dateUpdated, projId, wpId, pLevel, allocated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '2', 'P6', 0, 2011);

INSERT INTO WorkPackageBudgetPM (dateUpdated, projId, wpId, pLevel, allocated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '3', 'P6', 48, 2011);

INSERT INTO WorkPackageBudgetPM (dateUpdated, projId, wpId, pLevel, allocated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '4', 'P6', NULL, 2011);

INSERT INTO WorkPackageBudgetPM (dateUpdated, projId, wpId, pLevel, allocated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '1', 'P5', 0, 2011);

INSERT INTO WorkPackageBudgetPM (dateUpdated, projId, wpId, pLevel, allocated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '2', 'P5', 0, 2011);

INSERT INTO WorkPackageBudgetPM (dateUpdated, projId, wpId, pLevel, allocated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '3', 'P5', 40, 2011);

INSERT INTO WorkPackageBudgetPM (dateUpdated, projId, wpId, pLevel, allocated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '4', 'P5', NULL, 2011);

INSERT INTO WorkPackageBudgetPM (dateUpdated, projId, wpId, pLevel, allocated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '1', 'P4', 0, 2011);

INSERT INTO WorkPackageBudgetPM (dateUpdated, projId, wpId, pLevel, allocated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '2', 'P4', 0, 2011);

INSERT INTO WorkPackageBudgetPM (dateUpdated, projId, wpId, pLevel, allocated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '3', 'P4', 40, 2011);

INSERT INTO WorkPackageBudgetPM (dateUpdated, projId, wpId, pLevel, allocated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '4', 'P4', NULL, 2011);

INSERT INTO WorkPackageBudgetPM (dateUpdated, projId, wpId, pLevel, allocated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '1', 'P3', 0, 2011);

INSERT INTO WorkPackageBudgetPM (dateUpdated, projId, wpId, pLevel, allocated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '2', 'P3', 0, 2011);

INSERT INTO WorkPackageBudgetPM (dateUpdated, projId, wpId, pLevel, allocated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '3', 'P3', 48, 2011);

INSERT INTO WorkPackageBudgetPM (dateUpdated, projId, wpId, pLevel, allocated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '4', 'P3', NULL, 2011);

INSERT INTO WorkPackageBudgetPM (dateUpdated, projId, wpId, pLevel, allocated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '1', 'P2', 0, 2011);

INSERT INTO WorkPackageBudgetPM (dateUpdated, projId, wpId, pLevel, allocated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '2', 'P2', 0, 2011);

INSERT INTO WorkPackageBudgetPM (dateUpdated, projId, wpId, pLevel, allocated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '3', 'P2', 24, 2011);

INSERT INTO WorkPackageBudgetPM (dateUpdated, projId, wpId, pLevel, allocated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '4', 'P2', NULL, 2011);

INSERT INTO WorkPackageBudgetPM (dateUpdated, projId, wpId, pLevel, allocated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '1', 'P1', 0, 2011);

INSERT INTO WorkPackageBudgetPM (dateUpdated, projId, wpId, pLevel, allocated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '2', 'P1', 0, 2011);

INSERT INTO WorkPackageBudgetPM (dateUpdated, projId, wpId, pLevel, allocated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '3', 'P1', 36, 2011);

INSERT INTO WorkPackageBudgetPM (dateUpdated, projId, wpId, pLevel, allocated_days, fiscalYear)
	VALUES ('2011/02/02', 4911, '4', 'P1', NULL, 2011);

INSERT INTO WorkPackageBudgetPM (dateUpdated, projId, wpId, pLevel, allocated_days, fiscalYear)
	VALUES ('2011/02/02', 12345, 'A1', 'DS', 24, 2011);

INSERT INTO WorkPackageBudgetPM (dateUpdated, projId, wpId, pLevel, allocated_days, fiscalYear)
	VALUES ('2011/02/02', 12345, 'A2', 'DS', 32, 2011);

INSERT INTO WorkPackageBudgetPM (dateUpdated, projId, wpId, pLevel, allocated_days, fiscalYear)
	VALUES ('2011/02/02', 12345, 'B1', 'DS', 67, 2011);

INSERT INTO WorkPackageBudgetPM (dateUpdated, projId, wpId, pLevel, allocated_days, fiscalYear)
	VALUES ('2011/02/02', 12345, 'B2', 'DS', 114, 2011);
	
---------------------------------------------------------------------------------
-- TimeSheetHeader Table
---------------------------------------------------------------------------------
INSERT INTO TimeSheetHeader (empId, tsDate, status, comments, approvedBy)
	VALUES(0, '2011/01/01', 'APPROVED', 'Bruce could have worked harder this weekend', 0);

INSERT INTO TimeSheetHeader (empId, tsDate, status, comments, approvedBy)
	VALUES(1, '2011/01/01', 'APPROVED', '', 0);

INSERT INTO TimeSheetHeader (empId, tsDate, status, comments, approvedBy)
	VALUES(2, '2011/01/01', 'APPROVED', 'Good job!', 8);

INSERT INTO TimeSheetHeader (empId, tsDate, status, comments, approvedBy)
	VALUES(3, '2011/01/01', 'REJECTED', 'You only stayed for 4 hours on Fri', 8);

INSERT INTO TimeSheetHeader (empId, tsDate, status, comments, approvedBy)
	VALUES(4, '2011/01/01', 'SUBMITTED', '', NULL);

INSERT INTO TimeSheetHeader (empId, tsDate, status, comments, approvedBy)
	VALUES(5, '2011/01/01', 'SUBMITTED', '', NULL);

INSERT INTO TimeSheetHeader (empId, tsDate, status, comments, approvedBy)
	VALUES(6, '2011/01/01', 'APPROVED', 'Good job!', 8);

INSERT INTO TimeSheetHeader (empId, tsDate, status, comments, approvedBy)
	VALUES(7, '2011/01/01', 'APPROVED', 'Good job!', 8);

INSERT INTO TimeSheetHeader (empId, tsDate, status, comments, approvedBy)
	VALUES(8, '2011/01/01', 'APPROVED', 'Good job!', 8);

INSERT INTO TimeSheetHeader (empId, tsDate, status, comments, approvedBy)
	VALUES(9, '2011/01/01', 'APPROVED', '', 8);

INSERT INTO TimeSheetHeader (empId, tsDate, status, comments, approvedBy)
	VALUES(0, '2011/02/01', 'APPROVED', DEFAULT, 0);

INSERT INTO TimeSheetHeader (empId, tsDate, status, comments, approvedBy)
	VALUES(1, '2011/02/01', 'APPROVED', DEFAULT, 0);

INSERT INTO TimeSheetHeader (empId, tsDate, status, comments, approvedBy)
	VALUES(2, '2011/02/01', DEFAULT, DEFAULT, 0);

INSERT INTO TimeSheetHeader (empId, tsDate, status, comments, approvedBy)
	VALUES(3, '2011/02/01', DEFAULT, DEFAULT, 0);

INSERT INTO TimeSheetHeader (empId, tsDate, status, comments, approvedBy)
	VALUES(4, '2011/02/01', DEFAULT, DEFAULT, 0);

INSERT INTO TimeSheetHeader (empId, tsDate, status, comments, approvedBy)
	VALUES(5, '2011/02/01', DEFAULT, DEFAULT, 0);

INSERT INTO TimeSheetHeader (empId, tsDate, status, comments, approvedBy)
	VALUES(6, '2011/02/01', 'APPROVED', DEFAULT, 0);

INSERT INTO TimeSheetHeader (empId, tsDate, status, comments, approvedBy)
	VALUES(7, '2011/02/01', 'APPROVED', 'No comments.', 0);

INSERT INTO TimeSheetHeader (empId, tsDate, status, comments, approvedBy)
	VALUES(8, '2011/02/01', 'APPROVED', 'Great work!', 0);

INSERT INTO TimeSheetHeader (empId, tsDate, status, comments, approvedBy)
	VALUES(9, '2011/02/01', 'APPROVED', 'Keep it up!', 0);

INSERT INTO TimeSheetHeader (empId, tsDate, status, comments, approvedBy)
	VALUES(320, '2011/01/01', 'APPROVED', 'Good job this week. :)', 2);

INSERT INTO TimeSheetHeader (empId, tsDate, status, comments, approvedBy)
	VALUES(321, '2011/01/01', 'APPROVED', '', 2);

INSERT INTO TimeSheetHeader (empId, tsDate, status, comments, approvedBy)
	VALUES(320, '2011/03/01', 'APPROVED', '', 2);

INSERT INTO TimeSheetHeader (empId, tsDate, status, comments, approvedBy)
	VALUES(321, '2011/03/01', 'APPROVED', '', 2);

INSERT INTO TimeSheetHeader (empId, tsDate, status, comments, approvedBy)
	VALUES(320, '2011/02/01', 'APPROVED', '', 2);

INSERT INTO TimeSheetHeader (empId, tsDate, status, comments, approvedBy)
	VALUES(321, '2011/02/01', 'APPROVED', '', 2);

---------------------------------------------------------------------------------
-- TimeSheetEntry Table
---------------------------------------------------------------------------------
INSERT INTO DefaultTimeSheet (empId, tsDate)
	VALUES (0, '2011/01/01');

INSERT INTO DefaultTimeSheet (empId, tsDate)
	VALUES (9, '2011/01/01');

INSERT INTO DefaultTimeSheet (empId, tsDate)
	VALUES (3, '2011/01/01');

INSERT INTO DefaultTimeSheet (empId, tsDate)
	VALUES (4, '2011/01/01');

---------------------------------------------------------------------------------
-- TimeSheetEntry Table
---------------------------------------------------------------------------------
INSERT INTO TimeSheetEntry
VALUES(0, '2011/01/01', 4911, '1', 8, 8, 8, 8, DEFAULT, DEFAULT, DEFAULT, '');

INSERT INTO TimeSheetEntry
VALUES(1, '2011/01/01', 4911, '1', 8, 8, 8, 8, 8, 8, 8, 'Visual Studio 2010 is awesome!');

INSERT INTO TimeSheetEntry
VALUES(2, '2011/01/01', 4911, '1', 8, 8, 8, 8, 8, 8, 8, 'I hate timesheets');

INSERT INTO TimeSheetEntry
VALUES(3, '2011/01/01', 4911, '1', 8, 8, 8, 8, 8, 8, 8, 'I love timesheets');

INSERT INTO TimeSheetEntry
VALUES(4, '2011/01/01', 4911, '1', 8, 8, 8, 8, 8, 8, 8, 'Why do cows wear bells? Their horns don''t work.');

INSERT INTO TimeSheetEntry
VALUES(5, '2011/01/01', 4911, '1', 8, 8, 8, 8, 8, 8, 8, 'A man walks into a bar... ouch');

INSERT INTO TimeSheetEntry
VALUES(6, '2011/01/01', 4911, '1', 8, 8, 8, 8, 8, 8, 8, 'What did one snowman say to the other snowman? Smells like carrots.');

INSERT INTO TimeSheetEntry
VALUES(7, '2011/01/01', 4911, '1', 8, 8, 8, 8, 8, 8, 8, 'What''s red and smells like blue paint? Red paint.');

INSERT INTO TimeSheetEntry
VALUES(8, '2011/01/01', 4911, '1', 8, 8, 8, 8, 8, 8, 8, 'What did one wall say to the other wall? Lets meet up in the corner.');

INSERT INTO TimeSheetEntry
VALUES(9, '2011/01/01', 4911, '1', 8, 8, 8, 8, 8, 8, 8, 'Why do seagulls live by the sea? Cause if they lived by the bay they''d be baygulls (bagels) :P');

INSERT INTO TimeSheetEntry
VALUES(0, '2011/02/01', 4911, '2', 8, 7, 6, 5, 4, 3, 7, 'How do you make Lady Gaga cry? Poke/her/face.');

INSERT INTO TimeSheetEntry
VALUES(1, '2011/02/01', 4911, '2', 8, 7, 6, 5, 4, 3, 7, 'Why did the man driving the train get hit by lightening? He was a good conductor.');

INSERT INTO TimeSheetEntry
VALUES(2, '2011/02/01', 4911, '2', 8, 7, 6, 5, 4, 3, 7, 'What happened to the magical tractor? It turned into a field.');

INSERT INTO TimeSheetEntry
VALUES(3, '2011/02/01', 4911, '2', 8, 7, 6, 5, 4, 3, 7, 'What do vampire zombies say? Veeeiiins...');

INSERT INTO TimeSheetEntry
VALUES(4, '2011/02/01', 4911, '2', 8, 7, 6, 5, 4, 3, 7, 'Why did the fungus and the algee get married? They took a lichen to each other.');

INSERT INTO TimeSheetEntry
VALUES(5, '2011/02/01', 4911, '2', 8, 7, 6, 5, 4, 3, 7, 'What do you get when you put a sheep on a trampoline? A woolie jumper.');

INSERT INTO TimeSheetEntry
VALUES(6, '2011/02/01', 4911, '2', 8, 7, 6, 5, 4, 3, 7, 'Why did the tomato blush? Cause it saw the salad dressing.');

INSERT INTO TimeSheetEntry
VALUES(7, '2011/02/01', 4911, '2', 8, 7, 6, 5, 4, 3, 7, 'Did you hear about the red ship and the blue ship that collided? All the sailors were marooned...');

INSERT INTO TimeSheetEntry
VALUES(8, '2011/02/01', 4911, '2', 8, 7, 6, 5, 4, 3, 7, 'Why did Kalen eat his homework? Bruce said it was a piece of cake.');

INSERT INTO TimeSheetEntry
VALUES(9, '2011/02/01', 4911, '2', 8, 7, 6, 5, 4, 3, 7, 'The calendar''s days are numbers');

INSERT INTO TimeSheetEntry
VALUES(320, '2011-01-01', 12345, 'A1', 20, 20, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, 'Why did the elephants leave the circus? They were tired of working for peanuts.');

INSERT INTO TimeSheetEntry
VALUES(321, '2011/01/01', 12345, 'A1', 10, 10, 10, 10, DEFAULT, DEFAULT, DEFAULT, 'What did zero say to eight? Nice belt.');

INSERT INTO TimeSheetEntry
VALUES(320, '2011/01/01', 12345, 'A2', 10, 5, 5, 5, 5, 5, 5, 'Why did the colandor retire? It just couldn''t take the strain anymore!');

INSERT INTO TimeSheetEntry
VALUES(321, '2011/01/01', 12345, 'A2', 24, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, NULL);

INSERT INTO TimeSheetEntry
VALUES(320, '2011/02/01', 12345, 'B1', 12, 10, 8, 20, DEFAULT, DEFAULT, DEFAULT, 'Never gonna give you up, never gonna let you down...');

INSERT INTO TimeSheetEntry
VALUES(321, '2011/02/01', 12345, 'B1', 8, 8, 8, 8, 8, 8, 0, '');
