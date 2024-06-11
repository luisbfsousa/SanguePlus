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
CREATE PROCEDURE [dbo].[AdicionarStaff]
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
                IF @TipoPessoa IN ('E', 'M')
                BEGIN
                    INSERT INTO SanguePlus_Pessoa (Nome, Numero, Sexo, Idade, Contacto)
                    VALUES (@Nome, @Numero, @Sexo, @Idade, @Contacto);
                    INSERT INTO SanguePlus_Staff (NFuncionario)
                    VALUES (@Numero);
                    IF @TipoPessoa = 'E'
                    BEGIN
                        INSERT INTO SanguePlus_Enfermeiro (NEnfermeiro)
                        VALUES (@Numero);
                    END
                    ELSE IF @TipoPessoa = 'M'
                    BEGIN
                        INSERT INTO SanguePlus_Medico (NMedico, PassMed)
                        VALUES (@Numero, NULL);
                    END
                    
                    SET @Status = 'Funcionário adicionado.';
                END
                ELSE
                BEGIN
                    SET @Status = 'Tipo de pessoa inválido. Formatos válidos: [Exxxx] [Mxxxx]';
                END
            END
            ELSE
            BEGIN
                SET @Status = 'Número inválido. Formatos válidos: [Exxxx] [Mxxxx]';
            END
        END
        ELSE
        BEGIN
            SET @Status = 'A pessoa já existe.';
        END
    END TRY
    BEGIN CATCH
        SET @Status = 'Erro: ' + ERROR_MESSAGE();
    END CATCH
END
GO
-- DECLARE @Status varchar(512);
-- exec [dbo].[AdicionarStaff] @Nome='Kelvin', @Numero='P1001', @Sexo='M', @Idade=25, @Contacto=123456789, @Status=@Status OUTPUT;
-- PRINT @Status;

-----------Remover pessoa-----------
CREATE PROCEDURE [dbo].[RemoverPessoa]
    @Numero varchar(255),
    @Status varchar(512) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;
        IF EXISTS (SELECT 1 FROM SanguePlus_Medico WHERE NMedico = @Numero)
        BEGIN
            DELETE FROM SanguePlus_Medico WHERE NMedico = @Numero;
        END
        ELSE IF EXISTS (SELECT 1 FROM SanguePlus_Enfermeiro WHERE NEnfermeiro = @Numero)
        BEGIN
            DELETE FROM SanguePlus_Enfermeiro WHERE NEnfermeiro = @Numero;
        END
        ELSE IF EXISTS (SELECT 1 FROM SanguePlus_Dador WHERE NDador = @Numero)
        BEGIN
            DELETE FROM SanguePlus_FichaMedica
            WHERE NPaciente IN (SELECT NPaciente FROM SanguePlus_Paciente WHERE BolsaRecebida IN (SELECT ID FROM SanguePlus_Bolsa WHERE Dador = @Numero));
            DELETE FROM SanguePlus_Paciente 
            WHERE BolsaRecebida IN (SELECT ID FROM SanguePlus_Bolsa WHERE Dador = @Numero);
            DELETE FROM SanguePlus_Laboratorio 
            WHERE IDBolsa IN (SELECT ID FROM SanguePlus_Bolsa WHERE Dador = @Numero);
            DELETE FROM SanguePlus_Bolsa WHERE Dador = @Numero;
            DELETE FROM SanguePlus_CartaoDador WHERE NDador = @Numero;
            DELETE FROM SanguePlus_Dador WHERE NDador = @Numero;
            DELETE FROM SanguePlus_Staff WHERE NFuncionario = @Numero;
            DELETE FROM SanguePlus_Pessoa WHERE Numero = @Numero;
        END
        ELSE
        BEGIN
            IF EXISTS (SELECT 1 FROM SanguePlus_Pessoa WHERE Numero = @Numero)
            BEGIN
                DELETE FROM SanguePlus_FichaMedica WHERE NPaciente = @Numero;
                DELETE FROM SanguePlus_Paciente WHERE NPaciente = @Numero;
                DELETE FROM SanguePlus_Staff WHERE NFuncionario = @Numero;
                DELETE FROM SanguePlus_Pessoa WHERE Numero = @Numero;
            END
            ELSE
            BEGIN
                ROLLBACK TRANSACTION;
                SET @Status = 'Pessoa não encontrada';
                RETURN;
            END
        END
        COMMIT TRANSACTION;
        SET @Status = 'Pessoa removida';
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
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
        PRINT 'Erro: ' + ERROR_MESSAGE();
    END CATCH
