-- THIS IS THE 3 LAYER AFTER STAGING 2 LAYER (DP_STG2)
-- INPUT OF THIS LAYER IS THE OUTPUT OF STAGING 2 (DP_STG2)
-- WE ARE CREATING PARQUET TABLE AND SAME NUMBER OF TABLES AS IN STAGING 2
-- THIS IS BASICALLY YOU CAN SAY DATA WAREHOUSE IN WHICH ALL HISTORICAL DATA WILL BE LOADED AND IT WILL BE KEPT TILL THE END
-- WHILE IN STAGNING 2 EVERY NIGHT AFTER LOADING IN THIS LAYER, STAGING 2 WILL BE CLEANED SO THAT NEXT DAY DATA CAN BE LOADED
-- PARQUET TABLE MEANS IT WILL COMPRESS THE SIZE OF BIG TABLES AND HELP US TO STORE THE HISTORICAL DATA AS MUCH AS WE WANT ACCORDING TO BUSINESS

-- DP_RDM 
-- THIS FILE CONTAINS THE TABLES OF 

--1) HR (DONE)

--2) PERSON (DONE)

--3) PURCHASING

--4) SALES (DONE)

--5) PRODUCT (DONE)

--------------------------------------------------------------------------------------------

-- CREATING DATA BASE  DP_RDM

CREATE DATABASE DP_RDM;
--------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------
--1)HR TABLES ACCORDING TO PREVIOUS LAYER

--1) EMPLOYEE
--2) DEPARTMENT
--3) EmployeeDepartmentHistory
--4) Shift

---------------------------------------------------------------------------------------
-- 1) EMPOYEE TABLE AND LOADING INTO THIS FROM DP_STG2

--CREATE MULTISET TABLE DP_RDM.Employee AS DP_STG2.Employee WITH DATA;

CREATE TABLE dp_rdm.Employee STORED AS PARQUET AS
SELECT * FROM dp_stg2.Employee;

--Checking if data is loaded successfully
SELECT * 
FROM dp_rdm.employee;

-------------------------------------------------------------------------------

-- 2) DEPARTMENT TABLE AND LOADING INTO THIS FROM DP_STG2

--CREATING AS PARQUET TABLE WITH 3 COLUMNS 
-- 1) DEPARTMENTID 2)DepartmentName , 3) GroupName

DROP TABLE DP_RDM.department;

CREATE TABLE Dp_RDM.Department
(
            DepartmentID BIGINT ,
			DepartmentName STRING,
			GroupName STRING 
) STORED AS PARQUET;


--INSERTING DATA INTO THE DEPARTMENT TABLE FROM DP_STG2
INSERT INTO DP_RDM.Department
Select *
From DP_STG2.Department;

--Checking if data is loaded successfully

SELECT *
FROM dp_rdm.department;

-------------------------------------------------------------------------------

--3) EmployeeDepartmentHistory  TABLE AND LOADING INTO THIS FROM DP_STG2

--CREATE MULTISET TABLE DP_RDM.EmployeeDepartmentHistory AS DP_STG2.EmployeeDepartmentHistory WITH DATA;


CREATE TABLE dp_rdm.EmployeeDepartmentHistory STORED AS PARQUET AS
SELECT * FROM dp_stg2.EmployeeDepartmentHistory;

--Checking if data is loaded successfully

SELECT * 
FROM DP_RDM.EmployeeDepartmentHistory;

----------------------------------------------------------------------------------------------------------------
--4) SHIFT  TABLE AND LOADING INTO THIS FROM DP_STG2

DROP TABLE DP_rdm.shift;

CREATE TABLE dp_rdm.Shift AS
SELECT * FROM dp_stg2.Shift;


--Checking if data is loaded successfully
SELECT *
FROM dp_rdm.shift;




/*CREATE MULTISET TABLE DP_RDM.Shift 
     (
      ShiftID INTEGER ,
      Name1 CHAR(8) CHARACTER SET LATIN NOT CASESPECIFIC,
      StartTime TIME(6),
      EndTime TIME(6))
UNIQUE PRIMARY INDEX ( ShiftID );

INSERT INTO DP_RDM.Shift
Select *
FROM DP_STG2.Shift;*/

-------------------------------------------------------------------------------------------------------------------------------------------------

--2) PERSON TABLES ACCORDING TO PREVIOUS LAYER

--TOTAL TABLES=12

--1)Passwords               DONE
--2)EmailAddress            DONE
--3)ContactType
--4)BusinessEntity          DONE
--5)CountryRegion           DONE
--6)StateProvince           DONE
--7)Address                 DONE
--8)BusinessEntityAddress   DONE
--9)AddressType             DONE
--10)Person                 DONE
--11)PersonPhone            DONE
--12)PhoneNumberType        DONE


-----------------------------------------------------------------------------------------------

--1) Address  TABLE AND LOADING INTO THIS FROM DP_STG2

--CREATE MULTISET TABLE DP_RDM.Address AS DP_STG2.Address WITH DATA;


CREATE TABLE dp_rdm.Address STORED AS PARQUET AS
SELECT * FROM dp_stg2.Address;


--Checking if data is loaded successfully

SELECT *
FROM dp_rdm.address;

--DROPING TABLE IF DATA IS NOT LOADED SUCCESSFULLY
DROP TABLE dp_rdm.address; 
-----------------------------------------------------------------

--2) AddressType  TABLE AND LOADING INTO THIS FROM DP_STG2

--CREATE MULTISET TABLE DP_RDM.AddressType AS DP_STG2.AddressType WITH DATA;

CREATE TABLE dp_rdm.AddressType STORED AS PARQUET AS
SELECT * FROM dp_stg2.AddressType;



--Checking if data is loaded successfully

