--PRODUCT TABLES ACCORDING TO SCHEMA

--TOTAL TABLES=16

--1)BillOfMaterials
--2)Culture
--3)Product
--4)ProductCategory
--5)ProductCostHistory
--6)ProductDescription
--7)ProductInventory
--8)ProductListPriceHistory
--9)ProductModel
--10)ProductModelProductDescriptionCulture
--11)ProductSubCategory
--12)ScrapReason
--13)TransactionHistory
--14)UnitMeasure
--15)WorkOrder
--16)WorkOrderRouting
--17)Location



-------------------------------------------------------------------------
--1) BillOfMaterials Table
--According to schema

-------------------------------

--Dropping table if there is some issue while inserting the data into the table
DROP TABLE DP_STG2.BillofMaterials ;

--Refreshing the table after inserting the data into the table

REFRESH dp_stg2.billofmaterials;


--Creating Table


CREATE TABLE dp_stg2.BillofMaterials
(
    BillOfMaterialsID INT,
    ProductAssemblyID INT,
    ComponentID INT,
    StartDate TIMESTAMP,
    EndDate TIMESTAMP,
    UnitMeasureCode VARCHAR(8),
    BOMLevel INT,
    PerAssemblyQty DECIMAL(10,2)
);


--Inserting the Data into the target table from the source table and removing NULLS means cleaning the data 
--Defining DataTypes accordingly 


INSERT INTO DP_STG2.BillofMaterials

SELECT DISTINCT
--CASE BillOfMaterialsID WHEN 'NULL' THEN -1 ELSE CAST (BillOfMaterialsID AS INTEGER) END AS BillOfMaterialsID,
CASE
    WHEN  BillOfMaterialsID='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( BillOfMaterialsID),'-1') AS VARCHAR(20)) AS INT) END AS  BillOfMaterialsID,

--CASE ProductAssemblyID WHEN 'NULL' THEN -1 ELSE CAST (ProductAssemblyID AS INTEGER) END AS ProductAssemblyID,
CASE
    WHEN  ProductAssemblyID='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( ProductAssemblyID),'-1') AS VARCHAR(20)) AS INT) END AS  ProductAssemblyID,

--CASE ComponentID WHEN 'NULL' THEN -1 ELSE CAST (ComponentID AS INTEGER) END AS ComponentID,
CASE
    WHEN   ComponentID='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(ComponentID),'-1') AS VARCHAR(20)) AS INT) END AS ComponentID,

--CASE StartDate WHEN 'NULL' THEN CAST ('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST (SUBSTR(StartDate,1,10) AS DATE FORMAT 'YYYY-MM-DD')  END AS StartDate,
 case
    when StartDate = 'NULL'
    then cast ('1900-01-01' as TIMESTAMP)
    else
    cast(coalesce(StartDate,to_date('1900-01-01')) as TIMESTAMP)
end StartDate,



--CASE EndDate WHEN 'NULL' THEN CAST ('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST (SUBSTR(EndDate,1,10) AS DATE FORMAT 'YYYY-MM-DD')  END AS EndDate,
 case
    when enddate = 'NULL'
    then cast ('1900-01-01' as TIMESTAMP)
    else
    cast(coalesce(EndDate,to_date('1900-01-01')) as TIMESTAMP)
end as end_date,

--CASE UnitMeasureCode WHEN 'NULL' THEN 'N/A' ELSE UnitMeasureCode END AS UnitMeasureCode,
CASE 
    WHEN UnitMeasureCode='NULL'
    THEN cast('N/A' AS VARCHAR(8))
    ELSE
    cast(coalesce(trim(UnitMeasureCode),'N/A') AS VARCHAR(8)) END AS UnitMeasureCode,
    
    
--CASE BOMLevel WHEN 'NULL' THEN -1 ELSE CAST (BOMLevel AS INTEGER) END AS BOMLevel,
CASE
    WHEN   BOMLevel='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(BOMLevel),'-1') AS VARCHAR(20)) AS INT) END AS BOMLevel,
    

--CASE PerAssemblyQty WHEN 'NULL' THEN -1 ELSE CAST (PerAssemblyQty AS DECIMAL(10,2)) END AS PerAssemblyQty
CASE
    WHEN   PerAssemblyQty='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(PerAssemblyQty),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS PerAssemblyQty

FROM  dp_stg1.bill_of_materials_production;


--Checking if data have been loaded in to the target table correctly nor not
SELECT *
FROM DP_STG2.billofmaterials;

--This should return 2679 Rows 
SELECT count(*) AS NumberOfRows
FROM dp_stg2.billofmaterials;

-----------------------------------------------------------------------------------------------------------------------------------------------

--2) CULTURE TABLE
-- Creatung according to Schema

-------------------------------------------------

--Dropping the table if there is any issue while inserting the data into the table

DROP TABLE DP_STG2.Culture;

--Refreshing the table after inserting the data into the table

REFRESH dp_stg2.culture;

--Creating the table With total 2 Columns
--1)CultureID 2)Name1


CREATE TABLE dp_stg2.Culture
(
    CultureID VARCHAR(8),
    Name1 VARCHAR(16)
);



--Inserting the data into the target Table from the source Table
--Removing the Null and -1 from the data and extracting the required columns 


INSERT INTO DP_STG2.Culture 

SELECT DISTINCT
--CASE CultureID1 WHEN 'NULL' THEN 'N/A' ELSE CultureID1 END AS CultureID,
CASE 
    WHEN CultureID1='NULL'
    THEN cast('N/A' AS VARCHAR(8))
    ELSE
    cast(coalesce(trim(CultureID1),'N/A') AS VARCHAR(8)) END AS CultureID1,


--CASE Name6 WHEN 'NULL' THEN 'N/A' ELSE Name6 END AS Name6
CASE 
    WHEN name6='NULL'
    THEN cast('N/A' AS VARCHAR(16))
    ELSE
    cast(coalesce(trim(name6),'N/A') AS VARCHAR(16)) END AS name6


FROM  dp_stg1.Production;

--Checking if data is correctly loaded into the target table or not 
--It should return total number of 6 rows
SELECT *
FROM DP_STG2.Culture;

----------------------------------------------------------------------------------------------------------------------------------------
--3) ProductCategory Table
--According to schema

--------------------------------------------------------
--Dropping the table if there is any issue while inserting the data into the table

DROP TABLE dp_stg2.ProductCategory;

--Refreshing the table after inserting the data into the table

REFRESH dp_stg2.productCategory;

--Creating the table With total 2 Columns
--1)ProductCategoryID 2)Name1


