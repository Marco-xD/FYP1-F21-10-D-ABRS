--3) SALES TABLES ACCORDING TO SCHEMA

--TOTAL TABLES=18

--1)CreditCard  --412 but 392 (DONE)
--2)Currency    -- 1 Row of currency type (DONE)        IN THIS FILE
--3)CurrencyRate --87 but 75 (DONE)                     IN THIS FILE
--4)Customer     --19820 ROWS (DONE)                    IN THIS FILE
--5)PersonCreditCard  (Zaeem) --412 but 392 (DONE)
--6)SalesOrderDetail                                    IN THIS FILE     
--7)SalesOrderHeader         -- 905 ROWS (DONE)         IN THIS FILE
--8)SalesOrderHeaderSalesReason (zaeem)--646 but 690 (DONE)DD
--9)SalesPerson   (zaeem)               --17 but 80 (DONE) DD
--10)SalesPersonQuotaHistory (Zaeem)   --139 rows (DONE)
--11)SalesReason    (Zaeem)            --3 Rows(DONE)
--12)SalesTaxRate(zaeeem)           -- 29 Rows(DONE)
--13)SalesTerritory (zaeem)         -- 10 but 57 (DONE)
--14)SalesTerritoryHistory (zaeem)  --396 Rows (DONE)
--15)ShoppingCartItem  (zaeem)      --3 ROWS (DONE) (Not necessary but made table and loaded data)  IN THIS FILE
--16)SpecialOffer                   --4 Rows (DONE)
--17)SpecialOfferProduct            -- 65 ROWS (DONE)   IN THIS FILE
--18)Store                          --701 ROWS (DONE)   IN THIS FILE

------------------------------------------------------------------------------------------

--We are cleansing the data (Removing NULL values and Empty Rows by using constraints) and assigining data types
--The input is stage 1 layer and populating into different tables according to business (Schema)
--Also making surrogate keys where required.
--Loading data in same format in the target Table
--Using constraints.

--This File contains The following Tables DDL and DML

--11) Currency Table
--12) CurrencyRate Table
--13) Customer Table
--14) SpecialOfferProduct Table
--15) Store Table
--16) ShoppingCartItem Table
--17)) salesOrderHeader Table
--18) SalesOrderDetail Table





-----------------------------------------------------------------------------------------
--11) Currency Table
-- According to Schema

---------------------------------------------------------

--Dropping the table if there is any issue while loading the data into the target table

DROP TABLE DP_STG2.Currency;


--Refreshing the table after inserting the data into the table 

REFRESH dp_stg2.currency;


--Creating the currency table total 2 columns
--1) CurrencyCode, 2)Name1

	CREATE TABLE dp_stg2.currency
	(
		CurrencyCode CHAR(3),
		Name1 VARCHAR(64) 
	);


--Inserting data into the table from the source table and removing NULL from the source table
--Cleaning the Data and defining data types.
	
INSERT INTO DP_STG2.Currency
SELECT DISTINCT 
	--CASE WHEN CurrencyCode = 'NULL' THEN -1 ELSE CAST(CurrencyCode AS CHAR(6)) END AS  CurrencyCode,
    CASE 
    WHEN CurrencyCode='NULL'
    THEN cast('N/A' AS CHAR(3))
    ELSE
    cast(coalesce(trim(CurrencyCode),'N/A') AS CHAR(3)) END AS CurrencyCode,


	--CASE WHEN Name2 = 'NULL' THEN 'N/A' ELSE Name2 END AS Name1
    CASE 
    WHEN Name2='NULL'
    THEN cast('N/A' AS VARCHAR(64))
    ELSE
    cast(coalesce(trim(Name2),'N/A') AS VARCHAR(64)) END AS Name1

FROM Dp_Stg1.Sales_May_06_10;



--Checking if the data have been loaded in to the target table or not
--It should return 1 Row

SELECT *
FROM DP_STG2.Currency;

--Issue resolved by this overwrite distinct (it was because of union)
--Removing 'N/A'
INSERT OVERWRITE TABLE dp_stg2.Currency
SELECT DISTINCT * FROM dp_stg2.Currency
 WHERE Name1 <> 'N/A';

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------



--12) CurrencyRate Table
--According to Schema

----------------------------------------------------------------------------------------------

--Dropping the table if there is any issue while loading the data into the target table

DROP TABLE DP_STG2.CurrencyRate;

--Refreshing the table after inserting the data into the table 

REFRESH dp_stg2.currencyrate;

--Creating the currencyrate table total 6 columns
--1) CurrencyRateID, 2)CurrencyRateDate, 3)FromCurrencyCode, 4)ToCurrencyCode, 5)AverageRate, 6) EndOfDayRate


CREATE TABLE dp_stg2.CurrencyRate
(
    CurrencyRateID INT,
	CurrencyRateDate TIMESTAMP,
	FromCurrencyCode VARCHAR(4),
	ToCurrencyCode VARCHAR(4),
	AverageRate DECIMAL(8,2),
	EndOfDayRate DECIMAL(8,2) 
);




--Inserting data into the table from the source table and removing NULL from the source table
--Cleaning the Data and defining data types.

INSERT INTO DP_STG2.CurrencyRate
SELECT DISTINCT 
	--CASE WHEN CurrencyRateID1='NULL' THEN -1 ELSE CurrencyRateID1 END AS CurrencyRateID1,
    CASE
    WHEN  CurrencyRateID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(CurrencyRateID1),'-1') AS VARCHAR(20)) AS INT) END AS CurrencyRateID1,

	--CASE WHEN CurrencyRateDate = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(CurrencyRateDate,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS CurrencyRateDate,
    CASE
    WHEN CurrencyRateDate = 'NULL'
    THEN cast ('1900-01-01' as TIMESTAMP)
    ELSE
    cast(coalesce(CurrencyRateDate,to_date('1900-01-01')) as TIMESTAMP) end CurrencyRateDate,

	--CASE WHEN FromCurrencyCode = 'NULL' THEN '-1' ELSE FromCurrencyCode END AS FromCurrencyCode,
    CASE 
    WHEN  FromCurrencyCode='NULL'
    THEN cast('N/A' AS VARCHAR(4))
    ELSE
    cast(coalesce(trim(FromCurrencyCode),'N/A') AS VARCHAR(4)) END AS  FromCurrencyCode,

	--CASE WHEN ToCurrencyCode = 'NULL' THEN '-1' ELSE ToCurrencyCode END AS ToCurrencyCode,
    CASE 
    WHEN  ToCurrencyCode='NULL'
    THEN cast('-1' AS VARCHAR(4))
    ELSE
    cast(coalesce(trim(ToCurrencyCode),'-1') AS VARCHAR(4)) END AS  ToCurrencyCode,


CASE AverageRate
    WHEN 'NULL' then cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(8,2))
    WHEN '' then cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(8,2))
    ELSE 
    cast(cast(coalesce(trim(AverageRate),'-1') AS VARCHAR(20)) AS DECIMAL(8,2)) END AS AverageRate,
    
CASE EndOfDayRate
    WHEN 'NULL' then cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(8,2))
    WHEN '' then cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(8,2))
    ELSE 
    cast(cast(coalesce(trim(EndOfDayRate),'-1') AS VARCHAR(20)) AS DECIMAL(8,2)) END AS EndOfDayRate

	--CASE WHEN AverageRate='NULL' THEN -1 ELSE CAST(AverageRate AS DECIMAL(8,2)) END AS AverageRate,
   /* CASE
    WHEN  AverageRate='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(14,2))
    ELSE 
    cast(cast(coalesce(trim(AverageRate),'-1') AS VARCHAR(20)) AS DECIMAL(14,2)) END AS AverageRate,*/

	--CASE WHEN EndOfDayRate='NULL' THEN -1 ELSE CAST(EndOfDayRate AS DECIMAL(8,2)) END AS EndOfDayRate
  /*  CASE
    WHEN  EndOfDayRate='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(14,2))
    ELSE 
    cast(cast(coalesce(trim(EndOfDayRate),'-1') AS VARCHAR(20)) AS DECIMAL(14,2)) END AS EndOfDayRate*/
    
    
FROM Dp_Stg1.Sales_April_1_10;
 --DONE

/*SELECT AverageRate
FROM dp_stg1.sales_april_1_10
where AverageRate <> 'NULL';*/



INSERT INTO DP_STG2.CurrencyRate
SELECT DISTINCT 

	--CASE WHEN CurrencyRateID1='NULL' THEN -1 ELSE CurrencyRateID1 END AS CurrencyRateID1,
    CASE
    WHEN  CurrencyRateID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(CurrencyRateID1),'-1') AS VARCHAR(20)) AS INT) END AS CurrencyRateID1,

	--CASE WHEN CurrencyRateDate = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(CurrencyRateDate,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS CurrencyRateDate,
    CASE
    WHEN CurrencyRateDate = 'NULL'
    THEN cast ('1900-01-01' as TIMESTAMP)
    ELSE
    cast(coalesce(CurrencyRateDate,to_date('1900-01-01')) as TIMESTAMP) end CurrencyRateDate,

	--CASE WHEN FromCurrencyCode = 'NULL' THEN '-1' ELSE FromCurrencyCode END AS FromCurrencyCode,
    CASE 
    WHEN  FromCurrencyCode='NULL'
    THEN cast('N/A' AS VARCHAR(4))
    ELSE
    cast(coalesce(trim(FromCurrencyCode),'N/A') AS VARCHAR(4)) END AS  FromCurrencyCode,

	--CASE WHEN ToCurrencyCode = 'NULL' THEN '-1' ELSE ToCurrencyCode END AS ToCurrencyCode,
    CASE 
    WHEN  ToCurrencyCode='NULL'
    THEN cast('-1' AS VARCHAR(4))
    ELSE
    cast(coalesce(trim(ToCurrencyCode),'-1') AS VARCHAR(4)) END AS  ToCurrencyCode,

	--CASE WHEN AverageRate='NULL' THEN -1 ELSE CAST(AverageRate AS DECIMAL(8,2)) END AS AverageRate,
    CASE
    WHEN  AverageRate='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(8,2))
    ELSE 
    cast(cast(coalesce(trim(AverageRate),'-1') AS VARCHAR(20)) AS DECIMAL(8,2)) END AS AverageRate,

	--CASE WHEN EndOfDayRate='NULL' THEN -1 ELSE CAST(EndOfDayRate AS DECIMAL(8,2)) END AS EndOfDayRate
    CASE
    WHEN  EndOfDayRate='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(8,2))
    ELSE 
    cast(cast(coalesce(trim(EndOfDayRate),'-1') AS VARCHAR(20)) AS DECIMAL(8,2)) END AS EndOfDayRate
    
    
FROM Dp_Stg1.Sales_April_11_20;


INSERT INTO DP_STG2.CurrencyRate

SELECT DISTINCT 
	--CASE WHEN CurrencyRateID1='NULL' THEN -1 ELSE CurrencyRateID1 END AS CurrencyRateID1,
    CASE
    WHEN  CurrencyRateID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(CurrencyRateID1),'-1') AS VARCHAR(20)) AS INT) END AS CurrencyRateID1,

	--CASE WHEN CurrencyRateDate = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(CurrencyRateDate,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS CurrencyRateDate,
    CASE
    WHEN CurrencyRateDate = 'NULL'
    THEN cast ('1900-01-01' as TIMESTAMP)
    ELSE
    cast(coalesce(CurrencyRateDate,to_date('1900-01-01')) as TIMESTAMP) end CurrencyRateDate,

	--CASE WHEN FromCurrencyCode = 'NULL' THEN '-1' ELSE FromCurrencyCode END AS FromCurrencyCode,
    CASE 
    WHEN  FromCurrencyCode='NULL'
    THEN cast('N/A' AS VARCHAR(4))
    ELSE
    cast(coalesce(trim(FromCurrencyCode),'N/A') AS VARCHAR(4)) END AS  FromCurrencyCode,

	--CASE WHEN ToCurrencyCode = 'NULL' THEN '-1' ELSE ToCurrencyCode END AS ToCurrencyCode,
    CASE 
    WHEN  ToCurrencyCode='NULL'
    THEN cast('-1' AS VARCHAR(4))
    ELSE
    cast(coalesce(trim(ToCurrencyCode),'-1') AS VARCHAR(4)) END AS  ToCurrencyCode,

	--CASE WHEN AverageRate='NULL' THEN -1 ELSE CAST(AverageRate AS DECIMAL(8,2)) END AS AverageRate,
    CASE
    WHEN  AverageRate='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(8,2))
    ELSE 
    cast(cast(coalesce(trim(AverageRate),'-1') AS VARCHAR(20)) AS DECIMAL(8,2)) END AS AverageRate,

	--CASE WHEN EndOfDayRate='NULL' THEN -1 ELSE CAST(EndOfDayRate AS DECIMAL(8,2)) END AS EndOfDayRate
    CASE
    WHEN  EndOfDayRate='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(8,2))
    ELSE 
    cast(cast(coalesce(trim(EndOfDayRate),'-1') AS VARCHAR(20)) AS DECIMAL(8,2)) END AS EndOfDayRate
FROM Dp_Stg1.Sales_April_21_30;


INSERT INTO DP_STG2.CurrencyRate
SELECT DISTINCT 
	--CASE WHEN CurrencyRateID1='NULL' THEN -1 ELSE CurrencyRateID1 END AS CurrencyRateID1,
    CASE
    WHEN  CurrencyRateID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(CurrencyRateID1),'-1') AS VARCHAR(20)) AS INT) END AS CurrencyRateID1,

	--CASE WHEN CurrencyRateDate = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(CurrencyRateDate,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS CurrencyRateDate,
    CASE
    WHEN CurrencyRateDate = 'NULL'
    THEN cast ('1900-01-01' as TIMESTAMP)
    ELSE
    cast(coalesce(CurrencyRateDate,to_date('1900-01-01')) as TIMESTAMP) end CurrencyRateDate,

	--CASE WHEN FromCurrencyCode = 'NULL' THEN '-1' ELSE FromCurrencyCode END AS FromCurrencyCode,
    CASE 
    WHEN  FromCurrencyCode='NULL'
    THEN cast('N/A' AS VARCHAR(4))
    ELSE
    cast(coalesce(trim(FromCurrencyCode),'N/A') AS VARCHAR(4)) END AS  FromCurrencyCode,

	--CASE WHEN ToCurrencyCode = 'NULL' THEN '-1' ELSE ToCurrencyCode END AS ToCurrencyCode,
    CASE 
    WHEN  ToCurrencyCode='NULL'
    THEN cast('-1' AS VARCHAR(4))
    ELSE
    cast(coalesce(trim(ToCurrencyCode),'-1') AS VARCHAR(4)) END AS  ToCurrencyCode,

	--CASE WHEN AverageRate='NULL' THEN -1 ELSE CAST(AverageRate AS DECIMAL(8,2)) END AS AverageRate,
    CASE
    WHEN  AverageRate='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(8,2))
    ELSE 
    cast(cast(coalesce(trim(AverageRate),'-1') AS VARCHAR(20)) AS DECIMAL(8,2)) END AS AverageRate,

	--CASE WHEN EndOfDayRate='NULL' THEN -1 ELSE CAST(EndOfDayRate AS DECIMAL(8,2)) END AS EndOfDayRate
    CASE
    WHEN  EndOfDayRate='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(8,2))
    ELSE 
    cast(cast(coalesce(trim(EndOfDayRate),'-1') AS VARCHAR(20)) AS DECIMAL(8,2)) END AS EndOfDayRate
FROM Dp_Stg1.Sales_May_06_10;


INSERT INTO DP_STG2.CurrencyRate
SELECT DISTINCT 
	--CASE WHEN CurrencyRateID1='NULL' THEN -1 ELSE CurrencyRateID1 END AS CurrencyRateID1,
    CASE
    WHEN  CurrencyRateID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(CurrencyRateID1),'-1') AS VARCHAR(20)) AS INT) END AS CurrencyRateID1,

	--CASE WHEN CurrencyRateDate = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(CurrencyRateDate,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS CurrencyRateDate,
    CASE
    WHEN CurrencyRateDate = 'NULL'
    THEN cast ('1900-01-01' as TIMESTAMP)
    ELSE
    cast(coalesce(CurrencyRateDate,to_date('1900-01-01')) as TIMESTAMP) end CurrencyRateDate,

	--CASE WHEN FromCurrencyCode = 'NULL' THEN '-1' ELSE FromCurrencyCode END AS FromCurrencyCode,
    CASE 
    WHEN  FromCurrencyCode='NULL'
    THEN cast('N/A' AS VARCHAR(4))
    ELSE
    cast(coalesce(trim(FromCurrencyCode),'N/A') AS VARCHAR(4)) END AS  FromCurrencyCode,

	--CASE WHEN ToCurrencyCode = 'NULL' THEN '-1' ELSE ToCurrencyCode END AS ToCurrencyCode,
    CASE 
    WHEN  ToCurrencyCode='NULL'
    THEN cast('-1' AS VARCHAR(4))
    ELSE
    cast(coalesce(trim(ToCurrencyCode),'-1') AS VARCHAR(4)) END AS  ToCurrencyCode,

	--CASE WHEN AverageRate='NULL' THEN -1 ELSE CAST(AverageRate AS DECIMAL(8,2)) END AS AverageRate,
    CASE
    WHEN  AverageRate='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(8,2))
    ELSE 
    cast(cast(coalesce(trim(AverageRate),'-1') AS VARCHAR(20)) AS DECIMAL(8,2)) END AS AverageRate,

	--CASE WHEN EndOfDayRate='NULL' THEN -1 ELSE CAST(EndOfDayRate AS DECIMAL(8,2)) END AS EndOfDayRate
    CASE
    WHEN  EndOfDayRate='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(8,2))
    ELSE 
    cast(cast(coalesce(trim(EndOfDayRate),'-1') AS VARCHAR(20)) AS DECIMAL(8,2)) END AS EndOfDayRate
FROM Dp_Stg1.Sales_May_11_20;


INSERT INTO DP_STG2.CurrencyRate
SELECT DISTINCT 
	--CASE WHEN CurrencyRateID1='NULL' THEN -1 ELSE CurrencyRateID1 END AS CurrencyRateID1,
    CASE
    WHEN  CurrencyRateID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(CurrencyRateID1),'-1') AS VARCHAR(20)) AS INT) END AS CurrencyRateID1,

	--CASE WHEN CurrencyRateDate = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(CurrencyRateDate,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS CurrencyRateDate,
    CASE
    WHEN CurrencyRateDate = 'NULL'
    THEN cast ('1900-01-01' as TIMESTAMP)
    ELSE
    cast(coalesce(CurrencyRateDate,to_date('1900-01-01')) as TIMESTAMP) end CurrencyRateDate,

	--CASE WHEN FromCurrencyCode = 'NULL' THEN '-1' ELSE FromCurrencyCode END AS FromCurrencyCode,
    CASE 
    WHEN  FromCurrencyCode='NULL'
    THEN cast('N/A' AS VARCHAR(4))
    ELSE
    cast(coalesce(trim(FromCurrencyCode),'N/A') AS VARCHAR(4)) END AS  FromCurrencyCode,

	--CASE WHEN ToCurrencyCode = 'NULL' THEN '-1' ELSE ToCurrencyCode END AS ToCurrencyCode,
    CASE 
    WHEN  ToCurrencyCode='NULL'
    THEN cast('-1' AS VARCHAR(4))
    ELSE
    cast(coalesce(trim(ToCurrencyCode),'-1') AS VARCHAR(4)) END AS  ToCurrencyCode,

	--CASE WHEN AverageRate='NULL' THEN -1 ELSE CAST(AverageRate AS DECIMAL(8,2)) END AS AverageRate,
    CASE
    WHEN  AverageRate='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(8,2))
    ELSE 
    cast(cast(coalesce(trim(AverageRate),'-1') AS VARCHAR(20)) AS DECIMAL(8,2)) END AS AverageRate,

	--CASE WHEN EndOfDayRate='NULL' THEN -1 ELSE CAST(EndOfDayRate AS DECIMAL(8,2)) END AS EndOfDayRate
    CASE
    WHEN  EndOfDayRate='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(8,2))
    ELSE 
    cast(cast(coalesce(trim(EndOfDayRate),'-1') AS VARCHAR(20)) AS DECIMAL(8,2)) END AS EndOfDayRate
FROM Dp_Stg1.Sales_May_21_31;



--Checking if the data have been loaded in to the target table or not
--It should return 75 Rows

SELECT *
FROM DP_stg2.currencyRate;

--Issue resolved by this overwrite distinct (it was because of union)

INSERT OVERWRITE TABLE dp_stg2.currencyRate
SELECT DISTINCT * FROM dp_stg2.currencyRate;


	



-----------------------------------------------------------------------------------------------------------------------


--13) Customer Table
--According to Schema

