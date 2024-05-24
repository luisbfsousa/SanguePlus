DECLARE @sql NVARCHAR(MAX) = '';

SELECT @sql += 'DROP VIEW ' + QUOTENAME(SCHEMA_NAME(schema_id)) + '.' + QUOTENAME(name) + '; '
FROM sys.views;

EXEC sp_executesql @sql;