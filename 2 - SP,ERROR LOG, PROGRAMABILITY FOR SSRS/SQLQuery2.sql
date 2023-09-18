
CREATE PROCEDURE REPORT_FOR_SSRS
--The user will enter these parameters through the application.
@TCKN INT,
@VKN INT
AS
BEGIN

BEGIN TRY

--These parameters meet the conditions of two separate tables that I will run.
DECLARE @COUNT_TCKN INT = 0
DECLARE @COUNT_VKN INT = 0

IF @TCKN IS NOT NULL --If the user entered a value for the TCKN parameter, I set the COUNT_TCKN parameter equal to 1.
SET @COUNT_TCKN = 1
IF @VKN IS NOT NULL  --Same for VKN parameter
SET @COUNT_VKN = 1
--With this case, I checked parameters for are they null or not null.

INSERT INTO dbo.ERROR_LOGS(StringParameter,DateString) -- These are log records so that if I get an error, I can see where the error is.
VALUES('Stage 1',GETDATE())

--Now let's print 2 tables according to our conditions.
IF @COUNT_TCKN = 1 AND @COUNT_VKN = 0
BEGIN
SELECT DISTINCT A.TCKN AS TCKN_VKN,A.HES_NO,A.EK_NO,B.MAIN_BRANCH
FROM CUSTOMER_TABLE AS A
LEFT JOIN BRANCH_TABLE AS B ON A.HES_NO = B.HES_NO
END

INSERT INTO dbo.ERROR_LOGS(StringParameter,DateString)
VALUES('Stage 2',GETDATE())

IF @COUNT_TCKN = 0 AND @COUNT_VKN = 1
BEGIN
SELECT DISTINCT A.VKN AS TCKN_VKN,A.HES_NO,A.EK_NO,B.MAIN_BRANCH
FROM CUSTOMER_TABLE AS A
LEFT JOIN BRANCH_TABLE AS B ON A.HES_NO = B.HES_NO
END

INSERT INTO dbo.ERROR_LOGS(StringParameter,DateString)
VALUES('Stage 3',GETDATE())

IF @COUNT_TCKN = 1 AND @COUNT_VKN = 1
BEGIN
SELECT DISTINCT A.TCKN AS TCKN_VKN,A.HES_NO,A.EK_NO,B.MAIN_BRANCH
FROM CUSTOMER_TABLE AS A
LEFT JOIN BRANCH_TABLE AS B ON A.HES_NO = B.HES_NO

UNION ALL

SELECT DISTINCT A.VKN AS TCKN_VKN,A.HES_NO,A.EK_NO,B.MAIN_BRANCH
FROM CUSTOMER_TABLE AS A
LEFT JOIN BRANCH_TABLE AS B ON A.HES_NO = B.HES_NO
END

INSERT INTO dbo.ERROR_LOGS(StringParameter,DateString)
VALUES('Stage 4',GETDATE())

IF @COUNT_TCKN = 0 AND @COUNT_VKN = 0
BEGIN
SELECT COALESCE(B.MAIN_BRANCH, 'TOTAL') AS MAIN_BRANCH, COUNT(DISTINCT(A.HES_NO)) AS COUNT_HES_NO
FROM CUSTOMER_TABLE AS A
INNER JOIN BRANCH_TABLE AS B ON A.HES_NO = B.HES_NO
WHERE B.MAIN_BRANCH IN ('ISTANBUL','ANKARA','IZMIR')
GROUP BY B.MAIN_BRANCH WITH ROLLUP --The ROLLUP option allows you to include extra rows that represent the subtotals, which are commonly referred to as super-aggregate rows, along with the grand total row.
ORDER BY CASE WHEN B.MAIN_BRANCH = 'TOTAL' THEN 1 ELSE -COUNT_HES_NO END --Sorts grouped values from largest to smallest
END

END TRY
BEGIN CATCH

INSERT INTO dbo.ERROR_LOGS(StringParameter,DateString)
VALUES(ERROR_MESSAGE(),GETDATE()) --I am printing the error I caught into the table. Since it will be placed here last, the record before 'catch' in the table will show my last transaction. 
								  --So I can figure out if I made a mistake in the next step.

END CATCH
END

--I will print log records into this table. This way I can see where I'm getting the error.
CREATE TABLE dbo.ERROR_LOGS(
Id int identity(1,1),
StringParameter NVARCHAR(MAX),
DateString DATETIME
)