SELECT *
FROM dp_rdm.AddressType;


--DROPING TABLE IF DATA IS NOT LOADED SUCCESSFULLY
DROP TABLE dp_rdm.AddressType; 
--------------------------------------------------------------------------


--3) BusinessEntityAddress  TABLE AND LOADING INTO THIS FROM DP_STG2

--CREATE MULTISET TABLE DP_RDM.BusinessEntityAddress AS DP_STG2.BusinessEntityAddress WITH DATA;


CREATE TABLE dp_rdm.BusinessEntityAddress STORED AS PARQUET AS
SELECT * FROM dp_stg2.BusinessEntityAddress;



--Checking if data is loaded successfully

SELECT *
FROM dp_rdm.BusinessEntityAddress;


--DROPING TABLE IF DATA IS NOT LOADED SUCCESSFULLY
DROP TABLE dp_rdm.BusinessEntityAddress; 


------------------------------------------------------------------------

--4) Passwords  TABLE AND LOADING INTO THIS FROM DP_STG2




--CREATE MULTISET TABLE DP_RDM.Passwords AS DP_STG2.Passwords WITH DATA;


CREATE TABLE dp_rdm.Passwords STORED AS PARQUET AS
SELECT * FROM dp_stg2.Passwords;



--Checking if data is loaded successfully

SELECT *
FROM dp_rdm.Passwords;


--DROPING TABLE IF DATA IS NOT LOADED SUCCESSFULLY
DROP TABLE dp_rdm.Passwords; 



-----------------------------------------------------------------------------------

--5) BusinessEntity  TABLE AND LOADING INTO THIS FROM DP_STG2


--CREATE MULTISET TABLE DP_RDM.BusinessEntity AS DP_STG2.BusinessEntity WITH DATA;


CREATE TABLE dp_rdm.BusinessEntity STORED AS PARQUET AS
SELECT * FROM dp_stg2.BusinessEntity;



--Checking if data is loaded successfully

SELECT *
FROM dp_rdm.BusinessEntity;


--DROPING TABLE IF DATA IS NOT LOADED SUCCESSFULLY
DROP TABLE dp_rdm.BusinessEntity; 

--------------------------------------------------------------------------------------

--6) CountryRegion  TABLE AND LOADING INTO THIS FROM DP_STG2


--CREATE MULTISET TABLE DP_RDM.CountryRegion AS DP_STG2.CountryRegion WITH DATA;


CREATE TABLE dp_rdm.CountryRegion STORED AS PARQUET AS
SELECT * FROM dp_stg2.CountryRegion;



--Checking if data is loaded successfully

SELECT *
FROM dp_rdm.CountryRegion;


--DROPING TABLE IF DATA IS NOT LOADED SUCCESSFULLY
DROP TABLE dp_rdm.CountryRegion; 




----------------------------------------------------------------------------------

--7) StateProvince  TABLE AND LOADING INTO THIS FROM DP_STG2


--CREATE MULTISET TABLE DP_RDM.StateProvince AS DP_STG2.StateProvince WITH DATA;


CREATE TABLE dp_rdm.StateProvince STORED AS PARQUET AS
SELECT * FROM dp_stg2.StateProvince;



--Checking if data is loaded successfully

SELECT *
FROM dp_rdm.StateProvince;


--DROPING TABLE IF DATA IS NOT LOADED SUCCESSFULLY
DROP TABLE dp_rdm.StateProvince; 



----------------------------------------------------------------------------

--8) EmailAddress  TABLE AND LOADING INTO THIS FROM DP_STG2

--CREATE MULTISET TABLE DP_RDM.EmailAddress AS DP_STG2.EmailAddress WITH DATA;

CREATE TABLE dp_rdm.EmailAddress STORED AS PARQUET AS
SELECT * FROM dp_stg2.EmailAddress;

--Checking if data is loaded successfully

SELECT *
FROM dp_rdm.EmailAddress;


--DROPING TABLE IF DATA IS NOT LOADED SUCCESSFULLY
DROP TABLE dp_rdm.EmailAddress; 


----------------------------------------------------------------------------

--9) Person  TABLE AND LOADING INTO THIS FROM DP_STG2


--CREATE MULTISET TABLE DP_RDM.Person AS DP_STG2.Person WITH DATA;


CREATE TABLE dp_rdm.Person STORED AS PARQUET AS
SELECT * FROM dp_stg2.Person;

--Checking if data is loaded successfully

SELECT *
FROM dp_rdm.Person;


--DROPING TABLE IF DATA IS NOT LOADED SUCCESSFULLY
DROP TABLE dp_rdm.Person; 



--------------------------------------------------------------------------

--10) PersonPhone  TABLE AND LOADING INTO THIS FROM DP_STG2


--CREATE MULTISET TABLE DP_RDM.PersonPhone AS DP_STG2.PersonPhone WITH DATA;


CREATE TABLE dp_rdm.PersonPhone STORED AS PARQUET AS
SELECT * FROM dp_stg2.PersonPhone;

--Checking if data is loaded successfully

SELECT *
FROM dp_rdm.PersonPhone;


--DROPING TABLE IF DATA IS NOT LOADED SUCCESSFULLY
DROP TABLE dp_rdm.PersonPhone; 







--------------------------------------------------------------



--11) PhoneNumberType  TABLE AND LOADING INTO THIS FROM DP_STG2


CREATE TABLE dp_rdm.PhoneNumberType STORED AS PARQUET AS
SELECT * FROM dp_stg2.PhoneNumberType;

--Checking if data is loaded successfully

SELECT *
FROM dp_rdm.PhoneNumberType;


--DROPING TABLE IF DATA IS NOT LOADED SUCCESSFULLY
DROP TABLE dp_rdm.PhoneNumberType; 



