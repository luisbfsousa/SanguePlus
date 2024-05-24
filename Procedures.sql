-----------Pessoas------------

-----Ver todas as pessoas-----

CREATE PROCEDURE [dbo].[getPessoas]
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        SELECT * FROM [SanguePlus_Pessoa];
    END TRY
    BEGIN CATCH
        -- Handle error
        PRINT 'Occoreu um erro: ' + ERROR_MESSAGE();
    END CATCH
END
GO

--exec [dbo].[getPessoas]


-----Adicionar pessoa-----

CREATE PROCEDURE [dbo].[AddPessoa]
    @Nome varchar(512),
    @Numero varchar(512),
    @Sexo varchar(512),
    @Idade int,
    @Contacto int,
    @Status varchar(512) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        IF NOT EXISTS (SELECT 1 FROM SanguePlus_Pessoa WHERE Numero = @Numero)
        BEGIN
            INSERT INTO SanguePlus_Pessoa (Nome, Numero, Sexo, Idade, Contacto)
            VALUES (@Nome, @Numero, @Sexo, @Idade, @Contacto);
            SET @Status = 'Pessoa adicionada.';
        END
        ELSE
        BEGIN
            SET @Status = 'A Pessoa ja existe.';
        END
    END TRY
    BEGIN CATCH
        -- Handle error
        SET @Status = 'Erro: ' + ERROR_MESSAGE();
    END CATCH
END
GO

-- DECLARE @Status varchar(512);
-- exec [dbo].[AddPessoa] @Nome='Kelvin', @Numero='P010', @Sexo='M', @Idade=25, @Contacto=123456789, @Status=@Status OUTPUT;
-- PRINT @Status;

--exec [dbo].[AddPessoa] @Nome='Kelvin',@Numero='P010',@Sexo='M',@Idade='25',@Contacto='123456789';


-----Remover pessoa-----
CREATE PROCEDURE [dbo].[RemovePessoa]
    @Numero varchar(255),
    @Status varchar(512) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        DELETE FROM SanguePlus_Pessoa WHERE Numero = @Numero;
        IF @@ROWCOUNT = 0
        BEGIN
            SET @Status = 'Pessoa não encontrada';
        END
        ELSE
        BEGIN
            SET @Status = 'Pessoa removida';
        END
    END TRY
    BEGIN CATCH
        -- Handle error
        SET @Status = 'Erro: ' + ERROR_MESSAGE();
    END CATCH
END
GO

-- DECLARE @Status varchar(512);
-- exec dbo.RemovePessoa @Numero='P002', @Status=@Status OUTPUT;
-- PRINT @Status;


-----Pesquisar pessoa-----
CREATE PROCEDURE [dbo].[SearchPessoa]
    @Numero varchar(255)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        SELECT * FROM SanguePlus_Pessoa WHERE Numero = @Numero;
    END TRY
    BEGIN CATCH
        -- Handle error
        PRINT 'Erro: ' + ERROR_MESSAGE();
    END CATCH
END
GO

--exec dbo.SearchPessoa @Numero='M001';


-----------Cartao Dador------------

CREATE PROCEDURE [dbo].[RemoveCartaoDador]
    @NDador varchar(512),
    @Status varchar(512) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        DELETE FROM SanguePlus_CartaoDador WHERE NDador = @NDador;
        
        IF @@ROWCOUNT = 0
        BEGIN
            SET @Status = 'Cartao Dador nao encontrado';
        END
        ELSE
        BEGIN
            SET @Status = 'Cartao Dador removido';
        END
    END TRY
    BEGIN CATCH
        -- Handle error
        SET @Status = 'Erroo ' + ERROR_MESSAGE();
    END CATCH
END
GO

-- DECLARE @Status varchar(512);
-- exec dbo.RemoveCartaoDador @NDador='D001', @Status=@Status OUTPUT;
-- PRINT @Status;

-----------Adicionar Dador e criar o cartao dador------------

