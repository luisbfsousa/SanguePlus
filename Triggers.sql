CREATE TRIGGER TirarMedicoDaFicha
ON SanguePlus_Medico
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE SanguePlus_FichaMedica
    SET Emissor = NULL
    WHERE Emissor IN (SELECT NMedico FROM deleted);
END
GO