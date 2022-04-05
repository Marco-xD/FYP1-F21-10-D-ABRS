################################

DROP TABLE DP_STG1.work_order_production;

REFRESH DP_STG1.work_order_production;

show create table DP_STG1.work_order_production;

SELECT * FROM dp_stg1.work_order_production;





#########################################


CREATE TABLE DP_STG1.work_order_production
(
    WorkOrderID	    VARCHAR(500) ,
    ProductID	    VARCHAR(500) ,
    OrderQty	    VARCHAR(500) ,
    StockedQty  	VARCHAR(500) ,
    ScrappedQty	    VARCHAR(500) ,
    StartDate	    VARCHAR(500) ,
    EndDate	        VARCHAR(500) ,
    DueDate	        VARCHAR(500) ,
    ScrapReasonID	VARCHAR(500) ,
    ModifiedDate	VARCHAR(500) 

)
	ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
    tblproperties ("skip.header.line.count"="1");

##################################################

#USE THE FOLLOWING COMMAND TO LOAD THE DATA INTO THIS TABLE

#"sudo -u hdfs hadoop fs -put /hdfs/AW_DS_DP_STG1/WorkOrder_Production.CSV /user/hive/warehouse/dp_stg1.db/work_order_production"