/*CREATE MULTISET TABLE DP_RDM.PhoneNumberType (
PhoneNumberType INTEGER,
Name1 VARCHAR(8)
)
UNIQUE PRIMARY INDEX (PhoneNumberType);
INSERT INTO DP_RDM.PhoneNumberType
SELECT *
FROM DP_STG2.PhoneNumberType; */


-------------------------------------------------------------


--12) ContactType  TABLE AND LOADING INTO THIS FROM DP_STG2


CREATE TABLE dp_rdm.ContactType STORED AS PARQUET AS
SELECT * FROM dp_stg2.ContactType;

--Checking if data is loaded successfully

SELECT *
FROM dp_rdm.ContactType;


--DROPING TABLE IF DATA IS NOT LOADED SUCCESSFULLY
DROP TABLE dp_rdm.ContactType; 


--PERSON ALL 12 TABLES DONE

-------------------------------------------------------------------------------------------------------------------------------------------------------

--3) PRODUCT TABLES ACCORDING TO SCHEMA

--TOTAL TABLES=17

--1)BillOfMaterials --DONE
--2)Culture --DONE
--3)Product --DONE
--4)ProductCategory--DONE
--5)ProductCostHistory --DONE
--6)ProductDescription --DONE
--7)ProductInventory --DONE
--8)ProductListPriceHistory --DONE
--9)ProductModel --DONE
--10)ProductModelProductDescriptionCulture --DONE
--11)ProductSubCategory --DONE
--12)ScrapReason --DONE
--13)TransactionHistory --HAVE TO CREATE AND LOAD THIS  (DONEEEEEE)
--14)UnitMeasure --DONE
--15)WorkOrder --DONE
--16)WorkOrderRouting --DONE
--17)Location1 --DONE



--------------------------------------------------------------------------------------------------------------------------------------


--1) TransactionHistory Table (HAVE TO LOAD THIS)


/*
CREATE TABLE dp_rdm.TransactionHistory
( 
    TransactionID INTEGER,
    ProductID INTEGER,
    ReferenceOrderID INTEGER,
    ReferenceOrderLineID SMALLINT,
    TransactionDate TIMESTAMP,
    TransactionType VARCHAR(8),
    Quantity SMALLINT,
    ActualCost DECIMAL(10,2),
)

PARTITION BY RANGE(TransactionDate  BETWEEN DATE '2007-08-01' AND '2020-07-31'  INTERVAL '1' DAY ) Stored as kudu;

INSERT INTO dp_rdm.TransactionHistory
SELECT * FROM  dp_stg2.TransactionHistory;*/


CREATE TABLE dp_rdm.TransactionHistory
( 
    TransactionID INTEGER,
    ProductID INTEGER,
    ReferenceOrderID INTEGER,
    ReferenceOrderLineID SMALLINT,
    TransactionType VARCHAR(8),
    Quantity SMALLINT,
    ActualCost DECIMAL(10,2)
)

PARTITIONED BY(TransactionDate VARCHAR(50))  --From timestamp to varchar(50));
stored as parquet

INSERT INTO dp_rdm.TransactionHistory PARTITION (TransactionDate) 

SELECT 
    
    TransactionID,
    ProductID,
    ReferenceOrderID,
    ReferenceOrderLineID,
    TransactionType,
    Quantity,
    ActualCost,
    cast(TransactionDate as Varchar(50))TransactionDate
FROM dp_stg2.TransactionHistory;




--Inserting into the table and using partition on TransactionDate 

SELECT *
FROM dp_rdm.transactionhistory;

----------------------------------------------------------------------------------------------------


--2) Culture  TABLE AND LOADING INTO THIS FROM DP_STG2

--CREATE MULTISET TABLE DP_RDM.Culture AS dp_stg2.Culture WITH DATA;


CREATE TABLE dp_rdm.Culture STORED AS PARQUET AS
SELECT * FROM dp_stg2.Culture;

--Checking if data is loaded successfully

SELECT *
FROM dp_rdm.Culture;


--DROPING TABLE IF DATA IS NOT LOADED SUCCESSFULLY
DROP TABLE dp_rdm.Culture; 



-------------------------------------------------------------------------


--3) Location1  TABLE AND LOADING INTO THIS FROM DP_STG2

--CREATE MULTISET TABLE DP_RDM.Location  AS dp_stg2.Location WITH DATA;

CREATE TABLE dp_rdm.Location1 STORED AS PARQUET AS
SELECT * FROM dp_stg2.Location1;

--Checking if data is loaded successfully

SELECT *
FROM dp_rdm.Location1;


--DROPING TABLE IF DATA IS NOT LOADED SUCCESSFULLY
DROP TABLE dp_rdm.Location1; 



---------------------------------------------------------------------------

--4) Product  TABLE AND LOADING INTO THIS FROM DP_STG2


--CREATE MULTISET TABLE DP_RDM.Product AS dp_stg2.Product WITH DATA;

CREATE TABLE dp_rdm.Product STORED AS PARQUET AS
SELECT * FROM dp_stg2.Product;

--Checking if data is loaded successfully

SELECT *
FROM dp_rdm.Product;


--DROPING TABLE IF DATA IS NOT LOADED SUCCESSFULLY
DROP TABLE dp_rdm.Product; 






----------------------------------------------------------------------------

--5) ProductCostHistory  TABLE AND LOADING INTO THIS FROM DP_STG2

--CREATE MULTISET TABLE DP_RDM.ProductCostHistory AS dp_stg2.ProductCostHistory WITH DATA;


CREATE TABLE dp_rdm.ProductCostHistory STORED AS PARQUET AS
SELECT * FROM dp_stg2.ProductCostHistory;