----------------------------------------------------------------------------------------------

--Dropping the table if there is any issue while loading the data into the target table

DROP TABLE DP_STG2.Customer;


--Refreshing the table after inserting the data into the table 

REFRESH dp_stg2.customer;

--Creating the customer table total 5 columns
--1) CustomerID, 2)PersonID, 3)StoreID, 4)TerritoryID, 5)AccountNumber


CREATE TABLE dp_stg2.Customer
(
	 CustomerID INT,
	 PersonID INT ,
	 StoreID INT,
	 TerritoryID INT,
	 AccountNumber VARCHAR(32)
);





--Inserting data into the table from the source table and removing NULL from the source table
--Cleaning the Data and defining data types.

INSERT INTO DP_STG2.Customer
SELECT DISTINCT 
 --CASE WHEN  CustomerID ='NULL' THEN -1 ELSE  CustomerID END AS  CustomerID,
 CASE
    WHEN  CustomerID='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( CustomerID),'-1') AS VARCHAR(20)) AS INT) END AS  CustomerID,

    --CASE WHEN  PersonID  = 'NULL' THEN -1 ELSE  PersonID END AS PersonID,
    CASE
    WHEN  PersonID='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( PersonID),'-1') AS VARCHAR(20)) AS INT) END AS  PersonID,

	--CASE WHEN  StoreID  = 'NULL'  THEN -1 ELSE  StoreID END AS StoreID,
    CASE
    WHEN  StoreID='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( StoreID),'-1') AS VARCHAR(20)) AS INT) END AS  StoreID,

	--CASE WHEN  TerritoryID = 'NULL' THEN -1 ELSE  TerritoryID END AS TerritoryID,
    CASE
    WHEN  TerritoryID='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( TerritoryID),'-1') AS VARCHAR(20)) AS INT) END AS  TerritoryID,

	--CASE WHEN AccountNumber = 'NULL' THEN 'N/A' ELSE AccountNumber END AS AccountNumber
    CASE 
    WHEN AccountNumber='NULL'
    THEN cast('N/A' AS VARCHAR(32))
    ELSE
    cast(coalesce(trim(AccountNumber),'N/A') AS VARCHAR(32)) END AS AccountNumber
    
FROM  DP_STG1.Customer_Sales;



--Checking if the data have been loaded in to the target table or not
--It should return 19820 Rows

SELECT *
FROM dp_stg2.customer;

SELECT count(*)
FROM dp_stg2.customer;


------------------------------------------------------------------------------------------------------------------



--14) SpecialOfferProduct Table
--According to Schema

----------------------------------------------------------------------------------------------

--Dropping the table if there is any issue while loading the data into the target table

DROP TABLE DP_STG2.SpecialOfferProduct;

--Refreshing the table after inserting the data into the table 

REFRESH DP_stg2.specialofferproduct;

--Creating the specialofferproduct table total 5 columns
--1) SpecialOfferID, 2)ProductID

CREATE TABLE dp_stg2.SpecialOfferProduct
	(
		SpecialOfferID INT,
		ProductID INT 
	);


--Inserting data into the table from the source table and removing NULL from the source table
--Cleaning the Data and defining data types.


INSERT INTO DP_STG2.SpecialOfferProduct
SELECT DISTINCT 
    --CASE WHEN SpecialOfferID1 ='NULL' THEN -1 ELSE SpecialOfferID1 END AS SpecialOfferID1,
    CASE
    WHEN  SpecialOfferID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(SpecialOfferID1),'-1') AS VARCHAR(20)) AS INT) END AS SpecialOfferID1,
    
    --CASE WHEN ProductID1 ='NULL' THEN -1 ELSE ProductID1 END AS ProductID1
    CASE
    WHEN  ProductID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(ProductID1),'-1') AS VARCHAR(20)) AS INT) END AS ProductID1
FROM Dp_Stg1.Sales;


INSERT INTO DP_STG2.SpecialOfferProduct

SELECT DISTINCT 
	--CASE WHEN SpecialOfferID1 ='NULL' THEN -1 ELSE SpecialOfferID1 END AS SpecialOfferID1,
    CASE
    WHEN  SpecialOfferID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(SpecialOfferID1),'-1') AS VARCHAR(20)) AS INT) END AS SpecialOfferID1,
    
    --CASE WHEN ProductID1 ='NULL' THEN -1 ELSE ProductID1 END AS ProductID1
    CASE
    WHEN  ProductID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(ProductID1),'-1') AS VARCHAR(20)) AS INT) END AS ProductID1
FROM Dp_Stg1.Sales_April_1_10;


INSERT INTO DP_STG2.SpecialOfferProduct

SELECT DISTINCT 
	--CASE WHEN SpecialOfferID1 ='NULL' THEN -1 ELSE SpecialOfferID1 END AS SpecialOfferID1,
    CASE
    WHEN  SpecialOfferID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(SpecialOfferID1),'-1') AS VARCHAR(20)) AS INT) END AS SpecialOfferID1,
    
    --CASE WHEN ProductID1 ='NULL' THEN -1 ELSE ProductID1 END AS ProductID1
    CASE
    WHEN  ProductID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(ProductID1),'-1') AS VARCHAR(20)) AS INT) END AS ProductID1
FROM Dp_Stg1.Sales_April_11_20;



INSERT INTO DP_STG2.SpecialOfferProduct

SELECT DISTINCT 
	--CASE WHEN SpecialOfferID1 ='NULL' THEN -1 ELSE SpecialOfferID1 END AS SpecialOfferID1,
    CASE
    WHEN  SpecialOfferID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(SpecialOfferID1),'-1') AS VARCHAR(20)) AS INT) END AS SpecialOfferID1,
    
    --CASE WHEN ProductID1 ='NULL' THEN -1 ELSE ProductID1 END AS ProductID1
    CASE
    WHEN  ProductID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(ProductID1),'-1') AS VARCHAR(20)) AS INT) END AS ProductID1
FROM Dp_Stg1.Sales_April_21_30;


INSERT INTO DP_STG2.SpecialOfferProduct

SELECT DISTINCT 
	--CASE WHEN SpecialOfferID1 ='NULL' THEN -1 ELSE SpecialOfferID1 END AS SpecialOfferID1,
    CASE
    WHEN  SpecialOfferID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(SpecialOfferID1),'-1') AS VARCHAR(20)) AS INT) END AS SpecialOfferID1,
    
    --CASE WHEN ProductID1 ='NULL' THEN -1 ELSE ProductID1 END AS ProductID1
    CASE
    WHEN  ProductID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(ProductID1),'-1') AS VARCHAR(20)) AS INT) END AS ProductID1
FROM Dp_Stg1.Sales_May_06_10;

INSERT INTO DP_STG2.SpecialOfferProduct

SELECT DISTINCT 
	--CASE WHEN SpecialOfferID1 ='NULL' THEN -1 ELSE SpecialOfferID1 END AS SpecialOfferID1,
    CASE
    WHEN  SpecialOfferID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(SpecialOfferID1),'-1') AS VARCHAR(20)) AS INT) END AS SpecialOfferID1,
    
    --CASE WHEN ProductID1 ='NULL' THEN -1 ELSE ProductID1 END AS ProductID1
    CASE
    WHEN  ProductID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(ProductID1),'-1') AS VARCHAR(20)) AS INT) END AS ProductID1
FROM Dp_Stg1.Sales_May_11_20;


INSERT INTO DP_STG2.SpecialOfferProduct

SELECT DISTINCT 
	--CASE WHEN SpecialOfferID1 ='NULL' THEN -1 ELSE SpecialOfferID1 END AS SpecialOfferID1,
    CASE
    WHEN  SpecialOfferID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(SpecialOfferID1),'-1') AS VARCHAR(20)) AS INT) END AS SpecialOfferID1,
    
    --CASE WHEN ProductID1 ='NULL' THEN -1 ELSE ProductID1 END AS ProductID1
    CASE
    WHEN  ProductID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(ProductID1),'-1') AS VARCHAR(20)) AS INT) END AS ProductID1
FROM Dp_Stg1.Sales_May_21_31;



--Checking if the data have been loaded in to the target table or not
--It should return 65 Rows

SELECT *
FROM DP_STG2.SpecialOfferProduct;


--Issue resolved by this overwrite distinct (it was because of union)


INSERT OVERWRITE TABLE dp_stg2.SpecialOfferProduct
SELECT DISTINCT * FROM dp_stg2.SpecialOfferProduct;


--------------------------------------------------------------------------------------------------------------------

--Comments

--15) Store Table
--According to Schema

----------------------------------------------------------------------------------------------

--Dropping the table if there is any issue while loading the data into the target table

DROP TABLE DP_STG2.Store;
	
--Refreshing the table after inserting the data into the table 

REFRESH dp_stg2.store;

	
--Creating the store table total 4 columns
--1) BusinessEntityID, 2)SalesPersonID, 3)NAME1, 4)DEMOGRAPHICS1
	
CREATE TABLE dp_stg2.Store
(
	BusinessEntityID INT,
	SalesPersonID INT,
	NAME1 VARCHAR(32),
	DEMOGRAPHICS1 VARCHAR(256)
);





--Inserting data into the table from the source table and removing NULL from the source table
--Cleaning the Data and defining data types.

INSERT INTO DP_STG2.Store	
SELECT DISTINCT 
	--CASE WHEN BusinessEntityID='NULL' THEN -1 ELSE BusinessEntityID END AS  BusinessEntityID,
    CASE
    WHEN  BusinessEntityID='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( BusinessEntityID),'-1') AS VARCHAR(20)) AS INT) END AS  BusinessEntityID,
    
	--CASE WHEN SalesPersonID='NULL' THEN -1 ELSE SalesPersonID END AS  SalesPersonID,
    CASE
    WHEN  SalesPersonID='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( SalesPersonID),'-1') AS VARCHAR(20)) AS INT) END AS  SalesPersonID,

	--CASE WHEN Name1='NULL' THEN 'N/A' ELSE Name1 END  AS Name1,
    CASE 
    WHEN Name1='NULL'
    THEN cast('N/A' AS VARCHAR(32))
    ELSE
    cast(coalesce(trim(Name1),'N/A') AS VARCHAR(32)) END AS Name1,

	--CASE WHEN DEMOGRAPHICS = 'NULL' THEN 'N/A' ELSE DEMOGRAPHICS END AS DEMOGRAPHICS
    CASE 
    WHEN DEMOGRAPHICS='NULL'
    THEN cast('N/A' AS VARCHAR(256))
    ELSE
    cast(coalesce(trim(DEMOGRAPHICS),'N/A') AS VARCHAR(256)) END AS DEMOGRAPHICS
