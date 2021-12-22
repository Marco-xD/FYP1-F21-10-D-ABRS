CREATE DATABASE DP_STG1;

#################################


Drop table dp_stg1.hr;

############################



######################################
CREATE TABLE DP_STG1.HR 
(
	BusinessEntityID	VARCHAR(200),
	NationalIDNumber	VARCHAR(200),
	LoginID	            VARCHAR(200),
	JobTitle        	VARCHAR(200),
	BirthDate       	VARCHAR(200),
	Gender	            VARCHAR(200),
	HireDate        	VARCHAR(200),
	VacationHours   	VARCHAR(200),
	SickLeaveHours	    VARCHAR(200),
	Name1           	VARCHAR(200),
	GroupName       	VARCHAR(200),
	Name2	            VARCHAR(200),
	StartTime       	VARCHAR(200),
	EndTime	            VARCHAR(200),
	StartDate	        VARCHAR(200),
	EndDate         	VARCHAR(200),
	ModifiedDate    	VARCHAR(200)

	 )
	ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
    tblproperties ("skip.header.line.count"="1");
    
    ################################################################
    #######################
    REFRESH dp_stg1.hr;
    
    show create table dp_stg1.hr;
    
    SELECT * from dp_stg1.hr;
    ###########################
    
    
    ###################################################################
     