--PURCHASING TABLES ACCORDING TO SCHEMA



--We are cleansing the data (Removing NULL values and Empty Rows by using constraints) and assigining data types
--The input is stage 1 layer and populating into different tables according to business (Schema)
--Also making surrogate keys where required.
--Loading data in same format in the target Table
--Using constraints.

--This File contains The following Tables DDL and DML



--TOTAL TABLES=5

--1)ProductVendor
--2)PurchaseOrderDetail
--3)PurchaseOrderHeader
--4)ShipMethod
--5)Vendor




-------------------------------------------------------------------------

--1) ProductVendor Table
--According to Schema

----------------------------------------------------------------------------------------------

--Dropping the table if there is any issue while loading the data into the target table

DROP TABLE dp_Stg2.ProductVendor;

--Refreshing the table after inserting the data into the table 

REFRESH dp_stg2.productVendor;

--Creating the ProductInventory table total 5 columns
--1) productID, 2)LocationID, 3)Shelf, 4)BIN1, 5)Quantity

CREATE TABLE Dp_Stg2.ProductVendor
(
           BusinessEntityID INT,
		   ProductID INT,
		   AverageLeadTime INT,
           StandardPrice DECIMAL(4,2),
		   LastReceiptCost DECIMAL(4,2), 
		   LastReceiptDate TIMESTAMP,
		   MinOrderQty INT,
		   MaxOrderQty INT,
		   OnOrderQty INT,
		   UnitMeasureCode CHAR(3)
);



--Inserting data into the table from the source table and removing NULL from the source table
--Cleaning the Data and defining data types.

INSERT INTO DP_STG2.ProductVendor(BusinessEntityID, ProductID, AverageLeadTime,StandardPrice,
LastReceiptCost,LastReceiptDate,MinOrderQty,MaxOrderQty,OnOrderQty,UnitMeasureCode)


SELECT DISTINCT
--CASE WHEN BusinessEntityID1 = 'NULL' THEN -1 ELSE BusinessEntityID1 END AS BusinessEntityID1,

CASE
    WHEN  BusinessEntityID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(BusinessEntityID1),'-1') AS VARCHAR(20)) AS INT) END AS  BusinessEntityID,


--CASE WHEN ProductID1 = 'NULL' THEN -1 ELSE ProductID1 END AS ProductID1,
CASE
    WHEN   ProductID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( ProductID1),'-1') AS VARCHAR(20)) AS INT) END AS   ProductID1,


--CASE WHEN AverageLeadTime = 'NULL' THEN -1 ELSE AverageLeadTime END AS AverageLeadTime,
CASE
    WHEN  AverageLeadTime='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( AverageLeadTime),'-1') AS VARCHAR(20)) AS INT) END AS  AverageLeadTime,


--CASE WHEN  StandardPrice = 'NULL' THEN -1 ELSE  CAST(StandardPrice AS DECIMAL(4,2)) END AS  StandardPrice,
CASE
    WHEN  StandardPrice='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(4,2))
    ELSE 
    cast(cast(coalesce(trim(StandardPrice),'-1') AS VARCHAR(20)) AS DECIMAL(4,2)) END AS StandardPrice,


--CASE WHEN  LastReceiptCost = 'NULL' THEN -1 ELSE  CAST(LastReceiptCost AS DECIMAL(4,2)) END AS LastReceiptCost,
CASE
    WHEN  LastReceiptCost='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(4,2))
    ELSE 
    cast(cast(coalesce(trim(LastReceiptCost),'-1') AS VARCHAR(20)) AS DECIMAL(4,2)) END AS LastReceiptCost,