--Checking if data is loaded successfully

SELECT *
FROM dp_rdm.ProductCostHistory;


--DROPING TABLE IF DATA IS NOT LOADED SUCCESSFULLY
DROP TABLE dp_rdm.ProductCostHistory;




-------------------------------------------------------------------------------

--6) ProductDescription  TABLE AND LOADING INTO THIS FROM DP_STG2


--CREATE MULTISET TABLE DP_RDM.ProductDescription AS dp_stg2.ProductDescription WITH DATA;


CREATE TABLE dp_rdm.ProductDescription STORED AS PARQUET AS
SELECT * FROM dp_stg2.ProductDescription;

--Checking if data is loaded successfully

SELECT *
FROM dp_rdm.ProductDescription;


--DROPING TABLE IF DATA IS NOT LOADED SUCCESSFULLY
DROP TABLE dp_rdm.ProductDescription;

-------------------------------------------------------------------------------


--7) ProductInventory  TABLE AND LOADING INTO THIS FROM DP_STG2

--CREATE MULTISET TABLE DP_RDM.ProductInventory AS dp_stg2.ProductInventory WITH DATA;


CREATE TABLE dp_rdm.ProductInventory STORED AS PARQUET AS
SELECT * FROM dp_stg2.ProductInventory;

--Checking if data is loaded successfully (141 Rows)

SELECT *
FROM dp_rdm.ProductInventory;


--DROPING TABLE IF DATA IS NOT LOADED SUCCESSFULLY
DROP TABLE dp_rdm.ProductInventory;

-------------------------------------------------------------------------------

--8) ProductListPriceHistory  TABLE AND LOADING INTO THIS FROM DP_STG2


--CREATE MULTISET TABLE DP_RDM.ProductListPriceHistory AS dp_stg2.ProductListPriceHistory WITH DATA;

CREATE TABLE dp_rdm.ProductListPriceHistory STORED AS PARQUET AS
SELECT * FROM dp_stg2.ProductListPriceHistory;

--Checking if data is loaded successfully 

SELECT *
FROM dp_rdm.ProductListPriceHistory;


--DROPING TABLE IF DATA IS NOT LOADED SUCCESSFULLY
DROP TABLE dp_rdm.ProductListPriceHistory;

-------------------------------------------------------------------------------


--9) ProductModel  TABLE AND LOADING INTO THIS FROM DP_STG2


--CREATE MULTISET TABLE DP_RDM.ProductModel AS dp_stg2.ProductModel WITH DATA;


CREATE TABLE dp_rdm.ProductModel STORED AS PARQUET AS
SELECT * FROM dp_stg2.ProductModel;

--Checking if data is loaded successfully

SELECT *
FROM dp_rdm.ProductModel;


--DROPING TABLE IF DATA IS NOT LOADED SUCCESSFULLY
DROP TABLE dp_rdm.ProductModel;


---------------------------------------------------------------------

--10) ProductModelProductDesctriptionCulture  TABLE AND LOADING INTO THIS FROM DP_STG2

--CREATE MULTISET TABLE DP_RDM.ProductModelProductDesctriptionCulture AS dp_stg2.ProductModelProductDesctriptionCulture WITH DATA;


CREATE TABLE dp_rdm.ProductModelProductDesctriptionCulture STORED AS PARQUET AS
SELECT * FROM dp_stg2.ProductModelProductDesctriptionCulture;

--Checking if data is loaded successfully (30 Rows)

SELECT *
FROM dp_rdm.ProductModelProductDesctriptionCulture;


--DROPING TABLE IF DATA IS NOT LOADED SUCCESSFULLY
DROP TABLE dp_rdm.ProductModelProductDesctriptionCulture;


---------------------------------------------------------------------



--11) WorkOrder  TABLE AND LOADING INTO THIS FROM DP_STG2

--CREATE MULTISET TABLE DP_RDM.WorkOrder AS dp_stg2.WorkOrder WITH DATA;

CREATE TABLE dp_rdm.WorkOrder STORED AS PARQUET AS
SELECT * FROM dp_stg2.WorkOrder;

--Checking if data is loaded successfully (72591 Rows)

SELECT *
FROM dp_rdm.WorkOrder;


--DROPING TABLE IF DATA IS NOT LOADED SUCCESSFULLY
DROP TABLE dp_rdm.WorkOrder;

--------------------------------------------------------------------------------------

--12) WorkOrderRouting  TABLE AND LOADING INTO THIS FROM DP_STG2

--CREATE MULTISET TABLE DP_RDM.WorkOrderRouting AS dp_stg2.WorkOrderRouting WITH DATA;

CREATE TABLE dp_rdm.WorkOrderRouting STORED AS PARQUET AS
SELECT * FROM dp_stg2.WorkOrderRouting;

--Checking if data is loaded successfully (67131 Rows)

SELECT *
FROM dp_rdm.WorkOrderRouting;


--DROPING TABLE IF DATA IS NOT LOADED SUCCESSFULLY
DROP TABLE dp_rdm.WorkOrderRouting;



--------------------------------------------------------------------------------------

--13) UnitMeasure  TABLE AND LOADING INTO THIS FROM DP_STG2

--CREATE MULTISET TABLE DP_RDM.UnitMeasure AS dp_stg2.UnitMeasure WITH DATA;

CREATE TABLE dp_rdm.UnitMeasure STORED AS PARQUET AS
SELECT * FROM dp_stg2.UnitMeasure;

--Checking if data is loaded successfully (38 Rows)

SELECT *
FROM dp_rdm.UnitMeasure;


--DROPING TABLE IF DATA IS NOT LOADED SUCCESSFULLY
DROP TABLE dp_rdm.UnitMeasure;