CREATE TABLE dp_stg2.ProductCategory
(
    ProductCategoryID SMALLINT,
    Name1  VARCHAR(16)
);


--Inserting the data into the target Table from the source Table
--Removing the Null and -1 from the data and extracting the required columns 

INSERT INTO DP_STG2.ProductCategory 

SELECT  DISTINCT
--CASE ProductCategoryID1 WHEN 'NULL' THEN -1 ELSE CAST (ProductCategoryID1 AS SMALLINT) END AS ProductCategoryID,
CASE
    WHEN   ProductCategoryID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS SMALLINT)
    ELSE 
    cast(cast(coalesce(trim(ProductCategoryID1),'-1') AS VARCHAR(20)) AS SMALLINT) END AS ProductCategoryID1,

--CASE Name3 WHEN 'NULL' THEN 'N/A' ELSE Name3 END AS Name1
CASE 
    WHEN name3='NULL'
    THEN cast('N/A' AS VARCHAR(16))
    ELSE
    cast(coalesce(trim(name3),'N/A') AS VARCHAR(16)) END AS name3


FROM  dp_stg1.Production ;


--Checking if data is correctly loaded into the target table or not 
--It should return total number of 4 rows
SELECT *
FROM DP_STG2.ProductCategory;

-------------------------------------------------------------------------------------------------------------------------------------------------------

--4)ProductCostHistory table
-- According to Schema

----------------------------------------------------------------------
--Dropping the table if there is any issue while inserting the data into the table

DROP TABLE dp_stg2.productCostHistory;

--Refreshing the table after inserting the data into the table

REFRESH dp_stg2.productCostHistory;


--Creating the table With total 4 Columns
--1)ProductID 2)StartDate 3)EndDate 4)StandardCost


CREATE TABLE dp_stg2.ProductCostHistory
(
    ProductID INT,
    StartDate TIMESTAMP ,
    EndDate   TIMESTAMP,
    StandardCost DECIMAL(10,2)
);


--Inserting the data into the target Table from the source Table
--Removing the Null and -1 from the data and extracting the required columns 

INSERT INTO dp_stg2.ProductCostHistory 

SELECT DISTINCT
--CASE ProductID1 WHEN 'NULL' THEN -1 ELSE ProductID1 END AS ProductID,
CASE
    WHEN  ProductID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( ProductID1),'-1') AS VARCHAR(20)) AS INT) END AS  ProductID1,

--CASE StartDate1 WHEN 'NULL' THEN CAST ('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST (SUBSTR(StartDate1,1,10) AS DATE FORMAT 'YYYY-MM-DD')  END AS StartDate,
CASE
    WHEN StartDate1 = 'NULL'
    THEN cast ('1900-01-01' as TIMESTAMP)
    ELSE
    cast(coalesce(StartDate1,to_date('1900-01-01')) as TIMESTAMP)
end StartDate1,

--CASE EndDate1 WHEN 'NULL' THEN CAST ('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST (SUBSTR(EndDate1,1,10) AS DATE FORMAT 'YYYY-MM-DD')  END AS EndDate,
CASE
    WHEN EndDate1 = 'NULL'
    THEN cast ('1900-01-01' as TIMESTAMP)
    ELSE
    cast(coalesce(EndDate1,to_date('1900-01-01')) as TIMESTAMP)
end EndDate,

--CASE StandardCost2 WHEN 'NULL' THEN -1 ELSE CAST (StandardCost2 AS DECIMAL(10,2)) END AS StandardCost
CASE
    WHEN   StandardCost2='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(StandardCost2),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS StandardCost2


FROM  dp_stg1.Production ;

--Checking if data is correctly loaded into the target table or not 
--It should return total number of 35 rows
SELECT *
FROM DP_STG2.ProductCostHistory;

-----------------------------------------------------------------------------------------------------------------------------------------

--5) ProductDescription Table
--according to schema

-----------------------------------------------------------

--Dropping the table if there is any issue while inserting the data into the table

DROP TABLE dp_stg2.ProductDescription;

--Refreshing the table after inserting the data into the table

REFRESH dp_stg2.productdescription;


--Creating the table With total 2 Columns
--1)ProductDescriptionID 2) Description

CREATE TABLE dp_stg2.ProductDescription
(
    ProductDescriptionID INT,
    Description VARCHAR(512)
);


--Inserting the data into the target Table from the source Table
--Removing the Null and -1 from the data and extracting the required columns 

INSERT INTO dp_stg2.ProductDescription

SELECT DISTINCT 
--CASE ProductDescriptionID1 WHEN 'NULL' THEN -1 ELSE ProductDescriptionID1 END AS ProductDescriptionID,
CASE
    WHEN  ProductDescriptionID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(ProductDescriptionID1),'-1') AS VARCHAR(20)) AS INT) END AS  ProductDescriptionID1,


--CASE Description WHEN 'NULL' THEN 'N/A' ELSE Description END AS Description
CASE 
    WHEN Description='NULL'
    THEN cast('N/A' AS VARCHAR(512))
    ELSE
    cast(coalesce(trim(Description),'N/A') AS VARCHAR(512)) END AS Description

FROM  dp_stg1.Production ;


--Checking if data is correctly loaded into the target table or not 
--It should return total number of 30 rows
SELECT *
FROM DP_STG2.ProductDescription;

-----------------------------------------------------------------------------------------------------------------------------------------------------

--6) ProductInventory Table
--According to Schema

----------------------------------------------------------------------------------------------

--Dropping the table if there is any issue while loading the data into the target table

DROP TABLE DP_STG2.ProductInventory;


--Refreshing the table after inserting the data into the table 
REFRESH dp_stg2.productinventory;



--Creating the ProductInventory table total 5 columns
--1) productID, 2)LocationID, 3)Shelf, 4)BIN1, 5)Quantity


CREATE TABLE DP_STG2.ProductInventory 
(
    ProductID INT,
    LocationID SMALLINT,
    Shelf  VARCHAR(16),
    Bin1  VARCHAR(16),
    Quantity SMALLINT
);


--Inserting data into the table from the source table and removing NULL from the source table
--Cleaning the Data and defining data types.

INSERT INTO DP_STG2.ProductInventory 

SELECT DISTINCT
--CASE ProductID1 WHEN 'NULL' THEN -1 ELSE ProductID1 END AS ProductID,
CASE
    WHEN  ProductID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( ProductID1),'-1') AS VARCHAR(20)) AS INT) END AS  ProductID,
    

--CASE LocationID1 WHEN 'NULL' THEN -1 ELSE CAST (LocationID1 AS SMALLINT) END AS LocationID,

