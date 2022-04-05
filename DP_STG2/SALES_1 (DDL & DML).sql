--SALES TABLES ACCORDING TO SCHEMA

--TOTAL TABLES=18

--1)CreditCard  --412 but 392 (DONE)  In This File
--2)Currency
--3)CurrencyRate
--4)Customer 
--5)PersonCreditCard  (Zaeem) --412 but 392 (DONE) In This File
--6)SalesOrderDetail  
--7)SalesOrderHeader
--8)SalesOrderHeaderSalesReason (zaeem)--646 but 690 (DONE) In This File
--9)SalesPerson   (zaeem)               --DONE   In This FIle
--10)SalesPersonQuotaHistory (Zaeem)
--11)SalesReason    (Zaeem)
--12)SalesTaxRate(zaeeem)
--13)SalesTerritory (zaeem)
--14)SalesTerritoryHistory (zaeem)
--15)ShoppingCartItem  (zaeem)
--16)SpecialOffer
--17)SpecialOfferProduct
--18)Store

------------------------------------------------------------------------------------------

--Comments

--We are cleansing the data (Removing NULL values and Empty Rows by using constraints) and assigining data types
--The input is stage 1 layer and populating into different tables according to business (Schema)
--Also making surrogate keys where required.
--Loading data in same format in the target Table
--Using constraints.

--This File contains The following Tables DDL and DML

--1) CreditCard Table 
--2) PersonCreditCard
--3) SalesOrderHeaderSalesReason 
--4) SalesPerson Table


----------------------------------------------------------------------------------------------------------------------
--1) CreditCard Table
--According to Schema

----------------------------------------------------------------------------------------------

--Dropping the table if there is any issue while loading the data into the target table

DROP TABLE DP_STG2.CreditCard;

--Refreshing the table after inserting the data into the table 

REFRESH dp_stg2.creditcard;

--Creating the ProductInventory table total 5 columns
--1)CreditCardID , 2)CardType, 3)CardNumber, 4)ExpMonth, 5)ExpYear



CREATE TABLE dp_stg2.CreditCard
(
	CreditCardID INTEGER,
	CardType VARCHAR(16),
	CardNumber VARCHAR(64),
	ExpMonth SMALLINT,
	ExpYear SMALLINT
);




--Inserting data into the table from the source table and removing NULL from the source table
--Cleaning the Data and defining data types.

INSERT INTO DP_STG2.CreditCard	

SELECT DISTINCT 
	--CASE WHEN CreditCardID1='NULL' THEN -1 ELSE CreditCardID1 END AS  CreditCardID,
	CASE
    WHEN  CreditCardID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(CreditCardID1),'-1') AS VARCHAR(20)) AS INT) END AS  CreditCardID1,
	
	--CASE WHEN CardType='NULL' THEN 'N/A' ELSE CardType END  AS CardType,
	CASE
    WHEN CardType='NULL'
    THEN cast('N/A' AS VARCHAR(16) )
    ELSE 
    cast(coalesce(trim(CardType),'N/A') AS VARCHAR(16)) END AS  CardType,
    
    
--	CASE WHEN CardNumber = 'NULL' THEN 'NA' ELSE CardNumber END AS CardNumber,
    CASE
    WHEN CardNumber='NULL'
    THEN cast('N/A' AS VARCHAR(64) )
    ELSE 
    cast(coalesce(trim(CardNumber),'N/A') AS VARCHAR(64)) END AS  CardNumber,
    
	--CASE WHEN ExpMonth='NULL' THEN -1 ELSE CAST(ExpMonth AS SMALLINT) END AS  ExpMonth,
	CASE
    WHEN  ExpMonth='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS SMALLINT)
    ELSE 
    cast(cast(coalesce(trim(ExpMonth),'-1') AS VARCHAR(20)) AS SMALLINT) END AS  ExpMonth,
	
	--CASE WHEN ExpYear='NULL' THEN -1 ELSE CAST(ExpYear AS SMALLINT) END AS  ExpYear
	CASE
    WHEN  ExpYear='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS SMALLINT)
    ELSE 
    cast(cast(coalesce(trim(ExpYear),'-1') AS VARCHAR(20)) AS SMALLINT) END AS  ExpYear
    
FROM Dp_Stg1.Sales;

INSERT INTO DP_STG2.CreditCard	
SELECT DISTINCT 
		--CASE WHEN CreditCardID1='NULL' THEN -1 ELSE CreditCardID1 END AS  CreditCardID,
	CASE
    WHEN  CreditCardID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(CreditCardID1),'-1') AS VARCHAR(20)) AS INT) END AS  CreditCardID1,
	
	--CASE WHEN CardType='NULL' THEN 'N/A' ELSE CardType END  AS CardType,
	CASE
    WHEN CardType='NULL'
    THEN cast('N/A' AS VARCHAR(16) )
    ELSE 
    cast(coalesce(trim(CardType),'N/A') AS VARCHAR(16)) END AS  CardType,
    
    
--	CASE WHEN CardNumber = 'NULL' THEN 'NA' ELSE CardNumber END AS CardNumber,
    CASE
    WHEN CardNumber='NULL'
    THEN cast('N/A' AS VARCHAR(64) )
    ELSE 
    cast(coalesce(trim(CardNumber),'N/A') AS VARCHAR(64)) END AS  CardNumber,
    
	--CASE WHEN ExpMonth='NULL' THEN -1 ELSE CAST(ExpMonth AS SMALLINT) END AS  ExpMonth,
	CASE
    WHEN  ExpMonth='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS SMALLINT)
    ELSE 
    cast(cast(coalesce(trim(ExpMonth),'-1') AS VARCHAR(20)) AS SMALLINT) END AS  ExpMonth,
	
	--CASE WHEN ExpYear='NULL' THEN -1 ELSE CAST(ExpYear AS SMALLINT) END AS  ExpYear
	CASE
    WHEN  ExpYear='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS SMALLINT)
    ELSE 
    cast(cast(coalesce(trim(ExpYear),'-1') AS VARCHAR(20)) AS SMALLINT) END AS  ExpYear
    
