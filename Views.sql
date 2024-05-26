CREATE VIEW VisaoLaboratorio AS
SELECT ID,DataValidade,TipoSangue
FROM 
    SanguePlus_Bolsa;
GO

--SELECT * FROM VisaoLaboratorio;
--o q o laboratorio ve (podemos fzr do genero envio desta informacao para o laboratorio, que depois retornara os resultados)

CREATE VIEW VisaoMedicos AS
SELECT NMedico
FROM 
    SanguePlus_Medico;
GO

--SELECT * FROM VisaoMedicos;
--Para ver os medicos sem mostrar a password

CREATE VIEW VisaoBolsasTestadas AS
SELECT Numero,IDBolsa
FROM 
    SanguePlus_Laboratorio;
GO
--SELECT * FROM VisaoBolsasTestadas;