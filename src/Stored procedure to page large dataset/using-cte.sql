-- Using a Common Table Expression (CTE)

CREATE PROCEDURE dbo.sp_load_data_cte
(
  @Page int,
  @RecsPerPage int
)
AS
  -- The number of rows affected by the different commands
  -- does not interest the application, so turn NOCOUNT ON
  SET NOCOUNT ON

  -- Determine the first record and last record 
  DECLARE @FirstRec int = 0
  DECLARE @LastRec int = 0

  SELECT @FirstRec = (@Page - 1) * @RecsPerPage
  SELECT @LastRec = (@Page * @RecsPerPage + 1);

  WITH TempResult as
  (
    SELECT       
      con.FirstName, con.LastName, emp.Title,
      ROW_NUMBER() OVER(ORDER BY con.ContactID DESC) as RowNum
    FROM 
      Person.Contact con
      JOIN HumanResources.Employee emp ON con.ContactID = emp.ContactID
  )
  SELECT TOP (@LastRec-1) *
  FROM TempResult
  WHERE RowNum > @FirstRec AND RowNum < @LastRec

  SET NOCOUNT OFF
  
GO