FROM Dp_Stg1.Sales_April_1_10;


INSERT INTO DP_STG2.CreditCard	
SELECT DISTINCT 
		--CASE WHEN CreditCardID1='NULL' THEN -1 ELSE CreditCardID1 END AS  CreditCardID,
	CASE
    WHEN  CreditCardID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(CreditCardID1),'-1') AS VARCHAR(20)) AS INT) END AS  CreditCardID1,
	
	--CASE WHEN CardType='NULL' THEN 'N/A' ELSE CardType END  AS CardType,
	CASE
    WHEN CardType='NULL'
    THEN cast('N/A' AS VARCHAR(16) )
    ELSE 
    cast(coalesce(trim(CardType),'N/A') AS VARCHAR(16)) END AS  CardType,
    
    
--	CASE WHEN CardNumber = 'NULL' THEN 'NA' ELSE CardNumber END AS CardNumber,
    CASE
    WHEN CardNumber='NULL'
    THEN cast('N/A' AS VARCHAR(64) )
    ELSE 
    cast(coalesce(trim(CardNumber),'N/A') AS VARCHAR(64)) END AS  CardNumber,
    
	--CASE WHEN ExpMonth='NULL' THEN -1 ELSE CAST(ExpMonth AS SMALLINT) END AS  ExpMonth,
	CASE
    WHEN  ExpMonth='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS SMALLINT)
    ELSE 
    cast(cast(coalesce(trim(ExpMonth),'-1') AS VARCHAR(20)) AS SMALLINT) END AS  ExpMonth,
	
	--CASE WHEN ExpYear='NULL' THEN -1 ELSE CAST(ExpYear AS SMALLINT) END AS  ExpYear
	CASE
    WHEN  ExpYear='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS SMALLINT)
    ELSE 
    cast(cast(coalesce(trim(ExpYear),'-1') AS VARCHAR(20)) AS SMALLINT) END AS  ExpYear
FROM Dp_Stg1.Sales_April_11_20

INSERT INTO DP_STG2.CreditCard	
SELECT DISTINCT 
		--CASE WHEN CreditCardID1='NULL' THEN -1 ELSE CreditCardID1 END AS  CreditCardID,
	CASE
    WHEN  CreditCardID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(CreditCardID1),'-1') AS VARCHAR(20)) AS INT) END AS  CreditCardID1,
	
	--CASE WHEN CardType='NULL' THEN 'N/A' ELSE CardType END  AS CardType,
	CASE
    WHEN CardType='NULL'
    THEN cast('N/A' AS VARCHAR(16) )
    ELSE 
    cast(coalesce(trim(CardType),'N/A') AS VARCHAR(16)) END AS  CardType,
    
    
--	CASE WHEN CardNumber = 'NULL' THEN 'NA' ELSE CardNumber END AS CardNumber,
    CASE
    WHEN CardNumber='NULL'
    THEN cast('N/A' AS VARCHAR(64) )
    ELSE 
    cast(coalesce(trim(CardNumber),'N/A') AS VARCHAR(64)) END AS  CardNumber,
    
	--CASE WHEN ExpMonth='NULL' THEN -1 ELSE CAST(ExpMonth AS SMALLINT) END AS  ExpMonth,
	CASE
    WHEN  ExpMonth='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS SMALLINT)
    ELSE 
    cast(cast(coalesce(trim(ExpMonth),'-1') AS VARCHAR(20)) AS SMALLINT) END AS  ExpMonth,
	
	--CASE WHEN ExpYear='NULL' THEN -1 ELSE CAST(ExpYear AS SMALLINT) END AS  ExpYear
	CASE
    WHEN  ExpYear='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS SMALLINT)
    ELSE 
    cast(cast(coalesce(trim(ExpYear),'-1') AS VARCHAR(20)) AS SMALLINT) END AS  ExpYear
FROM Dp_Stg1.Sales_April_21_30

INSERT INTO DP_STG2.CreditCard	
SELECT DISTINCT 
		--CASE WHEN CreditCardID1='NULL' THEN -1 ELSE CreditCardID1 END AS  CreditCardID,
	CASE
    WHEN  CreditCardID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(CreditCardID1),'-1') AS VARCHAR(20)) AS INT) END AS  CreditCardID1,
	
	--CASE WHEN CardType='NULL' THEN 'N/A' ELSE CardType END  AS CardType,
	CASE
    WHEN CardType='NULL'
    THEN cast('N/A' AS VARCHAR(16) )
    ELSE 
    cast(coalesce(trim(CardType),'N/A') AS VARCHAR(16)) END AS  CardType,
    
    
--	CASE WHEN CardNumber = 'NULL' THEN 'NA' ELSE CardNumber END AS CardNumber,
    CASE
    WHEN CardNumber='NULL'
    THEN cast('N/A' AS VARCHAR(64) )
    ELSE 
    cast(coalesce(trim(CardNumber),'N/A') AS VARCHAR(64)) END AS  CardNumber,
    
	--CASE WHEN ExpMonth='NULL' THEN -1 ELSE CAST(ExpMonth AS SMALLINT) END AS  ExpMonth,
	CASE
    WHEN  ExpMonth='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS SMALLINT)
    ELSE 
    cast(cast(coalesce(trim(ExpMonth),'-1') AS VARCHAR(20)) AS SMALLINT) END AS  ExpMonth,
	
	--CASE WHEN ExpYear='NULL' THEN -1 ELSE CAST(ExpYear AS SMALLINT) END AS  ExpYear
	CASE
    WHEN  ExpYear='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS SMALLINT)
    ELSE 
    cast(cast(coalesce(trim(ExpYear),'-1') AS VARCHAR(20)) AS SMALLINT) END AS  ExpYearr
