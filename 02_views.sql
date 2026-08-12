-- Question 1: Create a view to enter appointment details for the doctor with doctor_id = 'D0001'
create view D0001_Appointments as
select *
from appointment
where doctor_id = 'D0001'
with check option;

-- select * from D0001_Appointments;

-- Question 2: Create a view that enter all the doctor information whose salary is higher than the average salary among all doctors
create view HighPaid_Doctors as
select *
from doctor
where salary > (select avg(salary) from doctor)
with check option;

-- select * from HighPaid_Doctors;

-- Question 3: Create a view to enter all data of Saudi nurse
create view Saudi_Nurse as
select *
from nurse
where nationality = 'Saudi'
    with check option;

-- select * from Saudi_Nurse;

-- Question 4: Make a view to enter the values of Equipment ID, Name, Department_name and wardroom ID of equipment in department that starts with 'Financial'
create view Financial_dept_equipment as
    select Equipment_ID ,Name,Department_name,Wardroom_id
    from equipment
    where Department_name like 'Financial%'
    with check option ;

-- select * from Financial_dept_equipment;

-- Question 5: Make a view to enter wardrooms in the safety sub department
create view safety_wardrooms as
    select *
    from wardrooms
    where sub_dept_name = 'Safety'
    with check option ;

-- select * from safety_wardrooms;

-- Question 6: Make a view to enter only Patient_ID, Full_name, Phone, Blood_type, Date_of_birth, Gender from Patient where Gender = female
create view PatientG as
select Patient_ID,Full_name ,Phone ,Blood_type,Date_of_birth,Gender
from Patient
where Gender like 'Female'
with check option;

-- select * from PatientG;
