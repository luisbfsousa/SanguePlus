DROP TABLE IF EXISTS SanguePlus_Laboratorio;
DROP TABLE IF EXISTS SanguePlus_FichaMedica;
DROP TABLE IF EXISTS SanguePlus_Medico;
DROP TABLE IF EXISTS SanguePlus_Paciente;
DROP TABLE IF EXISTS SanguePlus_Bolsa;
DROP TABLE IF EXISTS SanguePlus_Enfermeiro;
DROP TABLE IF EXISTS SanguePlus_CartaoDador;
DROP TABLE IF EXISTS SanguePlus_Dador;
DROP TABLE IF EXISTS SanguePlus_Staff;
DROP TABLE IF EXISTS SanguePlus_Pessoa;
GO

DROP VIEW VisaoLaboratorio;
DROP VIEW VisaoMedicos;
DROP VIEW VisaoBolsasTestadas;
GO

--DROP TRIGGER TirarMedicoDaFicha;
--DROP TRIGGER MEDICCC;
--DROP TRIGGER NURSEEE;
--DROP TRIGGER ApagarDadorBolsa;
--DROP TRIGGER ApagarDadorPaciente;
--DROP TRIGGER ApagarDador;
--GO

DECLARE @sql NVARCHAR(MAX) = '';

SELECT @sql += 'DROP PROCEDURE ' + QUOTENAME(SCHEMA_NAME(schema_id)) + '.' + QUOTENAME(name) + '; '
FROM sys.procedures;

EXEC sp_executesql @sql;
GO

DROP FUNCTION dbo.DatasBolsas;
GO