FROM Dp_Stg1.Sales_May_06_10

INSERT INTO DP_STG2.CreditCard	
SELECT DISTINCT 
		--CASE WHEN CreditCardID1='NULL' THEN -1 ELSE CreditCardID1 END AS  CreditCardID,
	CASE
    WHEN  CreditCardID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(CreditCardID1),'-1') AS VARCHAR(20)) AS INT) END AS  CreditCardID1,
	
	--CASE WHEN CardType='NULL' THEN 'N/A' ELSE CardType END  AS CardType,
	CASE
    WHEN CardType='NULL'
    THEN cast('N/A' AS VARCHAR(16) )
    ELSE 
    cast(coalesce(trim(CardType),'N/A') AS VARCHAR(16)) END AS  CardType,
    
    
--	CASE WHEN CardNumber = 'NULL' THEN 'NA' ELSE CardNumber END AS CardNumber,
    CASE
    WHEN CardNumber='NULL'
    THEN cast('N/A' AS VARCHAR(64) )
    ELSE 
    cast(coalesce(trim(CardNumber),'N/A') AS VARCHAR(64)) END AS  CardNumber,
    
	--CASE WHEN ExpMonth='NULL' THEN -1 ELSE CAST(ExpMonth AS SMALLINT) END AS  ExpMonth,
	CASE
    WHEN  ExpMonth='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS SMALLINT)
    ELSE 
    cast(cast(coalesce(trim(ExpMonth),'-1') AS VARCHAR(20)) AS SMALLINT) END AS  ExpMonth,
	
	--CASE WHEN ExpYear='NULL' THEN -1 ELSE CAST(ExpYear AS SMALLINT) END AS  ExpYear
	CASE
    WHEN  ExpYear='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS SMALLINT)
    ELSE 
    cast(cast(coalesce(trim(ExpYear),'-1') AS VARCHAR(20)) AS SMALLINT) END AS  ExpYear
FROM Dp_Stg1.Sales_May_11_20


INSERT INTO DP_STG2.CreditCard	
SELECT DISTINCT 
		--CASE WHEN CreditCardID1='NULL' THEN -1 ELSE CreditCardID1 END AS  CreditCardID,
	CASE
    WHEN  CreditCardID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(CreditCardID1),'-1') AS VARCHAR(20)) AS INT) END AS  CreditCardID1,
	
	--CASE WHEN CardType='NULL' THEN 'N/A' ELSE CardType END  AS CardType,
	CASE
    WHEN CardType='NULL'
    THEN cast('N/A' AS VARCHAR(16) )
    ELSE 
    cast(coalesce(trim(CardType),'N/A') AS VARCHAR(16)) END AS  CardType,
    
    
--	CASE WHEN CardNumber = 'NULL' THEN 'NA' ELSE CardNumber END AS CardNumber,
    CASE
    WHEN CardNumber='NULL'
    THEN cast('N/A' AS VARCHAR(64) )
    ELSE 
    cast(coalesce(trim(CardNumber),'N/A') AS VARCHAR(64)) END AS  CardNumber,
    
	--CASE WHEN ExpMonth='NULL' THEN -1 ELSE CAST(ExpMonth AS SMALLINT) END AS  ExpMonth,
	CASE
    WHEN  ExpMonth='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS SMALLINT)
    ELSE 
    cast(cast(coalesce(trim(ExpMonth),'-1') AS VARCHAR(20)) AS SMALLINT) END AS  ExpMonth,
	
	--CASE WHEN ExpYear='NULL' THEN -1 ELSE CAST(ExpYear AS SMALLINT) END AS  ExpYear
	CASE
    WHEN  ExpYear='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS SMALLINT)
    ELSE 
    cast(cast(coalesce(trim(ExpYear),'-1') AS VARCHAR(20)) AS SMALLINT) END AS  ExpYear
FROM Dp_Stg1.Sales_May_21_31;


--Checking if the data have been loaded in to the target table or not
--It should return 412 Rows BUT GETTING 392 ROWS

SELECT *
FROM DP_STG2.CreditCard;

SELECT COUNT(*)
FROM dp_stg2.creditcard;



------------------------------------------------------------------------------------------------------

--2) PersonCreditCard

---------------------------------------------------

--Dropping the table if there is any issue while loading the data into the target table


DROP TABLE DP_STG2.PersonCreditCard;


--Refreshing the table after inserting the data into the table 

REFRESH dp_stg2.personcreditcard;


--Creating the ProductInventory table total 5 columns
--1) BusinessEntityID, 2) CreditCardID

CREATE TABLE dp_stg2.PersonCreditCard
(
    BusinessEntityID INT,
	CreditCardID INT
);


--Inserting data into the table from the source table and removing NULL from the source table
--Cleaning the Data and defining data types.

INSERT INTO DP_STG2.PersonCreditCard	
SELECT DISTINCT 
    --CASE WHEN BusinessEntityID1='NULL' THEN -1 ELSE BusinessEntityID1 END AS  BusinessEntityID,
    CASE
    WHEN  BusinessEntityID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( BusinessEntityID1),'-1') AS VARCHAR(20)) AS INT) END AS  BusinessEntityID,

	--CASE WHEN CreditCardID1='NULL' THEN -1 ELSE CreditCardID1 END AS  CreditCardID
    CASE
    WHEN  CreditCardID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( CreditCardID1),'-1') AS VARCHAR(20)) AS INT) END AS  CreditCardID
    
FROM Dp_Stg1.Sales;

INSERT INTO DP_STG2.PersonCreditCard
SELECT DISTINCT 
	 --CASE WHEN BusinessEntityID1='NULL' THEN -1 ELSE BusinessEntityID1 END AS  BusinessEntityID,
    CASE
    WHEN  BusinessEntityID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( BusinessEntityID1),'-1') AS VARCHAR(20)) AS INT) END AS  BusinessEntityID,

	--CASE WHEN CreditCardID1='NULL' THEN -1 ELSE CreditCardID1 END AS  CreditCardID
    CASE
    WHEN  CreditCardID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( CreditCardID1),'-1') AS VARCHAR(20)) AS INT) END AS  CreditCardID
    