CASE
    WHEN  LocationID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS SMALLINT)
    ELSE 
    cast(cast(coalesce(trim(LocationID1),'-1') AS VARCHAR(20)) AS SMALLINT) END AS  LocationID,
    

--CASE Shelf WHEN 'NULL' THEN 'N/A' ELSE Shelf END AS Shelf,
CASE 
    WHEN shelf='NULL'
    THEN cast('N/A' AS VARCHAR(16))
    ELSE
    cast(coalesce(trim(shelf),'N/A') AS VARCHAR(16)) END AS shelf,


--CASE Bin WHEN 'NULL' THEN -1 ELSE CAST (Bin AS SMALLINT) END AS Bin,
CASE 
    WHEN Bin1='NULL'
    THEN cast('N/A' AS VARCHAR(16))
    ELSE
    cast(coalesce(trim(Bin1),'N/A') AS VARCHAR(16)) END AS Bin1,



--CASE Quantity1 WHEN 'NULL' THEN -1 ELSE CAST (Quantity1 AS SMALLINT) END AS Quantity
CASE
    WHEN  Quantity1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS SMALLINT)
    ELSE 
    cast(cast(coalesce(trim(Quantity1),'-1') AS VARCHAR(20)) AS SMALLINT) END AS  Quantity1


FROM  dp_stg1.Production ;



--Checking if the data have been loaded in to the target table or not
--It should return 141 Rows


SELECT *
FROM DP_STG2.ProductInventory;

-------------------------------------------------------------------------------------------------------------------------

--7) ProductListPriceHistory
--According to Schema

---------------------------------------------------------------------------------------------------

----Dropping the table if there is any issue while loading the data into the target table
DROP TABLE DP_STG2.ProductListPriceHistory;


--Refreshing the table after inserting the data into the table 
REFRESH dp_stg2.productlistpricehistory;


--Creating the ProductInventory table total 4 columns
--1) productID, 2)StartDate, 3) EndDate, 4)ListPrice

CREATE TABLE dp_stg2.ProductListPriceHistory 
(
    ProductID INT,
    StartDate TIMESTAMP,
    EndDate TIMESTAMP,
    ListPrice DECIMAL(10,2)
);



--Inserting data into the table from the source table and removing NULL from the source table
--Cleaning the Data and defining data types.

INSERT INTO DP_STG2.ProductListPriceHistory 

SELECT DISTINCT
--CASE ProductID1 WHEN 'NULL' THEN -1 ELSE CAST (ProductID1 AS INTEGER) END AS ProductID,
CASE
    WHEN  ProductID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim( ProductID1),'-1') AS VARCHAR(20)) AS INT) END AS  ProductID,

--CASE StartDate1 WHEN 'NULL' THEN CAST ('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST (SUBSTR(StartDate1,1,10) AS DATE FORMAT 'YYYY-MM-DD')  END AS StartDate,
CASE
    WHEN StartDate1 = 'NULL'
    THEN cast ('1900-01-01' as TIMESTAMP)
    ELSE
    cast(coalesce(StartDate1,to_date('1900-01-01')) as TIMESTAMP)
end StartDate,



--CASE EndDate1 WHEN 'NULL' THEN CAST ('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST (SUBSTR(EndDate1,1,10) AS DATE FORMAT 'YYYY-MM-DD')  END AS EndDate,
CASE
    WHEN EndDate1 = 'NULL'
    THEN cast ('1900-01-01' as TIMESTAMP)
    ELSE
    cast(coalesce(EndDate1,to_date('1900-01-01')) as TIMESTAMP)
end EndDate,

--CASE ListPrice1 WHEN 'NULL' THEN -1 ELSE CAST (ListPrice1 AS DECIMAL(10,2)) END AS ListPrice
CASE
    WHEN   ListPrice1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(ListPrice1),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS ListPrice1

FROM  dp_stg1.Production ;


--Checking if the data have been loaded in to the target table or not
--It should return 35 Rows
SELECT *
FROM DP_STG2.ProductListPriceHistory;



-------------------------------------------------------------------------------------------------------------

--8) ProductModel Table
--According to Schema

----------------------------------------------------------------------------------------------

--Dropping the table if there is any issue while loading the data into the target table
DROP TABLE dp_stg2.ProductModel ;

--Refreshing the table after inserting the data into the table 

REFRESH dp_stg2.productmodel;

--Creating the ProductInventory table total 4 columns
--1) productModelID, 2) name1, 3) catalogDescription, 4) Instruction,

CREATE TABLE dp_stg2.ProductModel
(
    ProductModelID SMALLINT,
    Name1 VARCHAR(32),
    CatalogDescription VARCHAR(32),
    Instruction VARCHAR(32)
);




--Inserting data into the table from the source table and removing NULL from the source table
--Cleaning the Data and defining data types.

INSERT INTO DP_STG2.ProductModel 

SELECT DISTINCT
--CASE ProductModelID1 WHEN 'NULL' THEN -1 ELSE CAST (ProductModelID1 AS SMALLINT) END AS ProductModelID,
CASE
    WHEN  ProductModelID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS SMALLINT)
    ELSE 
    cast(cast(coalesce(trim( ProductModelID1),'-1') AS VARCHAR(20)) AS SMALLINT) END AS ProductModelID1,

--CASE Name5 WHEN 'NULL' THEN 'N/A' ELSE Name5 END AS Name5,
CASE 
    WHEN Name5='NULL'
    THEN cast('N/A' AS VARCHAR(32))
    ELSE
    cast(coalesce(trim(Name5),'N/A') AS VARCHAR(32)) END AS Name5,


--CASE CatalogDescription WHEN 'NULL' THEN 'N/A' ELSE CatalogDescription END AS CatalogDescription,
CASE 
    WHEN CatalogDescription='NULL'
    THEN cast('N/A' AS VARCHAR(32))
    ELSE
    cast(coalesce(trim(CatalogDescription),'N/A') AS VARCHAR(32)) END AS CatalogDescription,

--CASE Instructions WHEN 'NULL' THEN 'N/A' ELSE Instructions END AS Instructions
CASE 
    WHEN Instructions='NULL'
    THEN cast('N/A' AS VARCHAR(32))
    ELSE
    cast(coalesce(trim(Instructions),'N/A') AS VARCHAR(32)) END AS Instructions
    
FROM  dp_stg1.Production ;



--Checking if the data have been loaded in to the target table or not
--It should return 5 Rows

SELECT *
FROM DP_STG2.ProductModel;


------------------------------------------------------------------------------------------------------------

--9) ProductModelProductDesctriptionCulture
--According to Schema

----------------------------------------------------------------------------------------------

--Dropping the table if there is any issue while loading the data into the target table

