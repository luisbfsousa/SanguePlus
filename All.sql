---------------------------------Tabelas---------------------------------
CREATE TABLE SanguePlus_Pessoa(
    Nome varchar(512) NOT NULL,
    Numero varchar(512) NOT NULL,
    Sexo varchar(512) NOT NULL,
    Idade int NOT NULL,
    Contacto int NOT NULL,
    PRIMARY KEY (Numero)
)
GO

CREATE TABLE SanguePlus_Staff(
    NFuncionario  varchar(512) NOT NULL,
    PRIMARY KEY (NFuncionario),
    FOREIGN KEY (NFuncionario) REFERENCES SanguePlus_Pessoa(Numero)
)
GO

CREATE TABLE SanguePlus_Dador(
    NDador varchar(512) NOT NULL,
    PRIMARY KEY (NDador),
    FOREIGN KEY (NDador) REFERENCES SanguePlus_Pessoa(Numero)
)
GO

CREATE TABLE SanguePlus_CartaoDador(
    NDador varchar(512) NOT NULL,
    Nome varchar(512) NOT NULL,
    TipoSangue varchar(512) NOT NULL,
    EntidadeFornecedor varchar(512) NOT NULL,
    PRIMARY KEY (NDador),
    FOREIGN KEY (NDador) REFERENCES SanguePlus_Dador(NDador),
)
GO

CREATE TABLE SanguePlus_Enfermeiro(
    NEnfermeiro varchar(512) NOT NULL,
    PRIMARY KEY (NEnfermeiro),
    FOREIGN KEY (NEnfermeiro) REFERENCES SanguePlus_Staff(NFuncionario)
)
GO

CREATE TABLE SanguePlus_Bolsa(
    ID varchar(512) NOT NULL,
    DataValidade varchar(512) NOT NULL,
    TipoSangue varchar(512) NOT NULL,
    Dador varchar(512) NOT NULL,
    Coletor varchar(512) NOT NULL,
    PRIMARY KEY (ID),
    FOREIGN KEY (Dador) REFERENCES SanguePlus_Dador(NDador),
    FOREIGN KEY (Coletor) REFERENCES SanguePlus_Enfermeiro(NEnfermeiro)
)
GO

CREATE TABLE SanguePlus_Paciente(
    NPaciente varchar(512) NOT NULL,
    Tratador varchar(512) NOT NULL,
    BolsaRecebida varchar(512) NOT NULL,
    PRIMARY KEY (NPaciente),
    FOREIGN KEY (NPaciente) REFERENCES SanguePlus_Pessoa(Numero),
    FOREIGN KEY (Tratador) REFERENCES SanguePlus_Enfermeiro(NEnfermeiro),
    FOREIGN KEY (BolsaRecebida) REFERENCES SanguePlus_Bolsa(ID)
)
GO

CREATE TABLE SanguePlus_Medico(
    NMedico varchar(512) NOT NULL,
    PassMed varchar(512) NULL,
    PRIMARY KEY (NMedico),
    FOREIGN KEY (NMedico) REFERENCES SanguePlus_Staff(NFuncionario)
)
GO

CREATE TABLE SanguePlus_FichaMedica(
    NPaciente varchar(512) NOT NULL,
    TipoSangue varchar(512) NOT NULL,
    Diagnostico varchar(512) NULL,
    Tratamento varchar(512) NULL,
    Emissor varchar(512) NULL,
    PRIMARY KEY (NPaciente),
    FOREIGN KEY (NPaciente) REFERENCES SanguePlus_Paciente(NPaciente),
    FOREIGN KEY (Emissor) REFERENCES SanguePlus_Medico(NMedico)
)
GO

CREATE TABLE SanguePlus_Laboratorio(
    HIV varchar(512) NULL,
    Colesterol varchar(512) NULL,
    Numero int NOT NULL,
    IDBolsa varchar(512) NOT NULL,
    PRIMARY KEY (IDBolsa),
    FOREIGN KEY (IDBolsa) REFERENCES SanguePlus_Bolsa(ID)
)
GO

---------------------------------Inserts---------------------------------

