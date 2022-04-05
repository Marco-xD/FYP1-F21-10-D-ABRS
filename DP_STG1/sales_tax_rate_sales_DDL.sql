################################################

DROP TABLE DP_STG1.sales_tax_rate_sales;

REFRESH DP_STG1.sales_tax_rate_sales;

show create table dp_stg1.sales_tax_rate_sales;

SELECT * FROM dp_stg1.sales_tax_rate_sales LIMIT 100;





################################################


CREATE TABLE DP_STG1.sales_tax_rate_sales
(
    SalesTaxRateID		VARCHAR(500) ,
    StateProvinceID		VARCHAR(500) ,
    TaxType				VARCHAR(500) ,
    TaxRate				VARCHAR(500) ,
    Name				VARCHAR(500) ,
    rowguid				VARCHAR(500) ,
    ModifiedDate		VARCHAR(500) 

)

    ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
    tblproperties ("skip.header.line.count"="1");
    
###################################################


#USE THE FOLLOWING COMMAND TO LOAD THE DATA IN sales_tax_rate_sales TABLE

#"sudo -u hdfs hadoop fs -put /hdfs/AW_DS_DP_STG1/SalesTaxRate_Sales.CSV /user/hive/warehouse/dp_stg1.db/sales_tax_rate_sales"