--------------------------------------------------------------------------------------

--14) ProductCategory  TABLE AND LOADING INTO THIS FROM DP_STG2

--CREATE MULTISET TABLE DP_RDM.ProductCategory AS dp_stg2.ProductCategory WITH DATA;

CREATE TABLE dp_rdm.ProductCategory STORED AS PARQUET AS
SELECT * FROM dp_stg2.ProductCategory;

--Checking if data is loaded successfully (4 Rows)

SELECT *
FROM dp_rdm.ProductCategory;


--DROPING TABLE IF DATA IS NOT LOADED SUCCESSFULLY
DROP TABLE dp_rdm.ProductCategory;



--------------------------------------------------------------------------------------


--15) ProductSubcategory  TABLE AND LOADING INTO THIS FROM DP_STG2

--CREATE MULTISET TABLE DP_RDM.ProductSubcategory AS dp_stg2.ProductSubcategory WITH DATA;

CREATE TABLE dp_rdm.ProductSubcategory STORED AS PARQUET AS
SELECT * FROM dp_stg2.ProductSubcategory;

--Checking if data is loaded successfully (5 Rows)

SELECT *
FROM dp_rdm.ProductSubcategory;


--DROPING TABLE IF DATA IS NOT LOADED SUCCESSFULLY
DROP TABLE dp_rdm.ProductSubcategory;



--------------------------------------------------------------------------------------


--16) ScrapReason  TABLE AND LOADING INTO THIS FROM DP_STG2

--CREATE MULTISET TABLE DP_RDM.ScrapReason AS dp_stg2.ScrapReason WITH DATA;

CREATE TABLE dp_rdm.ScrapReason STORED AS PARQUET AS
SELECT * FROM dp_stg2.ScrapReason;

--Checking if data is loaded successfully (16 Rows)

SELECT *
FROM dp_rdm.ScrapReason;


--DROPING TABLE IF DATA IS NOT LOADED SUCCESSFULLY
DROP TABLE dp_rdm.ScrapReason;



--------------------------------------------------------------------------------------

--17) BillofMaterials  TABLE AND LOADING INTO THIS FROM DP_STG2


--CREATE MULTISET TABLE DP_RDM.BillofMaterials AS dp_stg2.BillofMaterials WITH DATA;

CREATE TABLE dp_rdm.BillofMaterials STORED AS PARQUET AS
SELECT * FROM dp_stg2.BillofMaterials;

--Checking if data is loaded successfully (2679 Rows)

SELECT *
FROM dp_rdm.BillofMaterials;


--DROPING TABLE IF DATA IS NOT LOADED SUCCESSFULLY
DROP TABLE dp_rdm.BillofMaterials;




-- ALL TABLES CREATED AND DATA LOADED SUCCESSFULLY EXCEPT TRANSACTIONHISTORY

-------------------------------------------------------------------------------------------------------------------------------------




--4) SALES TABLES ACCORDING TO SCHEMA

--TOTAL TABLES=18

--1)CreditCard  --412 but 392 
--2)Currency    -- 1 Row of currency type    
--3)CurrencyRate --87 but 75                     
--4)Customer     --19820 ROWS                 
--5)PersonCreditCard  (Zaeem) --412 but 392 )
--6)SalesOrderDetail                                       
--7)SalesOrderHeader         -- 905 ROWS (DONE)        
--8)SalesOrderHeaderSalesReason (zaeem)--646   DONEEEE
--9)SalesPerson   (zaeem)               --17 but 80 
--10)SalesPersonQuotaHistory (Zaeem)   --139 rows 
--11)SalesReason    (Zaeem)            --3 Rows
--12)SalesTaxRate(zaeeem)           -- 29 Rows
--13)SalesTerritory (zaeem)         -- 10 but 57 
--14)SalesTerritoryHistory (zaeem)  --396 Rows 
--15)ShoppingCartItem  (zaeem)      --3 ROWS    DONEEEE
--16)SpecialOffer                   --4 Rows    DONEEEE
--17)SpecialOfferProduct            -- 65 ROWS  DONEEEE
--18)Store                          --701 ROWS  DONEEEE 


-------------------------------------------------------------------------------------------------------------------------------------------------


--1) ShoppingCartItem  TABLE AND LOADING INTO THIS FROM DP_STG2

--CREATE MULTISET TABLE DP_RDM.ShoppingCartItem AS DP_STG2.ShoppingCartItem WITH DATA;


CREATE TABLE dp_rdm.ShoppingCartItem STORED AS PARQUET AS
SELECT * FROM dp_stg2.ShoppingCartItem;

--Checking if data is loaded successfully (3 Rows)

SELECT *
FROM dp_rdm.ShoppingCartItem;


--DROPING TABLE IF DATA IS NOT LOADED SUCCESSFULLY
DROP TABLE dp_rdm.ShoppingCartItem;


------------------------------------------------------------------------------------------------


--2) SpecialOffer  TABLE AND LOADING INTO THIS FROM DP_STG2


--CREATE MULTISET TABLE DP_RDM.SpecialOffer AS DP_STG2.SpecialOffer WITH DATA;

CREATE TABLE dp_rdm.SpecialOffer STORED AS PARQUET AS
SELECT * FROM dp_stg2.SpecialOffer;

--Checking if data is loaded successfully (4 Rows)

SELECT *
FROM dp_rdm.SpecialOffer;


--DROPING TABLE IF DATA IS NOT LOADED SUCCESSFULLY
DROP TABLE dp_rdm.SpecialOffer;


------------------------------------------------------------------------------------------------



--3) SpecialOfferProduct  TABLE AND LOADING INTO THIS FROM DP_STG2



