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