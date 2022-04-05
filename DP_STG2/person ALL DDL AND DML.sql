------------------------------------------------------
--PERSON TABLES ACCORDING TO SCHEMA

--TOTAL TABLES=12

--1)Password
--2)EmailAddress
--3)ContactType
--4)BusinessEntity
--5)CountryRegion
--6)StateProvince
--7)Address
--8)BusinessEntityAddress
--9)AddressType
--10)Person
--11)PersonPhone
--12)PhoneNumberType


------------------------------------------------------

--1) CREATING PERSON TABLE 
--According to schema
-------------------------------------------------------

--Droping table if needed
DROP TABLE dp_stg2.passwords;


-------------------------------
REFRESH dp_stg2.passwords;

--Creating Password table and extracting 3 columns from the Source tables

CREATE TABLE dp_stg2.passwords
(
    BusinessEntityID INT,
    PasswordHash VARCHAR(256),
    PasswordSalt VARCHAR(32)

);

--Inserting data into the target table from the source table

INSERT INTO dp_stg2.passwords

SELECT DISTINCT

cast(cast(coalesce(trim(BusinessEntityID1),'-1') AS VARCHAR(20)) AS INT),
--cast(cast(coalesce(trim(PasswordHash),'N/A') AS VARCHAR(20)) AS VARCHAR(256)),
cast(coalesce(trim(PasswordHash),'N/A') AS VARCHAR(256)),
cast(cast(coalesce(trim(passwordsalt),'N/A') AS VARCHAR(32)) AS VARCHAR(32))
FROM dp_stg1.person;


--Verifying if data has been loaded correctly or not
SELECT *
FROM dp_stg2.passwords;

--It should return total of 19972 Rows
SELECT count(*) FROM passwords;

--Checking aganist one ID if it's corresponding columns are correct or not
SELECT *
FROM passwords
WHERE businessentityid=8585;

----------------------------------------------------------------------------------------------------------------

--2)Creating EmailAddress Table
--ACCORDING TO SCHEMA

-------------------------------------------------


--Dropping the table if there is some issue while inserting from source table

DROP TABLE dp_Stg2.EmailAddress;

--Refreshing the table
REFRESH  dp_stg2.emailaddress;

--Creating EmailAddress table according to schema

CREATE TABLE dp_Stg2.emailAddress
(
BusinessEntityID INT,
EmailAddressID INT,
EmailAddress VARCHAR(64)
);

--Inserting data into the target table from the source table
--This query will clean the data and remove Null and empty rows and then load the data into the target table
--Total 3 columns 1)businessEntityID1 2)EmailAddressID 3)EmailAddress
INSERT INTO dp_stg2.emailaddress

SELECT DISTINCT

cast(cast(coalesce(trim(businessentityid1),'-1') AS VARCHAR(20)) AS INT),
cast(cast(coalesce(trim(EmailAddressID),'-1') AS VARCHAR(20)) AS INT),
cast(coalesce(trim(EmailAddress),'N/A') AS VARCHAR(64))

FROM dp_stg1.person;


--Checking the target table if data has been loaded correctly or not

SELECT *
FROM dp_stg2.emailaddress;

--Checking against one record 8585 if corresponding columns are correct or not
SELECT * 
FROM dp_stg2.emailaddress
WHERE businessentityid=8585;

--This should return total rows of 19972
SELECT count(*) 
FROM dp_stg2.emailaddress;

--------------------------------------------------------------------------------------------------------------------
--3) CONTACTTYPE TABLE 
--   ACCORDING TO SCHEMA

------------------------------------------

--Refreshing Contact table

REFRESH dp_stg2.contacttype;

--Dropping table if there is some issue while loading the data 
DROP TABLE dp_Stg2.ContactType;


--Creating contact type table

CREATE TABLE dp_stg2.ContactType
(
    BusinessEntityID INT,
    Name1 VARCHAR(16)
);

--Inserting the data into the target table according to schema 
--Cleaning the data by removing NULL and replacing it with -1 or NA
--Total 2 columns in this case 

INSERT INTO DP_STG2.ContactType
SELECT DISTINCT
cast(cast(coalesce(trim(businessentityid1),'-1') AS VARCHAR(20)) AS INT),
cast(coalesce(trim(name1),'N/A') AS VARCHAR(16)) 
FROM DP_STG1.Person;


--Checking if data has been loaded correctly or not
SELECT *
FROM DP_STG2.ContactType;