--CREATE MULTISET TABLE DP_RDM.SpecialOfferProduct AS DP_STG2.SpecialOfferProduct WITH DATA;



CREATE TABLE dp_rdm.SpecialOfferProduct STORED AS PARQUET AS
SELECT * FROM dp_stg2.SpecialOfferProduct;

--Checking if data is loaded successfully (65 Rows)

SELECT *
FROM dp_rdm.SpecialOfferProduct;


--DROPING TABLE IF DATA IS NOT LOADED SUCCESSFULLY
DROP TABLE dp_rdm.SpecialOfferProduct;


------------------------------------------------------------------------------------------------


--4) Store  TABLE AND LOADING INTO THIS FROM DP_STG2

--CREATE MULTISET TABLE DP_RDM.Store AS DP_STG2.Store WITH DATA;

CREATE TABLE dp_rdm.Store STORED AS PARQUET AS
SELECT * FROM dp_stg2.Store;

--Checking if data is loaded successfully (701 Rows)

SELECT *
FROM dp_rdm.Store;


--DROPING TABLE IF DATA IS NOT LOADED SUCCESSFULLY
DROP TABLE dp_rdm.Store;

---------------------------------------------------------------------------------------------



--5) SalesOrderHeaderSalesReason  TABLE AND LOADING INTO THIS FROM DP_STG2

--CREATE MULTISET TABLE DP_RDM.SalesOrderHeaderSalesReason AS DP_STG2.SalesOrderHeaderSalesReason WITH DATA;

CREATE TABLE dp_rdm.SalesOrderHeaderSalesReason STORED AS PARQUET AS
SELECT * FROM dp_stg2.SalesOrderHeaderSalesReason;

--Checking if data is loaded successfully (646 Rows)

SELECT *
FROM dp_rdm.SalesOrderHeaderSalesReason;


--DROPING TABLE IF DATA IS NOT LOADED SUCCESSFULLY
DROP TABLE dp_rdm.SalesOrderHeaderSalesReason;

---------------------------------------------------------------------------------------------



--6) SalesPerson  TABLE AND LOADING INTO THIS FROM DP_STG2


--CREATE MULTISET TABLE DP_RDM.SalesPerson AS DP_STG2.SalesPerson WITH DATA;

CREATE TABLE dp_rdm.SalesPerson STORED AS PARQUET AS
SELECT * FROM dp_stg2.SalesPerson;

--Checking if data is loaded successfully (17 Rows)

SELECT *
FROM dp_rdm.SalesPerson;


--DROPING TABLE IF DATA IS NOT LOADED SUCCESSFULLY
DROP TABLE dp_rdm.SalesPerson;

---------------------------------------------------------------------------------------------

--7) SalesPersonQuotaHistory  TABLE AND LOADING INTO THIS FROM DP_STG2


--CREATE MULTISET TABLE DP_RDM.SalesPersonQuotaHistory AS DP_STG2.SalesPersonQuotaHistory WITH DATA;

CREATE TABLE dp_rdm.SalesPersonQuotaHistory STORED AS PARQUET AS
SELECT * FROM dp_stg2.SalesPersonQuotaHistory;

--Checking if data is loaded successfully (139 Rows)

SELECT *
FROM dp_rdm.SalesPersonQuotaHistory;


--DROPING TABLE IF DATA IS NOT LOADED SUCCESSFULLY
DROP TABLE dp_rdm.SalesPersonQuotaHistory;

---------------------------------------------------------------------------------------------


--8) SalesReason  TABLE AND LOADING INTO THIS FROM DP_STG2

--CREATE MULTISET TABLE DP_RDM.SalesReason AS DP_STG2.SalesReason WITH DATA;

CREATE TABLE dp_rdm.SalesReason STORED AS PARQUET AS
SELECT * FROM dp_stg2.SalesReason;

--Checking if data is loaded successfully (3 Rows)

SELECT *
FROM dp_rdm.SalesReason;


--DROPING TABLE IF DATA IS NOT LOADED SUCCESSFULLY
DROP TABLE dp_rdm.SalesReason;

---------------------------------------------------------------------------------------------

--9) SalesTaxRate  TABLE AND LOADING INTO THIS FROM DP_STG2


--CREATE MULTISET TABLE DP_RDM.SalesTaxRate AS DP_STG2.SalesTaxRate WITH DATA;


CREATE TABLE dp_rdm.SalesTaxRate STORED AS PARQUET AS
SELECT * FROM dp_stg2.SalesTaxRate;

--Checking if data is loaded successfully (29 Rows)

SELECT *
FROM dp_rdm.SalesTaxRate;


--DROPING TABLE IF DATA IS NOT LOADED SUCCESSFULLY
DROP TABLE dp_rdm.SalesTaxRate;

---------------------------------------------------------------------------------------------


--10) SalesTerritory  TABLE AND LOADING INTO THIS FROM DP_STG2

--CREATE MULTISET TABLE DP_RDM.SalesTerritory AS DP_STG2.SalesTerritory WITH DATA;


CREATE TABLE dp_rdm.SalesTerritory STORED AS PARQUET AS
SELECT * FROM dp_stg2.SalesTerritory;

--Checking if data is loaded successfully (57 Rows)

SELECT *
FROM dp_rdm.SalesTerritory;


--DROPING TABLE IF DATA IS NOT LOADED SUCCESSFULLY
DROP TABLE dp_rdm.SalesTerritory;

---------------------------------------------------------------------------------------------

--11) SalesTerritoryHistory  TABLE AND LOADING INTO THIS FROM DP_STG2


--CREATE MULTISET TABLE DP_RDM.SalesTerritoryHistory AS DP_STG2.SalesTerritoryHistory WITH DATA;

