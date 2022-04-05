##################################

DROP TABLE dp_stg1.scrap_reason_production;

REFRESH dp_stg1.scrap_reason_production;

SHOW CREATE TABLE dp_stg1.scrap_reason_production;

SELECT * FROM dp_stg1.scrap_reason_production;


############################################

CREATE TABLE DP_STG1.scrap_reason_production
(
    ScrapReason	    VARCHAR(500) ,
    Name1	        VARCHAR(500) ,
    ModifiedDate	VARCHAR(500) 
)

	ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
    tblproperties ("skip.header.line.count"="1");
    
###################################################    

#USE THE FOLLOWING COMMAND TO LOAD THE DATA INTO TABLE
#"sudo -u hdfs hadoop fs -put /hdfs/AW_DS_DP_STG1/ScrapReason_Production.CSV /user/hive/warehouse/dp_stg1.db/scrap_reason_production"