DROP TABLE DP_STG2.ProductModelProductDesctriptionCulture;

--Refreshing the table after inserting the data into the table 

REFRESH dp_stg2.productmodelproductdesctriptionculture;

--Creating the ProductInventory table total 3 columns
--1) productModelID, 2)ProductDescriptionID, 3)CultureID

CREATE TABLE DP_STG2.ProductModelProductDesctriptionCulture
(
    ProductModelID SMALLINT,
    ProductDescriptionID INTEGER,
    CultureID VARCHAR(8)
);




--Inserting data into the table from the source table and removing NULL from the source table
--Cleaning the Data and defining data types.

INSERT INTO DP_STG2.ProductModelProductDesctriptionCulture 

SELECT DISTINCT
--CASE ProductModelID3 WHEN 'NULL' THEN -1 ELSE CAST (ProductModelID3 AS SMALLINT) END AS ProductModelID,
CASE
    WHEN  ProductModelID3='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS SMALLINT)
    ELSE 
    cast(cast(coalesce(trim( ProductModelID3),'-1') AS VARCHAR(20)) AS SMALLINT) END AS ProductModelID,

--CASE ProductDescriptionID1 WHEN 'NULL' THEN -1 ELSE ProductDescriptionID1 END AS ProductDescriptionID,
CASE
    WHEN  ProductDescriptionID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(ProductDescriptionID1),'-1') AS VARCHAR(20)) AS INT) END AS ProductDescriptionID,


--CASE CultureID1 WHEN 'NULL' THEN 'N/A' ELSE CultureID1 END AS CultureID

CASE 
    WHEN CultureID1='NULL'
    THEN cast('N/A' AS VARCHAR(8))
    ELSE
    cast(coalesce(trim(CultureID1),'N/A') AS VARCHAR(8)) END AS CultureID


FROM  dp_stg1.Production;



--Checking if the data have been loaded in to the target table or not
--It should return 30 rows

SELECT *
FROM DP_STG2.ProductModelProductDesctriptionCulture;


----------------------------------------------------------------------------------------------------------------

--Comments

--10) ProductSubCategory
--According to Schema

----------------------------------------------------------------------------------------------

--Dropping the table if there is any issue while loading the data into the target table

DROP TABLE DP_STG2.ProductSubCategory;

--Refreshing the table after inserting the data into the table 

REFRESH dp_stg2.productsubcategory;

--Creating the ProductInventory table total 5 columns
--1) productSubCategoryID, 2) ProductCategoryID, 3) name1

CREATE TABLE DP_STG2.ProductSubCategory
(
    ProductSubCategoryID SMALLINT,
    ProductCategoryID SMALLINT,
    Name1  VARCHAR(16)
);


--Inserting data into the table from the source table and removing NULL from the source table
--Cleaning the Data and defining data types.

INSERT INTO DP_STG2.ProductSubCategory 

SELECT  DISTINCT
--CASE ProductSubCategoryID1 WHEN 'NULL' THEN -1 ELSE CAST (ProductSubCategoryID1 AS SMALLINT) END AS ProductSubCategoryID,
CASE
    WHEN  ProductSubCategoryID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS SMALLINT)
    ELSE 
    cast(cast(coalesce(trim(ProductSubCategoryID1),'-1') AS VARCHAR(20)) AS SMALLINT) END AS ProductSubCategoryID,


--CASE ProductCategoryID1 WHEN 'NULL' THEN -1 ELSE CAST (ProductCategoryID1 AS SMALLINT) END AS ProductCategoryID,
CASE
    WHEN  ProductCategoryID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS SMALLINT)
    ELSE 
    cast(cast(coalesce(trim(ProductCategoryID1),'-1') AS VARCHAR(20)) AS SMALLINT) END AS ProductCategoryID,



--CASE Name2 WHEN 'NULL' THEN 'N/A' ELSE Name2 END AS Name1
CASE 
    WHEN Name2='NULL'
    THEN cast('N/A' AS VARCHAR(16))
    ELSE
    cast(coalesce(trim(Name2),'N/A') AS VARCHAR(16)) END AS Name1


FROM  dp_stg1.Production ;




--Checking if the data have been loaded in to the target table or not
--It should return 5 Rows
SELECT *
FROM DP_STG2.ProductSubCategory;


-------------------------------------------------------------------------------------------------------------------

--11) ScrapReason Table
--According to Schema

----------------------------------------------------------------------------------------------

--Dropping the table if there is any issue while loading the data into the target table

DROP TABLE DP_STG2.ScrapReason ;

--Refreshing the table after inserting the data into the table 

REFRESH dp_stg2.scrapreason;

--Creating the ProductInventory table total 2 columns
--1) ScrapReasonID 2)Name1

CREATE TABLE DP_STG2.ScrapReason
(
    ScrapReasonID INTEGER,
    Name1 VARCHAR(64)
);



--Inserting data into the table from the source table and removing NULL from the source table
--Cleaning the Data and defining data types.

INSERT INTO DP_STG2.ScrapReason 
SELECT 
--CASE ScrapReason WHEN 'NULL' THEN -1 ELSE ScrapReason END AS ScrapReason,
CASE
    WHEN  ScrapReason='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(ScrapReason),'-1') AS VARCHAR(20)) AS INT) END AS ScrapReason,


--CASE Name1 WHEN 'NULL' THEN 'N/A' ELSE Name1 END AS Name1
CASE 
    WHEN Name1='NULL'
    THEN cast('N/A' AS VARCHAR(64))
    ELSE
    cast(coalesce(trim(Name1),'N/A') AS VARCHAR(64)) END AS Name1


FROM  dp_stg1.Scrap_Reason_Production;



--Checking if the data have been loaded in to the target table or not
--It should return 16 Rows

SELECT *
FROM DP_STG2.ScrapReason;


-------------------------------------------------------------------------------------------------------------

--12) TransactionHistory Table
--According to Schema

----------------------------------------------------------------------------------------------

--Dropping the table if there is any issue while loading the data into the target table

DROP TABLE DP_STG2.TransactionHistory;

--Refreshing the table after inserting the data into the table 

REFRESH dp_stg2.TransactionHistory;

--Creating the TransactionHistory table total 5 columns
--1) transactionID, 2) ProductID, 3) ReferenceOrderID , 4) ReferenceOrderLineID, 5) TransactionDate, 6)TransactionType, 7)  Quantity, 8) ActualCost


CREATE TABLE DP_STG2.TransactionHistory
(
    TransactionID INTEGER,
    ProductID INTEGER,
    ReferenceOrderID INTEGER,
    ReferenceOrderLineID SMALLINT,
    TransactionDate TIMESTAMP,
    TransactionType VARCHAR(8),
    Quantity SMALLINT,
    ActualCost DECIMAL(10,2)
);