FROM Dp_Stg1.Store_Sales;


--Checking if the data have been loaded in to the target table or not
--It should return 701 Rows
SELECT *
FROM DP_STG2.store;



-------------------------------------------------------------------------------------------------------------

--16) ShoppingCartItem Table
--According to Schema

----------------------------------------------------------------------------------------------

--Dropping the table if there is any issue while loading the data into the target table

DROP TABLE DP_STG2.ShoppingCartItem;

--Refreshing the table after inserting the data into the table 

REFRESH dp_stg2.shoppingcartitem;

--Creating the ShoppingCartItem table total 5 columns
--1) ShoppingCartItemID, 2)ShoppingCartID, 3)Quantity, 4)ProductID, 5)DateCreated

	
CREATE TABLE dp_stg2.ShoppingCartItem
(
	ShoppingCartItemID INT ,
	ShoppingCartID VARCHAR(64),
	Quantity INT,  
	ProductID INT,
	DateCreated TIMESTAMP
);
	





--Inserting data into the table from the source table and removing NULL from the source table
--Cleaning the Data and defining data types.

INSERT INTO DP_STG2.ShoppingCartItem
SELECT DISTINCT 
	--CASE WHEN ShoppingCartItemID = 'NULL' THEN -1 ELSE ShoppingCartItemID END AS  ShoppingCartItemID,
    CASE
    WHEN  ShoppingCartItemID='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( ShoppingCartItemID),'-1') AS VARCHAR(20)) AS INT) END AS  ShoppingCartItemID,

	--CASE WHEN ShoppingCartID = 'NULL' THEN -1 ELSE ShoppingCartID END AS ShoppingCartID,
    CASE 
    WHEN ShoppingCartID='NULL'
    THEN cast('N/A' AS VARCHAR(64))
    ELSE
    cast(coalesce(trim(ShoppingCartID),'N/A') AS VARCHAR(64)) END AS ShoppingCartID,

	--CASE WHEN Quantity = 'NULL' THEN -1 ELSE Quantity END AS  Quantity,
    CASE
    WHEN  Quantity='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( Quantity),'-1') AS VARCHAR(20)) AS INT) END AS  Quantity,

	--CASE WHEN ProductID = 'NULL' THEN -1 ELSE ProductID END AS  ProductID,
    CASE
    WHEN  ProductID='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( ProductID),'-1') AS VARCHAR(20)) AS INT) END AS  ProductID,

	--CASE WHEN DateCreated = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(DateCreated,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS DateCreated
    case
    when DateCreated = 'NULL'
    then cast ('1900-01-01' as TIMESTAMP)
    else
    cast(coalesce(DateCreated,to_date('1900-01-01')) as TIMESTAMP) end DateCreated
FROM Dp_Stg1.Shopping_Cart_Item_Sales;


--Checking if the data have been loaded in to the target table or not
--It should return 141 Rows

SELECT *
FROM DP_STG2.ShoppingCartItem;



---------------------------------------------------------------------------------------------------------------

--17)) salesOrderHeader Table
--According to Schema

----------------------------------------------------------------------------------------------

--Dropping the table if there is any issue while loading the data into the target table

DROP TABLE dp_Stg2.SalesOrderHeader;

--Refreshing the table after inserting the data into the table 

REFRESH dp_stg2.salesorderheader;

--Creating the salesorderheader table total 22 columns
--1) BusinessEntityID, 2)SalesOrderID, 3)ShipMethodID, 4)RevisionNumber, 5)OrderDate, 6)DueDate ,7)ShipDate ,8)Status ,9)OnlineOrderFlag , 10)SalesOrderNumber , 11) PurchaseOrderNumber, 12)AccountNumber
-- 13)TerritoryID , 14)BillToAddressID ,15)ShipToAddressID ,16)CreditCardID ,17)CreditCardApprovalCode , 18)CurrencyRateID, 19)SubTotal ,20)TaxAmt ,21)Freight , 22)TotalDue


CREATE TABLE dp_stg2.SalesOrderHeader
	(
		BusinessEntityID	INT,
		SalesOrderID	    INT,
		ShipMethodID	    INT,
		RevisionNumber	    INT,
		OrderDate	        TIMESTAMP,
		DueDate	            TIMESTAMP,
		ShipDate	        TIMESTAMP,
		Status	            TINYINT,
		OnlineOrderFlag	    TINYINT,
		SalesOrderNumber	VARCHAR(16),
		PurchaseOrderNumber	VARCHAR(16),
		AccountNumber	    VARCHAR(16),
		TerritoryID	        INT,
		BillToAddressID	    INT,
		ShipToAddressID	    INT,
		CreditCardID        INT,
		CreditCardApprovalCode VARCHAR(32),
		CurrencyRateID	    INT,
		SubTotal	        DECIMAL (10,2),
		TaxAmt	            DECIMAL (10,2),
		Freight	            DECIMAL (10,2),
		TotalDue	        DECIMAL (10,2)
	);
	




--Inserting data into the table from the source table and removing NULL from the source table
--Cleaning the Data and defining data types.
--Sales
INSERT INTO DP_STG2.SalesOrderHeader
SELECT DISTINCT
--CASE WHEN BusinessEntityID1 = 'NULL' THEN -1 ELSE BusinessEntityID1 END AS BusinessEntityID1,
CASE
    WHEN  BusinessEntityID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( BusinessEntityID1),'-1') AS VARCHAR(20)) AS INT) END AS  BusinessEntityID1,

--CASE WHEN SalesOrderID1 = 'NULL' THEN -1 ELSE SalesOrderID1 END AS SalesOrderID1,
CASE
    WHEN  SalesOrderID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( SalesOrderID1),'-1') AS VARCHAR(20)) AS INT) END AS  SalesOrderID1,

--CASE WHEN ShipMethodID = 'NULL' THEN -1 ELSE ShipMethodID END AS ShipMethodID,
CASE
    WHEN  ShipMethodID='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( ShipMethodID),'-1') AS VARCHAR(20)) AS INT) END AS  ShipMethodID,

--CASE WHEN RevisionNumber = 'NULL' THEN -1 ELSE RevisionNumber END AS RevisionNumber,
CASE
    WHEN  RevisionNumber='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( RevisionNumber),'-1') AS VARCHAR(20)) AS INT) END AS  RevisionNumber,

--CASE WHEN OrderDate = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(OrderDate,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS OrderDate,
case
    when OrderDate = 'NULL'
    then cast ('1900-01-01' as TIMESTAMP)
    else
    cast(coalesce(OrderDate,to_date('1900-01-01')) as TIMESTAMP)
end OrderDate,

--CASE WHEN DueDate = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(DueDate,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS DueDate,
case
    when DueDate = 'NULL'
    then cast ('1900-01-01' as TIMESTAMP)
    else
    cast(coalesce(DueDate,to_date('1900-01-01')) as TIMESTAMP)
end DueDate,

--CASE WHEN ShipDate = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(ShipDate,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS ShipDate,
case
    when ShipDate = 'NULL'
    then cast ('1900-01-01' as TIMESTAMP)
    else
    cast(coalesce(ShipDate,to_date('1900-01-01')) as TIMESTAMP)
end ShipDate,

--CASE WHEN Status = 'NULL' THEN -1 ELSE CAST(Status AS BYTEINT) END AS Status,
CASE
    WHEN  Status='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS TINYINT)
    ELSE 
    cast(cast(coalesce(trim(Status),'-1') AS VARCHAR(20)) AS TINYINT) END AS Status,

--CASE WHEN OnlineOrderFlag = 'NULL' THEN -1 ELSE CAST(OnlineOrderFlag AS BYTEINT) END AS OnlineOrderFlag,
CASE
    WHEN  OnlineOrderFlag='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS TINYINT)
    ELSE 
    cast(cast(coalesce(trim(OnlineOrderFlag),'-1') AS VARCHAR(20)) AS TINYINT) END AS OnlineOrderFlag,

--CASE WHEN SalesOrderNumber IS NULL THEN 'N/A' ELSE SalesOrderNumber END AS SalesOrderNumber,
CASE 
    WHEN SalesOrderNumber='NULL'
    THEN cast('N/A' AS VARCHAR(16))
    ELSE
    cast(coalesce(trim(SalesOrderNumber),'N/A') AS VARCHAR(16)) END AS SalesOrderNumber,

--CASE WHEN PurchaseOrderNumber IS NULL THEN 'N/A' ELSE PurchaseOrderNumber END AS PurchaseOrderNumber,
CASE 
    WHEN PurchaseOrderNumber='NULL'
    THEN cast('N/A' AS VARCHAR(16))
    ELSE
    cast(coalesce(trim(PurchaseOrderNumber),'N/A') AS VARCHAR(16)) END AS PurchaseOrderNumber,

--CASE WHEN AccountNumber= 'NULL' THEN 'N/A' ELSE AccountNumber END AS AccountNumber,
CASE 
    WHEN AccountNumber='NULL'
    THEN cast('N/A' AS VARCHAR(16))
    ELSE
    cast(coalesce(trim(AccountNumber),'N/A') AS VARCHAR(16)) END AS AccountNumber,

--CASE WHEN TerritoryID1 = 'NULL' THEN -1 ELSE TerritoryID1 END AS TerritoryID1,
CASE
    WHEN  TerritoryID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( TerritoryID1),'-1') AS VARCHAR(20)) AS INT) END AS  TerritoryID1,

--CASE WHEN BillToAddressID = 'NULL' THEN -1 ELSE BillToAddressID END AS BillToAddressID,
CASE
    WHEN  BillToAddressID='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( BillToAddressID),'-1') AS VARCHAR(20)) AS INT) END AS  BillToAddressID,

--CASE WHEN ShipToAddressID = 'NULL' THEN -1 ELSE ShipToAddressID END AS ShipToAddressID,
CASE
    WHEN  ShipToAddressID='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( ShipToAddressID),'-1') AS VARCHAR(20)) AS INT) END AS  ShipToAddressID,

--CASE WHEN CreditCardID1 = 'NULL' THEN -1 ELSE CreditCardID1 END AS CreditCardID1,
CASE
    WHEN  CreditCardID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( CreditCardID1),'-1') AS VARCHAR(20)) AS INT) END AS  CreditCardID1,

--CASE WHEN CreditCardApprovalCode IS NULL THEN 'N/A' ELSE CreditCardApprovalCode END AS CreditCardApprovalCode,
CASE 
    WHEN CreditCardApprovalCode='NULL'
    THEN cast('N/A' AS VARCHAR(32))
    ELSE
    cast(coalesce(trim(CreditCardApprovalCode),'N/A') AS VARCHAR(32)) END AS CreditCardApprovalCode,

--CASE WHEN CurrencyRateID1 = 'NULL' THEN -1 ELSE CurrencyRateID1 END AS CurrencyRateID1,
CASE
    WHEN  CurrencyRateID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( CurrencyRateID1),'-1') AS VARCHAR(20)) AS INT) END AS  CurrencyRateID1,

--CASE WHEN  SubTotal = 'NULL' THEN -1 ELSE  CAST(SubTotal AS DECIMAL(10,2)) END AS SubTotal,
CASE
    WHEN   SubTotal='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(SubTotal),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS SubTotal,

--CASE WHEN  TaxAmt = 'NULL' THEN -1 ELSE  CAST(TaxAmt AS DECIMAL(10,2)) END AS TaxAmt,
CASE
    WHEN   TaxAmt='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(TaxAmt),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS TaxAmt,

--CASE WHEN  Freight = 'NULL' THEN -1 ELSE  CAST(Freight AS DECIMAL(10,2)) END AS Freight,
CASE
    WHEN   Freight='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(Freight),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS Freight,

--CASE WHEN  TotalDue = 'NULL' THEN -1 ELSE  CAST(TotalDue AS DECIMAL(10,2)) END AS TotalDue
CASE
    WHEN   TotalDue='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(TotalDue),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS TotalDue

FROM DP_STG1.Sales;


INSERT INTO DP_STG2.SalesOrderHeader

--Sales_April_1_10
--INSERT INTO DP_STG2.SalesOrderHeader
SELECT DISTINCT
--CASE WHEN BusinessEntityID1 = 'NULL' THEN -1 ELSE BusinessEntityID1 END AS BusinessEntityID1,
CASE
    WHEN  BusinessEntityID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( BusinessEntityID1),'-1') AS VARCHAR(20)) AS INT) END AS  BusinessEntityID1,

--CASE WHEN SalesOrderID1 = 'NULL' THEN -1 ELSE SalesOrderID1 END AS SalesOrderID1,
CASE
    WHEN  SalesOrderID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( SalesOrderID1),'-1') AS VARCHAR(20)) AS INT) END AS  SalesOrderID1,

--CASE WHEN ShipMethodID = 'NULL' THEN -1 ELSE ShipMethodID END AS ShipMethodID,
CASE
    WHEN  ShipMethodID='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( ShipMethodID),'-1') AS VARCHAR(20)) AS INT) END AS  ShipMethodID,

--CASE WHEN RevisionNumber = 'NULL' THEN -1 ELSE RevisionNumber END AS RevisionNumber,
CASE
    WHEN  RevisionNumber='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( RevisionNumber),'-1') AS VARCHAR(20)) AS INT) END AS  RevisionNumber,

--CASE WHEN OrderDate = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(OrderDate,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS OrderDate,
case
    when OrderDate = 'NULL'
    then cast ('1900-01-01' as TIMESTAMP)
    else
    cast(coalesce(OrderDate,to_date('1900-01-01')) as TIMESTAMP)
end OrderDate,

--CASE WHEN DueDate = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(DueDate,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS DueDate,
case
    when DueDate = 'NULL'
    then cast ('1900-01-01' as TIMESTAMP)
    else
    cast(coalesce(DueDate,to_date('1900-01-01')) as TIMESTAMP)
end DueDate,

--CASE WHEN ShipDate = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(ShipDate,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS ShipDate,
case
    when ShipDate = 'NULL'
    then cast ('1900-01-01' as TIMESTAMP)
    else
    cast(coalesce(ShipDate,to_date('1900-01-01')) as TIMESTAMP)
end ShipDate,

--CASE WHEN Status = 'NULL' THEN -1 ELSE CAST(Status AS BYTEINT) END AS Status,
CASE
    WHEN  Status='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS TINYINT)
    ELSE 
    cast(cast(coalesce(trim(Status),'-1') AS VARCHAR(20)) AS TINYINT) END AS Status,

--CASE WHEN OnlineOrderFlag = 'NULL' THEN -1 ELSE CAST(OnlineOrderFlag AS BYTEINT) END AS OnlineOrderFlag,
CASE
    WHEN  OnlineOrderFlag='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS TINYINT)
    ELSE 
    cast(cast(coalesce(trim(OnlineOrderFlag),'-1') AS VARCHAR(20)) AS TINYINT) END AS OnlineOrderFlag,

--CASE WHEN SalesOrderNumber IS NULL THEN 'N/A' ELSE SalesOrderNumber END AS SalesOrderNumber,
CASE 
    WHEN SalesOrderNumber='NULL'
    THEN cast('N/A' AS VARCHAR(16))
    ELSE
    cast(coalesce(trim(SalesOrderNumber),'N/A') AS VARCHAR(16)) END AS SalesOrderNumber,

--CASE WHEN PurchaseOrderNumber IS NULL THEN 'N/A' ELSE PurchaseOrderNumber END AS PurchaseOrderNumber,
CASE 
    WHEN PurchaseOrderNumber='NULL'
    THEN cast('N/A' AS VARCHAR(16))
    ELSE
    cast(coalesce(trim(PurchaseOrderNumber),'N/A') AS VARCHAR(16)) END AS PurchaseOrderNumber,

--CASE WHEN AccountNumber= 'NULL' THEN 'N/A' ELSE AccountNumber END AS AccountNumber,
CASE 
    WHEN AccountNumber='NULL'
    THEN cast('N/A' AS VARCHAR(16))
    ELSE
    cast(coalesce(trim(AccountNumber),'N/A') AS VARCHAR(16)) END AS AccountNumber,

--CASE WHEN TerritoryID1 = 'NULL' THEN -1 ELSE TerritoryID1 END AS TerritoryID1,
CASE
    WHEN  TerritoryID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( TerritoryID1),'-1') AS VARCHAR(20)) AS INT) END AS  TerritoryID1,

