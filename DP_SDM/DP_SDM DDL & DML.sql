
CREATE DATABASE Dp_SDM;



--DDL FOR DP_SDM LAYER

/*********************************Vendor_DIM***********************************/
--1
CREATE TABLE DP_SDM.Vendor_DIM
(
      Vendor_id INTEGER,
      Vendor_Name VARCHAR(50)
)

Stored AS PARQUET;

/*********************************Country_Region_DIM***********************************/
--2
CREATE  TABLE DP_SDM.Country_Region_DIM
(
      Country_Region_id VARCHAR(8),
      Country_Region_Name VARCHAR(50)
)
Stored AS PARQUET;

/*********************************Payment_DIM***********************************/
--3
CREATE  TABLE DP_SDM.Payment_Type_DIM
(
      Payment_Type_id INTEGER,
      Payment_Type_Name VARCHAR(50)
)
Stored AS PARQUET;

/*********************************Person_DIM***********************************/
--4
CREATE  TABLE DP_SDM.Person_DIM
(
      Person_id INTEGER,
      First_Name VARCHAR(50),
      Middle_Name VARCHAR(50),
      Last_Name VARCHAR(50)
)
Stored AS PARQUET;

/*********************************Product_Cat_DIM***********************************/
--5
CREATE  TABLE DP_SDM.Product_Cat_DIM
(
      Product_Cat_id INTEGER,
      Product_Cat_Name VARCHAR(50)
)
Stored AS PARQUET;

/*********************************Product_DIM***********************************/

--6

CREATE TABLE DP_SDM.Product_DIM
(
      Product_id INTEGER,
      Product_Sub_cat_id INTEGER,
      Product_Name VARCHAR(50)
)
Stored AS PARQUET;


/*********************************Product_Purchase_Fact_Monthly***********************************/
--7) CREATED THIS BY PARTITION ON ORDER_MONTH_ID AND CONVERTED TO VARCHAR(50)

/*
CREATE  TABLE DP_SDM.Product_Purchase_Fact_Monthly
(
      Vendor_id INTEGER,
      Product_id INTEGER,
      Order_Month_id DATE FORMAT 'MM/DD/YYYY',
      Ship_Month_id DATE FORMAT 'MM/DD/YYYY',
      Ship_Type_id INTEGER,
      Purchase_Amt DECIMAL(19,2),
      Purchase_Qty INTEGER,
      Recieved_Qty INTEGER,
      Rejected_Qty INTEGER
)
PRIMARY INDEX ( Order_Month_id ,Ship_Month_id )
PARTITION BY RANGE_N (Order_Month_ID BETWEEN DATE '2000-05-17' AND DATE '2020-10-23' EACH INTERVAL '1' MONTH);*/

--create table blah_copy partitioned by (column_x, column_y, column_z) as select * from blah;

CREATE TABLE DP_SDM.Product_Purchase_Fact_Monthly
(
      Vendor_id INTEGER,
      Product_id INTEGER,
      Ship_Month_id TIMESTAMP,
      Ship_Type_id INTEGER,
      Purchase_Amt DECIMAL(19,2),
      Purchase_Qty INTEGER,
      Recieved_Qty INTEGER,
      Rejected_Qty INTEGER
) 

PARTITIONED BY( Order_Month_id varchar(50));

/*********************************Product_Sales_Fact_Monthly***********************************/

--8) HAVE TO CREATE THIS

/*
CREATE MULTISET TABLE DP_SDM.Product_Sales_Fact_Monthly
(
      Customer_ID INTEGER,
      Order_Month_ID DATE FORMAT 'MM/DD/YYYY',
      Ship_Month_ID DATE FORMAT 'MM/DD/YYYY',
      Product_ID INTEGER,
      Sales_Person_ID INTEGER,
      Territory_ID INTEGER,
      Sale_Type_ID INTEGER,
      Payment_Type_ID INTEGER,
      Shipt_Type_ID INTEGER,
      Sales_Amt DECIMAL(19,2),
      Sales_Qty INTEGER,
      Unit_Price DECIMAL(19,2),
      Cost_Price DECIMAL(19,2),
      Discount_Amount DECIMAL(19,2),
      Profit DECIMAL(19,2)
)
PRIMARY INDEX ( Customer_id ,Order_Month_id )
PARTITION BY RANGE_N (Order_Month_ID BETWEEN DATE '2000-04-01' AND DATE '2020-06-27' EACH INTERVAL '1' MONTH);*/


