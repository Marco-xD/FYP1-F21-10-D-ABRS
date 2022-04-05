#####################################

DROP TABLE DP_STG1.customer_sales;

REFRESH DP_STG1.customer_sales;

show create table DP_STG1.customer_sales;

SELECT * FROM dp_stg1.customer_sales LIMIT 100;







####################################

CREATE TABLE DP_STG1.customer_sales
(
    CustomerID			VARCHAR(500) ,
    PersonID			VARCHAR(500) ,
    StoreID				VARCHAR(500) ,
    TerritoryID			VARCHAR(500) ,
    AccountNumber		VARCHAR(500) ,
    rowguid				VARCHAR(500) ,
    ModifiedDate		VARCHAR(500) 

)

    ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
    tblproperties ("skip.header.line.count"="1");
    
###################################################

#USE THE FOLLOWING COMMAND TO LOAD THE DATA IN customer_sales TABLE

#" sudo -u hdfs hadoop fs -put /hdfs/AW_DS_DP_STG1/Customer_Sales.CSV /user/hive/warehouse/dp_stg1.db/customer_sales"