--Inserting data into the table from the source table and removing NULL from the source table
--Cleaning the Data and defining data types.

INSERT INTO DP_STG2.TransactionHistory 

SELECT DISTINCT
--CASE TransactionID WHEN 'NULL' THEN -1 ELSE TransactionID END AS TransactionID,
CASE
    WHEN  TransactionID='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(TransactionID),'-1') AS VARCHAR(20)) AS INT) END AS TransactionID,


--CASE ProductID1 WHEN 'NULL' THEN -1 ELSE ProductID1  END AS ProductID,
CASE
    WHEN  ProductID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(ProductID1),'-1') AS VARCHAR(20)) AS INT) END AS ProductID,

--CASE ReferenceOrderID WHEN 'NULL' THEN -1 ELSE ReferenceOrderID END AS ReferenceOrderID,
CASE
    WHEN  ReferenceOrderID='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(ReferenceOrderID),'-1') AS VARCHAR(20)) AS INT) END AS ReferenceOrderID,


--CASE ReferenceOrderLineID WHEN 'NULL' THEN -1 ELSE CAST (ReferenceOrderLineID AS SMALLINT) END AS ReferenceOrderLineID,
CASE
    WHEN  ReferenceOrderLineID='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS SMALLINT)
    ELSE 
    cast(cast(coalesce(trim(ReferenceOrderLineID),'-1') AS VARCHAR(20)) AS SMALLINT) END AS ReferenceOrderLineID,


--CASE TransactionDate WHEN 'NULL' THEN CAST ('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST (SUBSTR(TransactionDate,1,10) AS DATE FORMAT 'YYYY-MM-DD')  END AS TransactionDate,
CASE
    WHEN TransactionDate = 'NULL'
    THEN cast ('1900-01-01' as TIMESTAMP)
    ELSE
    cast(coalesce(TransactionDate,to_date('1900-01-01')) as TIMESTAMP)
end TransactionDate,



--CASE TransactionType WHEN 'NULL' THEN 'N/A' ELSE TransactionType END AS TransactionType,
CASE 
    WHEN TransactionType='NULL'
    THEN cast('N/A' AS VARCHAR(8))
    ELSE
    cast(coalesce(trim(TransactionType),'N/A') AS VARCHAR(8)) END AS TransactionType,

--CASE Quantity1 WHEN 'NULL' THEN -1 ELSE CAST (Quantity1 AS SMALLINT) END AS Quantity,

CASE
    WHEN  Quantity1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS SMALLINT)
    ELSE 
    cast(cast(coalesce(trim(Quantity1),'-1') AS VARCHAR(20)) AS SMALLINT) END AS Quantity,


--CASE ActualCost WHEN 'NULL' THEN -1 ELSE CAST (ActualCost AS DECIMAL(10,2)) END AS ActualCost

CASE
    WHEN   ActualCost='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(ActualCost),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS ActualCost


FROM  dp_stg1.Production ;



--Checking if the data have been loaded in to the target table or not
--It should return 9039 Rows

SELECT *
FROM DP_STG2.TransactionHistory;


SELECT count(*) AS NumberOfRows
FROM dp_stg2.transactionhistory;

----------------------------------------------------------------------------------------------------------

--13) UnitMeasure Table
--According to Schema

----------------------------------------------------------------------------------------------

--Dropping the table if there is any issue while loading the data into the target table

DROP TABLE dp_stg2.unitmeasure;

--Refreshing the table after inserting the data into the table 

REFRESH unitmeasure;

--Creating the unitMeasure table total 5 columns
--1) unitMeasureCode, 2) Name1

CREATE TABLE DP_STG2.UnitMeasure
(
    UnitMeasureCode CHAR(8),
    Name1 VARCHAR(32)
);



--Inserting data into the table from the source table and removing NULL from the source table
--Cleaning the Data and defining data types.

INSERT INTO DP_STG2.UnitMeasure 

SELECT 
--CASE UnitMeasureCode WHEN 'NULL' THEN 'N/A' ELSE CAST(UnitMeasureCode AS CHAR(8)) END AS UnitMeasureCode,
CASE 
    WHEN UnitMeasureCode='NULL'
    THEN cast('N/A' AS CHAR(8))
    ELSE
    cast(coalesce(trim(UnitMeasureCode),'N/A') AS CHAR(8)) END AS UnitMeasureCode,

--CASE Name1 WHEN 'NULL' THEN 'N/A' ELSE Name1 END AS Name1
CASE 
    WHEN  Name1='NULL'
    THEN cast('N/A' AS VARCHAR(32))
    ELSE
    cast(coalesce(trim( Name1),'N/A') AS VARCHAR(32)) END AS  Name1

FROM  dp_stg1.Unit_Measure_Production;


--Checking if the data have been loaded in to the target table or not
--It should return 38 Rows

SELECT *
FROM DP_STG2.UnitMeasure;

---------------------------------------------------------------------------------------------------------

--14) WorkOrder Table
--According to Schema

----------------------------------------------------------------------------------------------

--Dropping the table if there is any issue while loading the data into the target table

DROP TABLE DP_STG2.WorkOrder;

--Refreshing the table after inserting the data into the table 

REFRESH dp_stg2.workOrder;

--Creating the WorkOrder table total 9 columns
--1) workOrderID, 2) productID, 3) OrderQty, 4) StockedQty, 5)ScrappedQty, 6) StartDate, 7) EndDate,8) DueDate 9)ScrapReasonID

CREATE TABLE DP_STG2.WorkOrder
(
    WorkOrderID INT,
    ProductID INT,
    OrderQty INT,
    StockedQty INT,
    ScrappedQty INT,
    StartDate TIMESTAMP,
    EndDate TIMESTAMP,
    DueDate TIMESTAMP,
    ScrapReasonID INT
);


--Inserting data into the table from the source table and removing NULL from the source table
--Cleaning the Data and defining data types.

INSERT INTO DP_STG2.WorkOrder 

SELECT DISTINCT
--CASE WorkOrderID WHEN 'NULL' THEN -1 ELSE WorkOrderID END AS WorkOrderID,
CASE
    WHEN  WorkOrderID='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(WorkOrderID),'-1') AS VARCHAR(20)) AS INT) END AS WorkOrderID,

--CASE ProductID WHEN 'NULL' THEN -1 ELSE ProductID END AS ProductID,
CASE
    WHEN  ProductID='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(ProductID),'-1') AS VARCHAR(20)) AS INT) END AS ProductID,