FROM Dp_Stg1.Sales_April_1_10;


INSERT INTO DP_STG2.PersonCreditCard
SELECT DISTINCT 
	 --CASE WHEN BusinessEntityID1='NULL' THEN -1 ELSE BusinessEntityID1 END AS  BusinessEntityID,
    CASE
    WHEN  BusinessEntityID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( BusinessEntityID1),'-1') AS VARCHAR(20)) AS INT) END AS  BusinessEntityID,

	--CASE WHEN CreditCardID1='NULL' THEN -1 ELSE CreditCardID1 END AS  CreditCardID
    CASE
    WHEN  CreditCardID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( CreditCardID1),'-1') AS VARCHAR(20)) AS INT) END AS  CreditCardID
FROM Dp_Stg1.Sales_April_11_20;

INSERT INTO DP_STG2.PersonCreditCard
SELECT DISTINCT 
	 --CASE WHEN BusinessEntityID1='NULL' THEN -1 ELSE BusinessEntityID1 END AS  BusinessEntityID,
    CASE
    WHEN  BusinessEntityID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( BusinessEntityID1),'-1') AS VARCHAR(20)) AS INT) END AS  BusinessEntityID,

	--CASE WHEN CreditCardID1='NULL' THEN -1 ELSE CreditCardID1 END AS  CreditCardID
    CASE
    WHEN  CreditCardID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( CreditCardID1),'-1') AS VARCHAR(20)) AS INT) END AS  CreditCardID
FROM Dp_Stg1.Sales_April_21_30;

INSERT INTO DP_STG2.PersonCreditCard
SELECT DISTINCT 
	 --CASE WHEN BusinessEntityID1='NULL' THEN -1 ELSE BusinessEntityID1 END AS  BusinessEntityID,
    CASE
    WHEN  BusinessEntityID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( BusinessEntityID1),'-1') AS VARCHAR(20)) AS INT) END AS  BusinessEntityID,

	--CASE WHEN CreditCardID1='NULL' THEN -1 ELSE CreditCardID1 END AS  CreditCardID
    CASE
    WHEN  CreditCardID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( CreditCardID1),'-1') AS VARCHAR(20)) AS INT) END AS  CreditCardID
FROM Dp_Stg1.Sales_May_06_10;

INSERT INTO DP_STG2.PersonCreditCard
SELECT DISTINCT 
	 --CASE WHEN BusinessEntityID1='NULL' THEN -1 ELSE BusinessEntityID1 END AS  BusinessEntityID,
    CASE
    WHEN  BusinessEntityID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( BusinessEntityID1),'-1') AS VARCHAR(20)) AS INT) END AS  BusinessEntityID,

	--CASE WHEN CreditCardID1='NULL' THEN -1 ELSE CreditCardID1 END AS  CreditCardID
    CASE
    WHEN  CreditCardID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( CreditCardID1),'-1') AS VARCHAR(20)) AS INT) END AS  CreditCardID
FROM Dp_Stg1.Sales_May_11_20;

INSERT INTO DP_STG2.PersonCreditCard
SELECT DISTINCT 
	 --CASE WHEN BusinessEntityID1='NULL' THEN -1 ELSE BusinessEntityID1 END AS  BusinessEntityID,
    CASE
    WHEN  BusinessEntityID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( BusinessEntityID1),'-1') AS VARCHAR(20)) AS INT) END AS  BusinessEntityID,

	--CASE WHEN CreditCardID1='NULL' THEN -1 ELSE CreditCardID1 END AS  CreditCardID
    CASE
    WHEN  CreditCardID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( CreditCardID1),'-1') AS VARCHAR(20)) AS INT) END AS  CreditCardID
FROM Dp_Stg1.Sales_May_21_31;


--Checking if the data have been loaded in to the target table or not
--It should return 412 Rows BUT GETTING 392 ROWS

SELECT *
FROM DP_STG2.PersonCreditCard;

SELECT COUNT(*)
FROM dp_stg2.personcreditcard;

-----------------------------------------------------------------------------------------------------------------------------------------------------------

--3)SalesOrderHeaderSalesReason 
-- According to Schema

-------------------------------------------------
--Dropping the table if there is any issue while loading the data into the target table

DROP TABLE DP_STG2.SalesOrderHeaderSalesReason;

--Refreshing the table after inserting the data into the table 

REFRESH dp_stg2.salesOrderHeaderSalesReason;

--Creating the SalesOrderHeaderSalesReason table total 3 columns
--1)  BusinessEntityID, 2)SalesOrderID, 3)SalesReasonID


CREATE TABLE dp_stg2.SalesOrderHeaderSalesReason
	(
	    BusinessEntityID INT,
		SalesOrderID INT,
		SalesReasonID INT
	);




--Inserting data into the table from the source table and removing NULL from the source table
--Cleaning the Data and defining data types.

INSERT INTO DP_STG2.SalesOrderHeaderSalesReason
SELECT DISTINCT 
    --CASE WHEN BusinessEntityID1 ='NULL' THEN -1 ELSE BusinessEntityID1 END AS BusinessEntityID1,
    CASE
    WHEN  BusinessEntityID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( BusinessEntityID1),'-1') AS VARCHAR(20)) AS INT) END AS  BusinessEntityID1,

    --CASE WHEN SalesOrderID1 ='NULL' THEN -1 ELSE SalesOrderID1 END AS SalesOrderID,
    CASE
    WHEN  SalesOrderID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( SalesOrderID1),'-1') AS VARCHAR(20)) AS INT) END AS  SalesOrderID,

	--CASE WHEN SalesReasonID1 ='NULL' THEN -1 ELSE SalesReasonID1 END AS SalesReasonID
    CASE
    WHEN  SalesReasonID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( SalesReasonID1),'-1') AS VARCHAR(20)) AS INT) END AS  SalesReasonID