--CASE WHEN BillToAddressID = 'NULL' THEN -1 ELSE BillToAddressID END AS BillToAddressID,
CASE
    WHEN  BillToAddressID='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( BillToAddressID),'-1') AS VARCHAR(20)) AS INT) END AS  BillToAddressID,

--CASE WHEN ShipToAddressID = 'NULL' THEN -1 ELSE ShipToAddressID END AS ShipToAddressID,
CASE
    WHEN  ShipToAddressID='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( ShipToAddressID),'-1') AS VARCHAR(20)) AS INT) END AS  ShipToAddressID,

--CASE WHEN CreditCardID1 = 'NULL' THEN -1 ELSE CreditCardID1 END AS CreditCardID1,
CASE
    WHEN  CreditCardID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( CreditCardID1),'-1') AS VARCHAR(20)) AS INT) END AS  CreditCardID1,

--CASE WHEN CreditCardApprovalCode IS NULL THEN 'N/A' ELSE CreditCardApprovalCode END AS CreditCardApprovalCode,
CASE 
    WHEN CreditCardApprovalCode='NULL'
    THEN cast('N/A' AS VARCHAR(32))
    ELSE
    cast(coalesce(trim(CreditCardApprovalCode),'N/A') AS VARCHAR(32)) END AS CreditCardApprovalCode,

--CASE WHEN CurrencyRateID1 = 'NULL' THEN -1 ELSE CurrencyRateID1 END AS CurrencyRateID1,
CASE
    WHEN  CurrencyRateID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( CurrencyRateID1),'-1') AS VARCHAR(20)) AS INT) END AS  CurrencyRateID1,

--CASE WHEN  SubTotal = 'NULL' THEN -1 ELSE  CAST(SubTotal AS DECIMAL(10,2)) END AS SubTotal,
CASE
    WHEN   SubTotal='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(SubTotal),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS SubTotal,

--CASE WHEN  TaxAmt = 'NULL' THEN -1 ELSE  CAST(TaxAmt AS DECIMAL(10,2)) END AS TaxAmt,
CASE
    WHEN   TaxAmt='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(TaxAmt),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS TaxAmt,

--CASE WHEN  Freight = 'NULL' THEN -1 ELSE  CAST(Freight AS DECIMAL(10,2)) END AS Freight,
CASE
    WHEN   Freight='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(Freight),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS Freight,

--CASE WHEN  TotalDue = 'NULL' THEN -1 ELSE  CAST(TotalDue AS DECIMAL(10,2)) END AS TotalDue
CASE
    WHEN   TotalDue='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(TotalDue),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS TotalDue

FROM DP_STG1.Sales_April_1_10;


INSERT INTO DP_STG2.SalesOrderHeader

-- Sales_April_11_20
--INSERT INTO DP_STG2.SalesOrderHeader
SELECT DISTINCT
--CASE WHEN BusinessEntityID1 = 'NULL' THEN -1 ELSE BusinessEntityID1 END AS BusinessEntityID1,
CASE
    WHEN  BusinessEntityID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( BusinessEntityID1),'-1') AS VARCHAR(20)) AS INT) END AS  BusinessEntityID1,

--CASE WHEN SalesOrderID1 = 'NULL' THEN -1 ELSE SalesOrderID1 END AS SalesOrderID1,
CASE
    WHEN  SalesOrderID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( SalesOrderID1),'-1') AS VARCHAR(20)) AS INT) END AS  SalesOrderID1,

--CASE WHEN ShipMethodID = 'NULL' THEN -1 ELSE ShipMethodID END AS ShipMethodID,
CASE
    WHEN  ShipMethodID='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( ShipMethodID),'-1') AS VARCHAR(20)) AS INT) END AS  ShipMethodID,

--CASE WHEN RevisionNumber = 'NULL' THEN -1 ELSE RevisionNumber END AS RevisionNumber,
CASE
    WHEN  RevisionNumber='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( RevisionNumber),'-1') AS VARCHAR(20)) AS INT) END AS  RevisionNumber,

--CASE WHEN OrderDate = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(OrderDate,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS OrderDate,
case
    when OrderDate = 'NULL'
    then cast ('1900-01-01' as TIMESTAMP)
    else
    cast(coalesce(OrderDate,to_date('1900-01-01')) as TIMESTAMP)
end OrderDate,

--CASE WHEN DueDate = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(DueDate,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS DueDate,
case
    when DueDate = 'NULL'
    then cast ('1900-01-01' as TIMESTAMP)
    else
    cast(coalesce(DueDate,to_date('1900-01-01')) as TIMESTAMP)
end DueDate,

--CASE WHEN ShipDate = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(ShipDate,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS ShipDate,
case
    when ShipDate = 'NULL'
    then cast ('1900-01-01' as TIMESTAMP)
    else
    cast(coalesce(ShipDate,to_date('1900-01-01')) as TIMESTAMP)
end ShipDate,

--CASE WHEN Status = 'NULL' THEN -1 ELSE CAST(Status AS BYTEINT) END AS Status,
CASE
    WHEN  Status='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS TINYINT)
    ELSE 
    cast(cast(coalesce(trim(Status),'-1') AS VARCHAR(20)) AS TINYINT) END AS Status,

--CASE WHEN OnlineOrderFlag = 'NULL' THEN -1 ELSE CAST(OnlineOrderFlag AS BYTEINT) END AS OnlineOrderFlag,
CASE
    WHEN  OnlineOrderFlag='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS TINYINT)
    ELSE 
    cast(cast(coalesce(trim(OnlineOrderFlag),'-1') AS VARCHAR(20)) AS TINYINT) END AS OnlineOrderFlag,

--CASE WHEN SalesOrderNumber IS NULL THEN 'N/A' ELSE SalesOrderNumber END AS SalesOrderNumber,
CASE 
    WHEN SalesOrderNumber='NULL'
    THEN cast('N/A' AS VARCHAR(16))
    ELSE
    cast(coalesce(trim(SalesOrderNumber),'N/A') AS VARCHAR(16)) END AS SalesOrderNumber,

--CASE WHEN PurchaseOrderNumber IS NULL THEN 'N/A' ELSE PurchaseOrderNumber END AS PurchaseOrderNumber,
CASE 
    WHEN PurchaseOrderNumber='NULL'
    THEN cast('N/A' AS VARCHAR(16))
    ELSE
    cast(coalesce(trim(PurchaseOrderNumber),'N/A') AS VARCHAR(16)) END AS PurchaseOrderNumber,

--CASE WHEN AccountNumber= 'NULL' THEN 'N/A' ELSE AccountNumber END AS AccountNumber,
CASE 
    WHEN AccountNumber='NULL'
    THEN cast('N/A' AS VARCHAR(16))
    ELSE
    cast(coalesce(trim(AccountNumber),'N/A') AS VARCHAR(16)) END AS AccountNumber,

--CASE WHEN TerritoryID1 = 'NULL' THEN -1 ELSE TerritoryID1 END AS TerritoryID1,
CASE
    WHEN  TerritoryID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( TerritoryID1),'-1') AS VARCHAR(20)) AS INT) END AS  TerritoryID1,

--CASE WHEN BillToAddressID = 'NULL' THEN -1 ELSE BillToAddressID END AS BillToAddressID,
CASE
    WHEN  BillToAddressID='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( BillToAddressID),'-1') AS VARCHAR(20)) AS INT) END AS  BillToAddressID,

--CASE WHEN ShipToAddressID = 'NULL' THEN -1 ELSE ShipToAddressID END AS ShipToAddressID,
CASE
    WHEN  ShipToAddressID='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( ShipToAddressID),'-1') AS VARCHAR(20)) AS INT) END AS  ShipToAddressID,

--CASE WHEN CreditCardID1 = 'NULL' THEN -1 ELSE CreditCardID1 END AS CreditCardID1,
CASE
    WHEN  CreditCardID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( CreditCardID1),'-1') AS VARCHAR(20)) AS INT) END AS  CreditCardID1,

--CASE WHEN CreditCardApprovalCode IS NULL THEN 'N/A' ELSE CreditCardApprovalCode END AS CreditCardApprovalCode,
CASE 
    WHEN CreditCardApprovalCode='NULL'
    THEN cast('N/A' AS VARCHAR(32))
    ELSE
    cast(coalesce(trim(CreditCardApprovalCode),'N/A') AS VARCHAR(32)) END AS CreditCardApprovalCode,

--CASE WHEN CurrencyRateID1 = 'NULL' THEN -1 ELSE CurrencyRateID1 END AS CurrencyRateID1,
CASE
    WHEN  CurrencyRateID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( CurrencyRateID1),'-1') AS VARCHAR(20)) AS INT) END AS  CurrencyRateID1,

--CASE WHEN  SubTotal = 'NULL' THEN -1 ELSE  CAST(SubTotal AS DECIMAL(10,2)) END AS SubTotal,
CASE
    WHEN   SubTotal='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(SubTotal),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS SubTotal,

--CASE WHEN  TaxAmt = 'NULL' THEN -1 ELSE  CAST(TaxAmt AS DECIMAL(10,2)) END AS TaxAmt,
CASE
    WHEN   TaxAmt='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(TaxAmt),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS TaxAmt,

--CASE WHEN  Freight = 'NULL' THEN -1 ELSE  CAST(Freight AS DECIMAL(10,2)) END AS Freight,
CASE
    WHEN   Freight='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(Freight),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS Freight,

--CASE WHEN  TotalDue = 'NULL' THEN -1 ELSE  CAST(TotalDue AS DECIMAL(10,2)) END AS TotalDue
CASE
    WHEN   TotalDue='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(TotalDue),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS TotalDue

FROM DP_STG1.Sales_April_11_20;


INSERT INTO DP_STG2.SalesOrderHeader

--Sales_April_21_30
--INSERT INTO DP_STG2.SalesOrderHeader
SELECT DISTINCT
--CASE WHEN BusinessEntityID1 = 'NULL' THEN -1 ELSE BusinessEntityID1 END AS BusinessEntityID1,
CASE
    WHEN  BusinessEntityID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( BusinessEntityID1),'-1') AS VARCHAR(20)) AS INT) END AS  BusinessEntityID1,

--CASE WHEN SalesOrderID1 = 'NULL' THEN -1 ELSE SalesOrderID1 END AS SalesOrderID1,
CASE
    WHEN  SalesOrderID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( SalesOrderID1),'-1') AS VARCHAR(20)) AS INT) END AS  SalesOrderID1,

--CASE WHEN ShipMethodID = 'NULL' THEN -1 ELSE ShipMethodID END AS ShipMethodID,
CASE
    WHEN  ShipMethodID='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( ShipMethodID),'-1') AS VARCHAR(20)) AS INT) END AS  ShipMethodID,

--CASE WHEN RevisionNumber = 'NULL' THEN -1 ELSE RevisionNumber END AS RevisionNumber,
CASE
    WHEN  RevisionNumber='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( RevisionNumber),'-1') AS VARCHAR(20)) AS INT) END AS  RevisionNumber,

--CASE WHEN OrderDate = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(OrderDate,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS OrderDate,
case
    when OrderDate = 'NULL'
    then cast ('1900-01-01' as TIMESTAMP)
    else
    cast(coalesce(OrderDate,to_date('1900-01-01')) as TIMESTAMP)
end OrderDate,

--CASE WHEN DueDate = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(DueDate,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS DueDate,
case
    when DueDate = 'NULL'
    then cast ('1900-01-01' as TIMESTAMP)
    else
    cast(coalesce(DueDate,to_date('1900-01-01')) as TIMESTAMP)
end DueDate,

--CASE WHEN ShipDate = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(ShipDate,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS ShipDate,
case
    when ShipDate = 'NULL'
    then cast ('1900-01-01' as TIMESTAMP)
    else
    cast(coalesce(ShipDate,to_date('1900-01-01')) as TIMESTAMP)
end ShipDate,

--CASE WHEN Status = 'NULL' THEN -1 ELSE CAST(Status AS BYTEINT) END AS Status,
CASE
    WHEN  Status='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS TINYINT)
    ELSE 
    cast(cast(coalesce(trim(Status),'-1') AS VARCHAR(20)) AS TINYINT) END AS Status,

--CASE WHEN OnlineOrderFlag = 'NULL' THEN -1 ELSE CAST(OnlineOrderFlag AS BYTEINT) END AS OnlineOrderFlag,
CASE
    WHEN  OnlineOrderFlag='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS TINYINT)
    ELSE 
    cast(cast(coalesce(trim(OnlineOrderFlag),'-1') AS VARCHAR(20)) AS TINYINT) END AS OnlineOrderFlag,

--CASE WHEN SalesOrderNumber IS NULL THEN 'N/A' ELSE SalesOrderNumber END AS SalesOrderNumber,
CASE 
    WHEN SalesOrderNumber='NULL'
    THEN cast('N/A' AS VARCHAR(16))
    ELSE
    cast(coalesce(trim(SalesOrderNumber),'N/A') AS VARCHAR(16)) END AS SalesOrderNumber,

--CASE WHEN PurchaseOrderNumber IS NULL THEN 'N/A' ELSE PurchaseOrderNumber END AS PurchaseOrderNumber,
CASE 
    WHEN PurchaseOrderNumber='NULL'
    THEN cast('N/A' AS VARCHAR(16))
    ELSE
    cast(coalesce(trim(PurchaseOrderNumber),'N/A') AS VARCHAR(16)) END AS PurchaseOrderNumber,

--CASE WHEN AccountNumber= 'NULL' THEN 'N/A' ELSE AccountNumber END AS AccountNumber,
CASE 
    WHEN AccountNumber='NULL'
    THEN cast('N/A' AS VARCHAR(16))
    ELSE
    cast(coalesce(trim(AccountNumber),'N/A') AS VARCHAR(16)) END AS AccountNumber,

--CASE WHEN TerritoryID1 = 'NULL' THEN -1 ELSE TerritoryID1 END AS TerritoryID1,
CASE
    WHEN  TerritoryID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( TerritoryID1),'-1') AS VARCHAR(20)) AS INT) END AS  TerritoryID1,

