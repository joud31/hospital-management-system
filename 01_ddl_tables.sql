-- ============================================================
-- Hospital Management System - Data Definition Language (DDL)
-- Transcribed from PowerPoint screenshots (slides 6-9)
-- ============================================================

-- Table: Department
create table Department(
    Department_name varchar(50) primary key,
    Budget varchar(6) check(budget between 50000 and 500000)
)

-- Table: Sub_dept
create table Sub_dept(
    Sub_dept_name varchar(50) primary key,
    Department_name varchar(50) not null,
    CONSTRAINT Department_name_fk foreign key(Department_name) references department on delete cascade
)

-- Table: Wardrooms
create table Wardrooms(
Wardroom_id varchar(5) primary key ,
Sub_dept_name varchar(50) not null ,
Department_name varchar(50) not null ,
Availability varchar(30) ,
foreign key (Sub_dept_name) references Sub_dept on delete cascade ,
foreign key (Department_name) references Department on delete cascade ,
check(availability in ('Available','Non Available'))
)

-- Table: Doctor
CREATE TABLE doctor (
  doctor_id VARCHAR(5) PRIMARY KEY,
  full_name VARCHAR(100) NOT NULL,
  job_title VARCHAR(50) NOT NULL,
  department_name VARCHAR(50) NOT NULL REFERENCES department (department_name) ON DELETE CASCADE,
  sub_dept_name VARCHAR(50) NOT NULL REFERENCES sub_dept (sub_dept_name) ON DELETE CASCADE,
  gender VARCHAR(10) NOT NULL CHECK (gender IN ('Male', 'Female')),
  date_of_birth DATE NOT NULL,
  nationality VARCHAR(30) NOT NULL,
  experience VARCHAR(30) NOT NULL,
  salary NUMERIC(7, 2) NOT NULL CHECK (salary BETWEEN 10000 AND 50000),
  email VARCHAR(50) NOT NULL,
  phone_number CHAR(15) NOT NULL,
  CONSTRAINT uk_doctor UNIQUE (email, phone_number)
)

-- Table: Patient
create table Patient (
    Patient_ID varchar(5) primary key,
    Full_name varchar(50) not null,
    Date_of_birth date not null ,
    Gender varchar(6)not null,
    Phone_Number char(15) unique not null,
    Address varchar(50),
    Nationality varchar(30),
    Blood_type varchar(3),
    check(Gender in ('Female', 'Male'))
)

-- Table: Nurse
create table Nurse(
Nurse_id varchar(5) primary key,
Full_name varchar(50) not null,
Department_name varchar(50) not null,
Sub_dept_name varchar(50) not null,
Gender varchar(10)not null,
Date_of_birth date ,
Nationality varchar(30) not null,
Experience varchar(30) not null,
Salary numeric (7,2) not null,
Email varchar (50) not null,
Phone_Number char (15) not null,
check (gender IN('Male', 'Female')),
check (salary BETWEEN 10000 AND 50000),
constraints uk_Nurse UNIQUE (Email, Phone_Number),
foreign key (Department_name) references Department on delete cascade,
foreign key (Sub_dept_name) references Sub_dept on delete cascade
)

-- Table: Staff
Create table Staff(
Staff_id varchar(5) primary key,
Full_name varchar(50) not null,
Job_Title varchar(50) not null,
Department_name varchar(50) not null,
Sub_dept_name varchar(50) not null ,
Gender varchar(10) not null,
Date_Of_Birth date ,
Nationality varchar(30) not null,
Experience  varchar(30) not null,
Salary numeric(7,2) not null,
Email varchar(50) unique not null,
Phone_Number char(15) unique not null,
Foreign key(Department_name) references Department(Department_name) on delete cascade ,
Foreign key(Sub_dept_name) references Sub_dept(Sub_dept_name) on delete cascade ,
Check (Salary Between 1500 and 90000),
Check (Gender in ('Female','Male'))
)

-- Table: Appointment
CREATE TABLE Appointment (
  Appointment_id VARCHAR(5) PRIMARY KEY,
  Patient_id VARCHAR(5) NOT NULL REFERENCES patient (patient_id) ON DELETE CASCADE,
  Department_name VARCHAR(50) NOT NULL REFERENCES department (department_name) ON DELETE CASCADE,
  Sub_dept_name VARCHAR(50) NOT NULL REFERENCES sub_dept (sub_dept_name) ON DELETE CASCADE,
  Wardroom_id VARCHAR(5) NOT NULL REFERENCES wardrooms (Wardroom_id) ON DELETE CASCADE,
  Doctor_id VARCHAR(5) NOT NULL REFERENCES doctor (doctor_id) ON DELETE CASCADE,
  Appointment_date DATE NOT NULL,
  status VARCHAR(50) CHECK (status IN ('scheduled', 'completed', 'canceled'))
)

-- Table: Patient_satisfaction
create table Patient_satisfaction (
    Survey_ID varchar(5) primary key,
    Patient_ID varchar(5) references Patient(Patient_ID)  on delete cascade not null ,
    Doctor_ID varchar(5) references Doctor(Doctor_ID) on delete cascade not null ,
    Nurse_ID varchar(5) references Nurse(Nurse_ID) on delete set NULL ,
    Rating_scale int not null check(Rating_scale between 1 and 5),
    Survey_Date date not null
)

-- Table: Equipment
create table Equipment(
    Equipment_ID varchar(5) not null,
    Name varchar(20) not null,
    Department_name varchar(50) not null,
    Wardroom_id varchar(5) not null,
    Quantity int default 0 check (Quantity>=0),
    TypeOfEquipment varchar(15),
    Status varchar(15),
    primary key(Equipment_ID ,Name, Department_name, Wardroom_id),
    foreign key(Department_name) references Department on delete cascade,
    foreign key(Wardroom_id) references Wardrooms on delete cascade,
    check(TypeOfEquipment in ('one use','reusable')),
    check(Status in ('good','need checking'))
    )