--It should return 19972 rows 
SELECT count(*) AS NumberOfRows
FROM contacttype;

--Checking aganist one record if corresponding column is correct or not 
SELECT *
FROM contacttype
WHERE businessentityid=741;

-----------------------------------------------------------------------------------------------------------

--4) BusinessEntity Table 
-- According to Schema

---------------------------------

--Refreshing the table 
REFRESH dp_stg2.businessentity;

--Dropping table if there is some issue while inserting the data into the table
DROP TABLE dp_Stg2.BusinessEntity;


CREATE TABLE dp_stg2.BusinessEntity
(
    BusinessEntityID INT
);


--Inserting into the target table from source table according to schema
--In this Table we have only one column 1)businessEntityID

INSERT INTO dp_stg2.BusinessEntity
SELECT DISTINCT
cast(cast(coalesce(trim(businessentityid1),'-1') AS VARCHAR(20)) AS INT)
FROM dp_stg1.person;

--Checking if data has been loaded correctly or not 
SELECT *
FROM DP_STG2.BusinessEntity;

--It should return 19972 rows 
SELECT count(*) AS NumberOfRows
FROM businessentity;

------------------------------------------------------------------------------------------------------------------------

--5) CountryRegion Table
--According to schema 

--------------------------------

--Refreshing the table after inserting the data into the target table 
REFRESH dp_stg2.countryregion;


--Dropping the table if there is some issue while loading the data into the table
DROP TABLE dp_stg2.CountryRegion;

--Creating the countryRegion Table according to schema 

CREATE TABLE dp_stg2.CountryRegion
(
    CountryRegionCode CHAR(4),
    Name1 VARCHAR(32)
);


--Inserting the data into the target table 
--In this we are replacing 'NULL' with 'N/A'


INSERT INTO DP_STG2.CountryRegion
SELECT DISTINCT
--cast(cast(coalesce(countryRegionCode1,'N/A') AS VARCHAR(4)) AS CHAR(4)),

CASE
    WHEN countryregioncode1='NULL'
    THEN cast('N/A' AS CHAR(4))
    ELSE
    cast(coalesce(countryregioncode1,'N/A') AS CHAR(4)) END AS countryregioncode1,

CASE 
    WHEN Name3 = 'NULL' 
    THEN cast('N/A' AS VARCHAR (32)) 
    ELSE 
    cast(coalesce(name3,'N/A') AS VARCHAR(32)) END AS Name3
    
FROM DP_STG1.Person;

--Checking if the data from source table has been loaded correctly to the target table
--It should return 7 rows
SELECT *
FROM DP_STG2.CountryRegion;

---------------------------------------------------------------------------------------------------------------
--6) StateProvince Table
--According to Schema

------------------------------------------------------

--Refreshing the table after inserting the data into the target table

REFRESH dp_stg2.stateprovince;

--Dropping table if there is some issue while inserting the data into the table

DROP TABLE dp_Stg2.StateProvince;

--Creating the StateProvinceTable


CREATE TABLE Dp_Stg2.StateProvince
(
    StateProvinceID INT,
    StateProvinceCode CHAR(6),
    CountryRegionCode CHAR(4),
    isOnlyStateProvinceFlag TINYINT,
    Name1 VARCHAR(32),
    TerritoryID INT

);


INSERT INTO dp_stg2.StateProvince

SELECT DISTINCT
--CASE WHEN StateProvinceID1 = 'NULL' THEN -1 ELSE StateProvinceID1 END AS StateProvinceID,
CASE
    WHEN stateprovinceID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(stateprovinceID1),'-1') AS VARCHAR(20)) AS INT) END AS stateprovinceID1,

--CASE WHEN StateProvinceCode IS NULL THEN 'N/A' ELSE StateProvinceCode END AS StateProvinceCode,
--cast(cast(coalesce(stateprovincecode,'N/A') AS VARCHAR(6)) AS VARCHAR(6)),
CASE
    WHEN stateprovincecode='NULL'
    THEN cast('N/A' AS CHAR(6))
    ELSE
    cast(coalesce(stateprovincecode,'N/A') AS CHAR(6)) END AS stateprovincecode,


--StateProvinceCode,
--CASE WHEN CountryRegionCode1 = 'NULL' THEN 'N/A' ELSE CAST(CountryRegionCode1 AS CHAR(6)) END AS CountryRegionCode,
CASE
    WHEN countryregioncode1='NULL'
    THEN cast('N/A' AS CHAR(4))
    ELSE
    cast(coalesce(countryregioncode1,'N/A') AS CHAR(4)) END AS countryregioncode1,

