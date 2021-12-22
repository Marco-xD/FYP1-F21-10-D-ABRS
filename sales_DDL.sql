################################################

DROP TABLE DP_STG1.sales;

REFRESH DP_STG1.sales;

show create table DP_STG1.sales;

SELECT * FROM dp_stg1.sales LIMIT 100;




###############################################


CREATE TABLE DP_STG1.sales
(
    SalesOrderID1			VARCHAR(500) ,
    RevisionNumber			VARCHAR(500) ,
    OrderDate				VARCHAR(500) ,
    DueDate					VARCHAR(500) ,
    ShipDate				VARCHAR(500) ,
    Status					VARCHAR(500) ,
    OnlineOrderFlag			VARCHAR(500) ,
    SalesOrderNumber		VARCHAR(500) ,
    PurchaseOrderNumber		VARCHAR(500) ,
    AccountNumber			VARCHAR(500) ,
    CustomerID				VARCHAR(500) ,
    SalesPersonID			VARCHAR(500) ,
    TerritoryID1			VARCHAR(500) ,
    BillToAddressID			VARCHAR(500) ,
    ShipToAddressID			VARCHAR(500) ,
    ShipMethodID			VARCHAR(500) ,
    CreditCardID1			VARCHAR(500) ,
    CreditCardApprovalCode	VARCHAR(500) ,
    CurrencyRateID1			VARCHAR(500) ,
    SubTotal				VARCHAR(500) ,
    TaxAmt					VARCHAR(500) ,
    Freight					VARCHAR(500) ,
    TotalDue				VARCHAR(500) ,
    Comment1				VARCHAR(500) ,
    rowguid1				VARCHAR(500) ,
    ModifiedDate1			VARCHAR(500) ,
    SalesOrderID2			VARCHAR(500) ,
    SalesReasonID1			VARCHAR(500) ,
    ModifiedDate2			VARCHAR(500) ,
    SalesReasonID2			VARCHAR(500) ,
    Name1					VARCHAR(500) ,
    ReasonType				VARCHAR(500) ,
    ModifiedDate3			VARCHAR(500) ,
    SalesOrderID3			VARCHAR(500) ,
    SalesOrderDetailID		VARCHAR(500) ,
    CarrierTrackingNumber	VARCHAR(500) ,
    OrderQty				VARCHAR(500) ,
    ProductID1				VARCHAR(500) ,
    SpecialOfferID1			VARCHAR(500) ,
    UnitPrice				VARCHAR(500) ,
    UnitPriceDiscount		VARCHAR(500) ,
    LineTotal				VARCHAR(500) ,
    rowguid2				VARCHAR(500) ,
    ModifiedDate4			VARCHAR(500) ,
    SpecialOfferID2			VARCHAR(500) ,
    Description				VARCHAR(500) ,
    DiscountPct				VARCHAR(500) ,
    Type1					VARCHAR(500) ,
    Category				VARCHAR(500) ,
    StartDate1				VARCHAR(500) ,
    EndDate1				VARCHAR(500) ,
    MinQty					VARCHAR(500) ,
    MaxQty					VARCHAR(500) ,
    rowguid3				VARCHAR(500) ,
    ModifiedDate5			VARCHAR(500) ,
    SpecialOfferID3			VARCHAR(500) ,
    ProductID2				VARCHAR(500) ,
    rowguid4				VARCHAR(500) ,
    ModifiedDate6			VARCHAR(500) ,
    CurrencyRateID2			VARCHAR(500) ,
    CurrencyRateDate		VARCHAR(500) ,
    FromCurrencyCode		VARCHAR(500) ,
    ToCurrencyCode			VARCHAR(500) ,
    AverageRate				VARCHAR(500) ,
    EndOfDayRate			VARCHAR(500) ,
    ModifiedDate7			VARCHAR(500) ,
    CurrencyCode			VARCHAR(500) ,
    Name2					VARCHAR(500) ,
    ModifiedDate8			VARCHAR(500) ,
    CreditCardID2			VARCHAR(500) ,
    CardType				VARCHAR(500) ,
    CardNumber				VARCHAR(500) ,
    ExpMonth				VARCHAR(500) ,
    ExpYear					VARCHAR(500) ,
    ModifiedDate9			VARCHAR(500) ,
    BusinessEntityID1		VARCHAR(500) ,
    CreditCardID3			VARCHAR(500) ,
    ModifiedDate10			VARCHAR(500) ,
    TerritoryID2			VARCHAR(500) ,
    Name3					VARCHAR(500) ,
    CountryRegionCode		VARCHAR(500) ,
    Group1					VARCHAR(500) ,
    SalesYTD1				VARCHAR(500) ,
    SalesLastYear1			VARCHAR(500) ,
    CostYTD					VARCHAR(500) ,
    CostLastYear			VARCHAR(500) ,
    rowguid5				VARCHAR(500) ,
    ModifiedDate11			VARCHAR(500) ,
    BusinessEntityID2		VARCHAR(500) ,
    TerritoryID3			VARCHAR(500) ,
    StartDate2				VARCHAR(500) ,
    EndDate2				VARCHAR(500) ,
    rowguid6				VARCHAR(500) ,
    ModifiedDate12			VARCHAR(500) ,
    BusinessEntityID3		VARCHAR(500) ,
    QuotaDate				VARCHAR(500) ,
    SalesQuota1				VARCHAR(500) ,
    rowguid7				VARCHAR(500) ,
    ModifiedDate13			VARCHAR(500) ,
    BusinessEntityID4		VARCHAR(500) ,
    TerritoryID4			VARCHAR(500) ,
    SalesQuota2				VARCHAR(500) ,
    Bonus					VARCHAR(500) ,
    CommissionPct			VARCHAR(500) ,
    SalesYTD2				VARCHAR(500) ,
    SalesLastYear2			VARCHAR(500) ,
    rowguid8				VARCHAR(500) ,
    ModifiedDate14			VARCHAR(500) 

)

    ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
    tblproperties ("skip.header.line.count"="1");
    
###################################################

#USE THE FOLLOWING COMMAND TO LOAD THE DATA INTO SALES TABLE

#"sudo -u hdfs hadoop fs -put /hdfs/AW_DS_DP_STG1/Sales.CSV /user/hive/warehouse/dp_stg1.db/sales"