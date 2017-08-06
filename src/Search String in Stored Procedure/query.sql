--======================================================
-- Searching for Empoloyee table
--======================================================
SELECT DISTINCT 
  o.name AS OBJECT_NAME,
  o.type_desc, 
  SCHEMA_NAME(schema_id) AS SCHEMA_NAME
FROM 
  sys.sql_modules m 
  INNER JOIN sys.objects o ON m.object_id = o.object_id
WHERE 
  m.definition Like '%Employee%';
