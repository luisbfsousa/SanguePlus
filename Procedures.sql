-----------Ver todas as pessoas-----------
CREATE PROCEDURE [dbo].[VerPessoas]
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        SELECT * FROM [SanguePlus_Pessoa];
    END TRY
    BEGIN CATCH
        PRINT 'Erro: ' + ERROR_MESSAGE();
    END CATCH
END
GO
--exec [dbo].[VerPessoas]

-----------Adicionar pessoa-----------
CREATE PROCEDURE [dbo].[AdicionarPessoa]
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
            IF LEN(@Numero) = 5 AND ISNUMERIC(SUBSTRING(@Numero, 2, LEN(@Numero))) = 1 AND CHARINDEX(' ', @Numero) = 0
            BEGIN
                DECLARE @TipoPessoa varchar(1) = LEFT(@Numero, 1);
                INSERT INTO SanguePlus_Pessoa (Nome, Numero, Sexo, Idade, Contacto)
                VALUES (@Nome, @Numero, @Sexo, @Idade, @Contacto);
                
                IF @TipoPessoa = 'E'
                BEGIN
                    INSERT INTO SanguePlus_Staff (NFuncionario)
                    VALUES (@Numero);

                    INSERT INTO SanguePlus_Enfermeiro (NEnfermeiro)
                    VALUES (@Numero);
                END
                ELSE IF @TipoPessoa = 'M'
                BEGIN
                    INSERT INTO SanguePlus_Staff (NFuncionario)
                    VALUES (@Numero);

                    INSERT INTO SanguePlus_Medico (NMedico)
                    VALUES (@Numero);
                END
                ELSE IF @TipoPessoa = 'D'
                BEGIN
                    INSERT INTO SanguePlus_Dador (NDador)
                    VALUES (@Numero);
                END
                ELSE IF @TipoPessoa = 'P'
                BEGIN
                    INSERT INTO SanguePlus_Paciente (NPaciente)
                    VALUES (@Numero);
                END
                ELSE
                BEGIN
                    SET @Status = 'Tipo de pessoa invalido. Formatos validos: [Dxxxx] [Pxxxx] [Exxxx] [Mxxxx]';
                    RETURN;
                END
                SET @Status = 'Pessoa adicionada.';
            END
            ELSE
            BEGIN
                SET @Status = 'Numero invalido. Formatos validos: [Dxxxx] [Pxxxx] [Exxxx] [Mxxxx]';
            END
        END
        ELSE
        BEGIN
            SET @Status = 'A Pessoa ja existe.';
        END
    END TRY
    BEGIN CATCH
        SET @Status = 'Erro: ' + ERROR_MESSAGE();
    END CATCH
END
GO
-- DECLARE @Status varchar(512);
-- exec [dbo].[AdicionarPessoa] @Nome='Kelvin', @Numero='P1001', @Sexo='M', @Idade=25, @Contacto=123456789, @Status=@Status OUTPUT;
-- PRINT @Status;

-----------Remover pessoa-----------
CREATE PROCEDURE [dbo].[RemoverPessoa]
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
-- exec dbo.RemoverPessoa @Numero='P1001', @Status=@Status OUTPUT;
-- PRINT @Status;


-----Pesquisar pessoa-----
CREATE PROCEDURE [dbo].[PesquisarPessoa]
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
--exec dbo.PesquisarPessoa @Numero='P1001';


-----------Cartao Dador-----------
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

-----------Adicionar Dador e criar o cartao dador-----------
CREATE PROCEDURE [dbo].[RegistoDador_CartaoDador]
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
        IF LEFT(@Numero, 1) != 'D' OR LEN(@Numero) != 5 OR ISNUMERIC(SUBSTRING(@Numero, 2, LEN(@Numero) - 1)) = 0
        BEGIN
            SET @Status = 'Numero invalido. Formarto valido [Dxxxx]';
            RETURN;
        END

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

        IF NOT EXISTS (SELECT 1 FROM SanguePlus_CartaoDador WHERE NDador = @Numero)
        BEGIN
            INSERT INTO SanguePlus_CartaoDador (NDador, Nome, TipoSangue, EntidadeFornecedor)
            VALUES (@Numero, @Nome, @TipoSangue, @EntidadeFornecedor);
            SET @Status = 'Cartao Dador criado';
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
-- DECLARE @Status varchar(512);
-- EXEC dbo.RegistoDador_CartaoDador @Nome='Kelvin', @Numero='D1001', @Sexo='M', @Idade=25, @Contacto=123456789, @TipoSangue='A+', @EntidadeFornecedor='Sangue+', @Status=@Status OUTPUT;
-- PRINT @Status;