CREATE  TABLE DP_SDM.Product_Sales_Fact_Monthly
(
      Customer_ID INTEGER,
     -- Order_Month_ID DATE FORMAT 'MM/DD/YYYY',
      Ship_Month_ID TIMESTAMP,
      Product_ID INTEGER,
      Sales_Person_ID INTEGER,
      Territory_ID INTEGER,
      Sale_Type_ID INTEGER,
      Payment_Type_ID INTEGER,
      Shipt_Type_ID INTEGER,
      Sales_Amt DECIMAL(19,2),
      Sales_Qty INTEGER,
      Unit_Price DECIMAL(19,2),
      Cost_Price DECIMAL(19,2),
      Discount_Amount DECIMAL(19,2),
      Profit DECIMAL(19,2)
)

PARTITIONED BY( Order_Month_ID varchar(50));


/*********************************Product_Sub_Cat_DIM***********************************/

--9

CREATE  TABLE DP_SDM.Product_Sub_Cat_DIM
(
      Product_Sub_Cat_id INTEGER,
      Product_Sub_Cat_Name VARCHAR(50),
      Product_Cat_id INTEGER
)
Stored AS PARQUET;

/*********************************Purchase_Fact_Monthly***********************************/
--10) DONE 
/*
CREATE  TABLE DP_SDM.Purchase_Fact_Monthly
(
      Vendor_id INTEGER,
      Order_Month_id DATE FORMAT 'MM/DD/YYYY',
      Ship_Type_id DATE FORMAT 'MM/DD/YYYY',
      Ship_Month_id INTEGER,
      Purchase_Amt DECIMAL(19,2),
      Purchase_Qty INTEGER,
      Freight DECIMAL(19,2),
      Tax_Amt DECIMAL(19,2),
      Recieved_Qty INTEGER,
      Rejected_Qty INTEGER
)
PRIMARY INDEX ( Order_Month_id ,Ship_Month_id )
PARTITION BY RANGE_N (Order_Month_ID BETWEEN DATE '2000-05-17' AND DATE '2020-10-23' EACH INTERVAL '1' MONTH);*/

DROP TABLE DP_SDM.Purchase_Fact_Monthly

CREATE  TABLE DP_SDM.Purchase_Fact_Monthly
(
      Vendor_id INTEGER,
     -- Order_Month_id DATE FORMAT 'MM/DD/YYYY',
      Ship_Month_id TIMESTAMP,
      Ship_Type_id INT,
      Purchase_Amt DECIMAL(19,2),
      Purchase_Qty INTEGER,
      Freight DECIMAL(19,2),
      Tax_Amt DECIMAL(19,2),
      Recieved_Qty INTEGER,
      Rejected_Qty INTEGER
)
PARTITIONED BY( Order_Month_ID varchar(50)) STORED AS PARQUET;

/*********************************Sales_Fact_Monthly***********************************/

--11) DONE

CREATE  TABLE DP_SDM.Sales_Fact_Monthly
(
      Customer_ID INTEGER,
      --Order_Month_ID VARCHAR(50),
      Ship_Month_ID TIMESTAMP,
      Sales_Person_ID INTEGER,
      Territory_ID INTEGER,
      Sale_Type_ID INTEGER,
      Payment_Type_ID INTEGER,
      Ship_Type_ID INTEGER,
      Sales_Amt DECIMAL(19,2),
      Freight_Amt DECIMAL(19,2),
      Tax_Amt DECIMAL(19,2)
)
PARTITIONED BY(Order_Month_ID VARCHAR(50)) STORED AS PARQUET;

/*********************************Sales_Type_DIM***********************************/

--12) 

CREATE  TABLE DP_SDM.Sales_Type_DIM
(
      Sales_Type_id INTEGER,
      Sales_Type_Name VARCHAR(50)
)
Stored AS PARQUET;

/*********************************Ship_Type_DIM***********************************/

--13

CREATE TABLE DP_SDM.Ship_Type_DIM
(
      Ship_Type_id INTEGER,
      Ship_Type_Name VARCHAR(50)
)
Stored AS PARQUET;

/*********************************Territory_DIM***********************************/

--14

CREATE  TABLE DP_SDM.Territory_DIM
(
      Territory_id INTEGER,
      Territory_Name VARCHAR(50),
      Country_Region_id VARCHAR(8)
)
Stored AS PARQUET;


