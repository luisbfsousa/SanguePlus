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

CREATE TRIGGER MEDICCC
ON SanguePlus_Medico
INSTEAD OF DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Numero varchar(255);
    DECLARE @NewEmissor varchar(255);

    SELECT @Numero = NMedico FROM deleted;
    SELECT TOP 1 @NewEmissor = NMedico
    FROM SanguePlus_Medico
    WHERE NMedico != @Numero;

    IF @NewEmissor IS NULL
    BEGIN
        RAISERROR('Erro: É preciso pelo menos um Medico registado', 16, 1);
        RETURN;
    END

    BEGIN TRY
        BEGIN TRANSACTION;
        UPDATE SanguePlus_FichaMedica SET Emissor = @NewEmissor WHERE Emissor = @Numero;
        DELETE FROM SanguePlus_Medico WHERE NMedico = @Numero;
        DELETE FROM SanguePlus_Staff WHERE NFuncionario = @Numero;
        DELETE FROM SanguePlus_Pessoa WHERE Numero = @Numero;
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END
GO

CREATE TRIGGER NURSEEE
ON SanguePlus_Enfermeiro
INSTEAD OF DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Numero varchar(255);
    DECLARE @NewEnfermeiro varchar(255);

    SELECT @Numero = NEnfermeiro FROM deleted;
    SELECT TOP 1 @NewEnfermeiro = NEnfermeiro
    FROM SanguePlus_Enfermeiro
    WHERE NEnfermeiro != @Numero;

    IF @NewEnfermeiro IS NULL
    BEGIN
        RAISERROR('Erro: É preciso pelo menos um Enfermeiro registado', 16, 1);
        RETURN;
    END

    BEGIN TRY
        BEGIN TRANSACTION;
        UPDATE SanguePlus_Paciente SET Tratador = @NewEnfermeiro WHERE Tratador = @Numero;
        UPDATE SanguePlus_Bolsa SET Coletor = @NewEnfermeiro WHERE Coletor = @Numero;
        DELETE FROM SanguePlus_Enfermeiro WHERE NEnfermeiro = @Numero;
        DELETE FROM SanguePlus_Staff WHERE NFuncionario = @Numero;
        DELETE FROM SanguePlus_Pessoa WHERE Numero = @Numero;
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END
GO

CREATE TRIGGER ApagarDadorBolsa
ON SanguePlus_Dador
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;
    DELETE FROM SanguePlus_Bolsa WHERE Dador IN (SELECT NDador FROM deleted);
END
GO

CREATE TRIGGER ApagarDadorPaciente
ON SanguePlus_Dador
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;
    DELETE FROM SanguePlus_Paciente WHERE BolsaRecebida IN (SELECT ID FROM SanguePlus_Bolsa WHERE Dador IN (SELECT NDador FROM deleted));
    DELETE FROM SanguePlus_Dador WHERE NDador IN (SELECT NDador FROM deleted);
END
GO

CREATE TRIGGER ApagarDador
ON SanguePlus_Dador
INSTEAD OF DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @NDador varchar(255);

    SELECT @NDador = NDador FROM deleted;

    BEGIN TRY
        BEGIN TRANSACTION;
        UPDATE SanguePlus_Paciente 
        SET BolsaRecebida = NULL 
        WHERE BolsaRecebida IN (SELECT ID FROM SanguePlus_Bolsa WHERE Dador = @NDador);

        DELETE FROM SanguePlus_Laboratorio 
        WHERE IDBolsa IN (SELECT ID FROM SanguePlus_Bolsa WHERE Dador = @NDador);

        DELETE FROM SanguePlus_Bolsa WHERE Dador = @NDador;
        DELETE FROM SanguePlus_CartaoDador WHERE NDador = @NDador;
        DELETE FROM SanguePlus_Dador WHERE NDador = @NDador;
        DELETE FROM SanguePlus_Staff WHERE NFuncionario = @NDador;
        DELETE FROM SanguePlus_Pessoa WHERE Numero = @NDador;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END
GO