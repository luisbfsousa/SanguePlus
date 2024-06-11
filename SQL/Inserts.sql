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