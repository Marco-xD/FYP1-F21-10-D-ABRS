--2) SALES TABLES ACCORDING TO SCHEMA

--TOTAL TABLES=18

--1)CreditCard  --412 but 392 (DONE)
--2)Currency
--3)CurrencyRate
--4)Customer 
--5)PersonCreditCard  (Zaeem) --412 but 392 (DONE)
--6)SalesOrderDetail  
--7)SalesOrderHeader
--8)SalesOrderHeaderSalesReason (zaeem)--646 but 690 (DONE)DD
--9)SalesPerson   (zaeem)               --17 but 80 (DONE) DD
--10)SalesPersonQuotaHistory (Zaeem)   --139 rows (DONE)  IN THIS FILE
--11)SalesReason    (Zaeem)            --3 Rows(DONE)   IN THIS FILE
--12)SalesTaxRate(zaeeem)           -- 29 Rows(DONE)    IN THIS FILE
--13)SalesTerritory (zaeem)         -- 10 but 57 (DONE) IN THIS FILE
--14)SalesTerritoryHistory (zaeem)  --396 Rows (DONE)   IN THIS FILE
--15)ShoppingCartItem  (zaeem)
--16)SpecialOffer                   --4 Rows (DONE)     IN THIS FILE
--17)SpecialOfferProduct        
--18)Store

------------------------------------------------------------------------------------------



--We are cleansing the data (Removing NULL values and Empty Rows by using constraints) and assigining data types
--The input is stage 1 layer and populating into different tables according to business (Schema)
--Also making surrogate keys where required.
--Loading data in same format in the target Table
--Using constraints.

--This File contains The following Tables DDL and DML


--5) SALEPERSONQUOTAHISTORY
--6) SalesReason Table
--7) salesTaxRate Table
--8)SalesTerritory Table
--9) SalesTerritoryHistory Table
--10) SpecialOffer Table

------------------------------------------------------------------------------------------------------------------------------------
--5) SALEPERSONQUOTAHISTORY
--ACCORDING TO SCHEMA

---------------------------------------------

--Dropping the table if there is any issue while loading the data into the target table

DROP TABLE DP_STG2.SalesPersonQuotaHistory;


--Refreshing the table after inserting the data into the table 

REFRESH dp_stg2.salespersonquotahistory;

--Creating the SalesPersonQuotaHistory table total 3 columns
--1) BusinessEntityID, 2)SalesQuota, 3)QuotaDate

CREATE TABLE dp_stg2.SalesPersonQuotaHistory
	(
	  BusinessEntityID INT,
	  SalesQuota DECIMAL(10,2),
      QuotaDate TIMESTAMP
	 );


--Inserting data into the table from the source table and removing NULL from the source table
--Cleaning the Data and defining data types.


INSERT INTO DP_STG2.SalesPersonQuotaHistory
SELECT DISTINCT 
    --CASE WHEN  BusinessEntityID2 ='NULL' THEN -1 ELSE  BusinessEntityID2 END AS  BusinessEntityID,
    CASE
    WHEN  BusinessEntityID2='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( BusinessEntityID2),'-1') AS VARCHAR(20)) AS INT) END AS  BusinessEntityID,

    --CASE WHEN  SalesQuota1 = 'NULL' THEN -1 ELSE  CAST(SalesQuota1 AS DECIMAL(10,2)) END AS SalesQuota,
    CASE
    WHEN   SalesQuota1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(SalesQuota1),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS SalesQuota,

	--CASE WHEN QuotaDate = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(QuotaDate,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS QuotaDate
    case
    when QuotaDate = 'NULL'
    then cast ('1900-01-01' as TIMESTAMP)
    else
    cast(coalesce(QuotaDate,to_date('1900-01-01')) as TIMESTAMP) end QuotaDate
FROM Dp_Stg1.Sales;


INSERT INTO DP_STG2.SalesPersonQuotaHistory
SELECT DISTINCT 
	--CASE WHEN  BusinessEntityID2 ='NULL' THEN -1 ELSE  BusinessEntityID2 END AS  BusinessEntityID,
    CASE
    WHEN  BusinessEntityID2='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( BusinessEntityID2),'-1') AS VARCHAR(20)) AS INT) END AS  BusinessEntityID,

    --CASE WHEN  SalesQuota1 = 'NULL' THEN -1 ELSE  CAST(SalesQuota1 AS DECIMAL(10,2)) END AS SalesQuota,
    CASE
    WHEN   SalesQuota1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(SalesQuota1),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS SalesQuota,

	--CASE WHEN QuotaDate = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(QuotaDate,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS QuotaDate
    case
    when QuotaDate = 'NULL'
    then cast ('1900-01-01' as TIMESTAMP)
    else
    cast(coalesce(QuotaDate,to_date('1900-01-01')) as TIMESTAMP) end QuotaDate
FROM Dp_Stg1.Sales_April_1_10
where SalesQuota1 <>'';


INSERT INTO DP_STG2.SalesPersonQuotaHistory
SELECT DISTINCT 
	--CASE WHEN  BusinessEntityID2 ='NULL' THEN -1 ELSE  BusinessEntityID2 END AS  BusinessEntityID,
    CASE
    WHEN  BusinessEntityID2='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( BusinessEntityID2),'-1') AS VARCHAR(20)) AS INT) END AS  BusinessEntityID,

    --CASE WHEN  SalesQuota1 = 'NULL' THEN -1 ELSE  CAST(SalesQuota1 AS DECIMAL(10,2)) END AS SalesQuota,
    CASE
    WHEN   SalesQuota1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(SalesQuota1),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS SalesQuota,

	--CASE WHEN QuotaDate = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(QuotaDate,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS QuotaDate
    case
    when QuotaDate = 'NULL'
    then cast ('1900-01-01' as TIMESTAMP)
    else
    cast(coalesce(QuotaDate,to_date('1900-01-01')) as TIMESTAMP) end QuotaDate
FROM Dp_Stg1.Sales_April_11_20
where SalesQuota1 <>'';



INSERT INTO DP_STG2.SalesPersonQuotaHistory
SELECT DISTINCT 
--CASE WHEN  BusinessEntityID2 ='NULL' THEN -1 ELSE  BusinessEntityID2 END AS  BusinessEntityID,
    CASE
    WHEN  BusinessEntityID2='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( BusinessEntityID2),'-1') AS VARCHAR(20)) AS INT) END AS  BusinessEntityID,

    --CASE WHEN  SalesQuota1 = 'NULL' THEN -1 ELSE  CAST(SalesQuota1 AS DECIMAL(10,2)) END AS SalesQuota,
    CASE
    WHEN   SalesQuota1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(SalesQuota1),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS SalesQuota,

	--CASE WHEN QuotaDate = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(QuotaDate,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS QuotaDate
    case
    when QuotaDate = 'NULL'
    then cast ('1900-01-01' as TIMESTAMP)
    else
    cast(coalesce(QuotaDate,to_date('1900-01-01')) as TIMESTAMP) end QuotaDate
FROM Dp_Stg1.Sales_April_21_30;


INSERT INTO DP_STG2.SalesPersonQuotaHistory
SELECT DISTINCT 
	--CASE WHEN  BusinessEntityID2 ='NULL' THEN -1 ELSE  BusinessEntityID2 END AS  BusinessEntityID,
    CASE
    WHEN  BusinessEntityID2='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( BusinessEntityID2),'-1') AS VARCHAR(20)) AS INT) END AS  BusinessEntityID,

    --CASE WHEN  SalesQuota1 = 'NULL' THEN -1 ELSE  CAST(SalesQuota1 AS DECIMAL(10,2)) END AS SalesQuota,
    CASE
    WHEN   SalesQuota1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(SalesQuota1),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS SalesQuota,

	--CASE WHEN QuotaDate = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(QuotaDate,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS QuotaDate
    case
    when QuotaDate = 'NULL'
    then cast ('1900-01-01' as TIMESTAMP)
    else
    cast(coalesce(QuotaDate,to_date('1900-01-01')) as TIMESTAMP) end QuotaDate
FROM Dp_Stg1.Sales_May_06_10;


INSERT INTO DP_STG2.SalesPersonQuotaHistory
SELECT DISTINCT 
	--CASE WHEN  BusinessEntityID2 ='NULL' THEN -1 ELSE  BusinessEntityID2 END AS  BusinessEntityID,
    CASE
    WHEN  BusinessEntityID2='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( BusinessEntityID2),'-1') AS VARCHAR(20)) AS INT) END AS  BusinessEntityID,

    --CASE WHEN  SalesQuota1 = 'NULL' THEN -1 ELSE  CAST(SalesQuota1 AS DECIMAL(10,2)) END AS SalesQuota,
    CASE
    WHEN   SalesQuota1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(SalesQuota1),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS SalesQuota,

	--CASE WHEN QuotaDate = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(QuotaDate,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS QuotaDate
    case
    when QuotaDate = 'NULL'
    then cast ('1900-01-01' as TIMESTAMP)
    else
    cast(coalesce(QuotaDate,to_date('1900-01-01')) as TIMESTAMP) end QuotaDate
FROM Dp_Stg1.Sales_May_11_20;


INSERT INTO DP_STG2.SalesPersonQuotaHistory
SELECT DISTINCT 
	--CASE WHEN  BusinessEntityID2 ='NULL' THEN -1 ELSE  BusinessEntityID2 END AS  BusinessEntityID,
    CASE
    WHEN  BusinessEntityID2='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( BusinessEntityID2),'-1') AS VARCHAR(20)) AS INT) END AS  BusinessEntityID,

    --CASE WHEN  SalesQuota1 = 'NULL' THEN -1 ELSE  CAST(SalesQuota1 AS DECIMAL(10,2)) END AS SalesQuota,
    CASE
    WHEN   SalesQuota1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(SalesQuota1),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS SalesQuota,

	--CASE WHEN QuotaDate = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(QuotaDate,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS QuotaDate
    case
    when QuotaDate = 'NULL'
    then cast ('1900-01-01' as TIMESTAMP)
    else
    cast(coalesce(QuotaDate,to_date('1900-01-01')) as TIMESTAMP) end QuotaDate
FROM Dp_Stg1.Sales_May_21_31;


--Checking if the data have been loaded in to the target table or not
--It should return 139 Rows

SELECT *
FROM DP_STG2.SalesPersonQuotaHistory;



--Issue resolved by this overwrite distinct (it was because of union)
INSERT OVERWRITE TABLE dp_stg2.SalesPersonQuotaHistory
SELECT DISTINCT * FROM dp_stg2.SalesPersonQuotaHistory;


-------------------------------------------------------------------------------------------

--6) SalesReason Table
-- According to schema

----------------------------------

--Dropping the table if there is any issue while loading the data into the target table

DROP TABLE DP_STG2.SalesReason;

--Refreshing the table after inserting the data into the table 

REFRESH dp_stg2.salesreason;


--Creating the ProductInventory table total 3 columns
--1) SalesReasonID, 2)Name1, 3)ReasonType

CREATE TABLE dp_stg2.SalesReason
	(
		SalesReasonID INT,
		Name1 VARCHAR(32),
		ReasonType VARCHAR(32) 
	);
	
	
	
--Inserting data into the table from the source table and removing NULL from the source table
--Cleaning the Data and defining data types.		
INSERT INTO DP_STG2.SalesReason
SELECT DISTINCT 
	--CASE WHEN SalesReasonID1 ='NULL' THEN -1 ELSE SalesReasonID1 END AS SalesReasonID,
    CASE
    WHEN  SalesReasonID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( SalesReasonID1),'-1') AS VARCHAR(20)) AS INT) END AS  SalesReasonID,


	--CASE WHEN Name1 = 'NULL' THEN 'N/A' ELSE Name1 END AS Name1,
    CASE 
    WHEN Name1='NULL'
    THEN cast('N/A' AS VARCHAR(32))
    ELSE
    cast(coalesce(trim(Name1),'N/A') AS VARCHAR(32)) END AS Name1,

	--CASE WHEN ReasonType = 'NULL' THEN 'N/A' ELSE ReasonType END AS ReasonType
    CASE 
    WHEN ReasonType='NULL'
    THEN cast('N/A' AS VARCHAR(32))
    ELSE
    cast(coalesce(trim(ReasonType),'N/A') AS VARCHAR(32)) END AS ReasonType
