--THIS IS THE TRANFORMATION PHASE 
--creating new data base for stage2
--In this all tables created according to schema given
-- Different transformation and data types defined.
CREATE DATABASE DP_STG2;

------------------------------------------------------
--HUMAN RESOURCE TABLES ACCORDING TO SCHEMA

------------------------------------------------------
--DEPARTMENT TABLE

---------------------

DROP TABLE dp_Stg2.Department;

--Creating department table with correct data types as in source tables all data types are VARCHAR

CREATE TABLE dp_stg2.department
(
    DepartmentID BIGINT,
    DepartmentName STRING,
	GroupName STRING
);

--insert into vc select cast('a' as varchar(10))

--row_number() over (orderby tbl_stg.id) + t2.sk_max, tbl_stg.*

--Below code is used for doing partition 

/*SELECT  row_number() over (PARTITION BY name1,groupname,businessentityid ORDER BY businessentityid),name1,groupname,businessentityid
FROM 
(
SELECT DISTINCT name1,groupname,businessentityid
from Dp_Stg1.HR
) a;
*/

--Inserting data into the department table from source data (Staging area)
--Basiclly cleaning the data and extracting the required distinct departments from source data
--As department ID not given in source so creating surrogate keys

INSERT INTO DP_STG2.department(DepartmentID,DepartmentName,GroupName)

SELECT row_number() over(ORDER BY name1,groupname),a.*
from
(
SELECT DISTINCT name1,groupname
FROM dp_stg1.hr
where name1 <>''
)a;


SELECT *
FROM DP_STG2.Department;

/*
SELECT  name1,groupname,count(*)
FROM dp_stg1.hr
group by 1,2;
*/



--Impala dose not support delete table command so if you want to delete the records
--You will be dropping the table and then creating again
--DELETE FROM dp_stg2.department

--------------------------------------------------------------------------------------------------------------
--EMPLOYEE TABLE

-------------------

DROP TABLE dp_stg2.employee;

--Creating Employee Table

CREATE TABLE dp_stg2.employee
(
           BusinessEntityID INT,
		   NationalIDNumber INT,
		   LoginID VARCHAR(32),
		   --ShiftID no relation defined in LDM
		   JobTitle VARCHAR(32),
		   BirthDate TIMESTAMP,
		   --MaritalStatus not available
		   Gender CHAR(1),
		   HireDate TIMESTAMP,
		   --SalariedFlag not available
		   VacationHours INT,
		   SickLeaveHours INT
		   --CurrentFlag Not available	
);

--SELECTING DISTINCT VALUES FROM THE SOURCE TABLE 
--CLOUMNS ARE 1)businessEntityID 2)NationalIDNumber 3)LoginID 4)JobTitle 5) BirthDate 6) Gender 7)HireDate 8)VacationHour 9)SickLeaveHours
--using '-1' and '0' instead of -1 and 0
--In this query below we are eliminating NULL columns and extracting distinct rows


--Trim will Remove all spaces from text except for single spaces between words.
--Coalesce Returns the first v that is not NULL, or NULL if all v's are NULL. Return: T
--Casting is being used because source data is in Varchar

INSERT INTO dp_stg2.employee(BusinessEntityID, NationalIDNumber,LoginID,
JobTitle,BirthDate, Gender,HireDate,VacationHours,SickLeaveHours)
SELECT 
DISTINCT  
    cast(cast(coalesce(trim(businessentityid),'-1') as varchar(20)) as INT),
    cast(cast(coalesce(trim(NationalIDNumber),'-1') as varchar(20)) as INT),
    cast(cast(coalesce(trim(LoginID),'-1') as varchar(32)) as VARCHAR(32)),
    cast(cast(coalesce(trim(JobTitle),'-1') as varchar(32)) as VARCHAR(32)),
    CAST(BIRTHDATE AS TIMESTAMP),
    cast(cast(coalesce(trim(Gender),'-1') as varchar(20)) as CHAR(1)),
    CAST (HireDate as TIMESTAMP),
    cast(cast(coalesce(trim(VacationHours),'-1') as varchar(20)) as INT),
    cast(cast(coalesce(trim(SickLeaveHours),'-1') as varchar(20)) as INT)
    
    