FROM Dp_Stg1.Sales;


INSERT INTO DP_STG2.SalesOrderHeaderSalesReason
SELECT DISTINCT 
	--CASE WHEN BusinessEntityID1 ='NULL' THEN -1 ELSE BusinessEntityID1 END AS BusinessEntityID1,
    CASE
    WHEN  BusinessEntityID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( BusinessEntityID1),'-1') AS VARCHAR(20)) AS INT) END AS  BusinessEntityID1,

    --CASE WHEN SalesOrderID1 ='NULL' THEN -1 ELSE SalesOrderID1 END AS SalesOrderID,
    CASE
    WHEN  SalesOrderID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( SalesOrderID1),'-1') AS VARCHAR(20)) AS INT) END AS  SalesOrderID,

	--CASE WHEN SalesReasonID1 ='NULL' THEN -1 ELSE SalesReasonID1 END AS SalesReasonID
    CASE
    WHEN  SalesReasonID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( SalesReasonID1),'-1') AS VARCHAR(20)) AS INT) END AS  SalesReasonID
FROM Dp_Stg1.Sales_April_1_10;

INSERT INTO DP_STG2.SalesOrderHeaderSalesReason
SELECT DISTINCT 
	--CASE WHEN BusinessEntityID1 ='NULL' THEN -1 ELSE BusinessEntityID1 END AS BusinessEntityID1,
    CASE
    WHEN  BusinessEntityID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( BusinessEntityID1),'-1') AS VARCHAR(20)) AS INT) END AS  BusinessEntityID1,

    --CASE WHEN SalesOrderID1 ='NULL' THEN -1 ELSE SalesOrderID1 END AS SalesOrderID,
    CASE
    WHEN  SalesOrderID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( SalesOrderID1),'-1') AS VARCHAR(20)) AS INT) END AS  SalesOrderID,

	--CASE WHEN SalesReasonID1 ='NULL' THEN -1 ELSE SalesReasonID1 END AS SalesReasonID
    CASE
    WHEN  SalesReasonID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( SalesReasonID1),'-1') AS VARCHAR(20)) AS INT) END AS  SalesReasonID
FROM Dp_Stg1.Sales_April_11_20;


INSERT INTO DP_STG2.SalesOrderHeaderSalesReason
SELECT DISTINCT 
	--CASE WHEN BusinessEntityID1 ='NULL' THEN -1 ELSE BusinessEntityID1 END AS BusinessEntityID1,
    CASE
    WHEN  BusinessEntityID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( BusinessEntityID1),'-1') AS VARCHAR(20)) AS INT) END AS  BusinessEntityID1,

    --CASE WHEN SalesOrderID1 ='NULL' THEN -1 ELSE SalesOrderID1 END AS SalesOrderID,
    CASE
    WHEN  SalesOrderID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( SalesOrderID1),'-1') AS VARCHAR(20)) AS INT) END AS  SalesOrderID,

	--CASE WHEN SalesReasonID1 ='NULL' THEN -1 ELSE SalesReasonID1 END AS SalesReasonID
    CASE
    WHEN  SalesReasonID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( SalesReasonID1),'-1') AS VARCHAR(20)) AS INT) END AS  SalesReasonID
FROM Dp_Stg1.Sales_April_21_30;


INSERT INTO DP_STG2.SalesOrderHeaderSalesReason
SELECT DISTINCT 
	--CASE WHEN BusinessEntityID1 ='NULL' THEN -1 ELSE BusinessEntityID1 END AS BusinessEntityID1,
    CASE
    WHEN  BusinessEntityID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( BusinessEntityID1),'-1') AS VARCHAR(20)) AS INT) END AS  BusinessEntityID1,

    --CASE WHEN SalesOrderID1 ='NULL' THEN -1 ELSE SalesOrderID1 END AS SalesOrderID,
    CASE
    WHEN  SalesOrderID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( SalesOrderID1),'-1') AS VARCHAR(20)) AS INT) END AS  SalesOrderID,

	--CASE WHEN SalesReasonID1 ='NULL' THEN -1 ELSE SalesReasonID1 END AS SalesReasonID
    CASE
    WHEN  SalesReasonID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( SalesReasonID1),'-1') AS VARCHAR(20)) AS INT) END AS  SalesReasonID
FROM Dp_Stg1.Sales_May_06_10;


INSERT INTO DP_STG2.SalesOrderHeaderSalesReason
SELECT DISTINCT 
	--CASE WHEN BusinessEntityID1 ='NULL' THEN -1 ELSE BusinessEntityID1 END AS BusinessEntityID1,
    CASE
    WHEN  BusinessEntityID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( BusinessEntityID1),'-1') AS VARCHAR(20)) AS INT) END AS  BusinessEntityID1,

    --CASE WHEN SalesOrderID1 ='NULL' THEN -1 ELSE SalesOrderID1 END AS SalesOrderID,
    CASE
    WHEN  SalesOrderID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( SalesOrderID1),'-1') AS VARCHAR(20)) AS INT) END AS  SalesOrderID,

	--CASE WHEN SalesReasonID1 ='NULL' THEN -1 ELSE SalesReasonID1 END AS SalesReasonID
    CASE
    WHEN  SalesReasonID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( SalesReasonID1),'-1') AS VARCHAR(20)) AS INT) END AS  SalesReasonID
FROM Dp_Stg1.Sales_May_11_20;