FROM Dp_Stg1.Sales;

--Checking if the data have been loaded in to the target table or not
--It should return 3 Rows

SELECT *
FROM DP_STG2.SalesReason;


----------------------------------------------------------------------------------------------------------------



--7) salesTaxRate Table
--According to Schema

----------------------------------------------------------------------------------------------

--Dropping the table if there is any issue while loading the data into the target table

DROP TABLE dp_stg2.salestaxrate;

--Refreshing the table after inserting the data into the table 

REFRESH dp_stg2.salestaxrate;


--Creating the ProductInventory table total 5 columns
--1) SalesTaxRateID, 2)StateProvinceID, 3)TaxType, 4)TaxRate, 5)Name1

CREATE TABLE dp_stg2.SalesTaxRate
	(
		SalesTaxRateID INT ,
		StateProvinceID INT,
		TaxType TINYINT,
		TaxRate DECIMAL(4,2),
		Name1 VARCHAR(32) 
	);




--Inserting data into the table from the source table and removing NULL from the source table
--Cleaning the Data and defining data types.

INSERT INTO DP_STG2.SalesTaxRate

SELECT DISTINCT 
	--CASE WHEN SalesTaxRateID = 'NULL' THEN -1 ELSE SalesTaxRateID END AS  SalesTaxRateID,
    CASE
    WHEN  SalesTaxRateID='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( SalesTaxRateID),'-1') AS VARCHAR(20)) AS INT) END AS  SalesTaxRateID,

	--CASE WHEN StateProvinceID = 'NULL' THEN -1 ELSE StateProvinceID END AS  StateProvinceID,
    CASE
    WHEN  StateProvinceID='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( StateProvinceID),'-1') AS VARCHAR(20)) AS INT) END AS  StateProvinceID,

	--CASE WHEN TaxType = 'NULL' THEN -1 ELSE CAST(TaxType AS BYTEINT) END AS  TaxType,
    CASE
    WHEN  TaxType='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS TINYINT)
    ELSE 
    cast(cast(coalesce(trim(TaxType),'-1') AS VARCHAR(20)) AS TINYINT) END AS TaxType,


	--CASE WHEN TaxRate = 'NULL' THEN -1 ELSE CAST(TaxRate AS DECIMAL(4,2)) END AS  TaxRate,
    CASE
    WHEN  TaxRate='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(4,2))
    ELSE 
    cast(cast(coalesce(trim(TaxRate),'-1') AS VARCHAR(20)) AS DECIMAL(4,2)) END AS TaxRate,


	--CASE WHEN "Name" ='NULL' THEN 'N/A' ELSE "Name" END  AS "Name"
    CASE 
    WHEN  Name='NULL'
    THEN cast('N/A' AS VARCHAR(32))
    ELSE
    cast(coalesce(trim(Name),'N/A') AS VARCHAR(32)) END AS  Name

FROM Dp_Stg1.Sales_Tax_Rate_Sales;


--Checking if the data have been loaded in to the target table or not
--It should return 29 Rows

SELECT *
FROM dp_stg2.salestaxrate;

-----------------------------------------------------------------------------------------------------------------------------------



--8)SalesTerritory Table
-- According to Schema

--------------------------------------


--Dropping the table if there is any issue while loading the data into the target table

DROP TABLE DP_STG2.SalesTerritory;

--Refreshing the table after inserting the data into the table 

REFRESH dp_stg2.salesterritory;


--Creating the ProductInventory table total 8 columns
--1) TerritoryID, 2)Name1, 3)CountryRegionCode, 4)Group1, 5)SalesYtd, 6)SalesLastYear, 7)CostYtd, 8)CostLastYear



CREATE TABLE dp_stg2.SalesTerritory
	(
	  TerritoryID INT,
      Name1 VARCHAR(40),
      CountryRegionCode CHAR(5),
      Group1 VARCHAR(20),
      SalesYtd DECIMAL(15,2),
      SalesLastYear DECIMAL(15,2),
      CostYtd DECIMAL(15,2),
      CostLastYear DECIMAL(15,2)
	 );





--Inserting data into the table from the source table and removing NULL from the source table
--Cleaning the Data and defining data types.


INSERT INTO DP_STG2.SalesTerritory

SELECT DISTINCT 
   -- CASE WHEN TerritoryID1 ='NULL' THEN -1 ELSE TerritoryID1 END AS TerritoryID,