FROM dp_stg1.hr
where nationalidnumber <>'';



--Checking in target table if all data has been loaded or not
--Total 290 Rows should be displayed
SELECT *
FROM dp_stg2.employee;




/*select to_date(current_timestamp())

--This below query is to overwrite the table if want to update or remove anything from the table

insert overwrite dp_stg1.hr
SELECT * from dp_stg1.hr
where businessentityid = '(296 row(s) affected)'



where nationalidnumber <>''
and businessentityid ;
*/

--------------------------------------------------------------------------------------------------------------

--SHIFT TABLE

----------------------

DROP TABLE dp_stg2.shift;

REFRESH dp_stg2.shift;
--Creating shift table

CREATE TABLE dp_stg2.shift
(
           ShiftID BIGINT,
		   Name1 VARCHAR(8),
		   StartTime TIMESTAMP,
		   EndTime TIMESTAMP
);

--Inserting data into the shift table from source HR table 


INSERT INTO dp_stg2.shift(ShiftID, Name1,StartTime, EndTime)

--Using Rownumber () function for generating KEY VALUE as not given in source data (Surrogate)
--As in source table starttime and endtime columns are of varchar so need to convert it to timestamp in target table

SELECT row_number() over(ORDER BY name2),b.*
FROM 
(
SELECT DISTINCT
        cast(cast(coalesce(trim(name2),'N/A') as varchar(20)) as VARCHAR(8))
        name2,
        CAST(starttime AS TIMESTAMP),
		--StartTime,
		CAST(endtime AS TIMESTAMP)
		--CAST (SUBSTR(EndTime,1,10) AS TIMESTAMP)
FROM dp_stg1.hr
where name2 <>''
)b;


SELECT *
FROM DP_STG2.Shift;

------------------------------------------------------------------------------------------------------------

--EMPLOYEEDEPARTMENT HISTORY TABLE
DROP TABLE dp_stg2.employeedepartmenthistory;

REFRESH dp_stg2.employeedepartmenthistory;


--Creating employeeDepartmentHistory table according to schema given

CREATE TABLE dp_stg2.employeeDepartmentHistory
(
           BusinessEntityID INT,
		   DepartmentID INT,        
		   StartDate TIMESTAMP,
		   ShiftID INT,
		   EndDate TIMESTAMP
);


--Inserting into the employeeDepartmentHistory and cleaning the data by removing null

INSERT INTO dp_stg2.employeedepartmenthistory(BusinessEntityID,DepartmentID,StartDate,ShiftID,EndDate)

--Changing the dataTypes from varhcar to INT and TIMESTAMP accordingly


SELECT DISTINCT

 cast(cast(coalesce(trim(a.businessentityid),'-1') as varchar(20)) as INT),
 cast(coalesce(cast(b.departmentid as varchar(20)),'-1') as INT),
 cast(cast(coalesce(trim(StartDate),('1900-01-01')) as TIMESTAMP) as TIMESTAMP),
 cast(cast(coalesce(trim(cast(c.shiftid as varchar(20))),'-1') as varchar(20)) as INT),
 --cast(coalesce(trim(EndDate),to_date('1900-01-01')) as TIMESTAMP),
 case
    when enddate = 'NULL'
    then cast ('1900-01-01' as TIMESTAMP)
    else
    cast(coalesce(EndDate,to_date('1900-01-01')) as TIMESTAMP)
end end_date
 
FROM Dp_Stg1.HR a
INNER JOIN
 Dp_Stg2.Department b
ON a.Name1 = b.DepartmentName
INNER JOIN
Dp_Stg2.Shift c
ON a.Name2 = c.Name1;


--Verifying if the data inserted from the source table to target table is correct or not

SELECT *
FROM DP_STG2.EmployeeDepartmentHistory;

--Checking if the source table have the correct data
SELECT * 
FROM dp_stg2.employeedepartmenthistory
WHERE enddate <> '1900-01-01';

--TOTAL ROWS RETURNED SHOULD BE 296 EMPLOYEEDEPARTMENTHISTORY
----------------------------------------------------------------------------------------------------------------