--*****************************************************************************************************--





--****************************DML FOR DP_SDM LAYER ****************************************************--

--DONE

INSERT INTO DP_SDM.Sales_Fact_Monthly PARTITION(Order_Month_Id)
SELECT 
			SOH.BusinessEntityID AS Customer_ID, 
		--	(CAST(SOH.OrderDate AS DATE) - EXTRACT(DAY FROM SOH.OrderDate)+1) AS Order_Month_ID,			
		--	(CAST(SOH.ShipDate AS DATE) - EXTRACT(DAY FROM SOH.ShipDate)+1) AS Ship_Month_ID,
		  date_sub(to_date(SOH.ShipDate),EXTRACT(DAY FROM to_date(SOH.ShipDate))+1) AS Ship_Month_Id,
			CAST (CUS.personid AS INT) AS Sales_Person_ID, 
			CAST (SOH.TerritoryID AS INT) AS 	Territory_ID, 
			CAST((CASE	
						WHEN SOH.OnlineOrderFlag = 1 THEN 1 
						WHEN SOH.OnlineOrderFlag = 0 THEN 2 
						ELSE SOH.OnlineOrderFlag 
					END) AS INT) AS Sale_Type_ID,  --- 	1 is online and 2 is from the store
			CAST((CASE	SOH.CreditCardID 
						WHEN 0 THEN 1 
						ELSE 2 
					END) AS INT) AS Payment_Type_ID,	-- 1 is non creaditCard Payment and 2 is creditCard Payment
			SOH.ShipMethodID AS Ship_Type_ID,
			cast(SUM(SOH.SubTotal) AS DECIMAL(19,2)) AS Sales_Amt,
			cast(SUM(SOH.Freight) AS DECIMAL(19,2))	AS Freight_Amt,
			cast(SUM(SOH.TaxAmt) AS DECIMAL (19,2))	AS Tax_Amt,
			cast(date_sub(to_date(SOH.OrderDate),EXTRACT(DAY FROM to_date(SOH.OrderDate))+1)AS varchar(50)) as Order_Month_Id
	FROM	
			DP_RDM.SalesOrderHeader SOH
	LEFT JOIN DP_RDM.Customer CUS
		ON	CUS.CustomerID = SOH.BusinessEntityID
	GROUP BY 1,2,3,4,5,6,7,11;
	


SELECT *
FROM dp_sdm.sales_fact_monthly;

-------------------------------PURCHASE_FACT_MONTHLY-------------------------------------

-- DONE

INSERT INTO DP_SDM.PURCHASE_FACT_MONTHLY PARTITION(order_month_id)
SELECT
		     POH.vendorid AS Vendor_id , 
			-- (CAST(POH.orderdate AS DATE) - EXTRACT(DAY FROM POH.orderdate)+1) AS Order_Month_id,
             --(CAST(POH.shipdate AS DATE) - EXTRACT(DAY FROM POH.shipdate)+1) AS Ship_Month_id,
             date_sub(to_date(POH.ShipDate),EXTRACT(DAY FROM to_date(POH.ShipDate))+1) AS Ship_Month_Id,
	          POH.Shipmethodid AS Ship_Type_id,
	         cast(SUM	(POH.subtotal) AS DECIMAL(19,2)) AS Purchase_Amt,
			 cast(SUM   (POD.OrderQty) AS INT)AS  Purchase_Qty, 
			cast( SUM    (POH.Freight)AS DECIMAL (19,2)) AS Freight,
			 cast(SUM    (POH.Taxamt)AS DECIMAL (19,2)) AS Taxamt,
			 cast(SUM (POD.ReceivedQty)AS INT) AS Recieved_Qty,
			 cast(SUM ( POD.RejectedQty)AS INT) AS Rejected_Qty,
			 cast(date_sub(to_date(POH.OrderDate),EXTRACT(DAY FROM to_date(POH.OrderDate))+1)AS varchar(50)) as Order_Month_Id
	FROM 
	       DP_RDM.PurchaseOrderHeader POH
	LEFT JOIN  DP_RDM.PurchaseOrderDetail POD 
	ON POH.purchaseorderid=POD.purchaseorderid
	GROUP BY Vendor_id,Ship_Type_id,Ship_Month_Id,Order_Month_Id;
	
	