--CASE WHEN BillToAddressID = 'NULL' THEN -1 ELSE BillToAddressID END AS BillToAddressID,
CASE
    WHEN  BillToAddressID='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( BillToAddressID),'-1') AS VARCHAR(20)) AS INT) END AS  BillToAddressID,

--CASE WHEN ShipToAddressID = 'NULL' THEN -1 ELSE ShipToAddressID END AS ShipToAddressID,
CASE
    WHEN  ShipToAddressID='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( ShipToAddressID),'-1') AS VARCHAR(20)) AS INT) END AS  ShipToAddressID,

--CASE WHEN CreditCardID1 = 'NULL' THEN -1 ELSE CreditCardID1 END AS CreditCardID1,
CASE
    WHEN  CreditCardID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( CreditCardID1),'-1') AS VARCHAR(20)) AS INT) END AS  CreditCardID1,

--CASE WHEN CreditCardApprovalCode IS NULL THEN 'N/A' ELSE CreditCardApprovalCode END AS CreditCardApprovalCode,
CASE 
    WHEN CreditCardApprovalCode='NULL'
    THEN cast('N/A' AS VARCHAR(32))
    ELSE
    cast(coalesce(trim(CreditCardApprovalCode),'N/A') AS VARCHAR(32)) END AS CreditCardApprovalCode,

--CASE WHEN CurrencyRateID1 = 'NULL' THEN -1 ELSE CurrencyRateID1 END AS CurrencyRateID1,
CASE
    WHEN  CurrencyRateID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( CurrencyRateID1),'-1') AS VARCHAR(20)) AS INT) END AS  CurrencyRateID1,

--CASE WHEN  SubTotal = 'NULL' THEN -1 ELSE  CAST(SubTotal AS DECIMAL(10,2)) END AS SubTotal,
CASE
    WHEN   SubTotal='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(SubTotal),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS SubTotal,

--CASE WHEN  TaxAmt = 'NULL' THEN -1 ELSE  CAST(TaxAmt AS DECIMAL(10,2)) END AS TaxAmt,
CASE
    WHEN   TaxAmt='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(TaxAmt),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS TaxAmt,

--CASE WHEN  Freight = 'NULL' THEN -1 ELSE  CAST(Freight AS DECIMAL(10,2)) END AS Freight,
CASE
    WHEN   Freight='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(Freight),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS Freight,

--CASE WHEN  TotalDue = 'NULL' THEN -1 ELSE  CAST(TotalDue AS DECIMAL(10,2)) END AS TotalDue
CASE
    WHEN   TotalDue='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(TotalDue),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS TotalDue

FROM DP_STG1.Sales_April_21_30;


INSERT INTO DP_STG2.SalesOrderHeader

--Sales_May_06_10  (ORDERDATE NO NULL)
SELECT DISTINCT
--CASE WHEN BusinessEntityID1 = 'NULL' THEN -1 ELSE BusinessEntityID1 END AS BusinessEntityID1,
CASE
    WHEN  BusinessEntityID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( BusinessEntityID1),'-1') AS VARCHAR(20)) AS INT) END AS  BusinessEntityID1,

--CASE WHEN SalesOrderID1 = 'NULL' THEN -1 ELSE SalesOrderID1 END AS SalesOrderID1,
CASE
    WHEN  SalesOrderID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( SalesOrderID1),'-1') AS VARCHAR(20)) AS INT) END AS  SalesOrderID1,

--CASE WHEN ShipMethodID = 'NULL' THEN -1 ELSE ShipMethodID END AS ShipMethodID,
CASE
    WHEN  ShipMethodID='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( ShipMethodID),'-1') AS VARCHAR(20)) AS INT) END AS  ShipMethodID,

--CASE WHEN RevisionNumber = 'NULL' THEN -1 ELSE RevisionNumber END AS RevisionNumber,
CASE
    WHEN  RevisionNumber='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( RevisionNumber),'-1') AS VARCHAR(20)) AS INT) END AS  RevisionNumber,

--CASE WHEN OrderDate = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(OrderDate,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS OrderDate,
case
    when OrderDate = 'NULL'
    then cast ('1900-01-01' as TIMESTAMP)
    else
    cast(coalesce(OrderDate,to_date('1900-01-01')) as TIMESTAMP)
end OrderDate,

--CASE WHEN DueDate = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(DueDate,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS DueDate,
case
    when DueDate = 'NULL'
    then cast ('1900-01-01' as TIMESTAMP)
    else
    cast(coalesce(DueDate,to_date('1900-01-01')) as TIMESTAMP)
end DueDate,

--CASE WHEN ShipDate = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(ShipDate,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS ShipDate,
case
    when ShipDate = 'NULL'
    then cast ('1900-01-01' as TIMESTAMP)
    else
    cast(coalesce(ShipDate,to_date('1900-01-01')) as TIMESTAMP)
end ShipDate,

--CASE WHEN Status = 'NULL' THEN -1 ELSE CAST(Status AS BYTEINT) END AS Status,
CASE
    WHEN  Status='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS TINYINT)
    ELSE 
    cast(cast(coalesce(trim(Status),'-1') AS VARCHAR(20)) AS TINYINT) END AS Status,

--CASE WHEN OnlineOrderFlag = 'NULL' THEN -1 ELSE CAST(OnlineOrderFlag AS BYTEINT) END AS OnlineOrderFlag,
CASE
    WHEN  OnlineOrderFlag='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS TINYINT)
    ELSE 
    cast(cast(coalesce(trim(OnlineOrderFlag),'-1') AS VARCHAR(20)) AS TINYINT) END AS OnlineOrderFlag,

--CASE WHEN SalesOrderNumber IS NULL THEN 'N/A' ELSE SalesOrderNumber END AS SalesOrderNumber,
CASE 
    WHEN SalesOrderNumber='NULL'
    THEN cast('N/A' AS VARCHAR(16))
    ELSE
    cast(coalesce(trim(SalesOrderNumber),'N/A') AS VARCHAR(16)) END AS SalesOrderNumber,

--CASE WHEN PurchaseOrderNumber IS NULL THEN 'N/A' ELSE PurchaseOrderNumber END AS PurchaseOrderNumber,
CASE 
    WHEN PurchaseOrderNumber='NULL'
    THEN cast('N/A' AS VARCHAR(16))
    ELSE
    cast(coalesce(trim(PurchaseOrderNumber),'N/A') AS VARCHAR(16)) END AS PurchaseOrderNumber,

--CASE WHEN AccountNumber= 'NULL' THEN 'N/A' ELSE AccountNumber END AS AccountNumber,
CASE 
    WHEN AccountNumber='NULL'
    THEN cast('N/A' AS VARCHAR(16))
    ELSE
    cast(coalesce(trim(AccountNumber),'N/A') AS VARCHAR(16)) END AS AccountNumber,

--CASE WHEN TerritoryID1 = 'NULL' THEN -1 ELSE TerritoryID1 END AS TerritoryID1,
CASE
    WHEN  TerritoryID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( TerritoryID1),'-1') AS VARCHAR(20)) AS INT) END AS  TerritoryID1,

--CASE WHEN BillToAddressID = 'NULL' THEN -1 ELSE BillToAddressID END AS BillToAddressID,
CASE
    WHEN  BillToAddressID='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( BillToAddressID),'-1') AS VARCHAR(20)) AS INT) END AS  BillToAddressID,

--CASE WHEN ShipToAddressID = 'NULL' THEN -1 ELSE ShipToAddressID END AS ShipToAddressID,
CASE
    WHEN  ShipToAddressID='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( ShipToAddressID),'-1') AS VARCHAR(20)) AS INT) END AS  ShipToAddressID,

--CASE WHEN CreditCardID1 = 'NULL' THEN -1 ELSE CreditCardID1 END AS CreditCardID1,
CASE
    WHEN  CreditCardID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( CreditCardID1),'-1') AS VARCHAR(20)) AS INT) END AS  CreditCardID1,

--CASE WHEN CreditCardApprovalCode IS NULL THEN 'N/A' ELSE CreditCardApprovalCode END AS CreditCardApprovalCode,
CASE 
    WHEN CreditCardApprovalCode='NULL'
    THEN cast('N/A' AS VARCHAR(32))
    ELSE
    cast(coalesce(trim(CreditCardApprovalCode),'N/A') AS VARCHAR(32)) END AS CreditCardApprovalCode,

--CASE WHEN CurrencyRateID1 = 'NULL' THEN -1 ELSE CurrencyRateID1 END AS CurrencyRateID1,
CASE
    WHEN  CurrencyRateID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( CurrencyRateID1),'-1') AS VARCHAR(20)) AS INT) END AS  CurrencyRateID1,

--CASE WHEN  SubTotal = 'NULL' THEN -1 ELSE  CAST(SubTotal AS DECIMAL(10,2)) END AS SubTotal,
CASE
    WHEN   SubTotal='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(SubTotal),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS SubTotal,

--CASE WHEN  TaxAmt = 'NULL' THEN -1 ELSE  CAST(TaxAmt AS DECIMAL(10,2)) END AS TaxAmt,
CASE
    WHEN   TaxAmt='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(TaxAmt),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS TaxAmt,

--CASE WHEN  Freight = 'NULL' THEN -1 ELSE  CAST(Freight AS DECIMAL(10,2)) END AS Freight,
CASE
    WHEN   Freight='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(Freight),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS Freight,

--CASE WHEN  TotalDue = 'NULL' THEN -1 ELSE  CAST(TotalDue AS DECIMAL(10,2)) END AS TotalDue
CASE
    WHEN   TotalDue='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(TotalDue),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS TotalDue

FROM DP_STG1.Sales_May_06_10;


INSERT INTO DP_STG2.SalesOrderHeader

--Sales_May_11_20 (ORDER DATE NOT NULL)
SELECT DISTINCT
--CASE WHEN BusinessEntityID1 = 'NULL' THEN -1 ELSE BusinessEntityID1 END AS BusinessEntityID1,
CASE
    WHEN  BusinessEntityID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( BusinessEntityID1),'-1') AS VARCHAR(20)) AS INT) END AS  BusinessEntityID1,

--CASE WHEN SalesOrderID1 = 'NULL' THEN -1 ELSE SalesOrderID1 END AS SalesOrderID1,
CASE
    WHEN  SalesOrderID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( SalesOrderID1),'-1') AS VARCHAR(20)) AS INT) END AS  SalesOrderID1,

--CASE WHEN ShipMethodID = 'NULL' THEN -1 ELSE ShipMethodID END AS ShipMethodID,
CASE
    WHEN  ShipMethodID='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( ShipMethodID),'-1') AS VARCHAR(20)) AS INT) END AS  ShipMethodID,

--CASE WHEN RevisionNumber = 'NULL' THEN -1 ELSE RevisionNumber END AS RevisionNumber,
CASE
    WHEN  RevisionNumber='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( RevisionNumber),'-1') AS VARCHAR(20)) AS INT) END AS  RevisionNumber,

--CASE WHEN OrderDate = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(OrderDate,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS OrderDate,
case
    when OrderDate = 'NULL'
    then cast ('1900-01-01' as TIMESTAMP)
    else
    cast(coalesce(OrderDate,to_date('1900-01-01')) as TIMESTAMP)
end OrderDate,

--CASE WHEN DueDate = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(DueDate,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS DueDate,
case
    when DueDate = 'NULL'
    then cast ('1900-01-01' as TIMESTAMP)
    else
    cast(coalesce(DueDate,to_date('1900-01-01')) as TIMESTAMP)
end DueDate,

--CASE WHEN ShipDate = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(ShipDate,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS ShipDate,
case
    when ShipDate = 'NULL'
    then cast ('1900-01-01' as TIMESTAMP)
    else
    cast(coalesce(ShipDate,to_date('1900-01-01')) as TIMESTAMP)
end ShipDate,

--CASE WHEN Status = 'NULL' THEN -1 ELSE CAST(Status AS BYTEINT) END AS Status,
CASE
    WHEN  Status='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS TINYINT)
    ELSE 
    cast(cast(coalesce(trim(Status),'-1') AS VARCHAR(20)) AS TINYINT) END AS Status,

--CASE WHEN OnlineOrderFlag = 'NULL' THEN -1 ELSE CAST(OnlineOrderFlag AS BYTEINT) END AS OnlineOrderFlag,
CASE
    WHEN  OnlineOrderFlag='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS TINYINT)
    ELSE 
    cast(cast(coalesce(trim(OnlineOrderFlag),'-1') AS VARCHAR(20)) AS TINYINT) END AS OnlineOrderFlag,

--CASE WHEN SalesOrderNumber IS NULL THEN 'N/A' ELSE SalesOrderNumber END AS SalesOrderNumber,
CASE 
    WHEN SalesOrderNumber='NULL'
    THEN cast('N/A' AS VARCHAR(16))
    ELSE
    cast(coalesce(trim(SalesOrderNumber),'N/A') AS VARCHAR(16)) END AS SalesOrderNumber,

--CASE WHEN PurchaseOrderNumber IS NULL THEN 'N/A' ELSE PurchaseOrderNumber END AS PurchaseOrderNumber,
CASE 
    WHEN PurchaseOrderNumber='NULL'
    THEN cast('N/A' AS VARCHAR(16))
    ELSE
    cast(coalesce(trim(PurchaseOrderNumber),'N/A') AS VARCHAR(16)) END AS PurchaseOrderNumber,

--CASE WHEN AccountNumber= 'NULL' THEN 'N/A' ELSE AccountNumber END AS AccountNumber,
CASE 
    WHEN AccountNumber='NULL'
    THEN cast('N/A' AS VARCHAR(16))
    ELSE
    cast(coalesce(trim(AccountNumber),'N/A') AS VARCHAR(16)) END AS AccountNumber,

--CASE WHEN TerritoryID1 = 'NULL' THEN -1 ELSE TerritoryID1 END AS TerritoryID1,
CASE
    WHEN  TerritoryID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( TerritoryID1),'-1') AS VARCHAR(20)) AS INT) END AS  TerritoryID1,

--CASE WHEN BillToAddressID = 'NULL' THEN -1 ELSE BillToAddressID END AS BillToAddressID,
CASE
    WHEN  BillToAddressID='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( BillToAddressID),'-1') AS VARCHAR(20)) AS INT) END AS  BillToAddressID,

--CASE WHEN ShipToAddressID = 'NULL' THEN -1 ELSE ShipToAddressID END AS ShipToAddressID,
CASE
    WHEN  ShipToAddressID='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( ShipToAddressID),'-1') AS VARCHAR(20)) AS INT) END AS  ShipToAddressID,

--CASE WHEN CreditCardID1 = 'NULL' THEN -1 ELSE CreditCardID1 END AS CreditCardID1,
CASE
    WHEN  CreditCardID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( CreditCardID1),'-1') AS VARCHAR(20)) AS INT) END AS  CreditCardID1,

--CASE WHEN CreditCardApprovalCode IS NULL THEN 'N/A' ELSE CreditCardApprovalCode END AS CreditCardApprovalCode,
CASE 
    WHEN CreditCardApprovalCode='NULL'
    THEN cast('N/A' AS VARCHAR(32))
    ELSE
    cast(coalesce(trim(CreditCardApprovalCode),'N/A') AS VARCHAR(32)) END AS CreditCardApprovalCode,

