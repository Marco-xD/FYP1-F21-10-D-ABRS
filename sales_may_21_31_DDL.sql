#######################


DROP TABLE DP_STG1.sales_may_21_31;

REFRESH DP_STG1.sales_may_21_31;

show create table DP_STG1.sales_may_21_31;

SELECT * FROM dp_stg1.sales_may_21_31 LIMIT 100;

#######################


CREATE TABLE DP_STG1.sales_may_21_31
(

    SalesOrderID1			VARCHAR(550) ,
    RevisionNumber			VARCHAR(550) ,
    OrderDate				VARCHAR(550) ,
    DueDate					VARCHAR(550) ,
    ShipDate				VARCHAR(550) ,
    Status					VARCHAR(550) ,
    OnlineOrderFlag			VARCHAR(550) ,
    SalesOrderNumber		VARCHAR(550) ,
    PurchaseOrderNumber		VARCHAR(550) ,
    AccountNumber			VARCHAR(550) ,
    CustomerID				VARCHAR(550) ,
    SalesPersonID			VARCHAR(550) ,
    TerritoryID1			VARCHAR(550) ,
    BillToAddressID			VARCHAR(550) ,
    ShipToAddressID			VARCHAR(550) ,
    ShipMethodID			VARCHAR(550) ,
    CreditCardID1			VARCHAR(550) ,
    CreditCardApprovalCode	VARCHAR(550) ,
    CurrencyRateID1			VARCHAR(550) ,
    SubTotal				VARCHAR(550) ,
    TaxAmt					VARCHAR(550) ,
    Freight					VARCHAR(550) ,
    TotalDue				VARCHAR(550) ,
    Comment1				VARCHAR(550) ,
    rowguid1				VARCHAR(550) ,
    ModifiedDate1			VARCHAR(550) ,
    SalesOrderID2			VARCHAR(550) ,
    SalesReasonID1			VARCHAR(550) ,
    ModifiedDate2			VARCHAR(550) ,
    SalesReasonID2			VARCHAR(550) ,
    Name1					VARCHAR(550) ,
    ReasonType				VARCHAR(550) ,
    ModifiedDate3			VARCHAR(550) ,
    SalesOrderID3			VARCHAR(550) ,
    SalesOrderDetailID		VARCHAR(550) ,
    CarrierTrackingNumber	VARCHAR(550) ,
    OrderQty				VARCHAR(550) ,
    ProductID1				VARCHAR(550) ,
    SpecialOfferID1			VARCHAR(550) ,
    UnitPrice				VARCHAR(550) ,
    UnitPriceDiscount		VARCHAR(550) ,
    LineTotal				VARCHAR(550) ,
    rowguid2				VARCHAR(550) ,
    ModifiedDate4			VARCHAR(550) ,
    SpecialOfferID2			VARCHAR(550) ,
    Description				VARCHAR(550) ,
    DiscountPct				VARCHAR(550) ,
    Type1					VARCHAR(550) ,
    Category				VARCHAR(550) ,
    StartDate1				VARCHAR(550) ,
    EndDate1				VARCHAR(550) ,
    MinQty					VARCHAR(550) ,
    MaxQty					VARCHAR(550) ,
    rowguid3				VARCHAR(550) ,
    ModifiedDate5			VARCHAR(550) ,
    SpecialOfferID3			VARCHAR(550) ,
    ProductID2				VARCHAR(550) ,
    rowguid4				VARCHAR(550) ,
    ModifiedDate6			VARCHAR(550) ,
    CurrencyRateID2			VARCHAR(550) ,
    CurrencyRateDate		VARCHAR(550) ,
    FromCurrencyCode		VARCHAR(550) ,
    ToCurrencyCode			VARCHAR(550) ,
    AverageRate				VARCHAR(550) ,
    EndOfDayRate			VARCHAR(550) ,
    ModifiedDate7			VARCHAR(550) ,
    CurrencyCode			VARCHAR(550) ,
    Name2					VARCHAR(550) ,
    ModifiedDate8			VARCHAR(550) ,
    CreditCardID2			VARCHAR(550) ,
    CardType				VARCHAR(550) ,
    CardNumber				VARCHAR(550) ,
    ExpMonth				VARCHAR(550) ,
    ExpYear					VARCHAR(550) ,
    ModifiedDate9			VARCHAR(550) ,
    BusinessEntityID1		VARCHAR(550) ,
    CreditCardID3			VARCHAR(550) ,
    ModifiedDate10			VARCHAR(550) ,
    TerritoryID2			VARCHAR(550) ,
    Name3					VARCHAR(550) ,
    CountryRegionCode		VARCHAR(550) ,
    Group1					VARCHAR(550) ,
    SalesYTD1				VARCHAR(550) ,
    SalesLastYear1			VARCHAR(550) ,
    CostYTD					VARCHAR(550) ,
    CostLastYear			VARCHAR(550) ,
    rowguid5				VARCHAR(550) ,
    ModifiedDate11			VARCHAR(550) ,
    BusinessEntityID2		VARCHAR(550) ,
    TerritoryID3			VARCHAR(550) ,
    StartDate2				VARCHAR(550) ,
    EndDate2				VARCHAR(550) ,
    rowguid6				VARCHAR(550) ,
    ModifiedDate12			VARCHAR(550) ,
    BusinessEntityID3		VARCHAR(550) ,
    QuotaDate				VARCHAR(550) ,
    SalesQuota1				VARCHAR(550) ,
    rowguid7				VARCHAR(550) ,
    ModifiedDate13			VARCHAR(550) ,
    BusinessEntityID4		VARCHAR(550) ,
    TerritoryID4			VARCHAR(550) ,
    SalesQuota2				VARCHAR(550) ,
    Bonus					VARCHAR(550) ,
    CommissionPct			VARCHAR(550) ,
    SalesYTD2				VARCHAR(550) ,
    SalesLastYear2			VARCHAR(550) ,
    rowguid8				VARCHAR(550) ,
    ModifiedDate14			VARCHAR(550) 

)

    ROW FORMAT DELIMITED FIELDS TERMINATED BY '^' 
    tblproperties ("skip.header.line.count"="1");
    
######################################################   

#USE THE FLLOWING COMMAND TO LOAD THE DATA IN sales_may_21_31 TABLE

#"sudo -u hdfs hadoop fs -put /hdfs/AW_DS_DP_STG1/Sales_May21-31.csv /user/hive/warehouse/dp_stg1.db/sales_may_21_31"