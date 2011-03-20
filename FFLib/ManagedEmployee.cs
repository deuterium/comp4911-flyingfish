using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace FFLib
{
    public class ManagedEmployee
    {
        FlyingFishClassesDataContext ff = new FlyingFishClassesDataContext();
        public ManagedEmployee(aspnet_User u, Employee e)
        {
            AspUser = u;
            EmployeeUser = e;

            FirstName = e.firstName;
            LastName = e.lastName;
            EmployeeId = e.empId;
            Username = u.UserName;
            Email = ff.aspnet_Memberships.Where(m => m.UserId == AspUser.UserId).FirstOrDefault().Email;
            Supervisor = e.supervisor;
            Approver = e.approver;
            MinHoursPerWeek = (Double)e.minHoursPerWeek;
            VacationLeave = e.vacationLeave;
            SickDays = e.sickDays;
            FlexHours = (Double)e.flexHours;
            IsActive = e.isActive;
        }
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

        public aspnet_User AspUser { get; set; }
        public Employee EmployeeUser { get; set; }

    }
}
