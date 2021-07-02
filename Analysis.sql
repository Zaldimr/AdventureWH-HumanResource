
--Analisis Data
----Mencari karyawan dengan penggunaan leave hour dan vacation hour terendah
CREATE PROCEDURE MostDiligentEmployee
 AS
 BEGIN
	SELECT FirstName, LastName, VacationHours+SickLeaveHours AS DiligencePoint FROM AWHumanResource.dbo.DimEmployee
	ORDER BY DiligencePoint DESC
 END
EXEC MostDiligentEmployee
-----Mengetahui statistik status pernikahan karyawan berdasarkan gender
CREATE PROCEDURE MaritalStatusByGender
 AS
 BEGIN
	SELECT MaritalStatus, SUM(CASE WHEN Gender='M' THEN 1 ELSE 0 END) AS Male, SUM(CASE WHEN Gender='F' THEN 1 ELSE 0 END) AS Female
	FROM AWHumanResource.dbo.DimEmployee
	GROUP BY MaritalStatus
 END
EXEC MaritalStatusByGender
-----Menngetahui rata-rata gaji seluruh karyawan
CREATE PROCEDURE AvgRateEmployee
 AS
 BEGIN
	SELECT AVG(Rate) AS Rate FROM AWHumanResource.dbo.DimSalary
 END
EXEC AvgRateEmployee
-- Pegawai yang memiliki paling banyak kontribusinya pada penjualan akhir tahun 2012
CREATE PROCEDURE MostOutstandingEmployee
 AS
 BEGIN
SELECT TOP 1 FirstName, LastName, OverallWork, TimeKey='20121231' FROM AWHumanResource.dbo.FactSalesPurchase F
JOIN AWHumanResource.dbo.DimEmployee E ON E.EmployeeKey = F.EmployeeKey
JOIN AWHumanResource.dbo.DimTime T ON T.TimeKey = F.TimeKey
ORDER BY OverallWork DESC
END
EXEC MostOutstandingEmployee
--Untuk mengetahui percepatan baca query
----Performance testing MostDiligentEmployee
GO
SET SHOWPLAN_ALL ON
GO
EXEC MostDiligentEmployee
GO
SET SHOWPLAN_ALL OFF
----Performance testing MaritalStatusByGender
GO
SET SHOWPLAN_ALL ON
GO
EXEC MaritalStatusByGender
GO
SET SHOWPLAN_ALL OFF
----Performance testing AvgRateEmployee
GO
SET SHOWPLAN_ALL ON
GO
EXEC AvgRateEmployee
GO
SET SHOWPLAN_ALL OFF
----Performance testing MostOutstandingEmployeeAtTheEndofYear
GO
SET SHOWPLAN_ALL ON
GO
EXEC MostOutstandingEmployeeAtTheEndofYear
GO
SET SHOWPLAN_ALL OFF