/*-------------------- Tabelas de Pessoas -------------------------- */
/*-------------------- Tabelas de Pessoas -------------------------- */
INSERT INTO SanguePlus_Pessoa (Numero, Nome, Sexo, Idade, Contacto)
VALUES  
    ('M0001', 'Luis Sousa', 'Masculino', 21, 932102312),
    ('M0002', 'Vasco Rodrigues', 'Masculino', 22, 910123453),
    ('M0003', 'Valeria Teixeira', 'Feminino', 23, 912223408),
    ('M0004', 'Daniela Dias', 'Feminino', 24, 923928321),
    ('M0005', 'Goncalo Oliveira', 'Masculino', 25, 952832842),
    ('E0001', 'Guilherme Santos', 'Masculino', 26, 913913293),
    ('E0002', 'Irina Osorio', 'Feminino', 27, 987462231),
    ('E0003', 'Carolina Faustino', 'Feminino', 28, 987654321),
    ('E0004', 'Laura Teixeira', 'Feminino', 29, 936583721),
    ('E0005', 'Tiago Simoes', 'Masculino', 20, 934585732),
    ('P0001', 'Eduardo Gomes', 'Masculino', 30, 912345678),
    ('P0002', 'Beatriz Oliveira', 'Feminino', 31, 923456789),
    ('P0003', 'Goncalo Borges', 'Masculino', 32, 934567890),
    ('P0004', 'Viviana Silva', 'Feminino', 33, 945678901),
    ('P0005', 'Pedro Cruz', 'Masculino', 34, 956789012),
    ('P0006', 'Pedro Alberto', 'Masculino', 34, 956789022),
    ('P0007', 'Antonio Salvador', 'Masculino', 32, 956783012),
    ('P0008', 'Rodrigo Mora', 'Masculino', 34, 956789412),
    ('P0009', 'Susana Capitao', 'Feminino', 35, 956759012),
    ('P0010', 'Catarina Soares', 'Feminino', 36, 956709012),
    ('D0001', 'Joao Cruz', 'Masculino', 35, 967890123),
    ('D0002', 'Sofia Almeida', 'Feminino', 36, 978901234),
    ('D0003', 'Diogo Costa', 'Masculino', 37, 989012345),
    ('D0004', 'Tatiana Cruz', 'Feminino', 38, 990123456),
    ('D0005', 'Sergio Oliveira', 'Masculino', 39, 901234567),
    ('D0006', 'Carlos Silva', 'Masculino', 40, 912345678),
    ('D0007', 'Ana Santos', 'Feminino', 41, 923456789),
    ('D0008', 'Ricardo Pereira', 'Masculino', 42, 934567890),
    ('D0009', 'Marta Ferreira', 'Feminino', 43, 945678901),
    ('D0010', 'Pedro Sousa', 'Masculino', 44, 956789012);

SELECT * FROM SanguePlus_Pessoa;

/*-------------------- Tabelas de Staff -------------------------- */
INSERT INTO SanguePlus_Staff (NFuncionario)
VALUES  
    ('M0001'),
    ('M0002'),
    ('M0003'),
    ('M0004'),
    ('M0005'),
    ('E0001'),
    ('E0002'),
    ('E0003'),
    ('E0004'),
    ('E0005');

SELECT * FROM SanguePlus_Staff;

/*-------------------- Tabelas de Enfermeiros -------------------------- */
INSERT INTO SanguePlus_Enfermeiro (NEnfermeiro)
VALUES  
    ('E0001'),
    ('E0002'),
    ('E0003'),
    ('E0004'),
    ('E0005');

SELECT * FROM SanguePlus_Enfermeiro;

/*-------------------- Tabelas de Medicos -------------------------- */
INSERT INTO SanguePlus_Medico (NMedico,PassMed)
VALUES  
    ('M0001', HASHBYTES('SHA2_256', 'IamJoseMourinho')),
    ('M0002', HASHBYTES('SHA2_256', 'IamDiogoCarvalho')),
    ('M0003', NULL),
    ('M0004', HASHBYTES('SHA2_256', 'IamJustATest')),
    ('M0005', NULL);

SELECT * FROM SanguePlus_Medico;

/*-------------------- Tabelas de Dadores -------------------------- */
INSERT INTO SanguePlus_Dador (NDador)
VALUES
    ('D0001'),
    ('D0002'),
    ('D0003'),
    ('D0004'),
    ('D0005'),
    ('D0006'),
    ('D0007'),
    ('D0008'),
    ('D0009'),
    ('D0010');

SELECT * FROM SanguePlus_Dador;

/*-------------------- Tabelas de Bolsas -------------------------- */
INSERT INTO SanguePlus_Bolsa (ID, DataValidade, TipoSangue, Dador, Coletor)
VALUES
    ('B0001', '2022-12-31', 'A+', 'D0001', 'E0001'),
    ('B0002', '2022-12-31', 'B-', 'D0002', 'E0002'),
    ('B0003', '2022-12-31', 'AB+', 'D0003', 'E0003'),
    ('B0004', '2022-12-31', 'O-', 'D0004', 'E0004'),
    ('B0005', '2022-12-31', 'O+', 'D0005', 'E0005'),
    ('B0006', '2023-01-31', 'A-', 'D0006', 'E0001'),
    ('B0007', '2023-01-31', 'B+', 'D0007', 'E0002'),
    ('B0008', '2023-01-31', 'AB-', 'D0008', 'E0003'),
    ('B0009', '2023-01-31', 'O+', 'D0009', 'E0004'),
    ('B0010', '2023-01-31', 'O-', 'D0010', 'E0005');

