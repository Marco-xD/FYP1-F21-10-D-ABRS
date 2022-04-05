######################################

DROP TABLE DP_STG1.shopping_cart_item_sales;

REFRESH DP_STG1.shopping_cart_item_sales;

show create table DP_STG1.shopping_cart_item_sales;

SELECT * FROM dp_stg1.shopping_cart_item_sales LIMIT 100;







#######################################

CREATE TABLE DP_STG1.shopping_cart_item_sales
(
    ShoppingCartItemID	VARCHAR(500) ,
    ShoppingCartID		VARCHAR(500) ,
    Quantity			VARCHAR(500) ,
    ProductID			VARCHAR(500) ,
    DateCreated			VARCHAR(500) ,
    ModifiedDate		VARCHAR(500) 

)

    ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
    tblproperties ("skip.header.line.count"="1");
    
###################################################


#USE THE FOLLWOING COMMAND TO LOAD THE DATA IN shopping_cart_item_sales TABLE

#"sudo -u hdfs hadoop fs -put /hdfs/AW_DS_DP_STG1/ShoppingCartItem_Sales.CSV /user/hive/warehouse/dp_stg1.db/shopping_cart_item_sales"