SELECT * 
FROM dp_sdm.purchase_fact_monthly
	
	

------------------------------PRODUCT_PURCHASE_FACT_MONTHLY--------------------------------------

--DONE

INSERT INTO DP_SDM.PRODUCT_PURCHASE_FACT_MONTHLY PARTITION (Order_Month_Id)

SELECT 
POH.VendorID,
POD.ProductID,
date_sub(to_date(POH.ShipDate),EXTRACT(DAY FROM to_date(POH.ShipDate))+1) AS ShipMonthId,
SM.ShipMethodID,
cast(SUM(POD.linetotal) as DECIMAL(19,2)) AS Purchase_Amt,
CAST(SUM(POD.OrderQty) AS INTEGER) AS Purchase_Qty,
CAST(SUM(POD.ReceivedQty) AS INTEGER) AS Recieved_Qty,
CAST(SUM(POD.RejectedQty) AS INTEGER) AS Rejected_Qty,
cast(date_sub(to_date(POH.OrderDate),EXTRACT(DAY FROM to_date(POH.OrderDate))+1)AS varchar(50)) as OrderMonthId

FROM DP_RDM.PurchaseOrderDetail AS POD
	JOIN DP_RDM.PurchaseOrderHeader AS POH 
	 ON POD.PurchaseOrderID = POH.PurchaseOrderID
	JOIN DP_RDM.ShipMethod AS SM 
	 ON POH.ShipMethodID = SM.ShipMethodID
GROUP BY POH.VendorID, POD.ProductID, POH.OrderDate, SM.ShipMethodID, POH.ShipDate, POH.Status;

SELECT *
FROM dp_sdm.product_purchase_fact_monthly;



-------------------------------Product_Sales_Fact_Monthly-------------------------------------

--HAVE TO LOAD THIS BECAUSE OF MEMORY ISSUE

INSERT INTO DP_SDM.Product_Sales_Fact_Monthly
SELECT 
		SOH.BusinessEntityID AS Customer_ID, 
	--	(CAST(OrderDate AS DATE) - EXTRACT(DAY FROM OrderDate)+1) AS Order_Month_ID,
	--	(CAST(ShipDate AS DATE) - EXTRACT(DAY FROM ShipDate)+1) AS Ship_Month_ID,
		SOD.ProductID AS Product_ID, 
		CUS.PersonID AS Sales_Person_ID, 
		SOH.TerritoryID AS Territory_ID,				
		(CASE	
			WHEN OnlineOrderFlag = 1 THEN 1 
			WHEN OnlineOrderFlag = 0 THEN 2 
			ELSE OnlineOrderFlag 
		END) AS Sale_Type_ID, 
		(CASE	
			WHEN SOH.CreditcardID = 0 THEN 1 
			ELSE 2 
		END) AS Payment_Type_ID, 
		SOH.ShipMethodID AS Ship_Type_ID, 
    	SUM(SOD.LineTotal) AS Sales_Amt,
		SUM(SOD.OrderQty) AS sales_qty, 
		SOD.UnitPrice AS Unit_Price,
		PD.StandardCost AS Standard_Cost, 
		SOD.UnitPriceDiscount AS Discount_Amount,
		(COALESCE(	SOD.UnitPrice,0) - (COALESCE(PD.StandardCost,0) + COALESCE(SOD.UnitPriceDiscount ,0))) * COALESCE(SUM(SOD.OrderQty),1) AS PROFIT
FROM 
		DP_RDM.SalesOrderHeader SOH
		JOIN DP_RDM.Customer CUS
			ON SOH.BusinessEntityID = CUS.CustomerID
		JOIN DP_RDM.SalesOrderDetail SOD
			ON SOH.SalesOrderID = SOD.SalesOrderID
		JOIN DP_RDM.Product PD 
			ON SOD.ProductID = PD.ProductID
GROUP BY 1,2, 3, 4,5,6,7,10,11,12;

-------------------------------VENDOR_DIM-------------------------------------

--Successfully Loaded data in vendor_DIM

INSERT INTO DP_SDM.VENDOR_DIM
SELECT 
V.BusinessEntityID AS Vendor_id,
V.NAME1 AS vendor_name
FROM DP_RDM.Vendor V
GROUP BY 1,2;

--------------------------------PERSON_DIM------------------------------------

--Successfully Loaded data in PERSON_DIM