SELECT * FROM SanguePlus_Bolsa;

/*-------------------- Tabelas de Pacientes -------------------------- */
INSERT INTO SanguePlus_Paciente (NPaciente, Tratador, BolsaRecebida)
VALUES
    ('P0001', 'E0001', 'B0001'),
    ('P0002', 'E0001', 'B0002'),
    ('P0003', 'E0001', 'B0003'),
    ('P0004', 'E0001', 'B0004'),
    ('P0005', 'E0001', 'B0005'),
    ('P0006', 'E0001', 'B0006'),
    ('P0007', 'E0001', 'B0007'),
    ('P0008', 'E0001', 'B0008'),
    ('P0009', 'E0001', 'B0009'),
    ('P0010', 'E0001', 'B0010');
    

SELECT * FROM SanguePlus_Paciente;      ------------vazia

/*-------------------- Tabelas de Fichas Medicas -------------------------- */
INSERT INTO SanguePlus_FichaMedica (NPaciente, TipoSangue, Diagnostico, Tratamento, Emissor)
VALUES
    ('P0001', 'A+', 'Perna Partida', 'Amputar Perna', 'M0001'),
    ('P0002', 'B-', 'Tomou Viagra', 'Tirar Sangue', 'M0002'),
    ('P0003', 'AB+', 'Hemorragia', 'Dialise', 'M0003'),
    ('P0004', 'O-', '', '', 'M0004'),
    ('P0005', 'O+', '', '', 'M0005'),
    ('P0006', 'O-', '', '', 'M0001'),
    ('P0007', 'A+', '', '', 'M0002'),
    ('P0008', 'A-', '', '', 'M0003'),
    ('P0009', 'A+', '', '', 'M0004'),
    ('P0010', 'A+', '', '', 'M0005');

SELECT * FROM SanguePlus_FichaMedica;   -----------vazia

/*-------------------- Tabelas de Laboratorio -------------------------- */
INSERT INTO SanguePlus_Laboratorio(IDBolsa,Numero,HIV,Colesterol)
VALUES
    ('B0001', 1, 'Negativo', 200),
    ('B0002', 2, 'Positivo', 180),
    ('B0003', 3, 'Positivo', 200),
    ('B0004', 4, 'Negativo', 175),
    ('B0005', 5, '', NULL),
    ('B0006', 6, '', NULL),
    ('B0007', 7, '', NULL),
    ('B0008', 8, '', NULL),
    ('B0009', 9, '', NULL),
    ('B0010', 10, '', NULL);

SELECT IDBolsa, Numero, HIV, ISNULL(Colesterol, '') AS Colesterol
FROM SanguePlus_Laboratorio;

/*-------------------- Tabelas de Cartoes Dador -------------------------- */
INSERT INTO SanguePlus_CartaoDador(NDador,Nome,TipoSangue,EntidadeFornecedor)
VALUES
    ('D0001', 'Joao Cruz', 'A+', 'Sangue+'),
    ('D0002', 'Sofia Almeida', 'B-', 'Sangue+'),
    ('D0003', 'Diogo Costa', 'AB+', 'Sangue+'),
    ('D0004', 'Tatiana Cruz', 'O-', 'Sangue+'),
    ('D0005', 'Sergio Oliveira', 'O+', 'Sangue+'),
    ('D0006', 'Carlos Silva', 'A-', 'Sangue+'),
    ('D0007', 'Ana Santos', 'B+', 'Sangue+'),
    ('D0008', 'Ricardo Pereira', 'AB-', 'Sangue+'),
    ('D0009', 'Marta Ferreira', 'O+', 'Sangue+'),
    ('D0010', 'Pedro Sousa', 'O-', 'Sangue+');

SELECT * FROM SanguePlus_CartaoDador;
GO

---------------------------------Procedures---------------------------------

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
GO

--exec RegistarResultados @IDBolsa = 'B0003', @HIV = 'Negativo', @Colesterol = 200;

---------------------------------VIEWS---------------------------------

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

---------------------------------TRIGGERS---------------------------------

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

---------------------------------UDF---------------------------------

CREATE FUNCTION dbo.DatasBolsas()
RETURNS @result TABLE 
(
  Date DATE,
  Count INT
)
AS
BEGIN
    INSERT INTO @result
    SELECT DataValidade, COUNT(*)
    FROM SanguePlus_Bolsa
    GROUP BY DataValidade;

    RETURN;
END;

--SELECT * FROM dbo.DatasBolsas();