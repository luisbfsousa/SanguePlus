CREATE VIEW LabBloodBagInfo AS
SELECT 
    ID AS IDBolsa,
    Dador,
    DataValidade
FROM 
    SanguePlus_Bolsa;
GO