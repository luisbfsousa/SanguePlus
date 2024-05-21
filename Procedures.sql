-----------Pessoas------------

-----Ver todas as pessoas-----

CREATE PROCEDURE [dbo].[getPessoas]
AS
    BEGIN
            SELECT * FROM [SanguePlus_Pessoa]
    END
GO

--exec [dbo].[getPessoas]


-----Adicionar pessoa-----

CREATE PROCEDURE [dbo].[AddPessoa](@Nome varchar(512),@Numero varchar(512),@Sexo varchar(512),@Idade int,@Contacto int)
AS
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM SanguePlus_Pessoa WHERE Numero = @Numero)
        BEGIN
            INSERT INTO SanguePlus_Pessoa(Nome, Numero, Sexo, Idade, Contacto)
            VALUES (@Nome, @Numero, @Sexo, @Idade, @Contacto)
        END
        ELSE
        BEGIN
            PRINT 'A Pessoa ja existe'
        END
    END
GO

--exec [dbo].[AddPessoa] @Nome='Kelvin',@Numero='P010',@Sexo='M',@Idade='25',@Contacto='123456789';


-----Remover pessoa-----
CREATE PROCEDURE [dbo].[RemovePessoa](@Numero varchar(255))
AS
    BEGIN
        DELETE FROM SanguePlus_Pessoa WHERE NUMERO = @NUMERO
    END
GO

--exec dbo.RemovePessoa @Numero='P002';


-----Pesquisar pessoa-----
CREATE PROCEDURE [dbo].[SearchPessoa](@Numero varchar(255))

AS
    BEGIN
        SELECT * FROM SanguePlus_Pessoa WHERE Numero = @Numero
    END
GO

--exec dbo.SearchPessoa @Numero='M001';


-----------???------------

-----------???------------

-----------???------------

-----------???------------

-----------???------------

-----------???------------

-----------???------------