--CASE WHEN LastReceiptDate = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(LastReceiptDate,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS LastReceiptDate,
 case
    when LastReceiptDate = 'NULL'
    then cast ('1900-01-01' as TIMESTAMP)
    else
    cast(coalesce(LastReceiptDate,to_date('1900-01-01')) as TIMESTAMP)
end as LastReceiptDate,


--CASE WHEN MinOrderQty = 'NULL' THEN -1 ELSE MinOrderQty END AS MinOrderQty,

CASE
    WHEN  MinOrderQty='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(MinOrderQty),'-1') AS VARCHAR(20)) AS INT) END AS  MinOrderQty,



--CASE WHEN MaxOrderQty = 'NULL' THEN -1 ELSE MaxOrderQty END AS MaxOrderQty,
CASE
    WHEN MaxOrderQty='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(MaxOrderQty),'-1') AS VARCHAR(20)) AS INT) END AS  MaxOrderQty,


--CASE WHEN OnOrderQty = 'NULL' THEN -1 ELSE OnOrderQty END AS OnOrderQty,
CASE
    WHEN OnOrderQty='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(OnOrderQty),'-1') AS VARCHAR(20)) AS INT) END AS OnOrderQty,


--CASE WHEN UnitMeasureCode = 'NULL' THEN 'N/A' ELSE CAST(UnitMeasureCode AS CHAR(3)) END AS UnitMeasureCode
CASE
    WHEN UnitMeasureCode='NULL'
    THEN cast('N/A' AS CHAR(3))
    ELSE 
    cast(coalesce(trim(UnitMeasureCode),'N/A') AS CHAR(3)) END AS UnitMeasureCode

FROM Dp_Stg1.Purchase;


--Checking if the data have been loaded in to the target table or not
--It should return 141 Rows
Select *
From DP_STG2.ProductVendor;


--Checking Number of rows 
SELECT count(*) AS NumberOfRows
FROM dp_stg2.productvendor;


-----------------------------------------------------------------------------------------------------------------



--2) ProductVendor Table
--According to Schema

----------------------------------------------------------------------------------------------

--Dropping the table if there is any issue while loading the data into the target table

DROP TABLE dp_Stg2.ProductVendor;

--Refreshing the table after inserting the data into the table 

REFRESH dp_stg2.productVendor;

--Creating the ProductInventory table total 5 columns
--1) productID, 2)LocationID, 3)Shelf, 4)BIN1, 5)Quantity

CREATE TABLE Dp_Stg2.ProductVendor
(
           BusinessEntityID INT,
		   ProductID INT,
		   AverageLeadTime INT,
           StandardPrice DECIMAL(4,2),
		   LastReceiptCost DECIMAL(4,2), 
		   LastReceiptDate TIMESTAMP,
		   MinOrderQty INT,
		   MaxOrderQty INT,
		   OnOrderQty INT,
		   UnitMeasureCode CHAR(3)
);



--Inserting data into the table from the source table and removing NULL from the source table
--Cleaning the Data and defining data types.

INSERT INTO DP_STG2.ProductVendor(BusinessEntityID, ProductID, AverageLeadTime,StandardPrice,
LastReceiptCost,LastReceiptDate,MinOrderQty,MaxOrderQty,OnOrderQty,UnitMeasureCode)


SELECT DISTINCT
--CASE WHEN BusinessEntityID1 = 'NULL' THEN -1 ELSE BusinessEntityID1 END AS BusinessEntityID1,

CASE
    WHEN  BusinessEntityID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(BusinessEntityID1),'-1') AS VARCHAR(20)) AS INT) END AS  BusinessEntityID,


--CASE WHEN ProductID1 = 'NULL' THEN -1 ELSE ProductID1 END AS ProductID1,
CASE
    WHEN   ProductID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( ProductID1),'-1') AS VARCHAR(20)) AS INT) END AS   ProductID1,


--CASE WHEN AverageLeadTime = 'NULL' THEN -1 ELSE AverageLeadTime END AS AverageLeadTime,
CASE
    WHEN  AverageLeadTime='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( AverageLeadTime),'-1') AS VARCHAR(20)) AS INT) END AS  AverageLeadTime,


--CASE WHEN  StandardPrice = 'NULL' THEN -1 ELSE  CAST(StandardPrice AS DECIMAL(4,2)) END AS  StandardPrice,
CASE
    WHEN  StandardPrice='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(4,2))
    ELSE 
    cast(cast(coalesce(trim(StandardPrice),'-1') AS VARCHAR(20)) AS DECIMAL(4,2)) END AS StandardPrice,


