using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace FFLib
{
    public class ManagedEmployee
    {
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public int EmployeeId { get; set; }
        public string Username { get; set; }
        public string Email { get; set; }
        public int Supervisor { get; set; }
        public int Approver { get; set; }
        public double MinHoursPerWeek { get; set; }
        public double VacationLeave { get; set; }
        public double SickDays { get; set; }
        public double FlexHours { get; set; }
        public int IsActive { get; set; }
    }
}