--CASE WHEN isOnlyStateProvinceFlag = 'NULL' THEN -1 ELSE CAST(isOnlyStateProvinceFlag AS BYTEINT) END AS isOnlyStateProvinceFlag,
CASE
    WHEN isonlystateprovinceflag='NULL'
    THEN cast('-1' AS TINYINT)
    ELSE
    cast(cast(coalesce(isonlystateprovinceflag,'-1') AS VARCHAR(20)) AS TINYINT) END AS isonlystateprovinceflag,


--CASE WHEN Name2 = 'NULL' THEN 'N/A' ELSE Name2 END AS Name2,
CASE
    WHEN name2='NULL'
    THEN cast('N/A' AS VARCHAR(32))
    ELSE
    cast(coalesce(name2,'N/A') AS VARCHAR(32)) END AS name2,

--CASE WHEN TerritoryID = 'NULL' THEN -1 ELSE TerritoryID END AS TerritoryID
CASE
    WHEN territoryid='NULL'
    THEN cast(cast('-1' AS VARCHAR(20)) AS INT) 
    ELSE
    cast(cast(coalesce(trim(territoryid),'-1')AS VARCHAR(20)) AS INT) END AS territoryid
    
FROM DP_STG1.Person;

--Checking if data has been correctly loaded to target table
SELECT *
FROM DP_STG2.StateProvince;

-- It should return 58 rows
SELECT count(*) AS numberOfRows
from dp_stg2.stateprovince;

--------------------------------------------------------------------------------------------------------------
--7) Address Table
--   According to schema

---------------------------------

--Dropping the table if there is any issue while inserting the data from source table
DROP TABLE dp_Stg2.Address;

--Refreshing the table after inserting the data 
REFRESH dp_stg2.address;


--Creating the Address Table 
-- Total 7 columns
-- 1) addressID 2)AddressLine1 3)addressLine2 4)City 5)stateProvinceID 6)PostalCode 7)SpatialLocation


CREATE TABLE dp_stg2.Address
(
    AddressID INT,
    AddressLine1 VARCHAR(100),
    AddressLine2 VARCHAR(100),
    City VARCHAR(16),
    StateProvinceID INT,
    PostalCode VARCHAR(32),
    SpatialLocation VARCHAR(200)
);

--Inserting data into the table while cleaning the data and removing Null values of each kind
--Using Case condition for cleaning the data and extracting specific/required columns from the source table


INSERT INTO dp_stg2.address

SELECT DISTINCT
--CASE WHEN AddressID1 = 'NULL' THEN -1 ELSE AddressID1 END AS AddressID1,
CASE 
    WHEN addressid1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20)) AS INT)
    ELSE
    cast(coalesce(trim(addressid1),'-1') AS INT) END AS addressid1,


--CASE WHEN AddressLine1 IS NULL THEN 'N/A' ELSE AddressLine1 END AS AddressLine1,
CASE 
    WHEN addressline1='NULL'
    THEN cast('N/A' AS VARCHAR(100))
    ELSE
    cast(coalesce(trim(addressline1),'N/A') AS VARCHAR(100)) END AS addressline1,

--CASE WHEN AddressLine2 IS NULL THEN 'N/A' ELSE AddressLine2 END AS AddressLine2,
CASE 
    WHEN addressline2='NULL'
    THEN cast('N/A' AS VARCHAR(100))
    ELSE
    cast(coalesce(trim(addressline2),'N/A') AS VARCHAR(100)) END AS addressline2,

--CASE WHEN City= 'NULL' THEN 'N/A' ELSE City END AS City,
CASE 
    WHEN city='NULL'
    THEN cast('N/A' AS VARCHAR(16))
    ELSE
    cast(coalesce(trim(city),'N/A') AS VARCHAR(16)) END AS city,
    
--CASE WHEN StateProvinceID1 = 'NULL' THEN -1 ELSE StateProvinceID1 END AS StateProvinceID,
--Using stateprovinceID as Foreign Key
CASE
    WHEN stateprovinceID1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20) ) AS INT)
    ELSE 
    cast(cast(coalesce(trim(stateprovinceID1),'-1') AS VARCHAR(20)) AS INT) END AS stateprovinceID1,