CASE
    WHEN  TerritoryID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(TerritoryID1),'-1') AS VARCHAR(20)) AS INT) END AS TerritoryID,

	--CASE WHEN Name3 ='NULL' THEN 'N/A' ELSE Name3 END AS Name3,
    CASE 
    WHEN  Name3='NULL'
    THEN cast('N/A' AS VARCHAR(40))
    ELSE
    cast(coalesce(trim(Name3),'N/A') AS VARCHAR(40)) END AS  Name3,

	--CASE WHEN  CountryRegionCode ='NULL' THEN 'N/A' ELSE  CountryRegionCode END AS  CountryRegionCode,
    CASE 
    WHEN CountryRegionCode='NULL'
    THEN cast('N/A' AS CHAR(5))
    ELSE
    cast(coalesce(trim(CountryRegionCode),'N/A') AS CHAR(5)) END AS CountryRegionCode,

	--CASE WHEN Group1 ='NULL' THEN 'N/A' ELSE Group1 END AS Group1,
    CASE 
    WHEN  Group1='NULL'
    THEN cast('N/A' AS VARCHAR(20))
    ELSE
    cast(coalesce(trim(Group1),'N/A') AS VARCHAR(20)) END AS  Group1,

	--CASE WHEN SalesYtd1 ='NULL' THEN -1 ELSE CAST(SalesYtd1 AS DECIMAL(15,2)) END AS SalesYtd,
    CASE
    WHEN  SalesYtd1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(15,2))
    ELSE 
    cast(cast(coalesce(trim(SalesYtd1),'-1') AS VARCHAR(20)) AS DECIMAL(15,2)) END AS SalesYtd,

	--CASE WHEN SalesLastYear1 ='NULL' THEN -1 ELSE CAST(SalesLastYear1 AS DECIMAL(15,2)) END AS SalesLastYear,
     CASE
    WHEN  SalesLastYear1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(15,2))
    ELSE 
    cast(cast(coalesce(trim(SalesLastYear1),'-1') AS VARCHAR(20)) AS DECIMAL(15,2)) END AS SalesLastYear,

	--CASE WHEN CostYtd ='NULL' THEN -1 ELSE CAST(CostYtd AS DECIMAL(15,2)) END AS CostYtd,
     CASE
    WHEN  CostYtd='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(15,2))
    ELSE 
    cast(cast(coalesce(trim(CostYtd),'-1') AS VARCHAR(20)) AS DECIMAL(15,2)) END AS CostYtd,

	--CASE WHEN CostLastYear ='NULL' THEN -1 ELSE CAST(CostLastYear AS DECIMAL(15,2)) END AS CostLastYear
     CASE
    WHEN  CostLastYear='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(15,2))
    ELSE 
    cast(cast(coalesce(trim(CostLastYear),'-1') AS VARCHAR(20)) AS DECIMAL(15,2)) END AS CostLastYear
FROM Dp_Stg1.Sales;

INSERT INTO DP_STG2.SalesTerritory

SELECT DISTINCT 
	-- CASE WHEN TerritoryID1 ='NULL' THEN -1 ELSE TerritoryID1 END AS TerritoryID,
CASE
    WHEN  TerritoryID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(TerritoryID1),'-1') AS VARCHAR(20)) AS INT) END AS TerritoryID1,

	--CASE WHEN Name3 ='NULL' THEN 'N/A' ELSE Name3 END AS Name3,
    CASE 
    WHEN  Name3='NULL'
    THEN cast('N/A' AS VARCHAR(40))
    ELSE
    cast(coalesce(trim(Name3),'N/A') AS VARCHAR(40)) END AS  Name3,

	--CASE WHEN  CountryRegionCode ='NULL' THEN 'N/A' ELSE  CountryRegionCode END AS  CountryRegionCode,
    CASE 
    WHEN CountryRegionCode='NULL'
    THEN cast('N/A' AS CHAR(5))
    ELSE
    cast(coalesce(trim(CountryRegionCode),'N/A') AS CHAR(5)) END AS CountryRegionCode,

	--CASE WHEN Group1 ='NULL' THEN 'N/A' ELSE Group1 END AS Group1,
    CASE 
    WHEN  Group1='NULL'
    THEN cast('N/A' AS VARCHAR(20))
    ELSE
    cast(coalesce(trim(Group1),'N/A') AS VARCHAR(20)) END AS  Group1,

	--CASE WHEN SalesYtd1 ='NULL' THEN -1 ELSE CAST(SalesYtd1 AS DECIMAL(15,2)) END AS SalesYtd,
    CASE
    WHEN  SalesYtd1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(15,2))
    ELSE 
    cast(cast(coalesce(trim(SalesYtd1),'-1') AS VARCHAR(20)) AS DECIMAL(15,2)) END AS SalesYtd,

	--CASE WHEN SalesLastYear1 ='NULL' THEN -1 ELSE CAST(SalesLastYear1 AS DECIMAL(15,2)) END AS SalesLastYear,
     CASE
    WHEN  SalesLastYear1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(15,2))
    ELSE 
    cast(cast(coalesce(trim(SalesLastYear1),'-1') AS VARCHAR(20)) AS DECIMAL(15,2)) END AS SalesLastYear,

	--CASE WHEN CostYtd ='NULL' THEN -1 ELSE CAST(CostYtd AS DECIMAL(15,2)) END AS CostYtd,
     CASE
    WHEN  CostYtd='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(15,2))
    ELSE 
    cast(cast(coalesce(trim(CostYtd),'-1') AS VARCHAR(20)) AS DECIMAL(15,2)) END AS CostYtd,

	--CASE WHEN CostLastYear ='NULL' THEN -1 ELSE CAST(CostLastYear AS DECIMAL(15,2)) END AS CostLastYear
     CASE
    WHEN  CostLastYear='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(15,2))
    ELSE 
    cast(cast(coalesce(trim(CostLastYear),'-1') AS VARCHAR(20)) AS DECIMAL(15,2)) END AS CostLastYear
FROM Dp_Stg1.Sales_April_1_10
where salesYtd1 <> '';


INSERT INTO DP_STG2.SalesTerritory
SELECT DISTINCT 
	-- CASE WHEN TerritoryID1 ='NULL' THEN -1 ELSE TerritoryID1 END AS TerritoryID,
CASE
    WHEN  TerritoryID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(TerritoryID1),'-1') AS VARCHAR(20)) AS INT) END AS TerritoryID1,

	--CASE WHEN Name3 ='NULL' THEN 'N/A' ELSE Name3 END AS Name3,
    CASE 
    WHEN  Name3='NULL'
    THEN cast('N/A' AS VARCHAR(40))
    ELSE
    cast(coalesce(trim(Name3),'N/A') AS VARCHAR(40)) END AS  Name3,

	--CASE WHEN  CountryRegionCode ='NULL' THEN 'N/A' ELSE  CountryRegionCode END AS  CountryRegionCode,
    CASE 
    WHEN CountryRegionCode='NULL'
    THEN cast('N/A' AS CHAR(5))
    ELSE
    cast(coalesce(trim(CountryRegionCode),'N/A') AS CHAR(5)) END AS CountryRegionCode,

	--CASE WHEN Group1 ='NULL' THEN 'N/A' ELSE Group1 END AS Group1,
    CASE 
    WHEN  Group1='NULL'
    THEN cast('N/A' AS VARCHAR(20))
    ELSE
    cast(coalesce(trim(Group1),'N/A') AS VARCHAR(20)) END AS  Group1,

	--CASE WHEN SalesYtd1 ='NULL' THEN -1 ELSE CAST(SalesYtd1 AS DECIMAL(15,2)) END AS SalesYtd,
    CASE
    WHEN  SalesYtd1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(15,2))
    ELSE 
    cast(cast(coalesce(trim(SalesYtd1),'-1') AS VARCHAR(20)) AS DECIMAL(15,2)) END AS SalesYtd,

	--CASE WHEN SalesLastYear1 ='NULL' THEN -1 ELSE CAST(SalesLastYear1 AS DECIMAL(15,2)) END AS SalesLastYear,
     CASE
    WHEN  SalesLastYear1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(15,2))
    ELSE 
    cast(cast(coalesce(trim(SalesLastYear1),'-1') AS VARCHAR(20)) AS DECIMAL(15,2)) END AS SalesLastYear,

	--CASE WHEN CostYtd ='NULL' THEN -1 ELSE CAST(CostYtd AS DECIMAL(15,2)) END AS CostYtd,
     CASE
    WHEN  CostYtd='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(15,2))
    ELSE 
    cast(cast(coalesce(trim(CostYtd),'-1') AS VARCHAR(20)) AS DECIMAL(15,2)) END AS CostYtd,

	--CASE WHEN CostLastYear ='NULL' THEN -1 ELSE CAST(CostLastYear AS DECIMAL(15,2)) END AS CostLastYear
     CASE
    WHEN  CostLastYear='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(15,2))
    ELSE 
    cast(cast(coalesce(trim(CostLastYear),'-1') AS VARCHAR(20)) AS DECIMAL(15,2)) END AS CostLastYear
FROM Dp_Stg1.Sales_April_11_20;


INSERT INTO DP_STG2.SalesTerritory
SELECT DISTINCT 
	-- CASE WHEN TerritoryID1 ='NULL' THEN -1 ELSE TerritoryID1 END AS TerritoryID,