--CASE WHEN  LastReceiptCost = 'NULL' THEN -1 ELSE  CAST(LastReceiptCost AS DECIMAL(4,2)) END AS LastReceiptCost,
CASE
    WHEN  LastReceiptCost='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(4,2))
    ELSE 
    cast(cast(coalesce(trim(LastReceiptCost),'-1') AS VARCHAR(20)) AS DECIMAL(4,2)) END AS LastReceiptCost,




--CASE WHEN LastReceiptDate = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(LastReceiptDate,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS LastReceiptDate,
 case
    when LastReceiptDate = 'NULL'
    then cast ('1900-01-01' as TIMESTAMP)
    else
    cast(coalesce(LastReceiptDate,to_date('1900-01-01')) as TIMESTAMP)
end as LastReceiptDate,


--CASE WHEN MinOrderQty = 'NULL' THEN -1 ELSE MinOrderQty END AS MinOrderQty,

CASE
    WHEN  MinOrderQty='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(MinOrderQty),'-1') AS VARCHAR(20)) AS INT) END AS  MinOrderQty,



--CASE WHEN MaxOrderQty = 'NULL' THEN -1 ELSE MaxOrderQty END AS MaxOrderQty,
CASE
    WHEN MaxOrderQty='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(MaxOrderQty),'-1') AS VARCHAR(20)) AS INT) END AS  MaxOrderQty,


--CASE WHEN OnOrderQty = 'NULL' THEN -1 ELSE OnOrderQty END AS OnOrderQty,
CASE
    WHEN OnOrderQty='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(OnOrderQty),'-1') AS VARCHAR(20)) AS INT) END AS OnOrderQty,


--CASE WHEN UnitMeasureCode = 'NULL' THEN 'N/A' ELSE CAST(UnitMeasureCode AS CHAR(3)) END AS UnitMeasureCode
CASE
    WHEN UnitMeasureCode='NULL'
    THEN cast('N/A' AS CHAR(3))
    ELSE 
    cast(coalesce(trim(UnitMeasureCode),'N/A') AS CHAR(3)) END AS UnitMeasureCode

FROM Dp_Stg1.Purchase;


--Checking if the data have been loaded in to the target table or not
--It should return 141 Rows
Select *
From DP_STG2.ProductVendor;


--Checking Number of rows 
SELECT count(*) AS NumberOfRows
FROM dp_stg2.productvendor;


-----------------------------------------------------------------------------------------------------------------




--2) PurchaseOrderDetail Table
--According to Schema

----------------------------------------------------------------------------------------------

--Dropping the table if there is any issue while loading the data into the target table

DROP TABLE dp_Stg2.PurchaseOrderDetail;

--Refreshing the table after inserting the data into the table 

REFRESH dp_stg2.purchaseOrderDetail;

--Creating the ProductInventory table total 10 columns
--1)  PurchaseOrderID, 2)PurchaseOrderDetailID, 3) DueDate, 4)ProductID, 5)OrderQty, 6)UnitPrice, 7) LineTotal, 8)ReceivedQty, 9)RejectedQty, 10) StockedQty 


CREATE TABLE Dp_Stg2.PurchaseOrderDetail
(
           PurchaseOrderID INT,
           PurchaseOrderDetailID INT,
		   DueDate TIMESTAMP,
		   ProductID INT,
		   OrderQty INT,
		   UnitPrice DECIMAL(7,2),
		   LineTotal DECIMAL(9,2),
		   ReceivedQty DECIMAL(9,2),
		   RejectedQty DECIMAL(9,2),
		   StockedQty DECIMAL(9,2)
);


--Inserting data into the table from the source table and removing NULL from the source table
--Cleaning the Data and defining data types.

INSERT INTO DP_STG2.PurchaseOrderDetail(PurchaseOrderID, PurchaseOrderDetailID,DueDate,
ProductID, OrderQty,UnitPrice,LineTotal, ReceivedQty,RejectedQty,StockedQty)