--CASE WHEN PostalCode IS NULL THEN 'N/A' ELSE PostalCode END AS PostalCode,

CASE 
    WHEN postalcode='NULL'
    THEN cast('N/A' AS VARCHAR(32))
    ELSE
    cast(coalesce(trim(postalcode),'N/A') AS VARCHAR(32)) END AS postalcode,

--CASE WHEN SpatialLocation IS NULL THEN 'N/A' ELSE SpatialLocation END AS SpatialLocation
CASE 
    WHEN spatiallocation='NULL'
    THEN cast('N/A' AS VARCHAR(200))
    ELSE
    cast(coalesce(trim(spatiallocation),'N/A') AS VARCHAR(200)) END AS spatiallocation

FROM DP_STG1.Person;

--Checking if data has been loaded correctly into the target table or not
SELECT *
FROM dp_stg2.address;

--Checking row count it should return 18799
SELECT count(*) AS numberOfRows
from dp_stg2.address;

-------------------------------------------------------------------------------------------------------------------

--8) BusinessEntityAddress Table
-- According to Schema

-------------------------------------------

--Dropping the table if there is any issue while inserting the data into the table
DROP TABLE dp_Stg2.BusinessEntityAddress;

--Refreshing the table after inserting the data into the table
REFRESH dp_stg2.businessentityaddress;

--Creating businessEntityAddress table 
--Total 3 columns. 1) AddressID 2)BusinessEntityID 3) AddressTypeID

CREATE TABLE dp_stg2.BusinessEntityAddress
(
    AddressID INT,
    BusinessEntityID INT,
    AddressTypeID VARCHAR(8)
);


-- Inserting data into the target table 
-- Cleaning data and removing NULL from source data
-- Extracting required columns from the source table to the target table
-- Using Case condition statements for removing the NULL and replacing by -1


INSERT INTO dp_stg2.BusinessEntityAddress

SELECT DISTINCT
--CASE WHEN AddressID1 = 'NULL' THEN -1 ELSE AddressID1 END AS AddressID1,
CASE 
    WHEN addressid1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20)) AS INT)
    ELSE
    cast(coalesce(trim(addressid1),'-1') AS INT) END AS addressid1,


--CASE WHEN BusinessEntityID1 = 'NULL' THEN -1 ELSE BusinessEntityID1 END AS BusinessEntityID1,
CASE 
    WHEN businessentityid1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20)) AS INT)
    ELSE
    cast(coalesce(trim(businessentityid1),'-1') AS INT) END AS businessentityid1,


--CASE WHEN AddressTypeID1 = 'NULL' THEN -1 ELSE AddressTypeID1 END AS AddressTypeID

CASE 
    WHEN addresstypeid1='NULL'
    THEN cast('-1' AS VARCHAR(8))
    ELSE
    cast(coalesce(trim(addresstypeid1),'N/A') AS VARCHAR(8)) END AS addresstypeid1
    
FROM DP_STG1.Person;


--Checking if the target table have the correct data loaded or not
SELECT *
FROM dp_stg2.BusinessEntityAddress;

--Checking number of rows and it should return 19992
SELECT count(*) AS NumberOfRows
FROM businessentityaddress;

-----------------------------------------------------------------------------------------------------------

--9) AddressType Table
-- According to schema

--------------------------------

--Dropping the table if there is any issue while loading the data into the table
DROP TABLE dp_Stg2.AddressType;

--Refreshing the table after inserting the data into the table
REFRESH dp_stg2.addressType;


CREATE TABLE Dp_Stg2.AddressType
(
    AddressTypeID INT,
    Name1 VARCHAR(8)
);

INSERT INTO DP_STG2.AddressType

SELECT DISTINCT
--CASE WHEN AddressTypeID1 = 'NULL' THEN -1 ELSE AddressTypeID1 END AS AddressTypeID,
CASE
    WHEN addresstypeid1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20)) AS INT)
    ELSE
    cast(cast(coalesce(addresstypeid1,'-1') AS VARCHAR(20)) AS INT) END AS addresstypeid1,

--CASE WHEN Name4 = 'NULL' THEN 'N/A' ELSE Name4 END AS Name4
CASE
    WHEN name4='NULL'
    THEN cast('N/A' AS VARCHAR(8))
    ELSE
    cast(coalesce(name4,'N/A') AS VARCHAR(8)) END AS name4
    
FROM DP_STG1.Person;