CREATE TABLE dp_rdm.SalesTerritoryHistory STORED AS PARQUET AS
SELECT * FROM dp_stg2.SalesTerritoryHistory;

--Checking if data is loaded successfully (396 Rows)

SELECT *
FROM dp_rdm.SalesTerritoryHistory;


--DROPING TABLE IF DATA IS NOT LOADED SUCCESSFULLY
DROP TABLE dp_rdm.SalesTerritoryHistory;

---------------------------------------------------------------------------------------------

--12) Currency  TABLE AND LOADING INTO THIS FROM DP_STG2

--CREATE MULTISET TABLE DP_RDM.Currency AS DP_STG2.Currency WITH DATA;

CREATE TABLE dp_rdm.Currency STORED AS PARQUET AS
SELECT * FROM dp_stg2.Currency;

--Checking if data is loaded successfully (1 Rows)

SELECT *
FROM dp_rdm.Currency;


--DROPING TABLE IF DATA IS NOT LOADED SUCCESSFULLY
DROP TABLE dp_rdm.Currency;

---------------------------------------------------------------------------------------------


--13) CurrencyRate  TABLE AND LOADING INTO THIS FROM DP_STG2


--CREATE MULTISET TABLE DP_RDM.CurrencyRate AS DP_STG2.CurrencyRate WITH DATA;

CREATE TABLE dp_rdm.CurrencyRate STORED AS PARQUET AS
SELECT * FROM dp_stg2.CurrencyRate;

--Checking if data is loaded successfully (75 Rows)

SELECT *
FROM dp_rdm.CurrencyRate;


--DROPING TABLE IF DATA IS NOT LOADED SUCCESSFULLY
DROP TABLE dp_rdm.CurrencyRate;

---------------------------------------------------------------------------------------------

--14) Customer  TABLE AND LOADING INTO THIS FROM DP_STG2

--CREATE MULTISET TABLE DP_RDM.Customer AS DP_STG2.Customer WITH DATA;

CREATE TABLE dp_rdm.Customer STORED AS PARQUET AS
SELECT * FROM dp_stg2.Customer;

--Checking if data is loaded successfully (19820 Rows)

SELECT *
FROM dp_rdm.Customer;


--DROPING TABLE IF DATA IS NOT LOADED SUCCESSFULLY
DROP TABLE dp_rdm.Customer;

---------------------------------------------------------------------------------------------


--15) CreditCard  TABLE AND LOADING INTO THIS FROM DP_STG2

--CREATE MULTISET TABLE DP_RDM.CreditCard AS DP_STG2.CreditCard WITH DATA;

CREATE TABLE dp_rdm.CreditCard STORED AS PARQUET AS
SELECT * FROM dp_stg2.CreditCard;

--Checking if data is loaded successfully (392 Rows)

SELECT *
FROM dp_rdm.CreditCard;


--DROPING TABLE IF DATA IS NOT LOADED SUCCESSFULLY
DROP TABLE dp_rdm.CreditCard;

---------------------------------------------------------------------------------------------


--16) PersonCreditCard  TABLE AND LOADING INTO THIS FROM DP_STG2

--CREATE MULTISET TABLE DP_RDM.PersonCreditCard AS DP_STG2.PersonCreditCard WITH DATA;

CREATE TABLE dp_rdm.PersonCreditCard STORED AS PARQUET AS
SELECT * FROM dp_stg2.PersonCreditCard;

--Checking if data is loaded successfully (392 Rows)

SELECT *
FROM dp_rdm.PersonCreditCard;


--DROPING TABLE IF DATA IS NOT LOADED SUCCESSFULLY
DROP TABLE dp_rdm.PersonCreditCard;

---------------------------------------------------------------------------------------------


--Without Parition creating and loading the data 

--17) SalesOrderHeader  TABLE AND LOADING INTO THIS FROM DP_STG2

/*
CREATE MULTISET TABLE DP_RDM.SalesOrderHeader AS DP_STG2.SalesOrderHeader
WITH DATA
PRIMARY INDEX(SalesOrderID) 
PARTITION BY RANGE_N  (
   OrderDate BETWEEN DATE '2000-01-01' AND '2019-12-31' EACH INTERVAL '1' MONTH);*/
   
CREATE TABLE dp_rdm.SalesOrderHeader STORED AS PARQUET AS
SELECT * FROM dp_stg2.SalesOrderHeader;
   
--Checking if data is loaded successfully (392 Rows)
SELECT *
FROM dp_rdm.SalesOrderHeader;
   
   
-------------------------------------------------------------------------------------------------------

--Without Parition creating and loading the data 

--18) SalesOrderDetail  TABLE AND LOADING INTO THIS FROM DP_STG2



/*CREATE MULTISET TABLE DP_RDM.SalesOrderDetail AS DP_STG2.SalesOrderDetail
WITH DATA
PRIMARY INDEX(SalesOrderID) 
PARTITION BY ProductID;*/            --HAVE TO LOAD THESE TWO TABLES SalesOrderHeader AND SalesOrderDetail


CREATE TABLE dp_rdm.SalesOrderDetail STORED AS PARQUET AS
SELECT * FROM dp_stg2.SalesOrderDetail;


--Checking if data is loaded successfully (392 Rows)
SELECT *
FROM dp_rdm.SalesOrderDetail;

----------------------------------------------------------------------------------------------------------------------------

--TOTAL TABLES=5

--1)ProductVendor
--2)PurchaseOrderDetail
--3)PurchaseOrderHeader
--4)ShipMethod
--5)Vendor


------------------------------------------------------------------------------


--1) Vendor  TABLE AND LOADING INTO THIS FROM DP_STG2

--CREATE MULTISET TABLE dp_rdm.Vendor AS dp_stg2.Vendor WITH DATA;