SELECT DISTINCT
--CASE WHEN PurchaseOrderID1 = 'NULL' THEN -1 ELSE PurchaseOrderID1 END AS PurchaseOrderID1,
CASE
    WHEN  PurchaseOrderID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(PurchaseOrderID1),'-1') AS VARCHAR(20)) AS INT) END AS  PurchaseOrderID1,


--CASE WHEN PurchaseOrderDetailID = 'NULL' THEN -1 ELSE PurchaseOrderDetailID END AS PurchaseOrderDetailID,

CASE
    WHEN  PurchaseOrderDetailID='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(PurchaseOrderDetailID),'-1') AS VARCHAR(20)) AS INT) END AS  PurchaseOrderDetailID,


--CASE WHEN DueDate = 'NULL' THEN  CAST ('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(DueDate,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS DueDate,
 CASE
    when DueDate = 'NULL'
    then cast ('1900-01-01' as TIMESTAMP)
    else
    cast(coalesce(DueDate,to_date('1900-01-01')) as TIMESTAMP)
END as DueDate,



--CASE WHEN ProductID1 = 'NULL' THEN -1 ELSE ProductID1 END AS ProductID1,
CASE
    WHEN  ProductID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(ProductID1),'-1') AS VARCHAR(20)) AS INT) END AS  ProductID1,


--CASE WHEN OrderQty = 'NULL' THEN -1 ELSE OrderQty END AS OrderQty,
CASE
    WHEN  OrderQty='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(OrderQty),'-1') AS VARCHAR(20)) AS INT) END AS  OrderQty,


--CASE WHEN UnitPrice = 'NULL' THEN -1 ELSE CAST(UnitPrice AS DECIMAL(7,2)) END AS UnitPrice,
CASE
    WHEN   UnitPrice='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(7,2))
    ELSE 
    cast(cast(coalesce(trim(UnitPrice),'-1') AS VARCHAR(20)) AS DECIMAL(7,2)) END AS UnitPrice,


--CASE WHEN LineTotal = 'NULL' THEN -1 ELSE CAST( LineTotal AS DECIMAL(9,2)) END AS  LineTotal,
CASE
    WHEN   LineTotal='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(9,2))
    ELSE 
    cast(cast(coalesce(trim(LineTotal),'-1') AS VARCHAR(20)) AS DECIMAL(9,2)) END AS LineTotal,

--CASE WHEN ReceivedQty = 'NULL' THEN -1 ELSE ReceivedQty END AS ReceivedQty,
CASE
    WHEN  ReceivedQty='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) )AS DECIMAL(9,2))
    ELSE 
    cast(cast(coalesce(trim(ReceivedQty),'-1') AS VARCHAR(20)) AS DECIMAL(9,2)) END AS  ReceivedQty,

--CASE WHEN RejectedQty = 'NULL' THEN -1 ELSE RejectedQty END AS RejectedQty,
CASE
    WHEN  RejectedQty='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(9,2))
    ELSE 
    cast(cast(coalesce(trim(RejectedQty),'-1') AS VARCHAR(20)) AS DECIMAL(9,2)) END AS RejectedQty,

--CASE WHEN StockedQty = 'NULL' THEN -1 ELSE StockedQty END AS StockedQty
CASE
    WHEN  StockedQty='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) )AS DECIMAL(9,2))
    ELSE 
    cast(cast(coalesce(trim(StockedQty),'-1') AS VARCHAR(20)) AS DECIMAL(9,2)) END AS StockedQty



FROM Dp_Stg1.Purchase;


--Checking if the data have been loaded in to the target table or not
--It should return 8845 Rows

SELECT *
FROM DP_STG2.PurchaseOrderDetail;

--Checking Number of rows 
SELECT count(*) AS NumberOfRows
FROM dp_stg2.purchaseorderdetail;


-----------------------------------------------------------------------------------------------------------------


--Comments

--4) ShipMethod Table
--According to Schema

----------------------------------------------------------------------------------------------

--Dropping the table if there is any issue while loading the data into the target table

DROP TABLE dp_Stg2.ShipMethod;

--Refreshing the table after inserting the data into the table 

REFRESH dp_stg2.shipmethod;


