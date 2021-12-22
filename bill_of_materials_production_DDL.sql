###########################################


DROP table dp_stg1.bill_of_materials_production;

REFRESH dp_stg1.bill_of_materials_production;

SHOW create table dp_stg1.bill_of_materials_production;

SELECT * FROM dp_stg1.bill_of_materials_production;





#############################################



CREATE TABLE DP_STG1.bill_of_materials_production
(
    BillOfMaterialsID	VARCHAR(1000) ,
    ProductAssemblyID	VARCHAR(1000) ,
    ComponentID	        VARCHAR(1000) ,
    StartDate	        VARCHAR(1000) ,
    EndDate	            VARCHAR(1000) ,
    UnitMeasureCode	    VARCHAR(1000) ,
    BOMLevel	        VARCHAR(1000) ,
    PerAssemblyQty	    VARCHAR(1000) ,
    ModifiedDate	    VARCHAR(1000) 

)

	ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
    tblproperties ("skip.header.line.count"="1");
    
####################################################    


#USE THE FOLLOWING COMMAND ON CLI TO LOAD DATA IN TO THE TABLE CREATED

#"sudo -u hdfs hadoop fs -put /hdfs/AW_DS_DP_STG1/BillOfMaterials_Production.CSV /user/hive/warehouse/dp_stg1.db/bill_of_materials_production"