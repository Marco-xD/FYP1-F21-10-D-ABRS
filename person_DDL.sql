#########################################

DROP table dp_stg1.person;

REFRESH dp_stg1.person;

SHOW create table dp_stg1.person;

SELECT * FROM dp_stg1.person;




#########################################



CREATE TABLE DP_STG1.person
(

    BusinessEntityID1       VARCHAR(1000)  ,	
	PersonType	            VARCHAR(1000)  ,
	NameStyle	            VARCHAR(1000)  ,
    Title1                  VARCHAR(1000)  ,
    FirstName	            VARCHAR(1000)  ,
    MiddleName	            VARCHAR(1000)  ,
    LastName	            VARCHAR(1000)  ,
    Suffix	                VARCHAR(1000)  ,
    EmailPromotion	        VARCHAR(1000)  ,
    AdditionalContactInfo   VARCHAR(400)   ,
    Demographics	        VARCHAR(1000)  ,
    rowguid1	            VARCHAR(1000)  ,
    ModifiedDate1	        VARCHAR(1000)  ,
    BusinessEntityID2	    VARCHAR(1000)  ,
    EmailAddressID	        VARCHAR(1000)  ,
    EmailAddress	        VARCHAR(1000)  ,
    rowguid2	            VARCHAR(1000)  ,
    ModifiedDate2	        VARCHAR(1000)  ,
    BusinessEntityID3	    VARCHAR(1000)  ,
    PhoneNumber	            VARCHAR(1000)  ,
    PhoneNumberTypeID1	    VARCHAR(1000)  ,
    ModifiedDate3	        VARCHAR(1000)  ,
    PhoneNumberTypeID2	    VARCHAR(1000)  ,
    Name1	                VARCHAR(1000)  ,
    ModifiedDate4	        VARCHAR(1000)  ,
    BusinessEntityID4	    VARCHAR(1000)  ,
    PasswordHash	        VARCHAR(1000)  ,
    PasswordSalt	        VARCHAR(1000)  ,
    rowguid3	            VARCHAR(1000)  ,
    ModifiedDate5	        VARCHAR(1000)  ,
    BusinessEntityID5	    VARCHAR(1000)  ,
    AddressID1	            VARCHAR(1000)  ,
    AddressTypeID1	        VARCHAR(1000)  ,
    rowguid4	            VARCHAR(1000)  ,
    ModifiedDate6	        VARCHAR(1000)  ,
    AddressID2	            VARCHAR(1000)  ,
    AddressLine1	        VARCHAR(1000)  ,
    AddressLine2	        VARCHAR(1000)  ,
    City	                VARCHAR(1000)  ,
    StateProvinceID1	    VARCHAR(1000)  ,
    PostalCode	            VARCHAR(1000)  ,
    SpatialLocation	        VARCHAR(1000)  ,
    rowguid5	            VARCHAR(1000)  ,
    ModifiedDate7	        VARCHAR(1000)  ,
    StateProvinceID2	    VARCHAR(1000)  ,
    StateProvinceCode	    VARCHAR(1000)  ,
    CountryRegionCode1	    VARCHAR(1000)  ,
    IsOnlyStateProvinceFlag	VARCHAR(1000)  ,
    Name2	                VARCHAR(1000)  ,
    TerritoryID	            VARCHAR(1000)  ,
    rowguid6	            VARCHAR(1000)  ,
    ModifiedDate8	        VARCHAR(1000)  ,
    CountryRegionCode2	    VARCHAR(1000)  ,
    Name3	                VARCHAR(1000)  ,
    ModifiedDate9	        VARCHAR(1000)  ,
    AddressTypeID2	        VARCHAR(1000)  ,
    Name4	                VARCHAR(1000)  ,
    rowguid7	            VARCHAR(1000)  ,
    ModifiedDate10	        VARCHAR(1000)  
    
)

	ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
    tblproperties ("skip.header.line.count"="1");
    
######################################################

#LOADING THE DATA USE THIS COMMAND IN CLI  
#"sudo -u hdfs hadoop fs -put /hdfs/AW_DS_DP_STG1/Person.csv /user/hive/warehouse/dp_stg1.db/person"