--Creating the ProductInventory table total 5 columns
--1) ShipMethodID, 2)Name1, 3)ShipBase, 4)ShipRate


CREATE TABLE Dp_Stg2.ShipMethod
(
           ShipMethodID INTEGER,
           Name1 VARCHAR(32),
		   ShipBase DECIMAL(4,2),
		   ShipRate DECIMAL(4,2)
);


--Inserting data into the table from the source table and removing NULL from the source table
--Cleaning the Data and defining data types.

INSERT INTO DP_STG2.ShipMethod(ShipMethodID, Name1,ShipBase,ShipRate)

SELECT DISTINCT
--CASE WHEN ShipMethodID2 = 'NULL' THEN -1 ELSE ShipMethodID2 END AS ShipMethodID2,
CASE
    WHEN  ShipMethodID2='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(ShipMethodID2),'-1') AS VARCHAR(20)) AS INT) END AS  ShipMethodID2,

--CASE WHEN Name2 = 'NULL' THEN 'N/A' ELSE Name2 END AS Name2, 
CASE
    WHEN Name2='NULL'
    THEN cast('N/A' AS VARCHAR(32))
    ELSE 
    cast(coalesce(trim(Name2),'N/A') AS VARCHAR(32)) END AS Name2,


--CASE WHEN ShipBase = 'NULL' THEN -1 ELSE CAST(ShipBase AS DECIMAL(4,2)) END AS ShipBase,
CASE
    WHEN  ShipBase='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) )AS DECIMAL(4,2))
    ELSE 
    cast(cast(coalesce(trim(ShipBase),'-1') AS VARCHAR(20)) AS DECIMAL(4,2)) END AS ShipBase,

--CASE WHEN ShipRate = 'NULL' THEN -1 ELSE CAST(ShipRate AS DECIMAL(4,2)) END AS  ShipRate
CASE
    WHEN  ShipRate='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) )AS DECIMAL(4,2))
    ELSE 
    cast(cast(coalesce(trim(ShipRate),'-1') AS VARCHAR(20)) AS DECIMAL(4,2)) END AS ShipRate

FROM Dp_Stg1.Purchase;



--Checking if the data have been loaded in to the target table or not
--It should return 5 Rows

SELECT *
FROM DP_STG2.ShipMethod;


----------------------------------------------------------------------------------------------------------------

--5) Vendor According to Schema


------------------------------------------------

--Dropping the table if there is any issue while loading the data into the target table
DROP TABLE dp_Stg2.Vendor;


--Refreshing the table after inserting the data into the table 
REFRESH dp_stg2.vendor;



--Creating the ProductInventory table total 7 columns
--1) BusinessEntityID, 2)AccountNumber, 3) Name1, 4)CreditRating, 5)PreferredVendorStatus, 6)ActiveFlag, 7) Purchasing websericeURL


CREATE TABLE Dp_Stg2.Vendor
(
           BusinessEntityID INTEGER,
           AccountNumber VARCHAR(24),
		   Name1 VARCHAR(32), 
		   CreditRating TINYINT,
		   PreferredVendorStatus TINYINT,
		   ActiveFlag TINYINT,
		   PurchasingWebServiceURL VARCHAR(64)
);



--Inserting data into the table from the source table and removing NULL from the source table
--Cleaning the Data and defining data types.

INSERT INTO DP_STG2.Vendor(BusinessEntityID, AccountNumber, Name1,CreditRating, PreferredVendorStatus,ActiveFlag,PurchasingWebServiceURL)

SELECT DISTINCT
--CASE WHEN BusinessEntityID1 = 'NULL' THEN -1 ELSE BusinessEntityID1 END AS BusinessEntityID1,
CASE
    WHEN  BusinessEntityID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( BusinessEntityID1),'-1') AS VARCHAR(20)) AS INT) END AS  BusinessEntityID1 ,

--CASE WHEN AccountNumber = 'NULL' THEN 'N/A' ELSE AccountNumber END AS AccountNumber,
CASE 
    WHEN AccountNumber='NULL'
    THEN cast('N/A' AS VARCHAR(24))
    ELSE
    cast(coalesce(trim(AccountNumber),'N/A') AS VARCHAR(24)) END AS AccountNumber,