INSERT INTO DP_STG2.SalesOrderHeaderSalesReason
SELECT DISTINCT 
	--CASE WHEN BusinessEntityID1 ='NULL' THEN -1 ELSE BusinessEntityID1 END AS BusinessEntityID1,
    CASE
    WHEN  BusinessEntityID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( BusinessEntityID1),'-1') AS VARCHAR(20)) AS INT) END AS  BusinessEntityID1,

    --CASE WHEN SalesOrderID1 ='NULL' THEN -1 ELSE SalesOrderID1 END AS SalesOrderID,
    CASE
    WHEN  SalesOrderID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( SalesOrderID1),'-1') AS VARCHAR(20)) AS INT) END AS  SalesOrderID,

	--CASE WHEN SalesReasonID1 ='NULL' THEN -1 ELSE SalesReasonID1 END AS SalesReasonID
    CASE
    WHEN  SalesReasonID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( SalesReasonID1),'-1') AS VARCHAR(20)) AS INT) END AS  SalesReasonID
FROM Dp_Stg1.Sales_May_21_31;


--Checking if the data have been loaded in to the target table or not
--It should return 690 Rows but 646 ROWS


SELECT *
FROM dp_stg2.salesorderheadersalesreason;


--Issue resolved by this overwrite distinct (it was because of union)
INSERT OVERWRITE TABLE dp_stg2.salesorderheadersalesreason
SELECT DISTINCT * FROM dp_stg2.salesorderheadersalesreason;

		
----------------------------------------------------------------------------------------------------------------------------------------------------------

--4) SalesPerson Table
-- According to Schema


--SalesPerson_Sales_April_1_10_ Table Data not loading successfully error:"UDF ERROR: String to Decimal parse failed"
--------------------------------------------------

--Dropping the table if there is any issue while loading the data into the target table
DROP TABLE dp_Stg2.SalesPerson;


--Refreshing the table after inserting the data into the table 

REFRESH dp_stg2.salesperson;

--Creating the SalesPerson table total 7 columns
--1) BusinessEntityID, 2)TerritoryID, 3)SalesQuota, 4)Bonus, 5)CommissionPct, 6)SalesYTD, 7)SalesLastYear


CREATE TABLE dp_stg2.SalesPerson
(
		BusinessEntityID INT,
		TerritoryID INT,
		SalesQuota DECIMAL(10,2),
		Bonus DECIMAL(10,2) ,
		CommissionPct DECIMAL(10,2),
		SalesYTD DECIMAL(10,2) ,
		SalesLastYear DECIMAL(10,2)
);



--Inserting data into the table from the source table and removing NULL from the source table
--Cleaning the Data and defining data types.

--Sales
INSERT INTO DP_STG2.SalesPerson
SELECT DISTINCT
--CASE WHEN BusinessEntityID2 = 'NULL' THEN -1 ELSE BusinessEntityID2 END AS BusinessEntityID2,
CASE
    WHEN  BusinessEntityID2='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( BusinessEntityID2),'-1') AS VARCHAR(20)) AS INT) END AS  BusinessEntityID2,

--CASE WHEN TerritoryID1 = 'NULL' THEN -1 ELSE TerritoryID1 END AS TerritoryID1,
CASE
    WHEN  TerritoryID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( TerritoryID1),'-1') AS VARCHAR(20)) AS INT) END AS  TerritoryID1,

--CASE WHEN  SalesQuota2 = 'NULL' THEN -1 ELSE  CAST(SalesQuota2 AS DECIMAL(10,2)) END AS SalesQuota,
CASE
    WHEN   SalesQuota2='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(SalesQuota2),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS SalesQuota,


--CASE WHEN  Bonus = 'NULL' THEN -1 ELSE  CAST(Bonus AS DECIMAL(10,2)) END AS Bonus,
CASE
    WHEN   Bonus='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(Bonus),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS Bonus,

--CASE WHEN  CommissionPct = 'NULL' THEN -1 ELSE  CAST(CommissionPct AS DECIMAL(10,2)) END AS CommissionPct,
CASE
    WHEN   CommissionPct='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(CommissionPct),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS CommissionPct,

--CASE WHEN  SalesYTD2 = 'NULL' THEN -1 ELSE  CAST(SalesYTD2 AS DECIMAL(10,2)) END AS SalesYTD,
CASE
    WHEN   SalesYTD2='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(SalesYTD2),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS SalesYTD,

--CASE WHEN  SalesLastYear1 = 'NULL' THEN -1 ELSE  CAST(SalesLastYear1 AS DECIMAL(10,2)) END AS SalesLastYear
CASE
    WHEN   SalesLastYear1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(SalesLastYear1),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS SalesLastYear

FROM DP_STG1.Sales;


--THIS DATA IS NOT LOADING HAVING AN ERROR: "UDF ERROR: String to Decimal parse failed"
INSERT INTO DP_STG2.SalesPerson
--Sales_April_1_10
--INSERT INTO DP_STG2.SalesPerson
SELECT DISTINCT
CASE
    WHEN  BusinessEntityID2='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( BusinessEntityID2),'-1') AS VARCHAR(20)) AS INT) END AS  BusinessEntityID2,

--CASE WHEN TerritoryID1 = 'NULL' THEN -1 ELSE TerritoryID1 END AS TerritoryID1,
CASE
    WHEN  TerritoryID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( TerritoryID1),'-1') AS VARCHAR(20)) AS INT) END AS  TerritoryID1,

--CASE WHEN  SalesQuota2 = 'NULL' THEN -1 ELSE  CAST(SalesQuota2 AS DECIMAL(10,2)) END AS SalesQuota,
CASE
    WHEN   SalesQuota2='NULL'
    THEN cast(cast('-1' AS VARCHAR(50) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(SalesQuota2),'-1') AS VARCHAR(50)) AS DECIMAL(10,2)) END AS SalesQuota2,


--CASE WHEN  Bonus = 'NULL' THEN -1 ELSE  CAST(Bonus AS DECIMAL(10,2)) END AS Bonus,
CASE
    WHEN   Bonus='NULL'
    THEN cast(cast('-1' AS VARCHAR(50) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(Bonus),'-1') AS VARCHAR(50)) AS DECIMAL(10,2)) END AS Bonus,