-- Checking if the data has been loaded correctly into the target table or not
SELECT *
FROM dp_stg2.AddressType;

---------------------------------------------------------------------------------------------------

--10) Person Table
-- According to schema

-------------------------------

--Dropping the table if there is some issue while inserting the data into the target table
DROP TABLE dp_Stg2.Person;

--Refreshing the target table after inserting the data into the table
REFRESH dp_stg2.person;


--Creating the person table with 9 columns
--1)BusinessEntityID 2)PersonType 3)Title1 4) FirstName 5) MiddleName 6) LastName 7) Suffix 8)EmailPromotion 9)DemoGraphics

CREATE TABLE Dp_Stg2.Person
(
           BusinessEntityID INT,
		   PersonType CHAR(2),
		   --NameStyle INTEGER  has nothing only zero so drop it,
		   Title1 CHAR(4),
		   FirstName VARCHAR(16),
		   MiddleName VARCHAR(16),
		   LastName VARCHAR(16),
		   Suffix CHAR(5),
		   EmailPromotion TINYINT,
		   --AdditionalContactInfo VARCHAR(200) WE DON'T NEED THIS,
		 DemoGraphics1 VARCHAR(200)
);


--Inserting data from source table to the target table
-- removing NULLS and EMPTY rows
-- Only Selecting required columns and DataTypes defined accordingly

INSERT INTO dp_stg2.person

SELECT DISTINCT

--CASE WHEN BusinessEntityID1 = 'NULL' THEN -1 ELSE BusinessEntityID1 END AS BusinessEntityID1,
CASE 
    WHEN businessentityid1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20)) AS INT)
    ELSE
    cast(coalesce(trim(businessentityid1),'-1') AS INT) END AS businessentityid1,

--CASE WHEN PersonType = 'NULL' THEN 'N/A' ELSE PersonType END AS PersonType,
CASE 
    WHEN persontype='NULL'
    THEN cast('N/A' AS CHAR(2))
    ELSE
    cast(coalesce(trim(persontype),'N/A') AS CHAR(2)) END AS persontype,

--CASE WHEN Title1 = 'NULL' THEN 'N/A' ELSE CAST(Title1 AS CHAR(4)) END AS Title1,
CASE 
    WHEN title1='NULL'
    THEN cast('N/A' AS CHAR(4))
    ELSE
    cast(coalesce(trim(title1),'N/A') AS CHAR(4)) END AS title1,


--CASE WHEN FirstName = 'NULL' THEN 'N/A' ELSE FirstName END AS FirstName,
CASE 
    WHEN FirstName='NULL'
    THEN cast('N/A' AS VARCHAR(16))
    ELSE
    cast(coalesce(trim(FirstName),'N/A') AS VARCHAR(16)) END AS FirstName,


--CASE WHEN MiddleName = 'NULL' THEN 'N/A' ELSE MiddleName END AS MiddleName,
CASE 
    WHEN MiddleName='NULL'
    THEN cast('N/A' AS VARCHAR(16))
    ELSE
    cast(coalesce(trim(MiddleName),'N/A') AS VARCHAR(16)) END AS MiddleName,

--CASE WHEN LastName = 'NULL' THEN 'N/A' ELSE LastName END AS LastName,
CASE 
    WHEN LastName='NULL'
    THEN cast('N/A' AS VARCHAR(16))
    ELSE
    cast(coalesce(trim(LastName),'N/A') AS VARCHAR(16)) END AS LastName,


--CASE WHEN Suffix = 'NULL' THEN 'N/A' ELSE CAST(Suffix AS CHAR(5)) END AS Suffix,
CASE 
    WHEN suffix='NULL'
    THEN cast('N/A' AS CHAR(5))
    ELSE
    cast(coalesce(trim(suffix),'N/A') AS CHAR(5)) END AS suffix,

--CASE WHEN EmailPromotion = 'NULL' THEN -1 ELSE CAST(EmailPromotion AS BYTEINT) END AS EmailPromotion,
CASE
    WHEN EmailPromotion='NULL'
    THEN cast('-1' AS TINYINT)
    ELSE
    cast(cast(coalesce(EmailPromotion,'-1') AS VARCHAR(20)) AS TINYINT) END AS EmailPromotion,