CASE
    WHEN  TerritoryID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(TerritoryID1),'-1') AS VARCHAR(20)) AS INT) END AS TerritoryID1,

	--CASE WHEN Name3 ='NULL' THEN 'N/A' ELSE Name3 END AS Name3,
    CASE 
    WHEN  Name3='NULL'
    THEN cast('N/A' AS VARCHAR(40))
    ELSE
    cast(coalesce(trim(Name3),'N/A') AS VARCHAR(40)) END AS  Name3,

	--CASE WHEN  CountryRegionCode ='NULL' THEN 'N/A' ELSE  CountryRegionCode END AS  CountryRegionCode,
    CASE 
    WHEN CountryRegionCode='NULL'
    THEN cast('N/A' AS CHAR(5))
    ELSE
    cast(coalesce(trim(CountryRegionCode),'N/A') AS CHAR(5)) END AS CountryRegionCode,

	--CASE WHEN Group1 ='NULL' THEN 'N/A' ELSE Group1 END AS Group1,
    CASE 
    WHEN  Group1='NULL'
    THEN cast('N/A' AS VARCHAR(20))
    ELSE
    cast(coalesce(trim(Group1),'N/A') AS VARCHAR(20)) END AS  Group1,

	--CASE WHEN SalesYtd1 ='NULL' THEN -1 ELSE CAST(SalesYtd1 AS DECIMAL(15,2)) END AS SalesYtd,
    CASE
    WHEN  SalesYtd1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(15,2))
    ELSE 
    cast(cast(coalesce(trim(SalesYtd1),'-1') AS VARCHAR(20)) AS DECIMAL(15,2)) END AS SalesYtd,

	--CASE WHEN SalesLastYear1 ='NULL' THEN -1 ELSE CAST(SalesLastYear1 AS DECIMAL(15,2)) END AS SalesLastYear,
     CASE
    WHEN  SalesLastYear1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(15,2))
    ELSE 
    cast(cast(coalesce(trim(SalesLastYear1),'-1') AS VARCHAR(20)) AS DECIMAL(15,2)) END AS SalesLastYear,

	--CASE WHEN CostYtd ='NULL' THEN -1 ELSE CAST(CostYtd AS DECIMAL(15,2)) END AS CostYtd,
     CASE
    WHEN  CostYtd='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(15,2))
    ELSE 
    cast(cast(coalesce(trim(CostYtd),'-1') AS VARCHAR(20)) AS DECIMAL(15,2)) END AS CostYtd,

	--CASE WHEN CostLastYear ='NULL' THEN -1 ELSE CAST(CostLastYear AS DECIMAL(15,2)) END AS CostLastYear
     CASE
    WHEN  CostLastYear='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(15,2))
    ELSE 
    cast(cast(coalesce(trim(CostLastYear),'-1') AS VARCHAR(20)) AS DECIMAL(15,2)) END AS CostLastYear
FROM Dp_Stg1.Sales_April_21_30;


INSERT INTO DP_STG2.SalesTerritory
SELECT DISTINCT 
	-- CASE WHEN TerritoryID1 ='NULL' THEN -1 ELSE TerritoryID1 END AS TerritoryID,
CASE
    WHEN  TerritoryID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(TerritoryID1),'-1') AS VARCHAR(20)) AS INT) END AS TerritoryID1,

	--CASE WHEN Name3 ='NULL' THEN 'N/A' ELSE Name3 END AS Name3,
    CASE 
    WHEN  Name3='NULL'
    THEN cast('N/A' AS VARCHAR(40))
    ELSE
    cast(coalesce(trim(Name3),'N/A') AS VARCHAR(40)) END AS  Name3,

	--CASE WHEN  CountryRegionCode ='NULL' THEN 'N/A' ELSE  CountryRegionCode END AS  CountryRegionCode,
    CASE 
    WHEN CountryRegionCode='NULL'
    THEN cast('N/A' AS CHAR(5))
    ELSE
    cast(coalesce(trim(CountryRegionCode),'N/A') AS CHAR(5)) END AS CountryRegionCode,

	--CASE WHEN Group1 ='NULL' THEN 'N/A' ELSE Group1 END AS Group1,
    CASE 
    WHEN  Group1='NULL'
    THEN cast('N/A' AS VARCHAR(20))
    ELSE
    cast(coalesce(trim(Group1),'N/A') AS VARCHAR(20)) END AS  Group1,

	--CASE WHEN SalesYtd1 ='NULL' THEN -1 ELSE CAST(SalesYtd1 AS DECIMAL(15,2)) END AS SalesYtd,
    CASE
    WHEN  SalesYtd1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(15,2))
    ELSE 
    cast(cast(coalesce(trim(SalesYtd1),'-1') AS VARCHAR(20)) AS DECIMAL(15,2)) END AS SalesYtd,

	--CASE WHEN SalesLastYear1 ='NULL' THEN -1 ELSE CAST(SalesLastYear1 AS DECIMAL(15,2)) END AS SalesLastYear,
     CASE
    WHEN  SalesLastYear1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(15,2))
    ELSE 
    cast(cast(coalesce(trim(SalesLastYear1),'-1') AS VARCHAR(20)) AS DECIMAL(15,2)) END AS SalesLastYear,

	--CASE WHEN CostYtd ='NULL' THEN -1 ELSE CAST(CostYtd AS DECIMAL(15,2)) END AS CostYtd,
     CASE
    WHEN  CostYtd='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(15,2))
    ELSE 
    cast(cast(coalesce(trim(CostYtd),'-1') AS VARCHAR(20)) AS DECIMAL(15,2)) END AS CostYtd,

	--CASE WHEN CostLastYear ='NULL' THEN -1 ELSE CAST(CostLastYear AS DECIMAL(15,2)) END AS CostLastYear
     CASE
    WHEN  CostLastYear='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(15,2))
    ELSE 
    cast(cast(coalesce(trim(CostLastYear),'-1') AS VARCHAR(20)) AS DECIMAL(15,2)) END AS CostLastYear
FROM Dp_Stg1.Sales_May_06_10;


INSERT INTO DP_STG2.SalesTerritory
SELECT DISTINCT 
	-- CASE WHEN TerritoryID1 ='NULL' THEN -1 ELSE TerritoryID1 END AS TerritoryID,
CASE
    WHEN  ProductID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(ProductID1),'-1') AS VARCHAR(20)) AS INT) END AS ProductID,

	--CASE WHEN Name3 ='NULL' THEN 'N/A' ELSE Name3 END AS Name3,
    CASE 
    WHEN  Name3='NULL'
    THEN cast('N/A' AS VARCHAR(40))
    ELSE
    cast(coalesce(trim(Name3),'N/A') AS VARCHAR(40)) END AS  Name3,

	--CASE WHEN  CountryRegionCode ='NULL' THEN 'N/A' ELSE  CountryRegionCode END AS  CountryRegionCode,
    CASE 
    WHEN CountryRegionCode='NULL'
    THEN cast('N/A' AS CHAR(5))
    ELSE
    cast(coalesce(trim(CountryRegionCode),'N/A') AS CHAR(5)) END AS CountryRegionCode,

	--CASE WHEN Group1 ='NULL' THEN 'N/A' ELSE Group1 END AS Group1,
    CASE 
    WHEN  Group1='NULL'
    THEN cast('N/A' AS VARCHAR(20))
    ELSE
    cast(coalesce(trim(Group1),'N/A') AS VARCHAR(20)) END AS  Group1,

	--CASE WHEN SalesYtd1 ='NULL' THEN -1 ELSE CAST(SalesYtd1 AS DECIMAL(15,2)) END AS SalesYtd,
    CASE
    WHEN  SalesYtd1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(15,2))
    ELSE 
    cast(cast(coalesce(trim(SalesYtd1),'-1') AS VARCHAR(20)) AS DECIMAL(15,2)) END AS SalesYtd,

	--CASE WHEN SalesLastYear1 ='NULL' THEN -1 ELSE CAST(SalesLastYear1 AS DECIMAL(15,2)) END AS SalesLastYear,
     CASE
    WHEN  SalesLastYear1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(15,2))
    ELSE 
    cast(cast(coalesce(trim(SalesLastYear1),'-1') AS VARCHAR(20)) AS DECIMAL(15,2)) END AS SalesLastYear,

	--CASE WHEN CostYtd ='NULL' THEN -1 ELSE CAST(CostYtd AS DECIMAL(15,2)) END AS CostYtd,
     CASE
    WHEN  CostYtd='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(15,2))
    ELSE 
    cast(cast(coalesce(trim(CostYtd),'-1') AS VARCHAR(20)) AS DECIMAL(15,2)) END AS CostYtd,

	--CASE WHEN CostLastYear ='NULL' THEN -1 ELSE CAST(CostLastYear AS DECIMAL(15,2)) END AS CostLastYear
     CASE
    WHEN  CostLastYear='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(15,2))
    ELSE 
    cast(cast(coalesce(trim(CostLastYear),'-1') AS VARCHAR(20)) AS DECIMAL(15,2)) END AS CostLastYear
FROM Dp_Stg1.Sales_May_11_20;


INSERT INTO DP_STG2.SalesTerritory
SELECT DISTINCT 
	-- CASE WHEN TerritoryID1 ='NULL' THEN -1 ELSE TerritoryID1 END AS TerritoryID,
