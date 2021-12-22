#############################################

DROP TABLE DP_STG1.purchase;

REFRESH DP_STG1.purchase;

show create table DP_STG1.purchase;

SELECT * FROM dp_stg1.purchase;






###########################################


CREATE TABLE DP_STG1.purchase
(
    PurchaseOrderID1	 		VARCHAR(500)  ,
    PurchaseOrderDetailID		VARCHAR(500)  ,
    DueDate	 					VARCHAR(500)  ,
    OrderQty	 				VARCHAR(500)  ,
    ProductID1	 				VARCHAR(500)  ,
    UnitPrice				    VARCHAR(500)  ,
    LineTotal	 				VARCHAR(500)  ,
    ReceivedQty	 				VARCHAR(500)  ,
    RejectedQty	 				VARCHAR(500)  ,
    StockedQty	 				VARCHAR(500)  ,
    ModifiedDate1			    VARCHAR(500)  ,
    PurchaseOrderID2		    VARCHAR(500)  ,
    RevisionNumber	 			VARCHAR(500)  ,
    Status	 					VARCHAR(500)  ,
    EmployeeID				    VARCHAR(500)  ,
    VendorID				    VARCHAR(500)  ,
    ShipMethodID1			    VARCHAR(500)  ,
    OrderDate	 				VARCHAR(500)  ,
    ShipDate				    VARCHAR(500)  ,
    SubTotal				    VARCHAR(500)  ,
    TaxAmt	 					VARCHAR(500)  ,
    Freight				   	    VARCHAR(500)  ,
    TotalDue	 				VARCHAR(500)  ,
    ModifiedDate2	 			VARCHAR(500)  ,
    BusinessEntityID1	 		VARCHAR(500)  ,
    AccountNumber	 			VARCHAR(500)  ,
    Name1	 					VARCHAR(500)  ,
    CreditRating	 			VARCHAR(500)  ,
    PreferredVendorStatus	 	VARCHAR(500)  ,
    ActiveFlag	 				VARCHAR(500)  ,
    PurchasingWebServiceURL	 	VARCHAR(500)  ,
    ModifiedDate3	 			VARCHAR(500)  ,
    ShipMethodID2	 			VARCHAR(500)  ,
    Name2	 					VARCHAR(500)  ,
    ShipBase	 				VARCHAR(500)  ,
    ShipRate	 				VARCHAR(500)  ,
    rowguid1	 				VARCHAR(500)  ,
    ModifiedDate4	 			VARCHAR(500)  ,
    ProductID2	 				VARCHAR(500)  ,
    BusinessEntityID2	 		VARCHAR(500)  ,
    AverageLeadTime	 			VARCHAR(500)  ,
    StandardPrice	 			VARCHAR(500)  ,
    LastReceiptCost	 			VARCHAR(500)  ,
    LastReceiptDate	 			VARCHAR(500)  ,
    MinOrderQty	 				VARCHAR(500)  ,
    MaxOrderQty	 				VARCHAR(500)  ,
    OnOrderQty	 				VARCHAR(500)  ,
    UnitMeasureCode	 			VARCHAR(500)  ,
    ModifiedDate5	 			VARCHAR(500)  ,
    ProductID3	 				VARCHAR(500)  ,
    Name3	 					VARCHAR(500)  ,
    ProductNumber	 			VARCHAR(500)  ,
    MakeFlag	 				VARCHAR(500)  ,
    FinishedGoodsFlag	 		VARCHAR(500)  ,
    Color	 					VARCHAR(500)  ,
    SafetyStockLevel	 		VARCHAR(500)  ,
    ReorderPoint	 			VARCHAR(500)  ,
    StandardCost	 			VARCHAR(500)  ,
    ListPrice	 				VARCHAR(500)  ,
    Size	 					VARCHAR(500)  ,
    SizeUnitMeasureCode	 		VARCHAR(500)  ,
    WeightUnitMeasureCode	 	VARCHAR(500)  ,
    Weight	 					VARCHAR(500)  ,
    DaysToManufacture	 		VARCHAR(500)  ,
    ProductLine	 				VARCHAR(500)  ,
    Class1					 	VARCHAR(500)  ,
    Style	 					VARCHAR(500)  ,
    ProductSubcategoryID	 	VARCHAR(500)  ,
    ProductModelID	 			VARCHAR(500)  ,
    SellStartDate	 			VARCHAR(500)  ,
    SellEndDate	 				VARCHAR(500)  ,
    DiscontinuedDate	 		VARCHAR(500)  ,
    rowguid2	 				VARCHAR(500)  ,
    ModifiedDate6	 			VARCHAR(500) 

)

    ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
    tblproperties ("skip.header.line.count"="1");

##################################################

#USE THE FOLLOWING COMMAND TO LOAD THE DATA INTO PURCHASE TABLE

#"sudo -u hdfs hadoop fs -put /hdfs/AW_DS_DP_STG1/Purchase.CSV /user/hive/warehouse/dp_stg1.db/purchase"