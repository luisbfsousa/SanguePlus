-----------Pessoas------------

-----Ver todas as pessoas-----

CREATE PROCEDURE [dbo].[getPessoas]

AS
    BEGIN
            SELECT * FROM [PROJ_Pessoa]
    END
GO

exec dbo.getPessoas