CASE
    WHEN  TerritoryID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(TerritoryID1),'-1') AS VARCHAR(20)) AS INT) END AS TerritoryID1,

	--CASE WHEN Name3 ='NULL' THEN 'N/A' ELSE Name3 END AS Name3,
    CASE 
    WHEN  Name3='NULL'
    THEN cast('N/A' AS VARCHAR(40))
    ELSE
    cast(coalesce(trim(Name3),'N/A') AS VARCHAR(40)) END AS  Name3,

	--CASE WHEN  CountryRegionCode ='NULL' THEN 'N/A' ELSE  CountryRegionCode END AS  CountryRegionCode,
    CASE 
    WHEN CountryRegionCode='NULL'
    THEN cast('N/A' AS CHAR(5))
    ELSE
    cast(coalesce(trim(CountryRegionCode),'N/A') AS CHAR(5)) END AS CountryRegionCode,

	--CASE WHEN Group1 ='NULL' THEN 'N/A' ELSE Group1 END AS Group1,
    CASE 
    WHEN  Group1='NULL'
    THEN cast('N/A' AS VARCHAR(20))
    ELSE
    cast(coalesce(trim(Group1),'N/A') AS VARCHAR(20)) END AS  Group1,

	--CASE WHEN SalesYtd1 ='NULL' THEN -1 ELSE CAST(SalesYtd1 AS DECIMAL(15,2)) END AS SalesYtd,
    CASE
    WHEN  SalesYtd1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(15,2))
    ELSE 
    cast(cast(coalesce(trim(SalesYtd1),'-1') AS VARCHAR(20)) AS DECIMAL(15,2)) END AS SalesYtd,

	--CASE WHEN SalesLastYear1 ='NULL' THEN -1 ELSE CAST(SalesLastYear1 AS DECIMAL(15,2)) END AS SalesLastYear,
     CASE
    WHEN  SalesLastYear1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(15,2))
    ELSE 
    cast(cast(coalesce(trim(SalesLastYear1),'-1') AS VARCHAR(20)) AS DECIMAL(15,2)) END AS SalesLastYear,

	--CASE WHEN CostYtd ='NULL' THEN -1 ELSE CAST(CostYtd AS DECIMAL(15,2)) END AS CostYtd,
     CASE
    WHEN  CostYtd='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(15,2))
    ELSE 
    cast(cast(coalesce(trim(CostYtd),'-1') AS VARCHAR(20)) AS DECIMAL(15,2)) END AS CostYtd,

	--CASE WHEN CostLastYear ='NULL' THEN -1 ELSE CAST(CostLastYear AS DECIMAL(15,2)) END AS CostLastYear
     CASE
    WHEN  CostLastYear='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(15,2))
    ELSE 
    cast(cast(coalesce(trim(CostLastYear),'-1') AS VARCHAR(20)) AS DECIMAL(15,2)) END AS CostLastYear
FROM Dp_Stg1.Sales_May_21_31;



--Checking if the data have been loaded in to the target table or not
--It should return 10 but 57 Rows



SELECT *
FROM DP_STG2.SalesTerritory;

INSERT OVERWRITE TABLE dp_stg2.salesterritory
SELECT DISTINCT * FROM dp_stg2.SalesTerritory;
		
/*INSERT OVERWRITE TABLE dp_stg2.salesterritory 
SELECT territoryid,name1
FROM   dp_stg2.salesterritory 
GROUP  BY territoryid,name1;
*/

--name1,countryregioncode,group1,salesytd,saleslastyear,costytd,costlastyear;

---------------------------------------------------------------------------------------------------------------------


--9) SalesTerritoryHistory Table
--According to Schema

----------------------------------------------------------------------------------------------



--Dropping the table if there is any issue while loading the data into the target table

DROP TABLE DP_STG2.SalesTerritoryHistory;

--Refreshing the table after inserting the data into the table 

REFRESH dp_stg2.salesterritoryhistory;

--Creating the ProductInventory table total 5 columns
--1) BusinessEntityID, 2)TerritoryID, 3)StartDate, 4)EndDate

CREATE TABLE dp_stg2.SalesTerritoryHistory
	(
	  BusinessEntityID INT,
	  TerritoryID INT,
      StartDate TIMESTAMP,
	  EndDate TIMESTAMP
	 );



--Inserting data into the table from the source table and removing NULL from the source table
--Cleaning the Data and defining data types

