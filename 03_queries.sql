-- ============================================================
-- Hospital Management System - Queries (52)
-- Transcribed from PowerPoint screenshots (slides 31-82)
-- ============================================================

-- Query 1: Show equipment_name, sub-department and wardroom number for each equipment that needs checking, ordered by wardroom_id ascending
select name as Equipment_name, sub_dept_name, Equipment.wardroom_id
from Equipment inner join wardrooms on (Equipment.wardroom_id=wardrooms.wardroom_id)
where status = 'need checking'
order by Equipment.wardroom_id asc;

-- Query 2: Find wardroom ID and sub-department of available rooms in a department starting with 'Therapeutic'
select wardroom_id, sub_dept_name
from wardrooms
where department_name like 'Therapeutic%' and availability = 'Available';

-- Query 3: Find ALL wardroom IDs, sub-department names, equipment names and quantities for wardrooms in Diagnostic Service Center department, descending by wardroom ID
select wardrooms.wardroom_id,sub_dept_name,name as Equipment_name,quantity
from equipment right outer join wardrooms on(Equipment.wardroom_id=wardrooms.wardroom_id)
where wardrooms.department_name ='Diagnostic Service Center'
order by wardroom_id desc;

-- Query 4: Find wardroom IDs of rooms that don't have any equipment
select wardroom_id
from wardrooms
where wardroom_id not in (select distinct wardroom_id
from equipment);

-- Query 5: Show department name and total number of rooms for departments with between 3 and 5 wardrooms
select  department_name, count(*) as  Number_of_rooms
from wardrooms
group by department_name
having count(*) between 3 and 5;

-- Query 6: Change status of equipment EQ008 in wardroom WR001 to good
update equipment
set status='good'
where equipment_id ='EQ008' and wardroom_id = 'WR001';

-- Query 7: Remove wardroom WR014
delete from wardrooms
where wardroom_id = 'WR014';

-- Query 8: Retrieve Survey ID, Patient ID, Nurse ID, Nurse name, rating scale — all records in patient satisfaction AND nurse tables
select SURVEY_ID,PATIENT_ID,NURSE_ID, FULL_NAME as Nurse_name, RATING_SCALE
from nurse natural full outer join Patient_satisfaction;

-- Query 9: Find doctor IDs and average ratings for doctors whose average patient satisfaction rating is below 3
select doctor_id , avg(rating_scale) as avg_rating_scale
from patient_satisfaction
group by doctor_id
having avg(rating_scale) < 3

-- Query 10: Find Doctor_id and full_name of doctors with no appointments between '2024-04-15' and '2024-04-17'
-- NOTE: transcribed exactly as shown in the slide screenshot, including the apparent typo
-- "17-APR_2024" (underscore instead of hyphen) — verify/fix before running.
Select Doctor_id , full_name
From doctor
Where doctor_id not in (select doctor_id from appointment where appointment_date between '15-APR-2024' and '17-APR_2024')

-- Query 11: Delete all appointments where doctor's ID is 'D0003' and patient's ID is 'P0003' or 'P0005'
delete from appointment
where doctor_id = 'D0003'and patient_id in ('P0003', 'P0005');

-- Query 12: Update doctors' salaries by years of experience: +15% for exactly 20 years, +10% for exactly 18 years, unchanged otherwise
UPDATE doctor SET salary =  CASE
        WHEN experience = '20 years' THEN salary * 1.15
        WHEN experience = '18 years' THEN salary * 1.1
        ELSE salary
   END;

-- Query 13: Total salary expenses per department (sum of doctor salaries), with department name
SELECT department_name, SUM(salary) AS total_salary_expense
FROM doctor
GROUP BY department_name;

-- Query 14: Doctor ID, full name, appointment ID, appointment date, status for ALL doctors including those without appointments
SELECT d.doctor_id, full_name, Appointment_id, appointment_date, status
 FROM doctor d
LEFT JOIN Appointment a ON d.doctor_id = a.doctor_id

-- Query 15: Departments where the highest doctor salary >= 45000, show department name and max_salary
SELECT department_name, MAX(salary) AS max_salary
FROM doctor
GROUP BY department_name
HAVING MAX(salary) >= 45000;

-- Query 16: Number of sub departments in each department
select DEPARTMENT_NAME , count(*) AS number_of_sub_department
from sub_dept
group by DEPARTMENT_NAME ;

-- Query 17: Department and number of sub departments, for the department with the most sub departments
SELECT Department_name, COUNT(*) AS num_sub_depts
FROM Sub_dept
GROUP BY Department_name
HAVING COUNT(*) >= all( SELECT  COUNT(*) AS num_sub_depts
                       FROM Sub_dept
                       GROUP BY Department_name);

-- Query 18: Rename attribute Sub_dept_name in sub department table to Sub_department_name
ALTER TABLE Sub_dept RENAME COLUMN  Sub_dept_name to Sub_department_name ;

-- Query 19: Find sub departments containing 'Center'
SELECT SUB_DEPT_NAME
FROM Sub_dept
WHERE SUB_DEPT_NAME LIKE '%Center%'

-- Query 20: Departments and number of doctors, for departments with more than 2 doctors
SELECT department_name, COUNT(*) AS total_doctors
FROM doctor
GROUP BY department_name
HAVING COUNT(*) > 2;

-- Query 21: Name and salary of the highest paid male doctor
select full_name, salary
from doctor
where GENDER= 'Male' and salary >=all ( select salary
                                         from doctor
                                         where GENDER= 'Male');

-- Query 22: Nationality of Staff with Experience of six years AND three years
select Nationality from Staff where Experience = 'Six Years'
INTERSECT
select Nationality from Staff where Experience = 'Three Years'