--CASE WHEN Name1 = 'NULL' THEN 'N/A' ELSE Name1 END AS Name1,
CASE 
    WHEN Name1='NULL'
    THEN cast('N/A' AS VARCHAR(32))
    ELSE
    cast(coalesce(trim(Name1),'N/A') AS VARCHAR(32)) END AS Name1,

--CASE WHEN CreditRating = 'NULL' THEN -1 ELSE CreditRating END AS CreditRating,
CASE
    WHEN  CreditRating='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS TINYINT)
    ELSE 
    cast(cast(coalesce(trim(CreditRating),'-1') AS VARCHAR(20)) AS TINYINT) END AS CreditRating,

--CASE WHEN PreferredVendorStatus = 'NULL' THEN -1 ELSE PreferredVendorStatus END AS PreferredVendorStatus,
CASE
    WHEN  PreferredVendorStatus='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS TINYINT)
    ELSE 
    cast(cast(coalesce(trim(PreferredVendorStatus),'-1') AS VARCHAR(20)) AS TINYINT) END AS PreferredVendorStatus,

--CASE WHEN ActiveFlag = 'NULL' THEN -1 ELSE CAST(ActiveFlag AS BYTEINT) END AS ActiveFlag,
CASE
    WHEN  ActiveFlag='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS TINYINT)
    ELSE 
    cast(cast(coalesce(trim(ActiveFlag),'-1') AS VARCHAR(20)) AS TINYINT) END AS ActiveFlag,

--CASE WHEN PurchasingWebServiceURL = 'NULL' THEN 'N/A' ELSE PurchasingWebServiceURL END AS PurchasingWebServiceURL
CASE 
    WHEN PurchasingWebServiceURL='NULL'
    THEN cast('N/A' AS VARCHAR(64))
    ELSE
    cast(coalesce(trim(PurchasingWebServiceURL),'N/A') AS VARCHAR(64)) END AS PurchasingWebServiceURL

FROM Dp_Stg1.Purchase;



--Checking if the data have been loaded in to the target table or not
--It should return 86 Rows

SELECT *
FROM DP_STG2.Vendor;


---------------------------------------------------------------------------------------------------------------

--Comments

--6) PurchaseOrderHeader Table
--According to Schema

----------------------------------------------------------------------------------------------

--Dropping the table if there is any issue while loading the data into the target table

DROP TABLE dp_Stg2.PurchaseOrderHeader;



--Refreshing the table after inserting the data into the table 
REFRESH dp_stg2.purchaseOrderHeader;


--Creating the ProductInventory table total 13 columns
--1) PurchaseOrderID, 2)ShipMethodID, 3)VendorID , 4)RevisionNumber, 5)RevisionNumber, 6)Status, 7)EmployeeID, 8)OrderDate, 9)ShipDate, 10)SubTotal, 11) TaxAmt
--12) Freight, 13)TotalDue

CREATE TABLE Dp_Stg2.PurchaseOrderHeader
(
           PurchaseOrderID INTEGER,
		   ShipMethodID INTEGER,
		   VendorID INTEGER,
		   RevisionNumber INTEGER,
		   Status INTEGER,
		   EmployeeID INTEGER,
		   OrderDate TIMESTAMP,
		   ShipDate TIMESTAMP,
		   SubTotal DECIMAL(9,2),
		   TaxAmt DECIMAL(7,2),
		   Freight DECIMAL(7,2),
		   TotalDue DECIMAL(9,2)
);



--Inserting data into the table from the source table and removing NULL from the source table
--Cleaning the Data and defining data types.



INSERT INTO DP_STG2.PurchaseOrderHeader(PurchaseOrderID,ShipMethodID,VendorID,
RevisionNumber,Status,EmployeeID,OrderDate,ShipDate,SubTotal,TaxAmt,Freight,TotalDue)

SELECT DISTINCT
--CASE WHEN PurchaseOrderID1 = 'NULL' THEN -1 ELSE PurchaseOrderID1 END AS PurchaseOrderID,
CASE
    WHEN  PurchaseOrderID1='NULL' 
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(PurchaseOrderID1),'-1') AS VARCHAR(20)) AS INT) END AS  PurchaseOrderID,


