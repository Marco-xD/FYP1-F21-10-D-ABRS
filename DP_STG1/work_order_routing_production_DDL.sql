##############################################

DROP TABLE DP_STG1.work_order_routing_production;

REFRESH DP_STG1.work_order_routing_production;

show create table DP_STG1.work_order_routing_production;

SELECT * FROM dp_stg1.work_order_routing_production LIMIT 100;






##############################################


CREATE TABLE DP_STG1.work_order_routing_production
(
    WorkOrderID				VARCHAR(500) ,
    ProductID				VARCHAR(500) ,
    OperationSequence		VARCHAR(500) ,
    LocationID				VARCHAR(500) ,
    ScheduledStartDate		VARCHAR(500) ,
    ScheduledEndDate		VARCHAR(500) ,
    ActualStartDate			VARCHAR(500) ,
    ActualEndDate			VARCHAR(500) ,
    ActualResourceHrs		VARCHAR(500) ,
    PlannedCost				VARCHAR(500) ,
    ActualCost				VARCHAR(500) ,
    ModifiedDate			VARCHAR(500) 

)

	ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
    tblproperties ("skip.header.line.count"="1");

##################################################

#USE THE FOLLOWING COMMAND TO LOAD THE DATA INTO THIS TABLE

#"sudo -u hdfs hadoop fs -put /hdfs/AW_DS_DP_STG1/WorkOrderRouting_Production.CSV /user/hive/warehouse/dp_stg1.db/work_order_routing_production"