--CASE WHEN CurrencyRateID1 = 'NULL' THEN -1 ELSE CurrencyRateID1 END AS CurrencyRateID1,
CASE
    WHEN  CurrencyRateID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( CurrencyRateID1),'-1') AS VARCHAR(20)) AS INT) END AS  CurrencyRateID1,

--CASE WHEN  SubTotal = 'NULL' THEN -1 ELSE  CAST(SubTotal AS DECIMAL(10,2)) END AS SubTotal,
CASE
    WHEN   SubTotal='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(SubTotal),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS SubTotal,

--CASE WHEN  TaxAmt = 'NULL' THEN -1 ELSE  CAST(TaxAmt AS DECIMAL(10,2)) END AS TaxAmt,
CASE
    WHEN   TaxAmt='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(TaxAmt),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS TaxAmt,

--CASE WHEN  Freight = 'NULL' THEN -1 ELSE  CAST(Freight AS DECIMAL(10,2)) END AS Freight,
CASE
    WHEN   Freight='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(Freight),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS Freight,

--CASE WHEN  TotalDue = 'NULL' THEN -1 ELSE  CAST(TotalDue AS DECIMAL(10,2)) END AS TotalDue
CASE
    WHEN   TotalDue='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(TotalDue),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS TotalDue

FROM DP_STG1.Sales_May_11_20;


INSERT INTO DP_STG2.SalesOrderHeader

--Sales_May_21_31
SELECT DISTINCT
--CASE WHEN BusinessEntityID1 = 'NULL' THEN -1 ELSE BusinessEntityID1 END AS BusinessEntityID1,
CASE
    WHEN  BusinessEntityID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( BusinessEntityID1),'-1') AS VARCHAR(20)) AS INT) END AS  BusinessEntityID1,

--CASE WHEN SalesOrderID1 = 'NULL' THEN -1 ELSE SalesOrderID1 END AS SalesOrderID1,
CASE
    WHEN  SalesOrderID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( SalesOrderID1),'-1') AS VARCHAR(20)) AS INT) END AS  SalesOrderID1,

--CASE WHEN ShipMethodID = 'NULL' THEN -1 ELSE ShipMethodID END AS ShipMethodID,
CASE
    WHEN  ShipMethodID='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( ShipMethodID),'-1') AS VARCHAR(20)) AS INT) END AS  ShipMethodID,

--CASE WHEN RevisionNumber = 'NULL' THEN -1 ELSE RevisionNumber END AS RevisionNumber,
CASE
    WHEN  RevisionNumber='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( RevisionNumber),'-1') AS VARCHAR(20)) AS INT) END AS  RevisionNumber,

--CASE WHEN OrderDate = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(OrderDate,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS OrderDate,
case
    when OrderDate = 'NULL'
    then cast ('1900-01-01' as TIMESTAMP)
    else
    cast(coalesce(OrderDate,to_date('1900-01-01')) as TIMESTAMP)
end OrderDate,

--CASE WHEN DueDate = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(DueDate,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS DueDate,
case
    when DueDate = 'NULL'
    then cast ('1900-01-01' as TIMESTAMP)
    else
    cast(coalesce(DueDate,to_date('1900-01-01')) as TIMESTAMP)
end DueDate,

--CASE WHEN ShipDate = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(ShipDate,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS ShipDate,
case
    when ShipDate = 'NULL'
    then cast ('1900-01-01' as TIMESTAMP)
    else
    cast(coalesce(ShipDate,to_date('1900-01-01')) as TIMESTAMP)
end ShipDate,

--CASE WHEN Status = 'NULL' THEN -1 ELSE CAST(Status AS BYTEINT) END AS Status,
CASE
    WHEN  Status='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS TINYINT)
    ELSE 
    cast(cast(coalesce(trim(Status),'-1') AS VARCHAR(20)) AS TINYINT) END AS Status,

--CASE WHEN OnlineOrderFlag = 'NULL' THEN -1 ELSE CAST(OnlineOrderFlag AS BYTEINT) END AS OnlineOrderFlag,
CASE
    WHEN  OnlineOrderFlag='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS TINYINT)
    ELSE 
    cast(cast(coalesce(trim(OnlineOrderFlag),'-1') AS VARCHAR(20)) AS TINYINT) END AS OnlineOrderFlag,

--CASE WHEN SalesOrderNumber IS NULL THEN 'N/A' ELSE SalesOrderNumber END AS SalesOrderNumber,
CASE 
    WHEN SalesOrderNumber='NULL'
    THEN cast('N/A' AS VARCHAR(16))
    ELSE
    cast(coalesce(trim(SalesOrderNumber),'N/A') AS VARCHAR(16)) END AS SalesOrderNumber,

--CASE WHEN PurchaseOrderNumber IS NULL THEN 'N/A' ELSE PurchaseOrderNumber END AS PurchaseOrderNumber,
CASE 
    WHEN PurchaseOrderNumber='NULL'
    THEN cast('N/A' AS VARCHAR(16))
    ELSE
    cast(coalesce(trim(PurchaseOrderNumber),'N/A') AS VARCHAR(16)) END AS PurchaseOrderNumber,

--CASE WHEN AccountNumber= 'NULL' THEN 'N/A' ELSE AccountNumber END AS AccountNumber,
CASE 
    WHEN AccountNumber='NULL'
    THEN cast('N/A' AS VARCHAR(16))
    ELSE
    cast(coalesce(trim(AccountNumber),'N/A') AS VARCHAR(16)) END AS AccountNumber,

--CASE WHEN TerritoryID1 = 'NULL' THEN -1 ELSE TerritoryID1 END AS TerritoryID1,
CASE
    WHEN  TerritoryID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( TerritoryID1),'-1') AS VARCHAR(20)) AS INT) END AS  TerritoryID1,

--CASE WHEN BillToAddressID = 'NULL' THEN -1 ELSE BillToAddressID END AS BillToAddressID,
CASE
    WHEN  BillToAddressID='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( BillToAddressID),'-1') AS VARCHAR(20)) AS INT) END AS  BillToAddressID,

--CASE WHEN ShipToAddressID = 'NULL' THEN -1 ELSE ShipToAddressID END AS ShipToAddressID,
CASE
    WHEN  ShipToAddressID='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( ShipToAddressID),'-1') AS VARCHAR(20)) AS INT) END AS  ShipToAddressID,

--CASE WHEN CreditCardID1 = 'NULL' THEN -1 ELSE CreditCardID1 END AS CreditCardID1,
CASE
    WHEN  CreditCardID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( CreditCardID1),'-1') AS VARCHAR(20)) AS INT) END AS  CreditCardID1,

--CASE WHEN CreditCardApprovalCode IS NULL THEN 'N/A' ELSE CreditCardApprovalCode END AS CreditCardApprovalCode,
CASE 
    WHEN CreditCardApprovalCode='NULL'
    THEN cast('N/A' AS VARCHAR(32))
    ELSE
    cast(coalesce(trim(CreditCardApprovalCode),'N/A') AS VARCHAR(32)) END AS CreditCardApprovalCode,

--CASE WHEN CurrencyRateID1 = 'NULL' THEN -1 ELSE CurrencyRateID1 END AS CurrencyRateID1,
CASE
    WHEN  CurrencyRateID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( CurrencyRateID1),'-1') AS VARCHAR(20)) AS INT) END AS  CurrencyRateID1,

--CASE WHEN  SubTotal = 'NULL' THEN -1 ELSE  CAST(SubTotal AS DECIMAL(10,2)) END AS SubTotal,
CASE
    WHEN   SubTotal='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(SubTotal),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS SubTotal,

--CASE WHEN  TaxAmt = 'NULL' THEN -1 ELSE  CAST(TaxAmt AS DECIMAL(10,2)) END AS TaxAmt,
CASE
    WHEN   TaxAmt='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(TaxAmt),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS TaxAmt,

--CASE WHEN  Freight = 'NULL' THEN -1 ELSE  CAST(Freight AS DECIMAL(10,2)) END AS Freight,
CASE
    WHEN   Freight='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(Freight),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS Freight,

--CASE WHEN  TotalDue = 'NULL' THEN -1 ELSE  CAST(TotalDue AS DECIMAL(10,2)) END AS TotalDue
CASE
    WHEN   TotalDue='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(TotalDue),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS TotalDue

FROM DP_STG1.Sales_May_21_31;


INSERT INTO DP_STG2.SalesOrderHeader

SELECT DISTINCT
--CASE WHEN BusinessEntityID1 = 'NULL' THEN -1 ELSE BusinessEntityID1 END AS BusinessEntityID1,
CASE
    WHEN  BusinessEntityID='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( BusinessEntityID),'-1') AS VARCHAR(20)) AS INT) END AS  BusinessEntityID1,

--CASE WHEN SalesOrderID1 = 'NULL' THEN -1 ELSE SalesOrderID1 END AS SalesOrderID1,
CASE
    WHEN  SalesOrderID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( SalesOrderID1),'-1') AS VARCHAR(20)) AS INT) END AS  SalesOrderID1,

--CASE WHEN ShipMethodID = 'NULL' THEN -1 ELSE ShipMethodID END AS ShipMethodID,
CASE
    WHEN  ShipMethodID='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( ShipMethodID),'-1') AS VARCHAR(20)) AS INT) END AS  ShipMethodID,

--CASE WHEN RevisionNumber = 'NULL' THEN -1 ELSE RevisionNumber END AS RevisionNumber,
CASE
    WHEN  RevisionNumber1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( RevisionNumber1),'-1') AS VARCHAR(20)) AS INT) END AS  RevisionNumber,

--CASE WHEN OrderDate = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(OrderDate,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS OrderDate,
case 
    when orderDate='NULL'
    Then  cast ('1900-01-01' as TIMESTAMP)
    else
    cast(to_date(concat(substr(orderdate,7,4),'-',substr(orderdate,1,2),'-',substr(orderdate,4,2))) as TIMESTAMP) 
end OrderDate,

--CASE WHEN DueDate = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(DueDate,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS DueDate,
case
    when DueDate = 'NULL'
    then cast ('1900-01-01' as TIMESTAMP)
    else
    cast(to_date(concat(substr(orderdate,7,4),'-',substr(orderdate,1,2),'-',substr(orderdate,4,2))) as TIMESTAMP)
end DueDate,

--CASE WHEN ShipDate = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(ShipDate,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS ShipDate,
case
    when ShipDate = 'NULL'
    then cast ('1900-01-01' as TIMESTAMP)
    else
    cast(to_date(concat(substr(orderdate,7,4),'-',substr(orderdate,1,2),'-',substr(orderdate,4,2))) as TIMESTAMP)
end ShipDate,

--CASE WHEN Status = 'NULL' THEN -1 ELSE CAST(Status AS BYTEINT) END AS Status,
CASE
    WHEN  Status='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS TINYINT)
    ELSE 
    cast(cast(coalesce(trim(Status),'-1') AS VARCHAR(20)) AS TINYINT) END AS Status,

--CASE WHEN OnlineOrderFlag = 'NULL' THEN -1 ELSE CAST(OnlineOrderFlag AS BYTEINT) END AS OnlineOrderFlag,
CASE
    WHEN  OnlineOrderFlag='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS TINYINT)
    ELSE 
    cast(cast(coalesce(trim(OnlineOrderFlag),'-1') AS VARCHAR(20)) AS TINYINT) END AS OnlineOrderFlag,

--CASE WHEN SalesOrderNumber IS NULL THEN 'N/A' ELSE SalesOrderNumber END AS SalesOrderNumber,
CASE 
    WHEN SalesOrderNumber1='NULL'
    THEN cast('N/A' AS VARCHAR(16))
    ELSE
    cast(coalesce(trim(SalesOrderNumber1),'N/A') AS VARCHAR(16)) END AS SalesOrderNumber,

--CASE WHEN PurchaseOrderNumber IS NULL THEN 'N/A' ELSE PurchaseOrderNumber END AS PurchaseOrderNumber,
CASE 
    WHEN PurchaseOrderNumber1='NULL'
    THEN cast('N/A' AS VARCHAR(16))
    ELSE
    cast(coalesce(trim(PurchaseOrderNumber1),'N/A') AS VARCHAR(16)) END AS PurchaseOrderNumber,

--CASE WHEN AccountNumber= 'NULL' THEN 'N/A' ELSE AccountNumber END AS AccountNumber,
CASE 
    WHEN AccountNumber='NULL'
    THEN cast('N/A' AS VARCHAR(16))
    ELSE
    cast(coalesce(trim(AccountNumber),'N/A') AS VARCHAR(16)) END AS AccountNumber,

--CASE WHEN TerritoryID1 = 'NULL' THEN -1 ELSE TerritoryID1 END AS TerritoryID1,
CASE
    WHEN  TerritoryID='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( TerritoryID),'-1') AS VARCHAR(20)) AS INT) END AS  TerritoryID,

--CASE WHEN BillToAddressID = 'NULL' THEN -1 ELSE BillToAddressID END AS BillToAddressID,
CASE
    WHEN  BillToAddressID='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( BillToAddressID),'-1') AS VARCHAR(20)) AS INT) END AS  BillToAddressID,

--CASE WHEN ShipToAddressID = 'NULL' THEN -1 ELSE ShipToAddressID END AS ShipToAddressID,
CASE
    WHEN  ShipToAddressID='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( ShipToAddressID),'-1') AS VARCHAR(20)) AS INT) END AS  ShipToAddressID,

--CASE WHEN CreditCardID1 = 'NULL' THEN -1 ELSE CreditCardID1 END AS CreditCardID1,
CASE
    WHEN  CreditCardID='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( CreditCardID),'-1') AS VARCHAR(20)) AS INT) END AS  CreditCardID,

--CASE WHEN CreditCardApprovalCode IS NULL THEN 'N/A' ELSE CreditCardApprovalCode END AS CreditCardApprovalCode,
CASE 
    WHEN CreditCardApprovalCode='NULL'
    THEN cast('N/A' AS VARCHAR(32))
    ELSE
    cast(coalesce(trim(CreditCardApprovalCode),'N/A') AS VARCHAR(32)) END AS CreditCardApprovalCode,

--CASE WHEN CurrencyRateID1 = 'NULL' THEN -1 ELSE CurrencyRateID1 END AS CurrencyRateID1,
CASE
    WHEN  CurrencyRateID='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( CurrencyRateID),'-1') AS VARCHAR(20)) AS INT) END AS  CurrencyRateID,

--CASE WHEN  SubTotal = 'NULL' THEN -1 ELSE  CAST(SubTotal AS DECIMAL(10,2)) END AS SubTotal,
CASE
    WHEN   SubTotal='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(SubTotal),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS SubTotal,

--CASE WHEN  TaxAmt = 'NULL' THEN -1 ELSE  CAST(TaxAmt AS DECIMAL(10,2)) END AS TaxAmt,
CASE
    WHEN   TaxAmt='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(TaxAmt),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS TaxAmt,

--CASE WHEN  Freight = 'NULL' THEN -1 ELSE  CAST(Freight AS DECIMAL(10,2)) END AS Freight,
CASE
    WHEN   Freight='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(Freight),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS Freight,

--CASE WHEN  TotalDue = 'NULL' THEN -1 ELSE  CAST(TotalDue AS DECIMAL(10,2)) END AS TotalDue
CASE
    WHEN   TotalDue='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(TotalDue),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS TotalDue

FROM DP_STG1.Sales_2
--where businessentityid='706';



--Checking if the data have been loaded in to the target table or not
--It should return 905 Rows

SELECT *
FROM DP_STG2.SalesOrderHeader;
WHERE orderdate IS NULL;

SELECT DISTINCT orderdate
FROM dp_stg1.sales_2;


--Issue resolved by this overwrite distinct (it was because of union)

        --Used todate and converted the format from (dd-mm-yyyy) to (yyyy-mm-dd)    
        --sperated the digits of date and concatenated and it is generic code (working on all sales_2 table of dp_stg1)
--SELECT orderdate,cast(orderdate as TIMESTAMP),to_date(concat(substr(orderdate,7,4),'-',substr(orderdate,1,2),'-',substr(orderdate,4,2))) from dp_stg1.sales_2
--where businessentityid='942'
--where businessentityid='706'


--select cast('07/01/2011 0:00' as timestamp)
--select to_date('01/01/1999') format "yyyy-mm-dd";
--select to_date('1900-01-01')

-------------------------------------------------------------------------------------------------------------------------------------------------



--18) salesorderdetail Table
--According to Schema

----------------------------------------------------------------------------------------------

--Dropping the table if there is any issue while loading the data into the target table

DROP TABLE dp_stg2.SalesOrderDetail;

--Refreshing the table after inserting the data into the table 

REFRESH dp_stg2.salesorderdetail;

--Creating the salesorderdetail table total 5 columns
--1) BusinessEntityID, 2)SalesOrderID, 3)SalesOrderDetailID, 4)CarrierTrackingNumber, 5)CarrierTrackingNumber , 6)OrderQty ,7)ProductID ,8)SpecialOfferID ,9)UnitPrice ,10) UnitPriceDiscount
--11)LineTotal