END
GO
--exec dbo.PesquisarPessoa @Numero='P1001';

-----------Cartao Dador-----------
CREATE PROCEDURE [dbo].[RemoveCartao]
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
        SET @Status = 'Erroo ' + ERROR_MESSAGE();
    END CATCH
END
GO
-- DECLARE @Status varchar(512);
-- exec dbo.RemoveCartao @NDador='D001', @Status=@Status OUTPUT;
-- PRINT @Status;

-----------Adicionar Dador e criar o cartao dador-----------
CREATE PROCEDURE [dbo].[RegistoDador_Cartao]
    @Nome varchar(512),
    @Numero varchar(512),
    @Sexo varchar(512),
    @Idade int,
    @Contacto int,
    @TipoSangue varchar(512),
    @EntidadeFornecedor varchar(512),
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
        SET @Status = 'Erro ' + ERROR_MESSAGE();
    END CATCH
END
GO  --corrigir EntidadeFornecedora!!!!!
-- DECLARE @Status varchar(512);
-- EXEC dbo.RegistoDador_Cartao @Nome='Kelvin', @Numero='D1001', @Sexo='M', @Idade=25, @Contacto=123456789, @TipoSangue='A+', @EntidadeFornecedor='Sangue+', @Status=@Status OUTPUT;
-- PRINT @Status;

-----------Adiocionar Paciente e ficha medica-----------
CREATE PROCEDURE [dbo].[RegistoPaciente_Ficha]
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
            SET @Status = 'Numero invalido. Formato valido [Pxxxx]';
            RETURN;
        END
        IF NOT EXISTS (SELECT 1 FROM SanguePlus_Enfermeiro WHERE NEnfermeiro = @Tratador)
        BEGIN
            SET @Status = 'Tratador não encontrado';
            RETURN;
        END
        IF NOT EXISTS (SELECT 1 FROM SanguePlus_Bolsa WHERE ID = @BolsaRecebida)
        BEGIN
            SET @Status = 'BolsaRecebida não encontrada';
            RETURN;
        END
        IF NOT EXISTS (SELECT 1 FROM SanguePlus_Pessoa WHERE Numero = @Numero)
        BEGIN
            INSERT INTO SanguePlus_Pessoa (Nome, Numero, Sexo, Idade, Contacto)
            VALUES (@Nome, @Numero, @Sexo, @Idade, @Contacto);
        END
        IF NOT EXISTS (SELECT 1 FROM SanguePlus_Paciente WHERE NPaciente = @Numero)
        BEGIN
            INSERT INTO SanguePlus_Paciente (NPaciente, Tratador, BolsaRecebida)
            VALUES (@Numero, @Tratador, @BolsaRecebida);
        END
        IF NOT EXISTS (SELECT 1 FROM SanguePlus_FichaMedica WHERE NPaciente = @Numero)
        BEGIN
            INSERT INTO SanguePlus_FichaMedica (NPaciente, TipoSangue, Diagnostico, Tratamento, Emissor)
            VALUES (@Numero, @TipoSangue, ISNULL(@Diagnostico, ''), ISNULL(@Tratamento, ''), @Emissor);
            SET @Status = 'Paciente registado e Ficha medica criada';
        END
        ELSE
        BEGIN
            SET @Status = 'O paciente ja existe';
            RETURN;
        END
    END TRY
    BEGIN CATCH
        SET @Status = 'Erro: ' + ERROR_MESSAGE();
    END CATCH
