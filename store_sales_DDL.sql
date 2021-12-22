#########################################

DROP TABLE DP_STG1.store_sales;

REFRESH DP_STG1.store_sales;

show create table DP_STG1.store_sales;

SELECT * FROM dp_stg1.store_sales LIMIT 100;







########################################

CREATE TABLE DP_STG1.store_sales
(
    BusinessEntityID		VARCHAR(500) ,
    Name1					VARCHAR(500) ,
    SalesPersonID			VARCHAR(500) ,
    Demographics			VARCHAR(500) ,
    rowguid					VARCHAR(500) ,
    ModifiedDate			VARCHAR(500) 

)


    ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
    tblproperties ("skip.header.line.count"="1");
    
###################################################

#USE THE FOLLOWING COMMAND TO LOAD THE DATA IN TO store_sales TABLE

#"sudo -u hdfs hadoop fs -put /hdfs/AW_DS_DP_STG1/Store_Sales.CSV /user/hive/warehouse/dp_stg1.db/store_sales"