CREATE TABLE dp_stg2.SalesOrderDetail
	(
		BusinessEntityID INTEGER,
		SalesOrderID INTEGER,
		SalesOrderDetailID INTEGER,
		CarrierTrackingNumber VARCHAR(16),
		 OrderQty INTEGER,
		 ProductID INTEGER,
		 SpecialOfferID INTEGER,
		 UnitPrice DECIMAL(10,2),
		 UnitPriceDiscount  DECIMAL(6,2),
		 LineTotal DECIMAL(10,2)
	 );



--Inserting data into the table from the source table and removing NULL from the source table
--Cleaning the Data and defining data types.

INSERT INTO DP_STG2.SalesOrderDetail
SELECT DISTINCT
	
--CASE WHEN BusinessEntityID1 = 'NULL' THEN -1 ELSE BusinessEntityID1 END AS BusinessEntityID1,
CASE
    WHEN  BusinessEntityID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( BusinessEntityID1),'-1') AS VARCHAR(20)) AS INT) END AS  BusinessEntityID1,


--CASE WHEN SalesOrderID1 = 'NULL' THEN -1 ELSE SalesOrderID1 END AS SalesOrderID1,
CASE
    WHEN  SalesOrderID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( SalesOrderID1),'-1') AS VARCHAR(20)) AS INT) END AS  SalesOrderID1,
    
--CASE WHEN SalesOrderDetailID = 'NULL' THEN -1 ELSE SalesOrderDetailID END AS SalesOrderDetailID,
CASE
    WHEN  SalesOrderDetailID='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( SalesOrderDetailID),'-1') AS VARCHAR(20)) AS INT) END AS  SalesOrderDetailID,
    


--CASE WHEN CarrierTrackingNumber = 'NULL' THEN 'N/A' ELSE CarrierTrackingNumber END AS CarrierTrackingNumber,
CASE 
    WHEN CarrierTrackingNumber='NULL'
    THEN cast('N/A' AS VARCHAR(16))
    ELSE
    cast(coalesce(trim(CarrierTrackingNumber),'N/A') AS VARCHAR(16)) END AS CarrierTrackingNumber,

--CASE WHEN OrderQty = 'NULL' THEN -1 ELSE OrderQty END AS OrderQty,
CASE
    WHEN  OrderQty='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( OrderQty),'-1') AS VARCHAR(20)) AS INT) END AS  OrderQty,

--CASE WHEN ProductID1 = 'NULL' THEN -1 ELSE ProductID1 END AS ProductID,
CASE
    WHEN  ProductID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( ProductID1),'-1') AS VARCHAR(20)) AS INT) END AS  ProductID1,


--CASE WHEN SpecialOfferID1 = 'NULL' THEN -1 ELSE SpecialOfferID1 END AS SpecialOfferID,
CASE
    WHEN  SpecialOfferID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( SpecialOfferID1),'-1') AS VARCHAR(20)) AS INT) END AS  SpecialOfferID1,


--CASE WHEN  UnitPrice = 'NULL' THEN -1 ELSE  CAST(UnitPrice AS DECIMAL(10,2)) END AS UnitPrice,
CASE
    WHEN   UnitPrice='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(UnitPrice),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS UnitPrice,


--CASE WHEN UnitPriceDiscount = 'NULL' THEN -1 ELSE  CAST(UnitPriceDiscount AS DECIMAL(6,2)) END AS UnitPriceDiscount,
CASE
    WHEN   UnitPriceDiscount='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(6,2))
    ELSE 
    cast(cast(coalesce(trim(UnitPriceDiscount),'-1') AS VARCHAR(20)) AS DECIMAL(6,2)) END AS UnitPriceDiscount,


--CASE WHEN  LineTotal = 'NULL' THEN -1 ELSE  CAST(LineTotal AS DECIMAL(10,2)) END AS LineTotal
CASE
    WHEN   LineTotal='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(LineTotal),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS LineTotal

FROM DP_STG1.Sales;
	
INSERT INTO DP_STG2.SalesOrderDetail
SELECT DISTINCT
	CASE
    WHEN  BusinessEntityID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( BusinessEntityID1),'-1') AS VARCHAR(20)) AS INT) END AS  BusinessEntityID1,


--CASE WHEN SalesOrderID1 = 'NULL' THEN -1 ELSE SalesOrderID1 END AS SalesOrderID1,
CASE
    WHEN  SalesOrderID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( SalesOrderID1),'-1') AS VARCHAR(20)) AS INT) END AS  SalesOrderID1,
    
--CASE WHEN SalesOrderDetailID = 'NULL' THEN -1 ELSE SalesOrderDetailID END AS SalesOrderDetailID,
CASE
    WHEN  SalesOrderDetailID='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( SalesOrderDetailID),'-1') AS VARCHAR(20)) AS INT) END AS  SalesOrderDetailID,
    


--CASE WHEN CarrierTrackingNumber = 'NULL' THEN 'N/A' ELSE CarrierTrackingNumber END AS CarrierTrackingNumber,
CASE 
    WHEN CarrierTrackingNumber='NULL'
    THEN cast('N/A' AS VARCHAR(16))
    ELSE
    cast(coalesce(trim(CarrierTrackingNumber),'N/A') AS VARCHAR(16)) END AS CarrierTrackingNumber,

--CASE WHEN OrderQty = 'NULL' THEN -1 ELSE OrderQty END AS OrderQty,
CASE
    WHEN  OrderQty='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( OrderQty),'-1') AS VARCHAR(20)) AS INT) END AS  OrderQty,

--CASE WHEN ProductID1 = 'NULL' THEN -1 ELSE ProductID1 END AS ProductID,
CASE
    WHEN  ProductID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( ProductID1),'-1') AS VARCHAR(20)) AS INT) END AS  ProductID1,


--CASE WHEN SpecialOfferID1 = 'NULL' THEN -1 ELSE SpecialOfferID1 END AS SpecialOfferID,
CASE
    WHEN  SpecialOfferID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( SpecialOfferID1),'-1') AS VARCHAR(20)) AS INT) END AS  SpecialOfferID1,


--CASE WHEN  UnitPrice = 'NULL' THEN -1 ELSE  CAST(UnitPrice AS DECIMAL(10,2)) END AS UnitPrice,
CASE UnitPrice
    WHEN  'NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    WHEN '' THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(UnitPrice),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS UnitPrice,


--CASE WHEN UnitPriceDiscount = 'NULL' THEN -1 ELSE  CAST(UnitPriceDiscount AS DECIMAL(6,2)) END AS UnitPriceDiscount,
CASE UnitPriceDiscount
    WHEN 'NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(6,2))
    WHEN '' THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(6,2))
    ELSE 
    cast(cast(coalesce(trim(UnitPriceDiscount),'-1') AS VARCHAR(20)) AS DECIMAL(6,2)) END AS UnitPriceDiscount,


--CASE WHEN  LineTotal = 'NULL' THEN -1 ELSE  CAST(LineTotal AS DECIMAL(10,2)) END AS LineTotal
CASE LineTotal
    WHEN  'NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    WHEN '' THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(LineTotal),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS LineTotal

FROM DP_STG1.Sales_April_1_10; --HAVE TO LOAD THIS
	
	
INSERT INTO DP_STG2.SalesOrderDetail
SELECT DISTINCT
CASE
    WHEN  BusinessEntityID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( BusinessEntityID1),'-1') AS VARCHAR(20)) AS INT) END AS  BusinessEntityID1,


--CASE WHEN SalesOrderID1 = 'NULL' THEN -1 ELSE SalesOrderID1 END AS SalesOrderID1,
CASE
    WHEN  SalesOrderID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( SalesOrderID1),'-1') AS VARCHAR(20)) AS INT) END AS  SalesOrderID1,
    
--CASE WHEN SalesOrderDetailID = 'NULL' THEN -1 ELSE SalesOrderDetailID END AS SalesOrderDetailID,
CASE
    WHEN  SalesOrderDetailID='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( SalesOrderDetailID),'-1') AS VARCHAR(20)) AS INT) END AS  SalesOrderDetailID,
    


--CASE WHEN CarrierTrackingNumber = 'NULL' THEN 'N/A' ELSE CarrierTrackingNumber END AS CarrierTrackingNumber,
CASE 
    WHEN CarrierTrackingNumber='NULL'
    THEN cast('N/A' AS VARCHAR(16))
    ELSE
    cast(coalesce(trim(CarrierTrackingNumber),'N/A') AS VARCHAR(16)) END AS CarrierTrackingNumber,

--CASE WHEN OrderQty = 'NULL' THEN -1 ELSE OrderQty END AS OrderQty,
CASE
    WHEN  OrderQty='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( OrderQty),'-1') AS VARCHAR(20)) AS INT) END AS  OrderQty,

--CASE WHEN ProductID1 = 'NULL' THEN -1 ELSE ProductID1 END AS ProductID,
CASE
    WHEN  ProductID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( ProductID1),'-1') AS VARCHAR(20)) AS INT) END AS  ProductID1,


--CASE WHEN SpecialOfferID1 = 'NULL' THEN -1 ELSE SpecialOfferID1 END AS SpecialOfferID,
CASE
    WHEN  SpecialOfferID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( SpecialOfferID1),'-1') AS VARCHAR(20)) AS INT) END AS  SpecialOfferID1,


--CASE WHEN  UnitPrice = 'NULL' THEN -1 ELSE  CAST(UnitPrice AS DECIMAL(10,2)) END AS UnitPrice,
CASE
    WHEN   UnitPrice='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(UnitPrice),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS UnitPrice,


--CASE WHEN UnitPriceDiscount = 'NULL' THEN -1 ELSE  CAST(UnitPriceDiscount AS DECIMAL(6,2)) END AS UnitPriceDiscount,
CASE
    WHEN   UnitPriceDiscount='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(6,2))
    ELSE 
    cast(cast(coalesce(trim(UnitPriceDiscount),'-1') AS VARCHAR(20)) AS DECIMAL(6,2)) END AS UnitPriceDiscount,


--CASE WHEN  LineTotal = 'NULL' THEN -1 ELSE  CAST(LineTotal AS DECIMAL(10,2)) END AS LineTotal
CASE
    WHEN   LineTotal='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(LineTotal),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS LineTotal

FROM DP_STG1.Sales_April_11_20;


	
	
INSERT INTO DP_STG2.SalesOrderDetail
SELECT DISTINCT
CASE
    WHEN  BusinessEntityID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( BusinessEntityID1),'-1') AS VARCHAR(20)) AS INT) END AS  BusinessEntityID1,


--CASE WHEN SalesOrderID1 = 'NULL' THEN -1 ELSE SalesOrderID1 END AS SalesOrderID1,
CASE
    WHEN  SalesOrderID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( SalesOrderID1),'-1') AS VARCHAR(20)) AS INT) END AS  SalesOrderID1,
    
--CASE WHEN SalesOrderDetailID = 'NULL' THEN -1 ELSE SalesOrderDetailID END AS SalesOrderDetailID,
CASE
    WHEN  SalesOrderDetailID='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( SalesOrderDetailID),'-1') AS VARCHAR(20)) AS INT) END AS  SalesOrderDetailID,
    


--CASE WHEN CarrierTrackingNumber = 'NULL' THEN 'N/A' ELSE CarrierTrackingNumber END AS CarrierTrackingNumber,
CASE 
    WHEN CarrierTrackingNumber='NULL'
    THEN cast('N/A' AS VARCHAR(16))
    ELSE
    cast(coalesce(trim(CarrierTrackingNumber),'N/A') AS VARCHAR(16)) END AS CarrierTrackingNumber,

--CASE WHEN OrderQty = 'NULL' THEN -1 ELSE OrderQty END AS OrderQty,
CASE
    WHEN  OrderQty='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( OrderQty),'-1') AS VARCHAR(20)) AS INT) END AS  OrderQty,

--CASE WHEN ProductID1 = 'NULL' THEN -1 ELSE ProductID1 END AS ProductID,
CASE
    WHEN  ProductID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( ProductID1),'-1') AS VARCHAR(20)) AS INT) END AS  ProductID1,


--CASE WHEN SpecialOfferID1 = 'NULL' THEN -1 ELSE SpecialOfferID1 END AS SpecialOfferID,
CASE
    WHEN  SpecialOfferID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( SpecialOfferID1),'-1') AS VARCHAR(20)) AS INT) END AS  SpecialOfferID1,


--CASE WHEN  UnitPrice = 'NULL' THEN -1 ELSE  CAST(UnitPrice AS DECIMAL(10,2)) END AS UnitPrice,
CASE
    WHEN   UnitPrice='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(UnitPrice),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS UnitPrice,


--CASE WHEN UnitPriceDiscount = 'NULL' THEN -1 ELSE  CAST(UnitPriceDiscount AS DECIMAL(6,2)) END AS UnitPriceDiscount,
CASE
    WHEN   UnitPriceDiscount='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(6,2))
    ELSE 
    cast(cast(coalesce(trim(UnitPriceDiscount),'-1') AS VARCHAR(20)) AS DECIMAL(6,2)) END AS UnitPriceDiscount,


--CASE WHEN  LineTotal = 'NULL' THEN -1 ELSE  CAST(LineTotal AS DECIMAL(10,2)) END AS LineTotal
CASE
    WHEN   LineTotal='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(LineTotal),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS LineTotal
	FROM DP_STG1.Sales_April_21_30;

INSERT INTO DP_STG2.SalesOrderDetail
SELECT DISTINCT
CASE
    WHEN  BusinessEntityID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( BusinessEntityID1),'-1') AS VARCHAR(20)) AS INT) END AS  BusinessEntityID1,


--CASE WHEN SalesOrderID1 = 'NULL' THEN -1 ELSE SalesOrderID1 END AS SalesOrderID1,
CASE
    WHEN  SalesOrderID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( SalesOrderID1),'-1') AS VARCHAR(20)) AS INT) END AS  SalesOrderID1,
    