CREATE TABLE dp_rdm.Vendor STORED AS PARQUET AS
SELECT * FROM dp_stg2.Vendor;

--Checking if data is loaded successfully (86 Rows)

SELECT *
FROM dp_rdm.Vendor;


--DROPING TABLE IF DATA IS NOT LOADED SUCCESSFULLY
DROP TABLE dp_rdm.Vendor;

---------------------------------------------------------------------------------------------



--2) ShipMethod  TABLE AND LOADING INTO THIS FROM DP_STG2

--CREATE MULTISET TABLE dp_rdm.ShipMethod AS dp_stg2.ShipMethod WITH DATA;

CREATE TABLE dp_rdm.ShipMethod STORED AS PARQUET AS
SELECT * FROM dp_stg2.ShipMethod;

--Checking if data is loaded successfully (5 Rows)

SELECT *
FROM dp_rdm.ShipMethod;


--DROPING TABLE IF DATA IS NOT LOADED SUCCESSFULLY
DROP TABLE dp_rdm.ShipMethod;

---------------------------------------------------------------------------------------------

--3) ProductVendor  TABLE AND LOADING INTO THIS FROM DP_STG2


--CREATE MULTISET TABLE dp_rdm.ProductVendor AS dp_stg2.ProductVendor WITH DATA;


CREATE TABLE dp_rdm.ProductVendor STORED AS PARQUET AS
SELECT * FROM dp_stg2.ProductVendor;

--Checking if data is loaded successfully (936 Rows)

SELECT *
FROM dp_rdm.ProductVendor;


--DROPING TABLE IF DATA IS NOT LOADED SUCCESSFULLY
DROP TABLE dp_rdm.ProductVendor;

---------------------------------------------------------------------------------------------

--4) PurchaseOrderHeader  TABLE AND LOADING INTO THIS FROM DP_STG2


CREATE TABLE dp_rdm.PurchaseOrderHeader STORED AS PARQUET AS
SELECT * FROM dp_stg2.PurchaseOrderHeader;


--Partitioned_Tables

DROP TABLE dp_rdm.PurchaseOrderHeader;

CREATE TABLE dp_rdm.PurchaseOrderHeader
( 
            PurchaseOrderID INTEGER,
		   ShipMethodID INTEGER,
		   VendorID INTEGER,
		   RevisionNumber INTEGER,
		   Status INTEGER,
		   EmployeeID INTEGER,
		   ShipDate TIMESTAMP,
		   SubTotal DECIMAL(9,2),
		   TaxAmt DECIMAL(7,2),
		   Freight DECIMAL(7,2),
		   TotalDue DECIMAL(9,2)
)
PARTITIONED BY (OrderDate varchar(50))
Stored as Parquet

--Inserting into the table and using partition on orderDate 

INSERT INTO dp_rdm.PurchaseOrderHeader PARTITION (OrderDate)
SELECT PurchaseOrderID ,
       ShipMethodID ,
       VendorID ,
       RevisionNumber ,
       Status ,
       EmployeeID ,
       ShipDate ,
       SubTotal ,
       TaxAmt ,
       Freight ,
       TotalDue ,
       cast(OrderDate as Varchar(50))OrderDate
FROM  dp_stg2.PurchaseOrderHeader ;

--Checking if data is loaded successfully (936 Rows)
SELECT *
FROM dp_rdm.purchaseorderheader;

--Checking if partition has been done correctly or not
alter table dp_rdm.purchaseorderheader drop partition (orderdate = '2006-05-13 00:00:00')


----------------------------------------------------------------------------------------------------------------------


--5) PurchaseOrderDetail  TABLE AND LOADING INTO THIS FROM DP_STG2

--Partitioned_Tables


/*
CREATE MULTISET TABLE dp_rdm.PurchaseOrderDetail 
( 
       PurchaseOrderID INTEGER,
           PurchaseOrderDetailID INTEGER,
		   DueDate TIMESTAMP,
		   ProductID INTEGER,
		   OrderQty INTEGER,
		   UnitPrice DECIMAL(7,2),
		   LineTotal DECIMAL(9,2),
		   ReceivedQty INTEGER,
		   RejectedQty INTEGER,
		   StockedQty INTEGER
)
PRIMARY INDEX(PurchaseOrderID,PurchaseOrderDetailID)
PARTITION BY ProductID;

INSERT INTO dp_rdm.PurchaseOrderDetail
SELECT * FROM  dp_stg2.PurchaseOrderDetail;*/ --THESE TWO TABLES LEFT

DROP TABLE dp_rdm.PurchaseOrderDetail

CREATE  TABLE dp_rdm.PurchaseOrderDetail
( 
           PurchaseOrderID INTEGER,
           PurchaseOrderDetailID INTEGER,
		   DueDate TIMESTAMP,
		  -- ProductID INTEGER,
		   OrderQty INT,
		   UnitPrice DECIMAL(7,2),
		   LineTotal DECIMAL(9,2),
		   ReceivedQty DECIMAL(9,2),
		   RejectedQty DECIMAL(9,2),
		   StockedQty DECIMAL(9,2)
)

PARTITIONED BY( ProductID INT);
stored as parquet


--Inserting into the table and using partition on orderDate 

INSERT INTO dp_rdm.PurchaseOrderDetail PARTITION (ProductID) 
SELECT   
  purchaseorderid,
  purchaseorderdetailid,
  duedate,
  orderqty,
  unitprice,
  linetotal,
  receivedqty,
  rejectedqty,
  stockedqty,
  productid
FROM  dp_stg2.PurchaseOrderDetail;


--Checking if data is loaded successfully 
SELECT *
from dp_rdm.purchaseorderdetail;

---------------------------------------------------------------------------------------------------------------------