INSERT INTO DP_SDM.PERSON_DIM
SELECT 
businessentityid AS Person_id, 
FirstName AS First_Name, 
MiddleName AS Middle_Name, 
LastName AS Last_Name
FROM DP_RDM.Person
GROUP BY 1,2,3,4;

-----------------------------------PRODUCT_CAT_DIM---------------------------------

--Successfully Loaded data in PRODUCT_CAT_DIM

INSERT INTO DP_SDM.PRODUCT_CAT_DIM
SELECT 
productcategoryID, 
Name1
FROM DP_RDM.ProductCategory
GROUP BY 1,2;

--------------------------------PRODUCT_DIM------------------------------------

--Successfully Loaded data in PRODUCT_DIM

INSERT INTO DP_SDM.PRODUCT_DIM
SELECT 
productID AS Product_id, 
productsubcategoryID AS Product_Sub_cat_id,
Name1 AS Product_Name
FROM DP_RDM.product
GROUP BY 1,2,3;

----------------------------------PRODUCT_SUB_CAT_DIM---------------------------------

--Successfully Loaded data in PRODUCT_SUB_CAT_DIM

INSERT INTO DP_SDM.PRODUCT_SUB_CAT_DIM
SELECT 
productsubcategoryID AS Product_Sub_Cat_id, 
NAME1 AS Product_Sub_Cat_Name, 
productcategoryID AS Product_Cat_id
FROM DP_RDM.productsubcategory
GROUP BY 1,2,3;

---------------------------SHIP_TYPE_DIM-----------------------------------------

--Successfully Loaded data in SHIP_TYPE_DIM

INSERT INTO DP_SDM.SHIP_TYPE_DIM
SELECT
		SM.ShipMethodID	AS Ship_Type_id,
		SM.NAME1 AS Ship_Type_Name
	FROM DP_RDM.ShipMethod SM
GROUP BY 1,2;

-------------------------------TERRITORY_DIM-------------------------------------

--Successfully Loaded data in TERRITORY_DIM

INSERT INTO DP_SDM.TERRITORY_DIM
SELECT 
    A.Territoryid AS Territory_id, A.Name1 AS Territory_Name, B.countryregioncode AS Country_Region_id
    FROM DP_RDM.salesterritory AS A
    LEFT JOIN DP_RDM.countryregion AS B
    ON A.countryregioncode=B.countryregioncode
    GROUP BY 1,2,3;
------------------------------Country_Region_DIM--------------------------------------

--Successfully Loaded data in Country_Region_DIM

INSERT INTO DP_SDM.Country_Region_DIM
SELECT 
Countryregioncode AS Country_Region_id, Name1 AS Country_Region_Name
FROM DP_RDM.CountryRegion
GROUP BY 1,2;

------------------------------Sales_Type_DIM--------------------------------------

--Successfully Loaded data in Sales_Type_DIM

INSERT INTO DP_SDM.Sales_Type_DIM
SELECT
CASE 
	WHEN OnlineOrderFlag =1 THEN 1
	WHEN OnlineOrderFlag=0 THEN 2
	ELSE OnlineOrderFlag 
END	AS Sales_Type_id,

--As onlineOrderFlag is of type tinyInt and in target table while loading we need to convert it to varchar type 

CASE 
	WHEN OnlineOrderFlag =1 THEN   cast(cast('Online' AS VARCHAR(50) )AS VARCHAR(50))
	WHEN OnlineOrderFlag=0 THEN  cast(cast('Store' AS VARCHAR(50) )AS VARCHAR(50))
	ELSE cast(onlineorderflag AS VARCHAR(50)) 
END	AS Sales_Type_Name
FROM
DP_RDM.Salesorderheader
GROUP BY 1,2;

 


SELECT *
FROM dp_rdm.salesorderheader;

-----------------------------Payment_Type_DIM---------------------------------------

--Successfully Loaded data in Payment_Type_DIM

INSERT INTO DP_SDM.Payment_Type_DIM
SELECT
CASE 
	WHEN Creditcardid = 0 THEN 1
	ELSE 2 
END	AS Payment_Type_id,
CASE 
	WHEN Creditcardid = 0 THEN cast('Cash' AS VARCHAR(50))
	ELSE cast('Credit Card' AS VARCHAR (50)) 
END	AS Payment_Type_Name
FROM
DP_RDM.Salesorderheader
GROUP BY 1,2;

----------------------------------------------------------------------------------------------