DECLARE @sql NVARCHAR(MAX) = '';

SELECT @sql += 'DROP PROCEDURE ' + QUOTENAME(SCHEMA_NAME(schema_id)) + '.' + QUOTENAME(name) + '; '
FROM sys.procedures;

EXEC sp_executesql @sql;