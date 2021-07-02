
-- Insert Values

--Tabel Employee
INSERT INTO AWHumanResource.dbo.DimEmployee(BusinessEntityID, FirstName, LastName, MaritalStatus, Gender, BirthDate, HireDate, VacationHours, SickLeaveHours)
SELECT HRE.BusinessEntityID, PP.FirstName, PP.LastName, HRE.MaritalStatus, HRE.Gender, HRE.BirthDate, HRE.HireDate, HRE.VacationHours, HRE.SickLeaveHours
FROM AdventureWorks2019.HumanResources.Employee HRE
JOIN AdventureWorks2019.Person.Person PP ON HRE.BusinessEntityID = PP.BusinessEntityID

--Tabel Salary
INSERT INTO AWHumanResource.dbo.DimSalary(BusinessEntityID, Rate) 
SELECT HDE.BusinessEntityID, EPH.Rate
FROM AdventureWorks2019.HumanResources.EmployeePayHistory EPH
JOIN AWHumanResource.dbo.DimEmployee HDE ON HDE.BusinessEntityID=EPH.BusinessEntityID

--Tabel Departement
INSERT INTO AWHumanResource.dbo.DimDepartment(DepartmentID, Name, GroupName)
SELECT HRD.DepartmentID, HRD.Name, HRD.GroupName
FROM AdventureWorks2019.HumanResources.Department HRD

--Tabel Time
INSERT INTO AWHumanResource.dbo.DimTime(TimeKey, Year, MonthNumber, MonthName, date)
SELECT DISTINCT 
YEAR(OrderDate) * 10000 + MONTH(OrderDate) * 100 + DAY(OrderDate) AS TimeKey,
DATEPART(Year, OrderDate) as Year, 
DATEPART (Month, OrderDate) as MonthNumber,
DATENAME(Month, OrderDate) as MonthName,
CONVERT(date,OrderDate) as date
FROM AdventureWorks2019.Sales.SalesOrderHeader

--Tabel FactSalesPurchase
-- Fact Table dari Sales
INSERT INTO AWHumanResource.dbo.FactSalesPurchase (EmployeeKey, TimeKey, OverallWork, SalaryKey, DepartmentKey)
SELECT EmployeeKey, TimeKey, SubTotal AS OverAllWork, SalaryKey, DepartmentKey
FROM AWHumanResource.dbo.DimEmployee E
LEFT JOIN AWHumanResource.dbo.DimSalary S ON S.BusinessEntityID = E.BusinessEntityID
JOIN AdventureWorks2019.HumanResources.EmployeeDepartmentHistory EDH ON E.BusinessEntityID = EDH.BusinessEntityID
JOIN AWHumanResource.dbo.DimDepartment D ON EDH.DepartmentID = D.DepartmentID
JOIN AdventureWorks2019.Sales.SalesOrderHeader SohMain ON E.BusinessEntityID = SohMain.SalesPersonID
JOIN AWHumanResource.dbo.DimTime T ON T.Date = SohMain.OrderDate
**/
--Create Procedure
CREATE PROCEDURE HResource
 AS
 BEGIN
	--Tabel Employee
	INSERT INTO AWHumanResource.dbo.DimEmployee(BusinessEntityID, FirstName, LastName, MaritalStatus, Gender, BirthDate, HireDate, VacationHours, SickLeaveHours)
	SELECT HRE.BusinessEntityID, PP.FirstName, PP.LastName, HRE.MaritalStatus, HRE.Gender, HRE.BirthDate, HRE.HireDate, HRE.VacationHours, HRE.SickLeaveHours
	FROM AdventureWorks2019.HumanResources.Employee HRE
	JOIN AdventureWorks2019.Person.Person PP ON HRE.BusinessEntityID = PP.BusinessEntityID

	--Tabel Salary
	INSERT INTO AWHumanResource.dbo.DimSalary(BusinessEntityID, Rate) 
	SELECT HDE.BusinessEntityID, EPH.Rate
	FROM AdventureWorks2019.HumanResources.EmployeePayHistory EPH
	JOIN AWHumanResource.dbo.DimEmployee HDE ON HDE.BusinessEntityID=EPH.BusinessEntityID

	--Tabel Departement
	INSERT INTO AWHumanResource.dbo.DimDepartment(DepartmentID, Name, GroupName)
	SELECT HRD.DepartmentID, HRD.Name, HRD.GroupName
	FROM AdventureWorks2019.HumanResources.Department HRD

	--Tabel Time
	INSERT INTO AWHumanResource.dbo.DimTime(TimeKey, Year, MonthNumber, MonthName, date)
	SELECT DISTINCT 
	YEAR(OrderDate) * 10000 + MONTH(OrderDate) * 100 + DAY(OrderDate) AS TimeKey,
	DATEPART(Year, OrderDate) as Year, 
	DATEPART (Month, OrderDate) as MonthNumber,
	DATENAME(Month, OrderDate) as MonthName,
	CONVERT(date,OrderDate) as date
	FROM AdventureWorks2019.Sales.SalesOrderHeader

	--Tabel FactSalesPurchase
	INSERT INTO AWHumanResource.dbo.FactSalesPurchase (EmployeeKey, TimeKey, OverallWork, SalaryKey, DepartmentKey)
	SELECT EmployeeKey, TimeKey, SubTotal AS OverAllWork, SalaryKey, DepartmentKey
	FROM AWHumanResource.dbo.DimEmployee E
	LEFT JOIN AWHumanResource.dbo.DimSalary S ON S.BusinessEntityID = E.BusinessEntityID
	JOIN AdventureWorks2019.HumanResources.EmployeeDepartmentHistory EDH ON E.BusinessEntityID = EDH.BusinessEntityID
	JOIN AWHumanResource.dbo.DimDepartment D ON EDH.DepartmentID = D.DepartmentID
	JOIN AdventureWorks2019.Sales.SalesOrderHeader SohMain ON E.BusinessEntityID = SohMain.SalesPersonID
	JOIN AWHumanResource.dbo.DimTime T ON T.Date = SohMain.OrderDate
 END
EXEC HResource