--CASE WHEN SalesOrderDetailID = 'NULL' THEN -1 ELSE SalesOrderDetailID END AS SalesOrderDetailID,
CASE
    WHEN  SalesOrderDetailID='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( SalesOrderDetailID),'-1') AS VARCHAR(20)) AS INT) END AS  SalesOrderDetailID,
    


--CASE WHEN CarrierTrackingNumber = 'NULL' THEN 'N/A' ELSE CarrierTrackingNumber END AS CarrierTrackingNumber,
CASE 
    WHEN CarrierTrackingNumber='NULL'
    THEN cast('N/A' AS VARCHAR(16))
    ELSE
    cast(coalesce(trim(CarrierTrackingNumber),'N/A') AS VARCHAR(16)) END AS CarrierTrackingNumber,

--CASE WHEN OrderQty = 'NULL' THEN -1 ELSE OrderQty END AS OrderQty,
CASE
    WHEN  OrderQty='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( OrderQty),'-1') AS VARCHAR(20)) AS INT) END AS  OrderQty,

--CASE WHEN ProductID1 = 'NULL' THEN -1 ELSE ProductID1 END AS ProductID,
CASE
    WHEN  ProductID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( ProductID1),'-1') AS VARCHAR(20)) AS INT) END AS  ProductID1,


--CASE WHEN SpecialOfferID1 = 'NULL' THEN -1 ELSE SpecialOfferID1 END AS SpecialOfferID,
CASE
    WHEN  SpecialOfferID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( SpecialOfferID1),'-1') AS VARCHAR(20)) AS INT) END AS  SpecialOfferID1,


--CASE WHEN  UnitPrice = 'NULL' THEN -1 ELSE  CAST(UnitPrice AS DECIMAL(10,2)) END AS UnitPrice,
CASE
    WHEN   UnitPrice='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(UnitPrice),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS UnitPrice,


--CASE WHEN UnitPriceDiscount = 'NULL' THEN -1 ELSE  CAST(UnitPriceDiscount AS DECIMAL(6,2)) END AS UnitPriceDiscount,
CASE
    WHEN   UnitPriceDiscount='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(6,2))
    ELSE 
    cast(cast(coalesce(trim(UnitPriceDiscount),'-1') AS VARCHAR(20)) AS DECIMAL(6,2)) END AS UnitPriceDiscount,


--CASE WHEN  LineTotal = 'NULL' THEN -1 ELSE  CAST(LineTotal AS DECIMAL(10,2)) END AS LineTotal
CASE
    WHEN   LineTotal='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(LineTotal),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS LineTotal
	FROM DP_STG1.Sales_May_06_10;

	
INSERT INTO DP_STG2.SalesOrderDetail	
SELECT DISTINCT
	CASE
    WHEN  BusinessEntityID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( BusinessEntityID1),'-1') AS VARCHAR(20)) AS INT) END AS  BusinessEntityID1,


--CASE WHEN SalesOrderID1 = 'NULL' THEN -1 ELSE SalesOrderID1 END AS SalesOrderID1,
CASE
    WHEN  SalesOrderID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( SalesOrderID1),'-1') AS VARCHAR(20)) AS INT) END AS  SalesOrderID1,
    
--CASE WHEN SalesOrderDetailID = 'NULL' THEN -1 ELSE SalesOrderDetailID END AS SalesOrderDetailID,
CASE
    WHEN  SalesOrderDetailID='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( SalesOrderDetailID),'-1') AS VARCHAR(20)) AS INT) END AS  SalesOrderDetailID,
    


--CASE WHEN CarrierTrackingNumber = 'NULL' THEN 'N/A' ELSE CarrierTrackingNumber END AS CarrierTrackingNumber,
CASE 
    WHEN CarrierTrackingNumber='NULL'
    THEN cast('N/A' AS VARCHAR(16))
    ELSE
    cast(coalesce(trim(CarrierTrackingNumber),'N/A') AS VARCHAR(16)) END AS CarrierTrackingNumber,

--CASE WHEN OrderQty = 'NULL' THEN -1 ELSE OrderQty END AS OrderQty,
CASE
    WHEN  OrderQty='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( OrderQty),'-1') AS VARCHAR(20)) AS INT) END AS  OrderQty,

--CASE WHEN ProductID1 = 'NULL' THEN -1 ELSE ProductID1 END AS ProductID,
CASE
    WHEN  ProductID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( ProductID1),'-1') AS VARCHAR(20)) AS INT) END AS  ProductID1,


--CASE WHEN SpecialOfferID1 = 'NULL' THEN -1 ELSE SpecialOfferID1 END AS SpecialOfferID,
CASE
    WHEN  SpecialOfferID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( SpecialOfferID1),'-1') AS VARCHAR(20)) AS INT) END AS  SpecialOfferID1,


--CASE WHEN  UnitPrice = 'NULL' THEN -1 ELSE  CAST(UnitPrice AS DECIMAL(10,2)) END AS UnitPrice,
CASE
    WHEN   UnitPrice='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(UnitPrice),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS UnitPrice,


--CASE WHEN UnitPriceDiscount = 'NULL' THEN -1 ELSE  CAST(UnitPriceDiscount AS DECIMAL(6,2)) END AS UnitPriceDiscount,
CASE
    WHEN   UnitPriceDiscount='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(6,2))
    ELSE 
    cast(cast(coalesce(trim(UnitPriceDiscount),'-1') AS VARCHAR(20)) AS DECIMAL(6,2)) END AS UnitPriceDiscount,


--CASE WHEN  LineTotal = 'NULL' THEN -1 ELSE  CAST(LineTotal AS DECIMAL(10,2)) END AS LineTotal
CASE
    WHEN   LineTotal='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(LineTotal),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS LineTotal
	FROM DP_STG1.Sales_May_11_20;


INSERT INTO DP_STG2.SalesOrderDetail	
SELECT DISTINCT
	CASE
    WHEN  BusinessEntityID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( BusinessEntityID1),'-1') AS VARCHAR(20)) AS INT) END AS  BusinessEntityID1,


--CASE WHEN SalesOrderID1 = 'NULL' THEN -1 ELSE SalesOrderID1 END AS SalesOrderID1,
CASE
    WHEN  SalesOrderID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( SalesOrderID1),'-1') AS VARCHAR(20)) AS INT) END AS  SalesOrderID1,
    
--CASE WHEN SalesOrderDetailID = 'NULL' THEN -1 ELSE SalesOrderDetailID END AS SalesOrderDetailID,
CASE
    WHEN  SalesOrderDetailID='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( SalesOrderDetailID),'-1') AS VARCHAR(20)) AS INT) END AS  SalesOrderDetailID,
    


--CASE WHEN CarrierTrackingNumber = 'NULL' THEN 'N/A' ELSE CarrierTrackingNumber END AS CarrierTrackingNumber,
CASE 
    WHEN CarrierTrackingNumber='NULL'
    THEN cast('N/A' AS VARCHAR(16))
    ELSE
    cast(coalesce(trim(CarrierTrackingNumber),'N/A') AS VARCHAR(16)) END AS CarrierTrackingNumber,

--CASE WHEN OrderQty = 'NULL' THEN -1 ELSE OrderQty END AS OrderQty,
CASE
    WHEN  OrderQty='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( OrderQty),'-1') AS VARCHAR(20)) AS INT) END AS  OrderQty,

--CASE WHEN ProductID1 = 'NULL' THEN -1 ELSE ProductID1 END AS ProductID,
CASE
    WHEN  ProductID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( ProductID1),'-1') AS VARCHAR(20)) AS INT) END AS  ProductID1,


--CASE WHEN SpecialOfferID1 = 'NULL' THEN -1 ELSE SpecialOfferID1 END AS SpecialOfferID,
CASE
    WHEN  SpecialOfferID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( SpecialOfferID1),'-1') AS VARCHAR(20)) AS INT) END AS  SpecialOfferID1,


--CASE WHEN  UnitPrice = 'NULL' THEN -1 ELSE  CAST(UnitPrice AS DECIMAL(10,2)) END AS UnitPrice,
CASE
    WHEN   UnitPrice='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(UnitPrice),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS UnitPrice,


--CASE WHEN UnitPriceDiscount = 'NULL' THEN -1 ELSE  CAST(UnitPriceDiscount AS DECIMAL(6,2)) END AS UnitPriceDiscount,
CASE
    WHEN   UnitPriceDiscount='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(6,2))
    ELSE 
    cast(cast(coalesce(trim(UnitPriceDiscount),'-1') AS VARCHAR(20)) AS DECIMAL(6,2)) END AS UnitPriceDiscount,


--CASE WHEN  LineTotal = 'NULL' THEN -1 ELSE  CAST(LineTotal AS DECIMAL(10,2)) END AS LineTotal
CASE
    WHEN   LineTotal='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(LineTotal),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS LineTotal

FROM DP_STG1.Sales_May_21_31;



INSERT INTO dp_stg2.salesorderdetail

SELECT DISTINCT

	CASE
    WHEN  BusinessEntityID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( BusinessEntityID1),'-1') AS VARCHAR(20)) AS INT) END AS  BusinessEntityID1,


--CASE WHEN SalesOrderID1 = 'NULL' THEN -1 ELSE SalesOrderID1 END AS SalesOrderID1,
CASE
    WHEN  SalesOrderID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( SalesOrderID1),'-1') AS VARCHAR(20)) AS INT) END AS  SalesOrderID1,
    
--CASE WHEN SalesOrderDetailID = 'NULL' THEN -1 ELSE SalesOrderDetailID END AS SalesOrderDetailID,
CASE
    WHEN  SalesOrderDetailID='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( SalesOrderDetailID),'-1') AS VARCHAR(20)) AS INT) END AS  SalesOrderDetailID,
    


--CASE WHEN CarrierTrackingNumber = 'NULL' THEN 'N/A' ELSE CarrierTrackingNumber END AS CarrierTrackingNumber,
CASE 
    WHEN CarrierTrackingNumber='NULL'
    THEN cast('N/A' AS VARCHAR(16))
    ELSE
    cast(coalesce(trim(CarrierTrackingNumber),'N/A') AS VARCHAR(16)) END AS CarrierTrackingNumber,

--CASE WHEN OrderQty = 'NULL' THEN -1 ELSE OrderQty END AS OrderQty,
CASE
    WHEN  OrderQty='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( OrderQty),'-1') AS VARCHAR(20)) AS INT) END AS  OrderQty,

--CASE WHEN ProductID1 = 'NULL' THEN -1 ELSE ProductID1 END AS ProductID,
CASE
    WHEN  ProductID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( ProductID1),'-1') AS VARCHAR(20)) AS INT) END AS  ProductID1,


--CASE WHEN SpecialOfferID1 = 'NULL' THEN -1 ELSE SpecialOfferID1 END AS SpecialOfferID,
CASE
    WHEN  SpecialOfferID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( SpecialOfferID1),'-1') AS VARCHAR(20)) AS INT) END AS  SpecialOfferID1,


--CASE WHEN  UnitPrice = 'NULL' THEN -1 ELSE  CAST(UnitPrice AS DECIMAL(10,2)) END AS UnitPrice,
CASE
    WHEN   UnitPrice='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(UnitPrice),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS UnitPrice,


--CASE WHEN UnitPriceDiscount = 'NULL' THEN -1 ELSE  CAST(UnitPriceDiscount AS DECIMAL(6,2)) END AS UnitPriceDiscount,
CASE
    WHEN   UnitPriceDiscount='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(6,2))
    ELSE 
    cast(cast(coalesce(trim(UnitPriceDiscount),'-1') AS VARCHAR(20)) AS DECIMAL(6,2)) END AS UnitPriceDiscount,


--CASE WHEN  LineTotal = 'NULL' THEN -1 ELSE  CAST(LineTotal AS DECIMAL(10,2)) END AS LineTotal
CASE
    WHEN   LineTotal='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(LineTotal),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS LineTotal
	FROM DP_STG1.Sales_May_11_20;


INSERT INTO DP_STG2.SalesOrderDetail	
SELECT DISTINCT
	CASE
    WHEN  BusinessEntityID='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( BusinessEntityID),'-1') AS VARCHAR(20)) AS INT) END AS  BusinessEntityID,


--CASE WHEN SalesOrderID1 = 'NULL' THEN -1 ELSE SalesOrderID1 END AS SalesOrderID1,
CASE
    WHEN  SalesOrderID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( SalesOrderID1),'-1') AS VARCHAR(20)) AS INT) END AS  SalesOrderID1,
    
--CASE WHEN SalesOrderDetailID = 'NULL' THEN -1 ELSE SalesOrderDetailID END AS SalesOrderDetailID,
CASE
    WHEN  SalesOrderDetailID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( SalesOrderDetailID1),'-1') AS VARCHAR(20)) AS INT) END AS  SalesOrderDetailID1,
    


--CASE WHEN CarrierTrackingNumber = 'NULL' THEN 'N/A' ELSE CarrierTrackingNumber END AS CarrierTrackingNumber,
CASE 
    WHEN CarrierTrackingNumber1='NULL'
    THEN cast('N/A' AS VARCHAR(16))
    ELSE
    cast(coalesce(trim(CarrierTrackingNumber1),'N/A') AS VARCHAR(16)) END AS CarrierTrackingNumber1,

--CASE WHEN OrderQty = 'NULL' THEN -1 ELSE OrderQty END AS OrderQty,
CASE
    WHEN  OrderQty1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( OrderQty1),'-1') AS VARCHAR(20)) AS INT) END AS  OrderQty1,

--CASE WHEN ProductID1 = 'NULL' THEN -1 ELSE ProductID1 END AS ProductID,
CASE
    WHEN  ProductID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( ProductID1),'-1') AS VARCHAR(20)) AS INT) END AS  ProductID1,


--CASE WHEN SpecialOfferID1 = 'NULL' THEN -1 ELSE SpecialOfferID1 END AS SpecialOfferID,
CASE
    WHEN  SpecialOfferID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( SpecialOfferID1),'-1') AS VARCHAR(20)) AS INT) END AS  SpecialOfferID1,


--CASE WHEN  UnitPrice = 'NULL' THEN -1 ELSE  CAST(UnitPrice AS DECIMAL(10,2)) END AS UnitPrice,
CASE
    WHEN   UnitPrice1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(UnitPrice1),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS UnitPrice,


--CASE WHEN UnitPriceDiscount = 'NULL' THEN -1 ELSE  CAST(UnitPriceDiscount AS DECIMAL(6,2)) END AS UnitPriceDiscount,
CASE
    WHEN   UnitPriceDiscount1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(6,2))
    ELSE 
    cast(cast(coalesce(trim(UnitPriceDiscount1),'-1') AS VARCHAR(20)) AS DECIMAL(6,2)) END AS UnitPriceDiscount,


--CASE WHEN  LineTotal = 'NULL' THEN -1 ELSE  CAST(LineTotal AS DECIMAL(10,2)) END AS LineTotal
CASE
    WHEN   LineTotal='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(LineTotal),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS LineTotal

FROM dp_stg1.sales_3_new;



--Checking if the data have been loaded in to the target table or not
--It should return 1911 Rows

--1911 ROWS
SELECT *
FROM dp_stg2.salesorderdetail;


SELECT count(*) AS NumberOFRows
from dp_stg2.salesorderdetail;

--Issue resolved by this overwrite distinct (it was because of union)

INSERT OVERWRITE TABLE dp_stg2.salesorderdetail
SELECT DISTINCT * FROM dp_stg2.salesorderdetail;



	 