--CASE OrderQty WHEN 'NULL' THEN -1 ELSE OrderQty END AS OrderQty,
CASE
    WHEN  OrderQty='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(OrderQty),'-1') AS VARCHAR(20)) AS INT) END AS OrderQty,


--CASE StockedQty WHEN 'NULL' THEN -1 ELSE StockedQty END AS StockedQty,
CASE
    WHEN  StockedQty='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(StockedQty),'-1') AS VARCHAR(20)) AS INT) END AS StockedQty,

--CASE ScrappedQty WHEN 'NULL' THEN -1 ELSE ScrappedQty END AS ScrappedQty,
CASE
    WHEN  ScrappedQty='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(ScrappedQty),'-1') AS VARCHAR(20)) AS INT) END AS ScrappedQty,


--CASE StartDate WHEN 'NULL' THEN CAST ('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST (SUBSTR(StartDate,1,10) AS DATE FORMAT 'YYYY-MM-DD')  END AS StartDate,
CASE
    WHEN StartDate = 'NULL'
    THEN cast ('1900-01-01' as TIMESTAMP)
    ELSE
    cast(coalesce(StartDate,to_date('1900-01-01')) as TIMESTAMP)
end StartDate,


--CASE EndDate WHEN 'NULL' THEN CAST ('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST (SUBSTR(EndDate,1,10) AS DATE FORMAT 'YYYY-MM-DD')  END AS EndDate,
CASE
    WHEN EndDate = 'NULL'
    THEN cast ('1900-01-01' as TIMESTAMP)
    ELSE
    cast(coalesce(EndDate,to_date('1900-01-01')) as TIMESTAMP)
end EndDate,



--CASE DueDate WHEN 'NULL' THEN CAST ('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST (SUBSTR(DueDate,1,10) AS DATE FORMAT 'YYYY-MM-DD')  END AS DueDate,
CASE
    WHEN DueDate = 'NULL'
    THEN cast ('1900-01-01' as TIMESTAMP)
    ELSE
    cast(coalesce(DueDate,to_date('1900-01-01')) as TIMESTAMP)
end DueDate,


--CASE ScrapReasonID WHEN 'NULL' THEN -1 ELSE ScrapReasonID END AS ScrapReasonID
CASE
    WHEN  ScrapReasonID='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(ScrapReasonID),'-1') AS VARCHAR(20)) AS INT) END AS ScrapReasonID

FROM  dp_stg1.Work_Order_Production;



--Checking if the data have been loaded in to the target table or not
--It should return 72591 Rows

SELECT *
FROM DP_STG2.WorkOrder;


SELECT count(*) AS NumberOfRows
FROM dp_stg2.workorder;

---------------------------------------------------------------------------------------------

--15) WorkOrderRouting Table
--According to Schema

----------------------------------------------------------------------------------------------

--Dropping the table if there is any issue while loading the data into the target table

DROP TABLE DP_STG2.WorkOrderRouting ;

--Refreshing the table after inserting the data into the table 

REFRESH dp_stg2.workorderrouting;

--Creating the ProductInventory table total 11 columns
--1)  WorkOrderID, 2)ProductID, 3)OperationSequence, 4)LocationID, 5)ScheduledStartDate, 6) ScheduledEndDate, 7) ActualStartDate, 8)ActualEndDate 
-- 9)ActualResourceHrs, 10)PlannedCost, 11)ActualCost


CREATE TABLE DP_STG2.WorkOrderRouting
(
    WorkOrderID INT,
    ProductID INT,
    OperationSequence INT,
    LocationID INT,
    ScheduledStartDate TIMESTAMP,
    ScheduledEndDate TIMESTAMP,
    ActualStartDate TIMESTAMP,
    ActualEndDate TIMESTAMP,
    ActualResourceHrs DECIMAL(10,2),
    PlannedCost DECIMAL(10,2),
    ActualCost DECIMAL(10,2)
);




--Inserting data into the table from the source table and removing NULL from the source table
--Cleaning the Data and defining data types.
INSERT INTO DP_STG2.WorkOrderRouting

SELECT DISTINCT
--CASE WorkOrderID WHEN 'NULL' THEN -1 ELSE WorkOrderID END AS WorkOrderID,
CASE
    WHEN  WorkOrderID='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(WorkOrderID),'-1') AS VARCHAR(20)) AS INT) END AS WorkOrderID,
    
    
--CASE ProductID WHEN 'NULL' THEN -1 ELSE ProductID END AS ProductID,

CASE
    WHEN  ProductID='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(ProductID),'-1') AS VARCHAR(20)) AS INT) END AS ProductID,
    

--CASE OperationSequence WHEN 'NULL' THEN -1 ELSE OperationSequence END AS OperationSequence,
CASE
    WHEN  OperationSequence='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(OperationSequence),'-1') AS VARCHAR(20)) AS INT) END AS OperationSequence,


--CASE LocationID WHEN 'NULL' THEN -1 ELSE LocationID END AS LocationID,

CASE
    WHEN  LocationID='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(LocationID),'-1') AS VARCHAR(20)) AS INT) END AS LocationID,

