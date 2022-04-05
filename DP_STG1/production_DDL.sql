#######################################


DROP table dp_stg1.production;

REFRESH dp_stg1.production;

SHOW create table dp_stg1.production;

SELECT * FROM dp_stg1.production LIMIT 100;




#######################################


CREATE TABLE DP_STG1.production
(
    TransactionID	        VARCHAR(500) ,
    ProductID1	            VARCHAR(500) ,
    ReferenceOrderID	    VARCHAR(500) ,
    ReferenceOrderLineID	VARCHAR(500) ,
    TransactionDate	        VARCHAR(500) ,
    TransactionType	        VARCHAR(500) ,
    Quantity1	            VARCHAR(500) ,
    ActualCost	            VARCHAR(500) ,
    ModifiedDate1	        VARCHAR(500) ,
    ProductID2          	VARCHAR(500) ,
    Name1	                VARCHAR(500) ,
    ProductNumber	        VARCHAR(500) ,
    MakeFlag	            VARCHAR(500) ,
    FinishedGoodsFlag	    VARCHAR(500) ,
    Color	                VARCHAR(500) ,
    SafetyStockLevel	    VARCHAR(500) ,
    ReorderPoint	        VARCHAR(500) ,
    StandardCost1	        VARCHAR(500) ,
    ListPrice1	            VARCHAR(500) ,
    Size	                VARCHAR(500) ,
    SizeUnitMeasureCode	    VARCHAR(500) ,
    WeightUnitMeasureCode	VARCHAR(500) ,
    Weight              	VARCHAR(500) ,
    DaysToManufacture   	VARCHAR(500) ,
    ProductLine	            VARCHAR(500) ,
    Class1	                VARCHAR(500) ,
    Style	                VARCHAR(500) ,
    ProductSubcategoryID1	VARCHAR(500) ,
    ProductModelID1     	VARCHAR(500) ,
    SellStartDate       	VARCHAR(500) ,
    SellEndDate         	VARCHAR(500) ,
    DiscontinuedDate    	VARCHAR(500) ,
    rowguid1	            VARCHAR(500) ,
    ModifiedDate2       	VARCHAR(500) ,
    ProductReviewID	        VARCHAR(500) ,
    ProductID3	            VARCHAR(500) ,
    ReviewerName	        VARCHAR(500) ,
    ReviewDate	            VARCHAR(500) ,
    EmailAddress	        VARCHAR(500) ,
    Rating	                VARCHAR(500) ,
    Comments            	VARCHAR(500) ,
    ModifiedDate3       	VARCHAR(500) ,
    ProductSubcategoryID2	VARCHAR(500) ,
    ProductCategoryID1	    VARCHAR(500) ,
    Name2	                VARCHAR(500) ,
    rowguid2            	VARCHAR(500) ,
    ModifiedDate4       	VARCHAR(500) ,
    ProductCategoryID2  	VARCHAR(500) ,
    Name3               	VARCHAR(500) ,
    rowguid3	            VARCHAR(500) ,
    ModifiedDate5       	VARCHAR(500) ,
    ProductID4	            VARCHAR(500) ,
    LocationID1	            VARCHAR(500) ,
    Shelf	                VARCHAR(500) ,
    Bin1	                VARCHAR(500) ,
    Quantity2           	VARCHAR(500) ,
    rowguid4	            VARCHAR(500) ,
    ModifiedDate6	        VARCHAR(500) ,
    LocationID2	            VARCHAR(500) ,
    Name4	                VARCHAR(500) ,
    CostRate	            VARCHAR(500) ,
    Availability        	VARCHAR(500) ,
    ModifiedDate7	        VARCHAR(500) ,
    ProductID5	            VARCHAR(500) ,
    StartDate1	            VARCHAR(500) ,
    EndDate1	            VARCHAR(500) ,
    StandardCost2       	VARCHAR(500) ,
    ModifiedDate8	        VARCHAR(500) ,
    ProductID6	            VARCHAR(500) ,
    StartDate2	            VARCHAR(500) ,
    EndDate2	            VARCHAR(500) ,
    ListPrice2          	VARCHAR(500) ,
    ModifiedDate9       	VARCHAR(500) ,
    ProductModelID2	        VARCHAR(500) ,
    Name5	                VARCHAR(500) ,
    CatalogDescription  	VARCHAR(500) ,
    Instructions        	VARCHAR(500) ,
    rowguid5            	VARCHAR(500) ,
    ModifiedDate10      	VARCHAR(500) ,
    ProductModelID3	        VARCHAR(500) ,
    ProductDescriptionID1	VARCHAR(500) ,
    CultureID1	            VARCHAR(500) ,
    ModifiedDate11	        VARCHAR(500) ,
    CultureID2	            VARCHAR(500) ,
    Name6	                VARCHAR(500) ,
    ModifiedDate12	        VARCHAR(500) ,
    ProductDescriptionID2	VARCHAR(500) ,
    Description	            VARCHAR(500) ,
    rowguid6	            VARCHAR(500) ,
    ModifiedDate13	        VARCHAR(500) ,
    ProductModelID4	        VARCHAR(500) ,
    IllustrationID1	        VARCHAR(500) ,
    ModifiedDate14      	VARCHAR(500) ,
    IllustrationID2     	VARCHAR(500) ,
    Diagram	                VARCHAR(500) ,
    ModifiedDate15      	VARCHAR(500) ,
    ProductID7          	VARCHAR(500) ,
    DocumentNode1       	VARCHAR(500) ,
    ModifiedDate16      	VARCHAR(500) ,
    DocumentNode2	        VARCHAR(500) ,
    DocumentLevel       	VARCHAR(500) ,
    Title1	                VARCHAR(500) ,
    Owner1              	VARCHAR(500) ,
    FolderFlag          	VARCHAR(500) ,
    FileName            	VARCHAR(500) ,
    FileExtension       	VARCHAR(500) ,
    Revision            	VARCHAR(500) ,
    ChangeNumber        	VARCHAR(500) ,
    Status              	VARCHAR(500) ,
    DocumentSummary     	VARCHAR(500) ,
    Document            	VARCHAR(500) ,
    rowguid7	            VARCHAR(500) ,
    ModifiedDate17      	VARCHAR(500) 

)

	ROW FORMAT DELIMITED FIELDS TERMINATED BY '^' 
    tblproperties ("skip.header.line.count"="1");
    
#################################################    

#USE THE FOLLOWING COMMAND TO LOAD DATA INTO TABLE

#"sudo -u hdfs hadoop fs -put /hdfs/AW_DS_DP_STG1/Production.CSV /user/hive/warehouse/dp_stg1.db/production"
