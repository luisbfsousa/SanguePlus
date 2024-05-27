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
    ('D0001', 'Joao Cruz', 'Masculino', 35, 967890123),
    ('D0002', 'Sofia Almeida', 'Feminino', 36, 978901234),
    ('D0003', 'Diogo Costa', 'Masculino', 37, 989012345),
    ('D0004', 'Tatiana Cruz', 'Feminino', 38, 990123456),
    ('D0005', 'Sergio Oliveira', 'Masculino', 39, 901234567);

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
    ('M0001','IamJoseMourinho'),
    ('M0002','IamDiogoCarvalho'),
    ('M0003',''),
    ('M0004','IamJustATest'),
    ('M0005','');

SELECT * FROM SanguePlus_Medico;

/*-------------------- Tabelas de Dadores -------------------------- */
INSERT INTO SanguePlus_Dador (NDador)
VALUES
    ('D0001'),
    ('D0002'),
    ('D0003'),
    ('D0004'),
    ('D0005');

SELECT * FROM SanguePlus_Dador;

/*-------------------- Tabelas de Bolsas -------------------------- */
INSERT INTO SanguePlus_Bolsa (ID, DataValidade, TipoSangue, Dador, Coletor)
VALUES
    ('B0001', '2022-12-31', 'A+', 'D0001', 'E0001'),
    ('B0002', '2022-12-31', 'B-', 'D0002', 'E0002'),
    ('B0003', '2022-12-31', 'AB+', 'D0003', 'E0003'),
    ('B0004', '2022-12-31', 'O-', 'D0004', 'E0004'),
    ('B0005', '2022-12-31', 'O+', 'D0005', 'E0005');

SELECT * FROM SanguePlus_Bolsa;

/*-------------------- Tabelas de Pacientes -------------------------- */
INSERT INTO SanguePlus_Paciente (NPaciente, Tratador, BolsaRecebida)
VALUES
    ('P0001', 'E0001', 'B0001'),
    ('P0002', 'E0001', 'B0002'),
    ('P0003', 'E0001', 'B0003'),
    ('P0004', 'E0001', 'B0004'),
    ('P0005', 'E0001', 'B0005');

SELECT * FROM SanguePlus_Paciente;      ------------vazia

/*-------------------- Tabelas de Fichas Medicas -------------------------- */
INSERT INTO SanguePlus_FichaMedica (NPaciente, TipoSangue, Diagnostico, Tratamento, Emissor)
VALUES
    ('P0001', 'A+', '', '', 'M0001'),
    ('P0002', 'B-', '', '', 'M0002'),
    ('P0003', 'AB+', '', '', 'M0003'),
    ('P0004', 'O-', '', '', 'M0004'),
    ('P0005', 'O+', '', '', 'M0005');

SELECT * FROM SanguePlus_FichaMedica;   -----------vazia

/*-------------------- Tabelas de Laboratorio -------------------------- */
INSERT INTO SanguePlus_Laboratorio(IDBolsa,Numero,HIV,Colesterol)
VALUES
    ('B0001', 1, 'Negativo', 200),
    ('B0002', 2, 'Negativo', 180),
    ('B0003', 3, 'Positivo', 220),
    ('B0004', 4, 'Negativo', 210),
    ('B0005', 5, 'Negativo', 190);

SELECT * FROM SanguePlus_Laboratorio;

/*-------------------- Tabelas de Cartoes Dador -------------------------- */
INSERT INTO SanguePlus_CartaoDador(NDador,Nome,TipoSangue,EntidadeFornecedor)
VALUES
    ('D0001', 'Joao Cruz', 'A+', 'Sangue+'),
    ('D0002', 'Sofia Almeida', 'B-', 'Sangue+'),
    ('D0003', 'Diogo Costa', 'AB+', 'Sangue+'),
    ('D0004', 'Tatiana Cruz', 'O-', 'Sangue+'),
    ('D0005', 'Sergio Oliveira', 'O+', 'Sangue+');

SELECT * FROM SanguePlus_CartaoDador;