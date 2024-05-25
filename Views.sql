CREATE VIEW LaboratorioBloodBagInfo AS
SELECT ID,DataValidade,TipoSangue
FROM 
    SanguePlus_Bolsa;
GO

--SELECT * FROM LaboratorioBloodBagInfo;
--o q o laboratorio ve

CREATE VIEW VerMedicos AS
SELECT NMedico
FROM 
    SanguePlus_Medico;
GO

--SELECT * FROM VerMedicos;