END
GO
-- DECLARE @Status varchar(512);
--eXEC dbo.RegistoPaciente_Ficha @Nome='---------', @Numero='P2322', @Sexo='M', @Idade=30, @Contacto=987654321, @Tratador='E0001', @BolsaRecebida='B0001', @TipoSangue='O+', @Emissor='M0001', @Status=@Status OUTPUT;
-- PRINT @Status;

-----------Ver todas as fichas-----------
CREATE PROCEDURE [dbo].[VerFicha]
AS
BEGIN
    SET NOCOUNT ON;
    SELECT * FROM SanguePlus_FichaMedica;
END
GO
-- EXEC dbo.VerFicha;

-----------Ver Pacientes-----------
CREATE PROCEDURE [dbo].[VerPacientes]
AS
BEGIN
    SET NOCOUNT ON;
    SELECT * FROM SanguePlus_Paciente;
END
GO
-- EXEC dbo.VerPacientes;

-----------ver todas as fichas medicas por ordem de NPaciente-----------
CREATE PROCEDURE [dbo].[VerFicha_NPaciente]
AS
BEGIN
    SET NOCOUNT ON;
    SELECT * FROM SanguePlus_FichaMedica
    ORDER BY NPaciente;
END
GO
-- EXEC dbo.VerFicha_NPaciente;

-----------Ver todas os cartoes-----------
CREATE PROCEDURE [dbo].[VerCartao]
AS
BEGIN
    SET NOCOUNT ON;
    SELECT * FROM SanguePlus_CartaoDador;
END
GO
-- EXEC dbo.VerCartao;

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
CREATE PROCEDURE [dbo].[VerBolsas]
AS
BEGIN
    SET NOCOUNT ON;
    SELECT * FROM SanguePlus_Bolsa;
END
GO
-- EXEC dbo.VerBolsas;

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

CREATE PROCEDURE [dbo].[VerMedicosPassword]
AS
BEGIN
    SET NOCOUNT ON;
    SELECT * FROM SanguePlus_Medico;
END
GO
-- EXEC dbo.VerMedicosPassword;

CREATE PROCEDURE [dbo].[VerStaff]
AS
BEGIN
    SET NOCOUNT ON;
    SELECT * FROM SanguePlus_Staff;
END
GO
-- EXEC dbo.VerStaff;

CREATE PROCEDURE [dbo].[VerDador]
AS
BEGIN
    SET NOCOUNT ON;
    SELECT * FROM SanguePlus_Dador;
END
GO
-- EXEC dbo.VerDador;

-----------Definir Password do medico-----------
CREATE PROCEDURE [dbo].[RegistarPassword]
    @NMedico varchar(512),
    @PassMed varchar(512),
    @Status varchar(512) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        IF EXISTS (SELECT 1 FROM SanguePlus_Medico WHERE NMedico = @NMedico)
        BEGIN
            IF EXISTS (SELECT 1 FROM SanguePlus_Medico WHERE NMedico = @NMedico AND (PassMed IS NULL OR PassMed = ''))
            BEGIN
                UPDATE SanguePlus_Medico
                SET PassMed = HASHBYTES('SHA2_256', @PassMed)
                WHERE NMedico = @NMedico;
                SET @Status = 'Password registada';
            END
            ELSE
            BEGIN
                SET @Status = 'O Medico ja tem password';
            END
        END
        ELSE
        BEGIN
            SET @Status = 'Medico Inexistente';
        END
    END TRY
    BEGIN CATCH
        SET @Status = 'Erro: ' + ERROR_MESSAGE();
    END CATCH
END
GO
--DECLARE @Status varchar(512);
--EXEC dbo.RegistarPassword @NMedico='M1001', @PassMed='NewSecurePass123', @Status=@Status OUTPUT;
--PRINT @Status;