--CASE ScheduledStartDate WHEN 'NULL' THEN CAST ('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST (SUBSTR(ScheduledStartDate,1,10) AS DATE FORMAT 'YYYY-MM-DD')  END AS ScheduledStartDate,
CASE
    WHEN ScheduledStartDate = 'NULL'
    THEN cast ('1900-01-01' as TIMESTAMP)
    ELSE
    cast(coalesce(ScheduledStartDate,to_date('1900-01-01')) as TIMESTAMP)
end ScheduledStartDate,

--CASE ScheduledEndDate WHEN 'NULL' THEN CAST ('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST (SUBSTR(ScheduledEndDate,1,10) AS DATE FORMAT 'YYYY-MM-DD')  END AS ScheduledEndDate,
CASE
    WHEN ScheduledEndDate = 'NULL'
    THEN cast ('1900-01-01' as TIMESTAMP)
    ELSE
    cast(coalesce(ScheduledEndDate,to_date('1900-01-01')) as TIMESTAMP)
end ScheduledEndDate,

--CASE ActualStartDate WHEN 'NULL' THEN CAST ('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST (SUBSTR(ActualStartDate,1,10) AS DATE FORMAT 'YYYY-MM-DD')  END AS ActualStartDate,

CASE
    WHEN ActualStartDate = 'NULL'
    THEN cast ('1900-01-01' as TIMESTAMP)
    ELSE
    cast(coalesce(ActualStartDate,to_date('1900-01-01')) as TIMESTAMP)
end ActualStartDate,

--CASE ActualEndDate WHEN 'NULL' THEN CAST ('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST (SUBSTR(ActualEndDate,1,10) AS DATE FORMAT 'YYYY-MM-DD')  END AS ActualEndDate,
CASE
    WHEN ActualEndDate = 'NULL'
    THEN cast ('1900-01-01' as TIMESTAMP)
    ELSE
    cast(coalesce(ActualEndDate,to_date('1900-01-01')) as TIMESTAMP)
end ActualEndDate,


--CASE ActualResourceHrs WHEN 'NULL' THEN -1 ELSE CAST (ActualResourceHrs AS DECIMAL(10,2)) END AS ActualResourceHrs,
CASE
    WHEN  ActualResourceHrs='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(ActualResourceHrs),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS ActualResourceHrs,

--CASE PlannedCost WHEN 'NULL' THEN -1 ELSE CAST (PlannedCost AS DECIMAL(10,2)) END AS PlannedCost,

CASE
    WHEN  PlannedCost='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(PlannedCost),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS PlannedCost,



--CASE ActualCost WHEN 'NULL' THEN -1 ELSE CAST (ActualCost AS DECIMAL(10,2)) END AS ActualCost

CASE
    WHEN  ActualCost='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(ActualCost),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS ActualCost


FROM  dp_stg1.Work_Order_Routing_Production;



--Checking if the data have been loaded in to the target table or not
SELECT *
FROM DP_STG2.WorkOrderRouting;

--It should return 67131 Rows

SELECT count(*) AS NumberOfRows
FROM dp_stg2.workorderrouting;



--------------------------------------------------------------------------------------------------------------------

--16) Product Table
--According to Schema

----------------------------------------------------------------------------------------------

--Dropping the table if there is any issue while loading the data into the target table

DROP TABLE DP_STG2.Product;

--Refreshing the table after inserting the data into the table 

REFRESH DP_STG2.product;

--Creating the ProductInventory table total 5 columns
--1) productID, 2)LocationID, 3)Shelf, 4)BIN1, 5)Quantity


CREATE TABLE DP_STG2.Product
(
    ProductID INT,
    Name1 VARCHAR(32),
    ProductNumber VARCHAR(16),
    MakeFlag TINYINT,
    FinishedGoodsFlag TINYINT,
    Color VARCHAR(8),
    SafetyStockLevel SMALLINT,
    ReorderPoint SMALLINT,
    StandardCost DECIMAL(10,2),
    ListPrice DECIMAL(10,2),
    Size1 VARCHAR(16),
    SizeUnitMeasureCode VARCHAR(16),
    WeightUnitMeasureCode VARCHAR(16),
    Weight DECIMAL(5,2),
    DayToManufacture SMALLINT,
    ProductLine VARCHAR(8),
    Class1 VARCHAR(8),
    Style1 VARCHAR(8),
    ProductSubcategoryID INT,
    ProductModelID INT,
    SellStartDate TIMESTAMP,
    SellEndDate TIMESTAMP,
    DiscontinuedDate TIMESTAMP
);



--Inserting data into the table from the source table and removing NULL from the source table
--Cleaning the Data and defining data types.

INSERT INTO DP_STG2.Product

SELECT DISTINCT
--CASE WHEN ProductID1 = 'NULL' THEN -1 ELSE ProductID1 END AS ProductID,

CASE
    WHEN  ProductID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(ProductID1),'-1') AS VARCHAR(20)) AS INT) END AS ProductID,

--CASE WHEN Name1 = 'NULL' THEN 'N/A' ELSE Name1 END AS Name1,
CASE 
    WHEN  Name1='NULL'
    THEN cast('N/A' AS VARCHAR(32))
    ELSE
    cast(coalesce(trim(Name1),'N/A') AS VARCHAR(32)) END AS  Name1,


--CASE WHEN ProductNumber = 'NULL' THEN 'N/A' ELSE ProductNumber END AS ProductNumber,
CASE 
    WHEN  ProductNumber='NULL'
    THEN cast('N/A' AS VARCHAR(16))
    ELSE
    cast(coalesce(trim( ProductNumber),'N/A') AS VARCHAR(16)) END AS ProductNumber,



--CASE WHEN MakeFlag = 'NULL' THEN -1 ELSE CAST(MakeFlag AS BYTEINT) END AS MakeFlag,

CASE
    WHEN  MakeFlag='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS TINYINT)
    ELSE 
    cast(cast(coalesce(trim(MakeFlag),'-1') AS VARCHAR(20)) AS TINYINT) END AS MakeFlag,


--CASE WHEN FinishedGoodsFlag = 'NULL' THEN -1 ELSE CAST(FinishedGoodsFlag AS BYTEINT) END AS FinishedGoodsFlag,

CASE
    WHEN  FinishedGoodsFlag='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS TINYINT)
    ELSE 
    cast(cast(coalesce(trim(FinishedGoodsFlag),'-1') AS VARCHAR(20)) AS TINYINT) END AS FinishedGoodsFlag,

--CASE WHEN Color = 'NULL' THEN 'N/A' ELSE Color END AS Color,

CASE 
    WHEN  Color='NULL'
    THEN cast('N/A' AS VARCHAR(8))
    ELSE
    cast(coalesce(trim( Color),'N/A') AS VARCHAR(8)) END AS Color,


--CASE WHEN SafetyStockLevel = 'NULL' THEN -1 ELSE SafetyStockLevel END AS SafetyStockLevel,

CASE
    WHEN  SafetyStockLevel='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS SMALLINT)
    ELSE 
    cast(cast(coalesce(trim(SafetyStockLevel),'-1') AS VARCHAR(20)) AS SMALLINT) END AS SafetyStockLevel,


--CASE WHEN ReorderPoint = 'NULL' THEN -1 ELSE ReorderPoint END AS ReorderPoint,

CASE
    WHEN  ReorderPoint='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS SMALLINT)
    ELSE 
    cast(cast(coalesce(trim(ReorderPoint),'-1') AS VARCHAR(20)) AS SMALLINT) END AS ReorderPoint,


--CASE WHEN StandardCost1 = 'NULL' THEN -1 ELSE CAST(StandardCost1 AS DECIMAL(10,2)) END AS StandardCost,
CASE
    WHEN  StandardCost1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(StandardCost1),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS StandardCost,


--CASE WHEN ListPrice1 = 'NULL' THEN -1 ELSE CAST(ListPrice1 AS DECIMAL(10,2)) END AS ListPrice,
CASE
    WHEN  ListPrice1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(ListPrice1),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS ListPrice,
    
    