--CASE WHEN ShipMethodID1 = 'NULL' THEN -1 ELSE ShipMethodID1 END AS ShipMethodID1,
CASE 
    WHEN  ShipMethodID1='NULL' 
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( ShipMethodID1),'-1') AS VARCHAR(20)) AS INT) END AS  ShipMethodID1 ,

--CASE WHEN VendorID = 'NULL' THEN -1 ELSE VendorID END AS VendorID,
CASE 
    WHEN  VendorID='NULL' 
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( VendorID),'-1') AS VARCHAR(20)) AS INT) END AS  VendorID ,

--CASE WHEN RevisionNumber = 'NULL' THEN -1 ELSE RevisionNumber END AS RevisionNumber,
CASE 
    WHEN  RevisionNumber='NULL' 
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( RevisionNumber),'-1') AS VARCHAR(20)) AS INT) END AS  RevisionNumber ,

--CASE WHEN Status = 'NULL' THEN -1 ELSE Status END AS Status,
CASE 
    WHEN  Status='NULL' 
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( Status),'-1') AS VARCHAR(20)) AS INT) END AS  Status ,

--CASE WHEN EmployeeID = 'NULL' THEN -1 ELSE EmployeeID END AS EmployeeID,
case
    WHEN  EmployeeID='NULL' 
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( EmployeeID),'-1') AS VARCHAR(20)) AS INT) END AS  EmployeeID ,

--CASE WHEN OrderDate = 'NULL' THEN  CAST ('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(OrderDate,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS OrderDate,

case
    when OrderDate = 'NULL'
    then cast ('1900-01-01' as TIMESTAMP)
    else
    cast(coalesce(OrderDate,to_date('1900-01-01')) as TIMESTAMP)
end OrderDate,

--CASE WHEN ShipDate = 'NULL' THEN  CAST ('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(ShipDate,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS ShipDate,
case
    when ShipDate = 'NULL'
    then cast ('1900-01-01' as TIMESTAMP)
    else
    cast(coalesce(ShipDate,to_date('1900-01-01')) as TIMESTAMP)
end ShipDate,

--CASE WHEN SubTotal = 'NULL' THEN -1 ELSE CAST(SubTotal AS DECIMAL(9,2)) END AS SubTotal,
CASE
    WHEN   SubTotal='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(9,2))
    ELSE 
    cast(cast(coalesce(trim(SubTotal),'-1') AS VARCHAR(20)) AS DECIMAL(9,2)) END AS SubTotal,

--CASE WHEN TaxAmt = 'NULL' THEN -1 ELSE CAST(TaxAmt AS DECIMAL(7,2)) END AS TaxAmt,
CASE
    WHEN   TaxAmt='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(7,2))
    ELSE 
    cast(cast(coalesce(trim(TaxAmt),'-1') AS VARCHAR(20)) AS DECIMAL(7,2)) END AS TaxAmt,

--CASE WHEN Freight = 'NULL' THEN -1 ELSE CAST(Freight AS DECIMAL(7,2)) END AS Freight,
CASE
    WHEN   Freight='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(7,2))
    ELSE 
    cast(cast(coalesce(trim(Freight),'-1') AS VARCHAR(20)) AS DECIMAL(7,2)) END AS Freight,

--CASE WHEN TotalDue = 'NULL' THEN -1 ELSE CAST(TotalDue AS DECIMAL(9,2)) END AS TotalDue
CASE
    WHEN   TotalDue='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(9,2))
    ELSE 
    cast(cast(coalesce(trim(TotalDue),'-1') AS VARCHAR(20)) AS DECIMAL(9,2)) END AS TotalDue

FROM Dp_Stg1.Purchase;


--Checking if the data have been loaded in to the target table or not
--It should return 4012 Rows
SELECT *
FROM DP_STG2.PurchaseOrderHeader;


SELECT count(*) AS NumberOfRows
FROM dp_stg2.purchaseorderheader;