--CASE WHEN DEMOGRAPHICS = 'NULL' THEN 'N/A' ELSE DEMOGRAPHICS END AS DEMOGRAPHICS
CASE 
    WHEN demographics='NULL'
    THEN cast('N/A' AS VARCHAR(200))
    ELSE
    cast(coalesce(trim(demographics),'N/A') AS VARCHAR(200)) END AS demographics


FROM Dp_Stg1.Person;


--Checking if data hass been loaded into the target table correctly or not

SELECT *
FROM dp_stg2.person;

--This should return 19972 Rows 

SELECT count(*) AS NumberOfRows
from dp_stg2.person;

---------------------------------------------------------------------------------------------------------------------

--11) PhoneNumberType Table
-- According to the Schema

------------------------------------------

--Dropping the table if there is some issue while inserting the data into the target table
DROP TABLE dp_Stg2.PhoneNumberType;


--Refreshing the table after inserting the data into the target table
REFRESH dp_stg2.phoneNumberType;

--Creating the phoneNumberType table with 2 columns
--1) Genrate auto number as PhoneNumberTypeID   2) Name1

CREATE TABLE Dp_Stg2.PhoneNumberType
(
    PhoneNumberTypeID BIGINT,
    Name1 VARCHAR(8)
);


INSERT INTO dp_stg2.PhoneNumberType


--Generating surrogate key for phoneNumberTypeID
--AND SELECTING NAME1 
--Removing NULL and cleaning the data 

SELECT row_number() over (ORDER BY name1),a.*
FROM 
(
    SELECT DISTINCT
    --CASE WHEN Name1 = 'NULL' THEN 'N/A' ELSE Name1 END AS Name1
    CASE
        WHEN name1='NULL'
        THEN cast('N/A' AS VARCHAR(8))
        ELSE
        cast(coalesce(name1,'N/A') AS VARCHAR(8)) END AS name1
        
    FROM dp_stg1.person
    
)a;

--Checking if data have been correctly loaded or not
SELECT *
from dp_stg2.phonenumbertype;

-----------------------------------------------------------------------------------------------------------------

--12) PersonPhone table
-- According to Schema 

------------------------------------

--Dropping the table if there is some issue while inserting the data into the target table
DROP TABLE dp_Stg2.PersonPhone;

--Refreshing the target table after inserting the data into it
REFRESH dp_stg2.personPhone;


--Creating the personPhone table with total 3 columns
-- 1)businessEntityID 2)phoneNumber 3)PhoneNumberTypeID


CREATE TABLE Dp_Stg2.PersonPhone
(
    BusinessEntityID INT,
    PhoneNumber VARCHAR(64),
    PhoneNumberTypeID BIGINT
);


--Inserting the data into the personPhone table and using the inner join of source data with
--Target table PhoneNumberType
--Perfoming Inner join and selecting required columns

INSERT INTO dp_stg2.PersonPhone

SELECT DISTINCT

--CASE WHEN a.BusinessEntityID1 = 'NULL' THEN -1 ELSE BusinessEntityID1 END AS BusinessEntityID1,
CASE 
    WHEN a.businessentityid1='NULL'
    THEN cast(cast('-1' AS VARCHAR(20)) AS INT)
    ELSE
    cast(cast(coalesce(trim(businessentityid1),'-1') AS VARCHAR(20) )AS INT) END AS businessentityid1,
    
--CASE WHEN a.PhoneNumber = 'NULL' THEN -1 ELSE PhoneNumber END AS PhoneNumber,
CASE
    WHEN a.phoneNumber='NULL'
    THEN cast('-1' AS VARCHAR(64))
    ELSE
    cast(coalesce(phoneNumber,'-1') AS VARCHAR(64)) END AS phoneNumber,

--CASE WHEN b.PhoneNumberTypeID IS NULL THEN -1 ELSE PhoneNumberTypeID END AS PhoneNumberTypeID
CASE
    WHEN b.phoneNumbertypeID=NULL
    THEN cast(cast(-1 AS VARCHAR(8)) AS BIGINT)
    ELSE
    cast(cast(coalesce(phoneNumbertypeID,-1) AS VARCHAR(8)) AS BIGINT) END AS phoneNumbertypeID

FROM DP_STG1.Person a
INNER JOIN
dp_stg2.PhoneNumberType b
ON a.Name1 = b.Name1;

--Checking if data have been loaded into the table or not

SELECT *
FROM DP_STG2.PersonPhone;

SELECT count(*) AS NumberofRows
from dp_stg2.personphone;

------------------------------------------------------------------------------------------------------------------