INSERT INTO DP_STG2.SalesTerritoryHistory
SELECT DISTINCT 
   -- CASE WHEN  BusinessEntityID1 ='NULL' THEN -1 ELSE  BusinessEntityID1 END AS  BusinessEntityID,
    CASE
    WHEN  BusinessEntityID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( BusinessEntityID1),'-1') AS VARCHAR(20)) AS INT) END AS  BusinessEntityID,

    --CASE WHEN TerritoryID1 ='NULL' THEN -1 ELSE TerritoryID1 END AS TerritoryID,
    CASE
    WHEN  TerritoryID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( TerritoryID1),'-1') AS VARCHAR(20)) AS INT) END AS  TerritoryID,
 
    --CASE WHEN StartDate1 = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(StartDate1,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS StartDate,
    case
    when StartDate1 = 'NULL'
    then cast ('1900-01-01' as TIMESTAMP)
    else
    cast(coalesce(StartDate1,to_date('1900-01-01')) as TIMESTAMP) end StartDate,

	--CASE WHEN EndDate1 = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(EndDate1,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS EndDate
     case
    when EndDate1 = 'NULL'
    then cast ('1900-01-01' as TIMESTAMP)
    else
    cast(coalesce(EndDate1,to_date('1900-01-01')) as TIMESTAMP) end EndDate
FROM Dp_Stg1.Sales;


INSERT INTO DP_STG2.SalesTerritoryHistory
SELECT DISTINCT 
	CASE
    WHEN  BusinessEntityID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( BusinessEntityID1),'-1') AS VARCHAR(20)) AS INT) END AS  BusinessEntityID,

    --CASE WHEN TerritoryID1 ='NULL' THEN -1 ELSE TerritoryID1 END AS TerritoryID,
    CASE
    WHEN  TerritoryID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( TerritoryID1),'-1') AS VARCHAR(20)) AS INT) END AS  TerritoryID,
 
    --CASE WHEN StartDate1 = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(StartDate1,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS StartDate,
    case
    when StartDate1 = 'NULL'
    then cast ('1900-01-01' as TIMESTAMP)
    else
    cast(coalesce(StartDate1,to_date('1900-01-01')) as TIMESTAMP) end StartDate,

	--CASE WHEN EndDate1 = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(EndDate1,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS EndDate
     case
    when EndDate1 = 'NULL'
    then cast ('1900-01-01' as TIMESTAMP)
    else
    cast(coalesce(EndDate1,to_date('1900-01-01')) as TIMESTAMP) end EndDate
FROM Dp_Stg1.Sales_April_1_10;


INSERT INTO DP_STG2.SalesTerritoryHistory
SELECT DISTINCT 
	CASE
    WHEN  BusinessEntityID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( BusinessEntityID1),'-1') AS VARCHAR(20)) AS INT) END AS  BusinessEntityID,

    --CASE WHEN TerritoryID1 ='NULL' THEN -1 ELSE TerritoryID1 END AS TerritoryID,
    CASE
    WHEN  TerritoryID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( TerritoryID1),'-1') AS VARCHAR(20)) AS INT) END AS  TerritoryID,
 
    --CASE WHEN StartDate1 = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(StartDate1,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS StartDate,
    case
    when StartDate1 = 'NULL'
    then cast ('1900-01-01' as TIMESTAMP)
    else
    cast(coalesce(StartDate1,to_date('1900-01-01')) as TIMESTAMP) end StartDate,

	--CASE WHEN EndDate1 = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(EndDate1,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS EndDate
     case
    when EndDate1 = 'NULL'
    then cast ('1900-01-01' as TIMESTAMP)
    else
    cast(coalesce(EndDate1,to_date('1900-01-01')) as TIMESTAMP) end EndDate
FROM Dp_Stg1.Sales_April_11_20;


INSERT INTO DP_STG2.SalesTerritoryHistory
SELECT DISTINCT 
--CASE WHEN  BusinessEntityID1 ='NULL' THEN '-1' ELSE  BusinessEntityID1 END AS  BusinessEntityID,
   CASE
    WHEN  BusinessEntityID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( BusinessEntityID1),'-1') AS VARCHAR(20)) AS INT) END AS  BusinessEntityID,

    --CASE WHEN TerritoryID1 ='NULL' THEN -1 ELSE TerritoryID1 END AS TerritoryID,
    CASE
    WHEN  TerritoryID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( TerritoryID1),'-1') AS VARCHAR(20)) AS INT) END AS  TerritoryID,
 
    --CASE WHEN StartDate1 = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(StartDate1,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS StartDate,
    case
    when StartDate1 = 'NULL'
    then cast ('1900-01-01' as TIMESTAMP)
    else
    cast(coalesce(StartDate1,to_date('1900-01-01')) as TIMESTAMP) end StartDate,

	--CASE WHEN EndDate1 = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(EndDate1,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS EndDate
     case
    when EndDate1 = 'NULL'
    then cast ('1900-01-01' as TIMESTAMP)
    else
    cast(coalesce(EndDate1,to_date('1900-01-01')) as TIMESTAMP) end EndDate
FROM Dp_Stg1.Sales_April_21_30;


INSERT INTO DP_STG2.SalesTerritoryHistory
SELECT DISTINCT 
	CASE
    WHEN  BusinessEntityID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( BusinessEntityID1),'-1') AS VARCHAR(20)) AS INT) END AS  BusinessEntityID,

    --CASE WHEN TerritoryID1 ='NULL' THEN -1 ELSE TerritoryID1 END AS TerritoryID,
    CASE
    WHEN  TerritoryID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( TerritoryID1),'-1') AS VARCHAR(20)) AS INT) END AS  TerritoryID,
 
    --CASE WHEN StartDate1 = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(StartDate1,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS StartDate,
    case
    when StartDate1 = 'NULL'
    then cast ('1900-01-01' as TIMESTAMP)
    else
    cast(coalesce(StartDate1,to_date('1900-01-01')) as TIMESTAMP) end StartDate,

	--CASE WHEN EndDate1 = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(EndDate1,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS EndDate
     case
    when EndDate1 = 'NULL'
    then cast ('1900-01-01' as TIMESTAMP)
    else
    cast(coalesce(EndDate1,to_date('1900-01-01')) as TIMESTAMP) end EndDate
FROM Dp_Stg1.Sales_May_06_10;


INSERT INTO DP_STG2.SalesTerritoryHistory
SELECT DISTINCT 
	CASE
    WHEN  BusinessEntityID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( BusinessEntityID1),'-1') AS VARCHAR(20)) AS INT) END AS  BusinessEntityID,

    --CASE WHEN TerritoryID1 ='NULL' THEN -1 ELSE TerritoryID1 END AS TerritoryID,
    CASE
    WHEN  TerritoryID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( TerritoryID1),'-1') AS VARCHAR(20)) AS INT) END AS  TerritoryID,
 
    --CASE WHEN StartDate1 = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(StartDate1,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS StartDate,
    case
    when StartDate1 = 'NULL'
    then cast ('1900-01-01' as TIMESTAMP)
    else
    cast(coalesce(StartDate1,to_date('1900-01-01')) as TIMESTAMP) end StartDate,

	--CASE WHEN EndDate1 = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(EndDate1,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS EndDate
     case
    when EndDate1 = 'NULL'
    then cast ('1900-01-01' as TIMESTAMP)
    else
    cast(coalesce(EndDate1,to_date('1900-01-01')) as TIMESTAMP) end EndDate
FROM Dp_Stg1.Sales_May_11_20;


INSERT INTO DP_STG2.SalesTerritoryHistory
SELECT DISTINCT 
	CASE
    WHEN  BusinessEntityID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( BusinessEntityID1),'-1') AS VARCHAR(20)) AS INT) END AS  BusinessEntityID,

    --CASE WHEN TerritoryID1 ='NULL' THEN -1 ELSE TerritoryID1 END AS TerritoryID,
    CASE
    WHEN  TerritoryID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( TerritoryID1),'-1') AS VARCHAR(20)) AS INT) END AS  TerritoryID,
 
    --CASE WHEN StartDate1 = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(StartDate1,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS StartDate,
    case
    when StartDate1 = 'NULL'
    then cast ('1900-01-01' as TIMESTAMP)
    else
    cast(coalesce(StartDate1,to_date('1900-01-01')) as TIMESTAMP) end StartDate,

	--CASE WHEN EndDate1 = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(EndDate1,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS EndDate
     case
    when EndDate1 = 'NULL'
    then cast ('1900-01-01' as TIMESTAMP)
    else
    cast(coalesce(EndDate1,to_date('1900-01-01')) as TIMESTAMP) end EndDate
FROM Dp_Stg1.Sales_May_21_31;


--Checking if the data have been loaded in to the target table or not
--It should return 396 Rows

SELECT *
FROM DP_STG2.SalesTerritoryHistory;


--Issue resolved by this overwrite distinct (it was because of union)
INSERT OVERWRITE TABLE dp_stg2.SalesTerritoryHistory
SELECT DISTINCT * FROM dp_stg2.SalesTerritoryHistory;


--------------------------------------------------------------------------------------------------------------------------

--10) SpecialOffer Table
-- According to Schema

----------------------------------------------------------------------

--Dropping the table if there is any issue while loading the data into the target table

DROP TABLE DP_STG2.SpecialOffer;

--Refreshing the table after inserting the data into the table 

REFRESH dp_stg2.specialoffer;



--Creating the ProductInventory table total 5 columns
--1) SpecialOfferID, 2)Description, 3)DiscountPct, 4)Type1, 5)Category, 6) StartDate, 7)EndDate, 8)MinQty, 9) MaxQty

CREATE TABLE dp_stg2.SpecialOffer
	(
		SpecialOfferID INT ,
		Description VARCHAR(256),
		DiscountPct DECIMAL(8,2),
		Type1 VARCHAR(64),
		Category VARCHAR(64),
		StartDate TIMESTAMP,
		EndDate TIMESTAMP,
		MinQty INT,
		MaxQty INT 
	);
	
	
--Inserting data into the table from the source table and removing NULL from the source table
--Cleaning the Data and defining data types.