-----------Completar Ficha Por Password-----------
CREATE PROCEDURE [dbo].[AtualizarFicha]
    @NMedico varchar(512),
    @PassMed varchar(512),
    @NPaciente varchar(512),
    @Diagnostico varchar(512) = NULL,
    @Tratamento varchar(512) = NULL,
    @Status varchar(512) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (SELECT 1 FROM SanguePlus_Medico WHERE NMedico = @NMedico AND PassMed = HASHBYTES('SHA2_256', @PassMed))
    BEGIN
        IF EXISTS (
            SELECT 1 
            FROM SanguePlus_FichaMedica 
            WHERE NPaciente = @NPaciente 
            AND Emissor = @NMedico
        )
        BEGIN
            BEGIN TRY
                -- Update the medical record
                UPDATE SanguePlus_FichaMedica
                SET Diagnostico = ISNULL(@Diagnostico, Diagnostico),
                    Tratamento = ISNULL(@Tratamento, Tratamento)
                WHERE NPaciente = @NPaciente;
                SET @Status = 'Ficha Medica atualizada com sucesso.';
            END TRY
            BEGIN CATCH
                SET @Status = 'Erro: ' + ERROR_MESSAGE();
            END CATCH
        END
        ELSE
        BEGIN
            SET @Status = 'O Medico nao esta autorizado a atualizar a Ficha Medica do paciente.';
        END
    END
    ELSE
    BEGIN
        SET @Status = 'Credenciais invalidas.';
    END
END
GO
-- DECLARE @Status varchar(512);
-- EXEC dbo.AtualizarFicha @NMedico = 'M0001', @PassMed = 'IamJoseMourinho', @NPaciente = 'P0001', @Diagnostico = '??????', @Tratamento = '????', @Status = @Status OUTPUT;
-- PRINT @Status;

-----------verpessoas-----------
CREATE PROCEDURE [dbo].[VerPessoas_Pacientes]
    @PessoaNum varchar(50)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        SELECT * FROM [SanguePlus_Pessoa] WHERE Numero = @PessoaNum;
    END TRY
    BEGIN CATCH
        PRINT 'Erro: ' + ERROR_MESSAGE();
    END CATCH
END
GO
--exec [dbo].[VerPessoas_Pacientes] @PessoaNum = 'Pxxxx'

-----------Registar valores nas bolsas-----------
CREATE PROCEDURE RegistarResultados
    @IDBolsa varchar(50),
    @HIV varchar(50) = NULL,
    @Colesterol int = NULL
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM SanguePlus_Laboratorio WHERE IDBolsa = @IDBolsa)
    BEGIN
        SELECT 'Bolsa Inexistente' AS Message;
        RETURN;
    END

    IF @HIV IS NOT NULL AND @HIV NOT IN ('Positivo', 'Negativo')
    BEGIN
        SELECT 'Resultados possíveis,  "Postivo" ou "Negativo"' AS Message;
        RETURN;
    END

    IF @Colesterol IS NOT NULL AND (@Colesterol < 0 OR @Colesterol > 300)
    BEGIN
        SELECT 'Valores válidos para o colestrol [0..300]' AS Message;
        RETURN;
    END

    IF EXISTS (SELECT 1 FROM SanguePlus_Laboratorio WHERE IDBolsa = @IDBolsa AND (HIV IS NULL OR HIV = '' OR Colesterol IS NULL))
    BEGIN
        UPDATE SanguePlus_Laboratorio
        SET HIV = ISNULL(@HIV, HIV),
            Colesterol = ISNULL(@Colesterol, Colesterol)
        WHERE IDBolsa = @IDBolsa;
    END
    ELSE
    BEGIN
        SELECT 'Resultados finais, não é possível mudar' AS Message;
    END
END

--exec RegistarResultados @IDBolsa = 'B0003', @HIV = 'Negativo', @Colesterol = 200;