CREATE PROCEDURE [dbo].[AddDadorWithCartao]
    @Nome varchar(512),
    @Numero varchar(512),
    @Sexo varchar(512),
    @Idade int,
    @Contacto int,
    @TipoSangue varchar(512),
    @EntidadeFornecedor int,
    @Status varchar(512) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        -- Validate Numero starts with "D" for Dador
        IF LEFT(@Numero, 1) != 'D'
        BEGIN
            SET @Status = 'Para ser Dador o numero precisa de comecar com D';
            RETURN;
        END

        -- Step 1: Add the person to SanguePlus_Pessoa
        IF NOT EXISTS (SELECT 1 FROM SanguePlus_Pessoa WHERE Numero = @Numero)
        BEGIN
            INSERT INTO SanguePlus_Pessoa (Nome, Numero, Sexo, Idade, Contacto)
            VALUES (@Nome, @Numero, @Sexo, @Idade, @Contacto);
        END
        ELSE
        BEGIN
            SET @Status = 'A pessoa ja existe';
            RETURN;
        END

        -- Step 2: Add the donor to SanguePlus_Dador
        IF NOT EXISTS (SELECT 1 FROM SanguePlus_Dador WHERE NDador = @Numero)
        BEGIN
            INSERT INTO SanguePlus_Dador (NDador)
            VALUES (@Numero);
        END
        ELSE
        BEGIN
            SET @Status = 'O dador ja existe';
            RETURN;
        END

        -- Step 3: Create Cartao Dador
        IF NOT EXISTS (SELECT 1 FROM SanguePlus_CartaoDador WHERE NDador = @Numero)
        BEGIN
            INSERT INTO SanguePlus_CartaoDador (NDador, Nome, TipoSangue, EntidadeFornecedor)
            VALUES (@Numero, @Nome, @TipoSangue, @EntidadeFornecedor);
            SET @Status = 'Success: Dador and Cartao Dador created.';
        END
        ELSE
        BEGIN
            SET @Status = 'O cartao dador ja existe';
        END
    END TRY
    BEGIN CATCH
        -- Handle error
        SET @Status = 'Erro ' + ERROR_MESSAGE();
    END CATCH
END
GO

-- Example usage:
-- DECLARE @Status varchar(512);
-- EXEC dbo.AddDadorWithCartao @Nome='Kelvin', @Numero='D010', @Sexo='M', @Idade=25, @Contacto=123456789, @TipoSangue='A+', @EntidadeFornecedor=1, @Status=@Status OUTPUT;
-- PRINT @Status;

