-- Note: these must be in their own batch file?

---------------------------------------------------------------------------------
-- Create a view that calculates the total time an employee has spent on a wp.
---------------------------------------------------------------------------------
CREATE VIEW Vw_TimesheetEntriesTotalHours AS
	SELECT projId, wpId, empId, SUM(sun + mon + tue + wed + thu + fri + sat) AS totalHoursOnWp
	FROM TimesheetEntries
	GROUP BY projId, wpId, empId;
