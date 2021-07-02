--Membuat database Human Resource
CREATE DATABASE AWHumanResource
GO
USE AWHumanResource;

DROP TABLE DimEmployee
CREATE TABLE DimEmployee(
    EmployeeKey int
        constraint DimEmployee_pk
            primary key identity(1,1),
 FirstName nvarchar(50),
 LastName nvarchar(50),
 MaritalStatus nchar(1), 
 Gender nchar(1),
 BusinessEntityID int,
 BirthDate date,
 HireDate date,
 VacationHours int,
 SickLeaveHours int
)

--Membuat tabel Salary
DROP TABLE DimSalary
CREATE TABLE DimSalary(
    SalaryKey int
        constraint Salary_pk
            primary key identity(1,1),
 BusinessEntityID int not null,
    Rate money
)

--Membuat tabel Departement
DROP TABLE DimDepartment
CREATE TABLE DimDepartment(
    DepartmentKey int
        constraint Department_pk
            primary key identity(1,1),
    DepartmentID int not null,
 Name nvarchar(50),
    GroupName nvarchar(50)
)

--Membuat tabel Time
DROP TABLE DimTime
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
DROP TABLE FactSalesPurchase
CREATE TABLE FactSalesPurchase(
    OverallWork money,
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



