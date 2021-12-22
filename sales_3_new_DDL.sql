###################################################

DROP TABLE DP_STG1.sales_3_new;

REFRESH DP_STG1.sales_3_new;

show create table DP_STG1.sales_3_new;

SELECT * FROM dp_stg1.sales_3_new LIMIT 100;






##################################################

CREATE TABLE DP_STG1.sales_3_new
(
    BusinessEntityID		VARCHAR(1000) ,
    SalesOrderID1			VARCHAR(1000) ,
    SalesOrderDetailID1		VARCHAR(1000) ,
    CarrierTrackingNumber1	VARCHAR(1000) ,
    OrderQty1				VARCHAR(1000) ,
    ProductID1				VARCHAR(1000) ,
    SpecialOfferID1			VARCHAR(1000) ,
    UnitPrice1				VARCHAR(1000) ,
    UnitPriceDiscount1		VARCHAR(1000) ,
    LineTotal				VARCHAR(1000) ,
    rowguid					VARCHAR(1000) ,
    ModifiedDate			VARCHAR(1000) ,
    ProductID2				VARCHAR(1000) ,
    SpecialOfferID2			VARCHAR(1000) ,
    UnitPrice2				VARCHAR(1000) ,
    UnitPriceDiscount2		VARCHAR(1000) ,
    SalesOrderID2			VARCHAR(1000) ,
    SalesOrderDetailID2		VARCHAR(1000) ,
    CarrierTrackingNumber2	VARCHAR(1000) ,
    OrderQty2				VARCHAR(1000) 
)


    ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
    tblproperties ("skip.header.line.count"="1");
    
###################################################

#USE THE FOLLOWING COMMAND TO LOAD THE DATA INTO THE sales_3_new TABLE

#"sudo -u hdfs hadoop fs -put /hdfs/AW_DS_DP_STG1/Sales_3_new.csv /user/hive/warehouse/dp_stg1.db/sales_3_new"


