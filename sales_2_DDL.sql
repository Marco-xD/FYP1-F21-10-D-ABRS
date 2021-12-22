###############################################

DROP TABLE DP_STG1.sales_2;

REFRESH DP_STG1.sales_2;

show create table DP_STG1.sales_2;

SELECT * FROM dp_stg1.sales_2 LIMIT 100;







###############################################

CREATE TABLE DP_STG1.sales_2
(
    SalesOrderID1	        VARCHAR(1000) ,
    RevisionNumber1 	    VARCHAR(1000) ,
    OrderDate	            VARCHAR(1000) ,
    DueDate	                VARCHAR(1000) ,
    ShipDate	            VARCHAR(1000) ,
    Status	                VARCHAR(1000) ,
    OnlineOrderFlag	        VARCHAR(1000) ,
    SalesOrderNumber1	    VARCHAR(1000) ,
    PurchaseOrderNumber1	VARCHAR(1000) ,
    AccountNumber	        VARCHAR(1000) ,
    CustomerID	            VARCHAR(1000) ,
    SalesPersonID1	        VARCHAR(1000) ,
    TerritoryID	            VARCHAR(1000) ,
    BillToAddressID	        VARCHAR(1000) ,
    ShipToAddressID	        VARCHAR(1000) ,
    ShipMethodID	        VARCHAR(1000) ,
    CreditCardID	        VARCHAR(1000) ,
    CreditCardApprovalCode	VARCHAR(1000) ,
    CurrencyRateID	        VARCHAR(1000) ,
    SubTotal	            VARCHAR(1000) ,
    TaxAmt	                VARCHAR(1000) ,
    Freight	                VARCHAR(1000) ,
    TotalDue	            VARCHAR(1000) ,
    Comment1	            VARCHAR(1000) ,
    rowguid1	            VARCHAR(1000) ,
    ModifiedDate	        VARCHAR(1000) ,
    SalesOrderNumber2	    VARCHAR(1000) ,
    PurchaseOrderNumber2	VARCHAR(1000) ,
    BusinessEntityID	    VARCHAR(1000) ,
    Name1	                VARCHAR(1000) ,
    SalesPersonID2	        VARCHAR(1000) ,
    Demographics	        VARCHAR(1000) ,
    rowguid2	            VARCHAR(1000) ,
    SalesOrderID2	        VARCHAR(1000) ,
    RevisionNumber2	        VARCHAR(1000) ,
    SalesOrderNumber3	    VARCHAR(1000) ,
    PurchaseOrderNumber3	VARCHAR(1000) 
)

    ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
    tblproperties ("skip.header.line.count"="1");
    
###################################################

#USING THIS COMMAND TO LOAD THE DATA IN TO THE SALES_2 TABLE

#"sudo -u hdfs hadoop fs -put /hdfs/AW_DS_DP_STG1/Sales_2.csv /user/hive/warehouse/dp_stg1.db/sales_2"