--CASE WHEN  CommissionPct = 'NULL' THEN -1 ELSE  CAST(CommissionPct AS DECIMAL(10,2)) END AS CommissionPct,
CASE
    WHEN   CommissionPct='NULL'
    THEN cast(cast('-1' AS VARCHAR(50) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(CommissionPct),'-1') AS VARCHAR(50)) AS DECIMAL(10,2)) END AS CommissionPct,

--CASE WHEN  SalesYTD2 = 'NULL' THEN -1 ELSE  CAST(SalesYTD2 AS DECIMAL(10,2)) END AS SalesYTD,
CASE
    WHEN   SalesYTD2='NULL'
    THEN cast(cast('-1' AS VARCHAR(50) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(SalesYTD2),'-1') AS VARCHAR(50)) AS DECIMAL(10,2)) END AS SalesYTD,

--CASE WHEN  SalesLastYear1 = 'NULL' THEN -1 ELSE  CAST(SalesLastYear1 AS DECIMAL(10,2)) END AS SalesLastYear
CASE
    WHEN   SalesLastYear1='NULL'
    THEN cast(cast('-1' AS VARCHAR(50) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(SalesLastYear1),'-1') AS VARCHAR(50)) AS DECIMAL(10,2)) END AS SalesLastYear
FROM DP_STG1.Sales_April_1_10
WHERE SalesYTD2 <>'';

---------------------------------------------------------

INSERT INTO DP_STG2.SalesPerson
--Sales_April_11_20
--INSERT INTO DP_STG2.SalesPerson
SELECT DISTINCT
CASE
    WHEN  BusinessEntityID2='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( BusinessEntityID2),'-1') AS VARCHAR(20)) AS INT) END AS  BusinessEntityID2,

--CASE WHEN TerritoryID1 = 'NULL' THEN -1 ELSE TerritoryID1 END AS TerritoryID1,
CASE
    WHEN  TerritoryID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( TerritoryID1),'-1') AS VARCHAR(20)) AS INT) END AS  TerritoryID1,

--CASE WHEN  SalesQuota2 = 'NULL' THEN -1 ELSE  CAST(SalesQuota2 AS DECIMAL(10,2)) END AS SalesQuota,
CASE
    WHEN   SalesQuota2='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(SalesQuota2),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS SalesQuota,


--CASE WHEN  Bonus = 'NULL' THEN -1 ELSE  CAST(Bonus AS DECIMAL(10,2)) END AS Bonus,
CASE
    WHEN   Bonus='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(Bonus),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS Bonus,

--CASE WHEN  CommissionPct = 'NULL' THEN -1 ELSE  CAST(CommissionPct AS DECIMAL(10,2)) END AS CommissionPct,
CASE
    WHEN   CommissionPct='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(CommissionPct),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS CommissionPct,

--CASE WHEN  SalesYTD2 = 'NULL' THEN -1 ELSE  CAST(SalesYTD2 AS DECIMAL(10,2)) END AS SalesYTD,
CASE
    WHEN   SalesYTD2='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(SalesYTD2),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS SalesYTD,

--CASE WHEN  SalesLastYear1 = 'NULL' THEN -1 ELSE  CAST(SalesLastYear1 AS DECIMAL(10,2)) END AS SalesLastYear
CASE
    WHEN   SalesLastYear1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(SalesLastYear1),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS SalesLastYear
FROM DP_STG1.Sales_April_11_20;



INSERT INTO DP_STG2.SalesPerson
--Sales_April_21_30
--INSERT INTO DP_STG2.SalesPerson
SELECT DISTINCT
CASE
    WHEN  BusinessEntityID2='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( BusinessEntityID2),'-1') AS VARCHAR(20)) AS INT) END AS  BusinessEntityID2,

--CASE WHEN TerritoryID1 = 'NULL' THEN -1 ELSE TerritoryID1 END AS TerritoryID1,
CASE
    WHEN  TerritoryID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( TerritoryID1),'-1') AS VARCHAR(20)) AS INT) END AS  TerritoryID1,

--CASE WHEN  SalesQuota2 = 'NULL' THEN -1 ELSE  CAST(SalesQuota2 AS DECIMAL(10,2)) END AS SalesQuota,
CASE
    WHEN   SalesQuota2='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(SalesQuota2),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS SalesQuota,


--CASE WHEN  Bonus = 'NULL' THEN -1 ELSE  CAST(Bonus AS DECIMAL(10,2)) END AS Bonus,
CASE
    WHEN   Bonus='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(Bonus),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS Bonus,

--CASE WHEN  CommissionPct = 'NULL' THEN -1 ELSE  CAST(CommissionPct AS DECIMAL(10,2)) END AS CommissionPct,
CASE
    WHEN   CommissionPct='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(CommissionPct),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS CommissionPct,

--CASE WHEN  SalesYTD2 = 'NULL' THEN -1 ELSE  CAST(SalesYTD2 AS DECIMAL(10,2)) END AS SalesYTD,
CASE
    WHEN   SalesYTD2='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(SalesYTD2),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS SalesYTD,

--CASE WHEN  SalesLastYear1 = 'NULL' THEN -1 ELSE  CAST(SalesLastYear1 AS DECIMAL(10,2)) END AS SalesLastYear
CASE
    WHEN   SalesLastYear1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(SalesLastYear1),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS SalesLastYear
FROM DP_STG1.Sales_April_21_30;


INSERT INTO DP_STG2.SalesPerson
--Sales_May_06_10
--INSERT INTO DP_STG2.SalesPerson
SELECT DISTINCT
CASE
    WHEN  BusinessEntityID2='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( BusinessEntityID2),'-1') AS VARCHAR(20)) AS INT) END AS  BusinessEntityID2,