INSERT INTO DP_STG2.SpecialOffer
SELECT DISTINCT 
    --CASE WHEN SpecialOfferID1 ='NULL' THEN -1 ELSE SpecialOfferID1 END AS SpecialOfferID1,
    CASE
    WHEN  SpecialOfferID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(SpecialOfferID1),'-1') AS VARCHAR(20)) AS INT) END AS SpecialOfferID1,

	--CASE WHEN Description ='NULL' THEN 'N/A' ELSE Description END AS Description,
    CASE 
    WHEN  Description='NULL'
    THEN cast('N/A' AS VARCHAR(256))
    ELSE
    cast(coalesce(trim(Description),'N/A') AS VARCHAR(256)) END AS  Description,

	--CASE WHEN DiscountPct ='NULL' THEN -1 ELSE CAST(DiscountPct AS DECIMAL(8,2)) END AS DiscountPct,
    CASE
    WHEN  DiscountPct='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(8,2))
    ELSE 
    cast(cast(coalesce(trim(DiscountPct),'-1') AS VARCHAR(20)) AS DECIMAL(8,2)) END AS DiscountPct,


	--CASE WHEN Type1 ='NULL' THEN 'N/A' ELSE Type1 END AS Type1,
    CASE 
    WHEN  Type1='NULL'
    THEN cast('N/A' AS VARCHAR(64))
    ELSE
    cast(coalesce(trim(Type1),'N/A') AS VARCHAR(64)) END AS  Type1,

	--CASE WHEN Category ='NULL' THEN 'N/A' ELSE Category END AS Category,
    CASE 
    WHEN  Category='NULL'
    THEN cast('N/A' AS VARCHAR(64))
    ELSE
    cast(coalesce(trim(Category),'N/A') AS VARCHAR(64)) END AS  Category,

	--CASE WHEN StartDate1 = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(StartDate1,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS StartDate,
    CASE
    WHEN StartDate1 = 'NULL'
    THEN cast ('1900-01-01' as TIMESTAMP)
    ELSE
    cast(coalesce(StartDate1,to_date('1900-01-01')) as TIMESTAMP) end StartDate,

	--CASE WHEN EndDate1 = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(EndDate1,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS EndDate,
    CASE
    WHEN EndDate1 = 'NULL'
    THEN cast ('1900-01-01' as TIMESTAMP)
    ELSE
    cast(coalesce(EndDate1,to_date('1900-01-01')) as TIMESTAMP) end EndDate,

    --CASE WHEN MinQty ='NULL' THEN -1 ELSE MinQty END AS MinQty,
    CASE
    WHEN  MinQty='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(MinQty),'-1') AS VARCHAR(20)) AS INT) END AS MinQty,

	--CASE WHEN MaxQty ='NULL' THEN -1 ELSE MaxQty END AS MaxQty
    CASE
    WHEN  MaxQty='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(MaxQty),'-1') AS VARCHAR(20)) AS INT) END AS MaxQty

FROM Dp_Stg1.Sales;


INSERT INTO DP_STG2.SpecialOffer

SELECT DISTINCT 
  --CASE WHEN SpecialOfferID1 ='NULL' THEN -1 ELSE SpecialOfferID1 END AS SpecialOfferID1,
    CASE
    WHEN  SpecialOfferID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(SpecialOfferID1),'-1') AS VARCHAR(20)) AS INT) END AS SpecialOfferID1,

	--CASE WHEN Description ='NULL' THEN 'N/A' ELSE Description END AS Description,
    CASE 
    WHEN  Description='NULL'
    THEN cast('N/A' AS VARCHAR(256))
    ELSE
    cast(coalesce(trim(Description),'N/A') AS VARCHAR(256)) END AS  Description,

	--CASE WHEN DiscountPct ='NULL' THEN -1 ELSE CAST(DiscountPct AS DECIMAL(8,2)) END AS DiscountPct,
    CASE
    WHEN  DiscountPct='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(8,2))
    ELSE 
    cast(cast(coalesce(trim(DiscountPct),'-1') AS VARCHAR(20)) AS DECIMAL(8,2)) END AS DiscountPct,


	--CASE WHEN Type1 ='NULL' THEN 'N/A' ELSE Type1 END AS Type1,
    CASE 
    WHEN  Type1='NULL'
    THEN cast('N/A' AS VARCHAR(64))
    ELSE
    cast(coalesce(trim(Type1),'N/A') AS VARCHAR(64)) END AS  Type1,

	--CASE WHEN Category ='NULL' THEN 'N/A' ELSE Category END AS Category,
    CASE 
    WHEN  Category='NULL'
    THEN cast('N/A' AS VARCHAR(64))
    ELSE
    cast(coalesce(trim(Category),'N/A') AS VARCHAR(64)) END AS  Category,

	--CASE WHEN StartDate1 = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(StartDate1,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS StartDate,
    CASE
    WHEN StartDate1 = 'NULL'
    THEN cast ('1900-01-01' as TIMESTAMP)
    ELSE
    cast(coalesce(StartDate1,to_date('1900-01-01')) as TIMESTAMP) end StartDate,

	--CASE WHEN EndDate1 = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(EndDate1,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS EndDate,
    CASE
    WHEN EndDate1 = 'NULL'
    THEN cast ('1900-01-01' as TIMESTAMP)
    ELSE
    cast(coalesce(EndDate1,to_date('1900-01-01')) as TIMESTAMP) end EndDate,

    --CASE WHEN MinQty ='NULL' THEN -1 ELSE MinQty END AS MinQty,
    CASE
    WHEN  MinQty='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(MinQty),'-1') AS VARCHAR(20)) AS INT) END AS MinQty,

	--CASE WHEN MaxQty ='NULL' THEN -1 ELSE MaxQty END AS MaxQty
    CASE
    WHEN  MaxQty='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(MaxQty),'-1') AS VARCHAR(20)) AS INT) END AS MaxQty

FROM Dp_Stg1.Sales_April_1_10
where SpecialOfferID1 <>'';


INSERT INTO DP_STG2.SpecialOffer

SELECT DISTINCT 
  --CASE WHEN SpecialOfferID1 ='NULL' THEN -1 ELSE SpecialOfferID1 END AS SpecialOfferID1,
    CASE
    WHEN  SpecialOfferID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(SpecialOfferID1),'-1') AS VARCHAR(20)) AS INT) END AS SpecialOfferID1,

	--CASE WHEN Description ='NULL' THEN 'N/A' ELSE Description END AS Description,
    CASE 
    WHEN  Description='NULL'
    THEN cast('N/A' AS VARCHAR(256))
    ELSE
    cast(coalesce(trim(Description),'N/A') AS VARCHAR(256)) END AS  Description,

	--CASE WHEN DiscountPct ='NULL' THEN -1 ELSE CAST(DiscountPct AS DECIMAL(8,2)) END AS DiscountPct,
    CASE
    WHEN  DiscountPct='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(8,2))
    ELSE 
    cast(cast(coalesce(trim(DiscountPct),'-1') AS VARCHAR(20)) AS DECIMAL(8,2)) END AS DiscountPct,


	--CASE WHEN Type1 ='NULL' THEN 'N/A' ELSE Type1 END AS Type1,
    CASE 
    WHEN  Type1='NULL'
    THEN cast('N/A' AS VARCHAR(64))
    ELSE
    cast(coalesce(trim(Type1),'N/A') AS VARCHAR(64)) END AS  Type1,

	--CASE WHEN Category ='NULL' THEN 'N/A' ELSE Category END AS Category,
    CASE 
    WHEN  Category='NULL'
    THEN cast('N/A' AS VARCHAR(64))
    ELSE
    cast(coalesce(trim(Category),'N/A') AS VARCHAR(64)) END AS  Category,

	--CASE WHEN StartDate1 = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(StartDate1,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS StartDate,
    CASE
    WHEN StartDate1 = 'NULL'
    THEN cast ('1900-01-01' as TIMESTAMP)
    ELSE
    cast(coalesce(StartDate1,to_date('1900-01-01')) as TIMESTAMP) end StartDate,

	--CASE WHEN EndDate1 = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(EndDate1,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS EndDate,
    CASE
    WHEN EndDate1 = 'NULL'
    THEN cast ('1900-01-01' as TIMESTAMP)
    ELSE
    cast(coalesce(EndDate1,to_date('1900-01-01')) as TIMESTAMP) end EndDate,

    --CASE WHEN MinQty ='NULL' THEN -1 ELSE MinQty END AS MinQty,
    CASE
    WHEN  MinQty='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(MinQty),'-1') AS VARCHAR(20)) AS INT) END AS MinQty,

	--CASE WHEN MaxQty ='NULL' THEN -1 ELSE MaxQty END AS MaxQty
    CASE
    WHEN  MaxQty='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(MaxQty),'-1') AS VARCHAR(20)) AS INT) END AS MaxQty

FROM Dp_Stg1.Sales_April_11_20;


INSERT INTO DP_STG2.SpecialOffer

SELECT DISTINCT 
  --CASE WHEN SpecialOfferID1 ='NULL' THEN -1 ELSE SpecialOfferID1 END AS SpecialOfferID1,
    CASE
    WHEN  SpecialOfferID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(SpecialOfferID1),'-1') AS VARCHAR(20)) AS INT) END AS SpecialOfferID1,

	--CASE WHEN Description ='NULL' THEN 'N/A' ELSE Description END AS Description,
    CASE 
    WHEN  Description='NULL'
    THEN cast('N/A' AS VARCHAR(256))
    ELSE
    cast(coalesce(trim(Description),'N/A') AS VARCHAR(256)) END AS  Description,

	--CASE WHEN DiscountPct ='NULL' THEN -1 ELSE CAST(DiscountPct AS DECIMAL(8,2)) END AS DiscountPct,
    CASE
    WHEN  DiscountPct='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(8,2))
    ELSE 
    cast(cast(coalesce(trim(DiscountPct),'-1') AS VARCHAR(20)) AS DECIMAL(8,2)) END AS DiscountPct,


	--CASE WHEN Type1 ='NULL' THEN 'N/A' ELSE Type1 END AS Type1,
    CASE 
    WHEN  Type1='NULL'
    THEN cast('N/A' AS VARCHAR(64))
    ELSE
    cast(coalesce(trim(Type1),'N/A') AS VARCHAR(64)) END AS  Type1,

	--CASE WHEN Category ='NULL' THEN 'N/A' ELSE Category END AS Category,
    CASE 
    WHEN  Category='NULL'
    THEN cast('N/A' AS VARCHAR(64))
    ELSE
    cast(coalesce(trim(Category),'N/A') AS VARCHAR(64)) END AS  Category,

	--CASE WHEN StartDate1 = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(StartDate1,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS StartDate,
    CASE
    WHEN StartDate1 = 'NULL'
    THEN cast ('1900-01-01' as TIMESTAMP)
    ELSE
    cast(coalesce(StartDate1,to_date('1900-01-01')) as TIMESTAMP) end StartDate,

	--CASE WHEN EndDate1 = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(EndDate1,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS EndDate,
    CASE
    WHEN EndDate1 = 'NULL'
    THEN cast ('1900-01-01' as TIMESTAMP)
    ELSE
    cast(coalesce(EndDate1,to_date('1900-01-01')) as TIMESTAMP) end EndDate,

    --CASE WHEN MinQty ='NULL' THEN -1 ELSE MinQty END AS MinQty,
    CASE
    WHEN  MinQty='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(MinQty),'-1') AS VARCHAR(20)) AS INT) END AS MinQty,

	--CASE WHEN MaxQty ='NULL' THEN -1 ELSE MaxQty END AS MaxQty
    CASE
    WHEN  MaxQty='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(MaxQty),'-1') AS VARCHAR(20)) AS INT) END AS MaxQty

FROM Dp_Stg1.Sales_April_21_30;


INSERT INTO DP_STG2.SpecialOffer

SELECT DISTINCT 
  --CASE WHEN SpecialOfferID1 ='NULL' THEN -1 ELSE SpecialOfferID1 END AS SpecialOfferID1,
    CASE
    WHEN  SpecialOfferID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(SpecialOfferID1),'-1') AS VARCHAR(20)) AS INT) END AS SpecialOfferID1,

	--CASE WHEN Description ='NULL' THEN 'N/A' ELSE Description END AS Description,
    CASE 
    WHEN  Description='NULL'
    THEN cast('N/A' AS VARCHAR(256))
    ELSE
    cast(coalesce(trim(Description),'N/A') AS VARCHAR(256)) END AS  Description,

	--CASE WHEN DiscountPct ='NULL' THEN -1 ELSE CAST(DiscountPct AS DECIMAL(8,2)) END AS DiscountPct,
    CASE
    WHEN  DiscountPct='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(8,2))
    ELSE 
    cast(cast(coalesce(trim(DiscountPct),'-1') AS VARCHAR(20)) AS DECIMAL(8,2)) END AS DiscountPct,


	--CASE WHEN Type1 ='NULL' THEN 'N/A' ELSE Type1 END AS Type1,
    CASE 
    WHEN  Type1='NULL'
    THEN cast('N/A' AS VARCHAR(64))
    ELSE
    cast(coalesce(trim(Type1),'N/A') AS VARCHAR(64)) END AS  Type1,

	--CASE WHEN Category ='NULL' THEN 'N/A' ELSE Category END AS Category,
    CASE 
    WHEN  Category='NULL'
    THEN cast('N/A' AS VARCHAR(64))
    ELSE
    cast(coalesce(trim(Category),'N/A') AS VARCHAR(64)) END AS  Category,

	--CASE WHEN StartDate1 = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(StartDate1,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS StartDate,
    CASE
    WHEN StartDate1 = 'NULL'
    THEN cast ('1900-01-01' as TIMESTAMP)
    ELSE
    cast(coalesce(StartDate1,to_date('1900-01-01')) as TIMESTAMP) end StartDate,

	--CASE WHEN EndDate1 = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(EndDate1,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS EndDate,
    CASE
    WHEN EndDate1 = 'NULL'
    THEN cast ('1900-01-01' as TIMESTAMP)
    ELSE
    cast(coalesce(EndDate1,to_date('1900-01-01')) as TIMESTAMP) end EndDate,

    --CASE WHEN MinQty ='NULL' THEN -1 ELSE MinQty END AS MinQty,
    CASE
    WHEN  MinQty='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(MinQty),'-1') AS VARCHAR(20)) AS INT) END AS MinQty,

	--CASE WHEN MaxQty ='NULL' THEN -1 ELSE MaxQty END AS MaxQty
    CASE
    WHEN  MaxQty='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(MaxQty),'-1') AS VARCHAR(20)) AS INT) END AS MaxQty

FROM Dp_Stg1.Sales_May_06_10;


INSERT INTO DP_STG2.SpecialOffer

SELECT DISTINCT 
  --CASE WHEN SpecialOfferID1 ='NULL' THEN -1 ELSE SpecialOfferID1 END AS SpecialOfferID1,
    CASE
    WHEN  SpecialOfferID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(SpecialOfferID1),'-1') AS VARCHAR(20)) AS INT) END AS SpecialOfferID1,

	--CASE WHEN Description ='NULL' THEN 'N/A' ELSE Description END AS Description,
    CASE 
    WHEN  Description='NULL'
    THEN cast('N/A' AS VARCHAR(256))
    ELSE
    cast(coalesce(trim(Description),'N/A') AS VARCHAR(256)) END AS  Description,

	--CASE WHEN DiscountPct ='NULL' THEN -1 ELSE CAST(DiscountPct AS DECIMAL(8,2)) END AS DiscountPct,
    CASE
    WHEN  DiscountPct='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(8,2))
    ELSE 
    cast(cast(coalesce(trim(DiscountPct),'-1') AS VARCHAR(20)) AS DECIMAL(8,2)) END AS DiscountPct,


	--CASE WHEN Type1 ='NULL' THEN 'N/A' ELSE Type1 END AS Type1,
    CASE 
    WHEN  Type1='NULL'
    THEN cast('N/A' AS VARCHAR(64))
    ELSE
    cast(coalesce(trim(Type1),'N/A') AS VARCHAR(64)) END AS  Type1,

	--CASE WHEN Category ='NULL' THEN 'N/A' ELSE Category END AS Category,
    CASE 
    WHEN  Category='NULL'
    THEN cast('N/A' AS VARCHAR(64))
    ELSE
    cast(coalesce(trim(Category),'N/A') AS VARCHAR(64)) END AS  Category,

	--CASE WHEN StartDate1 = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(StartDate1,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS StartDate,
    CASE
    WHEN StartDate1 = 'NULL'
    THEN cast ('1900-01-01' as TIMESTAMP)
    ELSE
    cast(coalesce(StartDate1,to_date('1900-01-01')) as TIMESTAMP) end StartDate,

	--CASE WHEN EndDate1 = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(EndDate1,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS EndDate,
    CASE
    WHEN EndDate1 = 'NULL'
    THEN cast ('1900-01-01' as TIMESTAMP)
    ELSE
    cast(coalesce(EndDate1,to_date('1900-01-01')) as TIMESTAMP) end EndDate,

    --CASE WHEN MinQty ='NULL' THEN -1 ELSE MinQty END AS MinQty,
    CASE
    WHEN  MinQty='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(MinQty),'-1') AS VARCHAR(20)) AS INT) END AS MinQty,

	--CASE WHEN MaxQty ='NULL' THEN -1 ELSE MaxQty END AS MaxQty
    CASE
    WHEN  MaxQty='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(MaxQty),'-1') AS VARCHAR(20)) AS INT) END AS MaxQty

FROM Dp_Stg1.Sales_May_11_20;


INSERT INTO DP_STG2.SpecialOffer

SELECT DISTINCT

  --CASE WHEN SpecialOfferID1 ='NULL' THEN -1 ELSE SpecialOfferID1 END AS SpecialOfferID1,
    CASE
    WHEN  SpecialOfferID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(SpecialOfferID1),'-1') AS VARCHAR(20)) AS INT) END AS SpecialOfferID1,

	--CASE WHEN Description ='NULL' THEN 'N/A' ELSE Description END AS Description,
    CASE 
    WHEN  Description='NULL'
    THEN cast('N/A' AS VARCHAR(256))
    ELSE
    cast(coalesce(trim(Description),'N/A') AS VARCHAR(256)) END AS  Description,

	--CASE WHEN DiscountPct ='NULL' THEN -1 ELSE CAST(DiscountPct AS DECIMAL(8,2)) END AS DiscountPct,
    CASE
    WHEN  DiscountPct='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(8,2))
    ELSE 
    cast(cast(coalesce(trim(DiscountPct),'-1') AS VARCHAR(20)) AS DECIMAL(8,2)) END AS DiscountPct,


	--CASE WHEN Type1 ='NULL' THEN 'N/A' ELSE Type1 END AS Type1,
    CASE 
    WHEN  Type1='NULL'
    THEN cast('N/A' AS VARCHAR(64))
    ELSE
    cast(coalesce(trim(Type1),'N/A') AS VARCHAR(64)) END AS  Type1,

	--CASE WHEN Category ='NULL' THEN 'N/A' ELSE Category END AS Category,
    CASE 
    WHEN  Category='NULL'
    THEN cast('N/A' AS VARCHAR(64))
    ELSE
    cast(coalesce(trim(Category),'N/A') AS VARCHAR(64)) END AS  Category,

	--CASE WHEN StartDate1 = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(StartDate1,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS StartDate,
    CASE
    WHEN StartDate1 = 'NULL'
    THEN cast ('1900-01-01' as TIMESTAMP)
    ELSE
    cast(coalesce(StartDate1,to_date('1900-01-01')) as TIMESTAMP) end StartDate,

	--CASE WHEN EndDate1 = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(EndDate1,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS EndDate,
    CASE
    WHEN EndDate1 = 'NULL'
    THEN cast ('1900-01-01' as TIMESTAMP)
    ELSE
    cast(coalesce(EndDate1,to_date('1900-01-01')) as TIMESTAMP) end EndDate,

    --CASE WHEN MinQty ='NULL' THEN -1 ELSE MinQty END AS MinQty,
    CASE
    WHEN  MinQty='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(MinQty),'-1') AS VARCHAR(20)) AS INT) END AS MinQty,

	--CASE WHEN MaxQty ='NULL' THEN -1 ELSE MaxQty END AS MaxQty
    CASE
    WHEN  MaxQty='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(MaxQty),'-1') AS VARCHAR(20)) AS INT) END AS MaxQty

FROM Dp_Stg1.Sales_May_21_31;



--Checking if the data have been loaded in to the target table or not
--It should return 4 Rows

SELECT * 
FROM dp_stg2.specialoffer;


--Issue resolved by this overwrite distinct (it was because of union)
INSERT OVERWRITE TABLE dp_stg2.specialoffer
SELECT DISTINCT * FROM dp_stg2.specialoffer;


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------