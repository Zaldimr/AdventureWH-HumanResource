--Create Index
CREATE INDEX mostdiligent ON DimEmployee (FirstName, LastName, VacationHours, SickLeaveHours)
CREATE INDEX maritalstatus ON DimEmployee (MaritalStatus, Gender)
CREATE INDEX mostoutstanding ON FactSalesPurchase (OverallWork, TimeKey)

--Melihat Data
SELECT * FROM DimEmployee
SELECT * FROM DimSalary
SELECT * FROM DimDepartment
SELECT * FROM DimTime
SELECT * FROM FactSalesPurchase

