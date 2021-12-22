######################################
DROP TABLE DP_STG1.unit_measure_production;

REFRESH DP_STG1.unit_measure_production;

show create table DP_STG1.unit_measure_production;

SELECT * FROM dp_stg1.unit_measure_production;




#########################################


CREATE TABLE DP_STG1.unit_measure_production
(
    UnitMeasureCode 	VARCHAR(500) ,
    Name1           	VARCHAR(500) ,
    ModifiedDate   		VARCHAR(500)
)

	ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
    tblproperties ("skip.header.line.count"="1");

#################################################

#USE THE FOLLOWING COMMAND TO LOAD DATA INTO THE TABLE

#"sudo -u hdfs hadoop fs -put /hdfs/AW_DS_DP_STG1/UnitMeasure_Production.CSV /user/hive/warehouse/dp_stg1.db/unit_measure_production"