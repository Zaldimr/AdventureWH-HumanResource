--Membuat database Human Resource
CREATE DATABASE AWHumanResource
GO
USE AWHumanResource;

-- kalau mau bikin Schema, klik kanan folder Database Diagram --> New Database Diagram

-- [Query untuk membuat tabel di-execute dengan connect ke database AWHumanResource]

--Membuat tabel Employee 
CREATE TABLE DimEmployee(
    EmployeeKey int
        constraint DimEmployee_pk
            primary key identity(1,1),
 MaritalStatus nchar(1), 
 Gender nchar(1),
 BusinessEntityID int,
 BirthDate date,
 HireDate date
)

--Membuat tabel Salary
CREATE TABLE DimSalary(
    SalaryKey int
        constraint Salary_pk
            primary key identity(1,1),
 BusinessEntityID int,
    Rate money
)

--Membuat tabel Departement
CREATE TABLE DimDepartment(
    DepartmentKey int
        constraint Department_pk
            primary key identity(1,1),
    DepartmentID int,
 Name nvarchar(50),
    GroupName nvarchar(50)
)

--Membuat tabel Time
CREATE TABLE DimTime(
 TimeKey int
  constraint Time_pk
   primary key,
 Year int,
 MonthNumber int,
 MonthName nvarchar(10),
 date datetime2(7)
)
--Membuat tabel FactTable
CREATE TABLE DimFactTable(
    SalesQuota money,
    SalesYTD money,
    EmployeeKey int
        constraint FactTable_Employee_EmployeeKey_fk
            references DimEmployee,
    SalaryKey int
        constraint FactTable_Salary_SalaryKey_fk
            references DimSalary,
    DepartmentKey int
        constraint FactTable_Department_DepartmentKey_fk
            references DimDepartment,
 TimeKey int
  constraint FactTable_Time_TimeKey_fk
   references DimTime
)
ALTER TABLE HRDevelopment.DimFactTable ADD CONSTRAINT PK_FACTID PRIMARY KEY (SalesQuota, SalesYTD) --harusnya fact table gapake PK gapapa