-- Query 23: Department name and average salary of staff, where average salary > 50000
select Department_name , avg(Salary)
from Staff
group by Department_name
having avg(Salary) > 50000

-- Query 24: Staff's name whose gender is female with 6 years experience OR male with 3 years experience
select Full_name  from Staff where Gender = 'Female'and EXPERIENCE = 'Six Years'
Union
select Full_name  from Staff where Gender = 'Male'and EXPERIENCE = 'Three Years'

-- Query 25: staff_id of staff born 22 July 1983 with Spanish nationality, OR born 8 January 1991 with British nationality
select staff_id  from Staff where Date_Of_Birth = '22-JUL-83' and Nationality = 'Spanish'
union
select staff_id from Staff where Date_Of_Birth = '08-JAN-91' and Nationality = 'British'

-- Query 26: Rename column Experience to BackGround
-- NOTE: slide shows "EXPERINCE" (typo for EXPERIENCE) in the ALTER statement itself, transcribed as-is.
ALTER TABLE Staff RENAME COLUMN EXPERINCE to BackGround ;

-- Query 27: Delete column Email from Staff table
ALTER TABLE Staff DROP COLUMN Email

-- Query 28: List ID of Wardrooms along with Budget of the Department
select Wardroom_id , Budget
from Department NATURAL JOIN Wardrooms

-- Query 29: Retrieve Patient ID, full name, blood type of patients with blood type 'O+'
select Patient_ID, Full_name, Blood_type
from Patient
where Blood_type Like 'O+';

-- Query 30: Retrieve all patient satisfaction data ordered by rating scale descending
select *
from Patient_satisfaction
order by Rating_scale Desc;

-- Query 31: Find survey ID, doctor ID, nurse ID with rating scale '5', renaming survey ID column to 'Surveynumber'
select Survey_ID As Surveynumber, Doctor_ID, Nurse_ID
from Patient_satisfaction
where Rating_scale = 5 ;

-- Query 32: Update rating scale of survey ID '00006' to '5'
Update Patient_satisfaction
set Rating_scale = 5
where Survey_ID = '00006';

-- Query 33: Average rating scale of patient satisfaction survey
SELECT AVG(Rating_scale) AS AverageRating
FROM Patient_satisfaction;

-- Query 34: Name, survey date, rating scale of every patient
select Full_name, Survey_Date, Rating_scale
from Patient_satisfaction
natural join Patient

-- Query 35: All patient info for Saudi nationality, date of birth between '01-JAN-1995' and '31-DEC-2000'
SELECT *
FROM Patient
WHERE Nationality = 'Saudi'
AND Date_of_birth BETWEEN '01-JAN-1995' AND '31-DEC-2000';

-- Query 36: Departments with budget between 190000-450000, sorted descending by budget
Select department_name
From department
Where Budget between 190000 and 450000
Order by budget DESC;

-- Query 37: Increase salaries of Nurses in the Information Center by 5%
Update Nurse
Set salary = salary*1.05
Where sub_dept_name= 'Information Center';

-- Query 38: Remove nurses associated with departments with budget <= 90000
Delete from nurse
Where department_name in(select department_name
from department
where budget<=90000);

-- Query 39: Add a Shift column to Nurse table
Alter table nurse add Shift varchar(15);

-- Query 40: Min, max, total salaries of nurses in Administrative Service Center Department
select min(salary) as min_salary , max(salary) as max_salary , sum(salary) as sum_salaries
from Nurse
where Department_name='Administrative Service Center';

-- Query 41: Department name, average salaries, total nurses per department where avg salary > 20000
Select department_name , avg(salary) as average_salaries , count(Nurse_ID) as number_of_nurses
From Nurse
Group by department_name
Having avg(salary) >20000;

-- Query 42: Names and salaries of nurses with salary greater than some nurse in Administrative Service Center
Select full_name ,salary
From nurse
Where salary >some (select salary
                     From nurse
                     Where department_name = 'Administrative Service Center' );

-- Query 43: ALL departments with full name, sub department name, experience of nurses (if available)
Select department.department_name, department.budget, nurse.full_name,nurse.sub_dept_name, nurse.experience
From department left outer join nurse
on department.department_name = nurse.department_name;

-- Query 44: Names/salaries of nurses with salary <= that of all nurses in Administrative Service Center
Select full_name ,salary
From nurse
Where salary<=all(select salary
                   From nurse
                   Where department_name = 'Administrative Service Center' );

-- Query 45: ALL sub department records with nurses information
Select *
From nurse right outer join sub_dept
Using(sub_dept_name ,department_name);

-- Query 46: Names and annual salary of nurses whose name starts with 'No'
Select full_name ,salary*12 as annual_salary
From nurse
Where full_name like 'No%';

-- Query 47: Update blood type of patient ID 'P0002' to 'O+'
UPDATE Patient
SET Blood_type = 'O+'
WHERE Patient_ID = 'P0002';

-- Query 48: Remove patients born between Jan 1 1990 and Dec 31 1999
DELETE FROM Patient
WHERE Date_of_birth BETWEEN DATE '1990-01-01' AND DATE '1999-12-31';

-- Query 49: Full names and phone numbers of patients whose phone starts with '+96653'
SELECT Full_name, Phone_Number
FROM Patient
WHERE Phone_Number LIKE '+96653%';

-- Query 50: All patients ordered by date of birth descending
SELECT * FROM Patient
ORDER BY Date_of_birth DESC;

-- Query 51: Full names, genders, dates of birth of male patients, renaming full name column to 'PatientName'
SELECT Full_name AS PatientName, Gender, Date_of_birth
FROM Patient
WHERE Gender = 'Male';

-- Query 52: Appointment IDs, appointment dates, full names of patients who have appointments
SELECT appointment_id, appointment_date,full_name
FROM Appointment
NATURAL JOIN Patient;