--CASE WHEN SIZE = 'NULL' THEN 'N/A' ELSE CAST(SIZE AS CHAR(4)) END AS Size1,

CASE 
    WHEN  SIZE='NULL'
    THEN cast('N/A' AS VARCHAR(16))
    ELSE
    cast(coalesce(trim( SIZE),'N/A') AS VARCHAR(16)) END AS SIZE1,


--CASE WHEN SizeUnitMeasureCode = 'NULL' THEN 'N/A' ELSE SizeUnitMeasureCode END AS SizeUnitMeasureCode,
CASE 
    WHEN  SizeUnitMeasureCode='NULL'
    THEN cast('N/A' AS VARCHAR(16))
    ELSE
    cast(coalesce(trim(SizeUnitMeasureCode),'N/A') AS VARCHAR(16)) END AS SizeUnitMeasureCode,




--CASE WHEN WeightUnitMeasureCode = 'NULL' THEN 'N/A' ELSE WeightUnitMeasureCode END AS WeightUnitMeasureCode,
CASE 
    WHEN  WeightUnitMeasureCode='NULL'
    THEN cast('N/A' AS VARCHAR(16))
    ELSE
    cast(coalesce(trim(WeightUnitMeasureCode),'N/A') AS VARCHAR(16)) END AS WeightUnitMeasureCode,


--CASE WHEN Weight = 'NULL' THEN -1 ELSE CAST(Weight AS DECIMAL(5,2)) END AS Weight,
CASE
    WHEN  Weight='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(5,2))
    ELSE 
    cast(cast(coalesce(trim(Weight),'-1') AS VARCHAR(20)) AS DECIMAL(5,2)) END AS Weight,

--CASE WHEN DaysToManufacture = 'NULL' THEN -1 ELSE CAST(DaysToManufacture AS SMALLINT) END AS DaysToManufacture,

CASE
    WHEN DaysToManufacture='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS SMALLINT)
    ELSE 
    cast(cast(coalesce(trim(DaysToManufacture),'-1') AS VARCHAR(20)) AS SMALLINT) END AS DaysToManufacture,

--CASE WHEN ProductLine = 'NULL' THEN 'N/A' ELSE ProductLine END AS ProductLine,
CASE 
    WHEN  ProductLine='NULL'
    THEN cast('N/A' AS VARCHAR(8))
    ELSE
    cast(coalesce(trim(ProductLine),'N/A') AS VARCHAR(8)) END AS ProductLine,

--CASE WHEN CLASS1 = 'NULL' THEN 'N/A' ELSE CLASS1 END AS CLASS1,
CASE 
    WHEN  CLASS1='NULL'
    THEN cast('N/A' AS VARCHAR(8))
    ELSE
    cast(coalesce(trim(CLASS1),'N/A') AS VARCHAR(8)) END AS CLASS1,


--CASE WHEN STYLE = 'NULL' THEN 'N/A' ELSE STYLE END AS Style1,
CASE 
    WHEN  STYLE='NULL'
    THEN cast('N/A' AS VARCHAR(8))
    ELSE
    cast(coalesce(trim(STYLE),'N/A') AS VARCHAR(8)) END AS Style1,


--CASE WHEN ProductSubcategoryID1 = 'NULL' THEN -1 ELSE ProductSubcategoryID1 END AS ProductSubcategoryID,
CASE
    WHEN  ProductSubcategoryID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(ProductSubcategoryID1),'-1') AS VARCHAR(20)) AS INT) END AS ProductSubcategoryID,

--CASE WHEN ProductModelID1 = 'NULL' THEN -1 ELSE ProductModelID1 END AS ProductModelID,
CASE
    WHEN  ProductModelID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(ProductModelID1),'-1') AS VARCHAR(20)) AS INT) END AS ProductModelID,


--CASE WHEN SellStartDate = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(SellStartDate,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS SellStartDate,
CASE
    WHEN SellStartDate = 'NULL'
    THEN cast ('1900-01-01' as TIMESTAMP)
    ELSE
    cast(coalesce(SellStartDate,to_date('1900-01-01')) as TIMESTAMP)
end SellStartDate,


--CASE WHEN SellEndDate = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(SellEndDate,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS SellEndDate,
CASE
    WHEN SellEndDate = 'NULL'
    THEN cast ('1900-01-01' as TIMESTAMP)
    ELSE
    cast(coalesce(SellEndDate,to_date('1900-01-01')) as TIMESTAMP)
end SellEndDate,


--CASE WHEN DiscontinuedDate = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(DiscontinuedDate,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS DiscontinuedDate
CASE
    WHEN DiscontinuedDate = 'NULL'
    THEN cast ('1900-01-01' as TIMESTAMP)
    ELSE
    cast(coalesce(DiscontinuedDate,to_date('1900-01-01')) as TIMESTAMP)
end DiscontinuedDate


FROM DP_STG1.Production;



--Checking if the data have been loaded in to the target table or not
--It should return 14 Rows

SELECT *
FROM dp_stg2.product;


---------------------------------------------------------------------------------------------------------------

--17) Location1 Table
--According to Schema

----------------------------------------------------------------------------------------------

--Dropping the table if there is any issue while loading the data into the target table

DROP TABLE dp_stg2.location1;

--REFRESHING THE TABLE AFTER INSERTING THE DATA INTO THE TARGET TABLE
REFRESH dp_stg2.location1


--Creating the ProductInventory table total 4 columns
--1) LocationID, 2) Name1, 3)CostRate, 4)Availablity

CREATE TABLE dp_stg2.location1
(
    locationID INT,
    Name1 VARCHAR(40),
    costRate DECIMAL(10,2),
    availability DECIMAL(10,2)

);



-- Inserting the data into the target table and cleaning the data by removing NULLS and Extracting required columns from source table
-- Using Name5 from source

INSERT INTO dp_stg2.location1

SELECT DISTINCT

CASE
    WHEN  locationID2='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(LocationID2),'-1') AS VARCHAR(20)) AS INT) END AS locationid1,
    


CASE 
    WHEN  name4='NULL'
    THEN cast('N/A' AS VARCHAR(40))
    ELSE
    cast(coalesce(trim(name4),'N/A') AS VARCHAR(40)) END AS name1,
    

CASE
    WHEN  costRate='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(costRate),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS costRate,
    

CASE
    WHEN  availability='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS DECIMAL(10,2))
    ELSE 
    cast(cast(coalesce(trim(availability),'-1') AS VARCHAR(20)) AS DECIMAL(10,2)) END AS availability
    

FROM dp_stg1.production;


--Checking if the data have been loaded in to the target table or not
--It should return 3 Rows

SELECT *
FROM dp_stg2.location1;