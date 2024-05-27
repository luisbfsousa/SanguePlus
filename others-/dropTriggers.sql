DROP TRIGGER TirarMedicoDaFicha;
DROP TRIGGER MEDICCC;
DROP TRIGGER NURSEEE;
DROP TRIGGER ApagarDadorBolsa;
DROP TRIGGER ApagarDadorPaciente;

DECLARE @sql NVARCHAR(MAX) = N'';

SELECT @sql += N'DROP TRIGGER ' + QUOTENAME(name) + ';
'
FROM sys.triggers;

PRINT @sql; -- This is optional, it allows you to review the SQL statements that will be executed

-- Once you've reviewed the SQL, you can uncomment the line below to execute the commands
-- EXEC sp_executesql @sql;