--CASE WHEN TerritoryID1 = 'NULL' THEN -1 ELSE TerritoryID1 END AS TerritoryID1,
CASE
    WHEN  TerritoryID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( TerritoryID1),'-1') AS VARCHAR(20)) AS INT) END AS  TerritoryID1,

--CASE WHEN  SalesQuota2 = 'NULL' THEN -1 ELSE  CAST(SalesQuota2 AS DECIMAL(10,2)) END AS SalesQuota,
CASE
    WHEN   SalesQuota2='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(SalesQuota2),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS SalesQuota,


--CASE WHEN  Bonus = 'NULL' THEN -1 ELSE  CAST(Bonus AS DECIMAL(10,2)) END AS Bonus,
CASE
    WHEN   Bonus='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(Bonus),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS Bonus,

--CASE WHEN  CommissionPct = 'NULL' THEN -1 ELSE  CAST(CommissionPct AS DECIMAL(10,2)) END AS CommissionPct,
CASE
    WHEN   CommissionPct='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(CommissionPct),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS CommissionPct,

--CASE WHEN  SalesYTD2 = 'NULL' THEN -1 ELSE  CAST(SalesYTD2 AS DECIMAL(10,2)) END AS SalesYTD,
CASE
    WHEN   SalesYTD2='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(SalesYTD2),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS SalesYTD,

--CASE WHEN  SalesLastYear1 = 'NULL' THEN -1 ELSE  CAST(SalesLastYear1 AS DECIMAL(10,2)) END AS SalesLastYear
CASE
    WHEN   SalesLastYear1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(SalesLastYear1),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS SalesLastYear
FROM DP_STG1.Sales_May_06_10;



INSERT INTO DP_STG2.SalesPerson
--INSERT INTO DP_STG2.SalesPerson
SELECT DISTINCT
CASE
    WHEN  BusinessEntityID2='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( BusinessEntityID2),'-1') AS VARCHAR(20)) AS INT) END AS  BusinessEntityID2,

--CASE WHEN TerritoryID1 = 'NULL' THEN -1 ELSE TerritoryID1 END AS TerritoryID1,
CASE
    WHEN  TerritoryID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( TerritoryID1),'-1') AS VARCHAR(20)) AS INT) END AS  TerritoryID1,

--CASE WHEN  SalesQuota2 = 'NULL' THEN -1 ELSE  CAST(SalesQuota2 AS DECIMAL(10,2)) END AS SalesQuota,
CASE
    WHEN   SalesQuota2='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(SalesQuota2),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS SalesQuota,


--CASE WHEN  Bonus = 'NULL' THEN -1 ELSE  CAST(Bonus AS DECIMAL(10,2)) END AS Bonus,
CASE
    WHEN   Bonus='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(Bonus),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS Bonus,

--CASE WHEN  CommissionPct = 'NULL' THEN -1 ELSE  CAST(CommissionPct AS DECIMAL(10,2)) END AS CommissionPct,
CASE
    WHEN   CommissionPct='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(CommissionPct),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS CommissionPct,

--CASE WHEN  SalesYTD2 = 'NULL' THEN -1 ELSE  CAST(SalesYTD2 AS DECIMAL(10,2)) END AS SalesYTD,
CASE
    WHEN   SalesYTD2='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(SalesYTD2),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS SalesYTD,

--CASE WHEN  SalesLastYear1 = 'NULL' THEN -1 ELSE  CAST(SalesLastYear1 AS DECIMAL(10,2)) END AS SalesLastYear
CASE
    WHEN   SalesLastYear1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(SalesLastYear1),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS SalesLastYear
FROM DP_STG1.Sales_May_11_20;


INSERT INTO DP_STG2.SalesPerson
--Sales_May_21_31
--INSERT INTO DP_STG2.SalesPerson
SELECT DISTINCT
CASE
    WHEN  BusinessEntityID2='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( BusinessEntityID2),'-1') AS VARCHAR(20)) AS INT) END AS  BusinessEntityID2,

--CASE WHEN TerritoryID1 = 'NULL' THEN -1 ELSE TerritoryID1 END AS TerritoryID1,
CASE
    WHEN  TerritoryID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( TerritoryID1),'-1') AS VARCHAR(20)) AS INT) END AS  TerritoryID1,

--CASE WHEN  SalesQuota2 = 'NULL' THEN -1 ELSE  CAST(SalesQuota2 AS DECIMAL(10,2)) END AS SalesQuota,
CASE
    WHEN   SalesQuota2='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(SalesQuota2),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS SalesQuota,


--CASE WHEN  Bonus = 'NULL' THEN -1 ELSE  CAST(Bonus AS DECIMAL(10,2)) END AS Bonus,
CASE
    WHEN   Bonus='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(Bonus),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS Bonus,

--CASE WHEN  CommissionPct = 'NULL' THEN -1 ELSE  CAST(CommissionPct AS DECIMAL(10,2)) END AS CommissionPct,
CASE
    WHEN   CommissionPct='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(CommissionPct),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS CommissionPct,

--CASE WHEN  SalesYTD2 = 'NULL' THEN -1 ELSE  CAST(SalesYTD2 AS DECIMAL(10,2)) END AS SalesYTD,
CASE
    WHEN   SalesYTD2='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(SalesYTD2),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS SalesYTD,

--CASE WHEN  SalesLastYear1 = 'NULL' THEN -1 ELSE  CAST(SalesLastYear1 AS DECIMAL(10,2)) END AS SalesLastYear
CASE
    WHEN   SalesLastYear1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(SalesLastYear1),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS SalesLastYear
FROM DP_STG1.Sales_May_21_31;



--Checking if the data have been loaded in to the target table or not
--It should return 64 Rows

SELECT *
FROM dp_stg2.salesperson;

--Issue resolved by this overwrite distinct (it was because of union)

INSERT OVERWRITE TABLE dp_stg2.salesperson
SELECT DISTINCT * FROM dp_stg2.salesperson;