-----------Adiocionar Paciente e ficha medica------------
CREATE PROCEDURE [dbo].[AddPacienteWithFichaMedica]
    @Nome varchar(512),
    @Numero varchar(512),
    @Sexo varchar(512),
    @Idade int,
    @Contacto int,
    @Tratador varchar(512),
    @BolsaRecebida varchar(512), -- Change this line
    @TipoSangue varchar(512),
    @Diagnostico varchar(512) = NULL,
    @Tratamento varchar(512) = NULL,
    @Emissor varchar(512),
    @Status varchar(512) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        -- Validate Numero starts with "P" for Paciente
        IF LEFT(@Numero, 1) != 'P'
        BEGIN
            SET @Status = 'Para ser paciente o numero precisa de comecar com P';
            RETURN;
        END

        -- Step 1: Add the person to SanguePlus_Pessoa
        IF NOT EXISTS (SELECT 1 FROM SanguePlus_Pessoa WHERE Numero = @Numero)
        BEGIN
            INSERT INTO SanguePlus_Pessoa (Nome, Numero, Sexo, Idade, Contacto)
            VALUES (@Nome, @Numero, @Sexo, @Idade, @Contacto);
        END
        ELSE
        BEGIN
            SET @Status = 'A pessoa ja existe';
            RETURN;
        END

        -- Step 2: Add the patient to SanguePlus_Paciente
        IF NOT EXISTS (SELECT 1 FROM SanguePlus_Paciente WHERE NPaciente = @Numero)
        BEGIN
            IF EXISTS (SELECT 1 FROM SanguePlus_Bolsa WHERE ID = @BolsaRecebida)
            BEGIN
                INSERT INTO SanguePlus_Paciente (NPaciente, Tratador, BolsaRecebida)
                VALUES (@Numero, @Tratador, @BolsaRecebida);
            END
            ELSE
            BEGIN
                SET @Status = 'A bolsa de sangue não existe';
                RETURN;
            END
        END
        ELSE
        BEGIN
            SET @Status = 'O paciente ja existe';
            RETURN;
        END

        -- Step 3: Create Ficha Medica
        IF NOT EXISTS (SELECT 1 FROM SanguePlus_FichaMedica WHERE NPaciente = @Numero)
        BEGIN
            INSERT INTO SanguePlus_FichaMedica (NPaciente, TipoSangue, Diagnostico, Tratamento, Emissor)
            VALUES (@Numero, @TipoSangue, ISNULL(@Diagnostico, ''), ISNULL(@Tratamento, ''), @Emissor);
            SET @Status = 'Paciente registado e Ficha medica criada';
        END
        ELSE
        BEGIN
            SET @Status = 'A ficha medica ja existe';
        END
    END TRY
    BEGIN CATCH
        -- Handle error
        SET @Status = 'Error: ' + ERROR_MESSAGE();
    END CATCH
END
GO

-- Example usage:
-- DECLARE @Status varchar(512);
-- EXEC dbo.AddPacienteWithFichaMedica @Nome='John Doe', @Numero='P001', @Sexo='M', @Idade=30, @Contacto=987654321, @Tratador='E001', @BolsaRecebida=1, @TipoSangue='O+', @Emissor='M001', @Status=@Status OUTPUT;
-- PRINT @Status;

-----------Medico atualiza a ficha medica com tratamento e diagnostico------------

CREATE PROCEDURE [dbo].[UpdateFichaMedica]
    @NPaciente varchar(512),
    @Tratamento varchar(512),
    @Diagnostico varchar(512),
    @Status varchar(512) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        -- Check if the user is authorized (you may need to implement authentication and authorization)
        -- For example, you might have a table of authorized users or roles
        -- For simplicity, let's assume the user executing the procedure is always authorized
        
        -- Update the Ficha Medica
        UPDATE SanguePlus_FichaMedica
        SET Tratamento = @Tratamento,
            Diagnostico = @Diagnostico
        WHERE NPaciente = @NPaciente;
        
        SET @Status = 'Ficha medica atualizada com sucesso';
    END TRY
    BEGIN CATCH
        -- Handle error
        SET @Status = 'Error: ' + ERROR_MESSAGE();
    END CATCH
END
GO

--DECLARE @Status varchar(512);
--EXEC UpdateFichaMedica @NPaciente = 'P001', @Tratamento = 'New treatment information',  @Diagnostico = 'New diagnosis information', @Status = @Status OUTPUT;
--PRINT @Status;


-----------ver todas as fichas medicas por ordem de NPaciente------------
CREATE PROCEDURE [dbo].[GetAllFichasMedicasPorNumeroPaciente]
AS
BEGIN
    SET NOCOUNT ON;
    SELECT * FROM SanguePlus_FichaMedica
    ORDER BY NPaciente;
END
GO

-- EXEC dbo.GetAllFichasMedicas;

-----------ver todos os cartoes dador por ordem de NDador------------
CREATE PROCEDURE [dbo].[GetAllCartoesDadorPorNumeroDador]
AS
BEGIN
    SET NOCOUNT ON;
    SELECT * FROM SanguePlus_CartaoDador
    ORDER BY NDador;
END
GO

-- Example usage:
-- EXEC dbo.GetAllCartoesDador;

-----------???------------

-----------???------------