-----------Adiocionar Paciente e ficha medica-----------
CREATE PROCEDURE [dbo].[RegistoPaciente_FichaMedica]
    @Nome varchar(512),
    @Numero varchar(512),
    @Sexo varchar(512),
    @Idade int,
    @Contacto int,
    @Tratador varchar(512),
    @BolsaRecebida varchar(512),
    @TipoSangue varchar(512),
    @Diagnostico varchar(512) = NULL,
    @Tratamento varchar(512) = NULL,
    @Emissor varchar(512),
    @Status varchar(512) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        IF LEFT(@Numero, 1) != 'P' OR LEN(@Numero) != 5 OR ISNUMERIC(SUBSTRING(@Numero, 2, LEN(@Numero) - 1)) = 0
        BEGIN
            SET @Status = 'Numero invalido. Formarto valido [Pxxxx]';
            RETURN;
        END

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
-- DECLARE @Status varchar(512);
-- EXEC dbo.RegistoPaciente_FichaMedica @Nome='Fatima', @Numero='P1112', @Sexo='M', @Idade=30, @Contacto=987654321, @Tratador='E001', @BolsaRecebida='B001', @TipoSangue='O+', @Emissor='M001', @Status=@Status OUTPUT;
-- PRINT @Status;

-----------Ver todas as fichas-----------
CREATE PROCEDURE [dbo].[VerFichaMedica]
AS
BEGIN
    SET NOCOUNT ON;
    SELECT * FROM SanguePlus_FichaMedica;
END
GO
-- EXEC dbo.VerFichaMedica;

-----------ver todas as fichas medicas por ordem de NPaciente-----------
CREATE PROCEDURE [dbo].[FichaMedica_NPaciente]
AS
BEGIN
    SET NOCOUNT ON;
    SELECT * FROM SanguePlus_FichaMedica
    ORDER BY NPaciente;
END
GO
-- EXEC dbo.FichaMedica_NPaciente;

-----------Ver todas os cartoes-----------
CREATE PROCEDURE [dbo].[VerCartaoDador]
AS
BEGIN
    SET NOCOUNT ON;
    SELECT * FROM SanguePlus_CartaoDador;
END
GO
-- EXEC dbo.VerCartaoDador;

-----------ver todos os cartoes dador por ordem de NDador-----------
CREATE PROCEDURE [dbo].[CartaoDador_NDador]
AS
BEGIN
    SET NOCOUNT ON;
    SELECT * FROM SanguePlus_CartaoDador
    ORDER BY NDador;
END
GO
-- EXEC dbo.CartaoDador_NDador;

-----------Ver todas as bolsas-----------
CREATE PROCEDURE [dbo].[VerBolsasSangue]
AS
BEGIN
    SET NOCOUNT ON;
    SELECT * FROM SanguePlus_Bolsa;
END
GO
-- EXEC dbo.VerBolsasSangue;

-----------Ver laboratorio-----------
CREATE PROCEDURE [dbo].[VerLaboratorio]
AS
BEGIN
    SET NOCOUNT ON;
    SELECT * FROM SanguePlus_Laboratorio;
END
GO
-- EXEC dbo.VerLaboratorio;

-----------Ver enfermeiros e staff(nao se vai usar, so para testar umas coisas)-----------
CREATE PROCEDURE [dbo].[VerEnfermeiros]
AS
BEGIN
    SET NOCOUNT ON;
    SELECT * FROM SanguePlus_Enfermeiro;
END
GO
-- EXEC dbo.VerEnfermeiros;

CREATE PROCEDURE [dbo].[VerStaff]
AS
BEGIN
    SET NOCOUNT ON;
    SELECT * FROM SanguePlus_Staff;
END
GO
-- EXEC dbo.VerStaff;
