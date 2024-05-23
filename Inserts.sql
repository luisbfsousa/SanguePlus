/*-------------------- Tabelas de Pessoas -------------------------- */
INSERT INTO SanguePlus_Pessoa (Numero, Nome, Sexo, Idade, Contacto)
VALUES  
    ('M001', 'Luis Sousa', 'M', 21, 932102312),
    ('M002', 'Vasco Rodrigues', 'M', 22, 910123453),
    ('M003', 'Valeria Teixeira', 'F', 23, 912223408),
    ('M004', 'Daniela Dias', 'F', 24, 923928321),
    ('M005', 'Goncalo Oliveira', 'M', 25, 952832842),
    ('E001', 'Guilherme Santos', 'M', 26, 913913293),
    ('E002', 'Irina Osorio', 'F', 27, 987462231),
    ('E003', 'Carolina Faustino', 'F', 28, 987654321),
    ('E004', 'Laura Teixeira', 'F', 29, 936583721),
    ('E005', 'Tiago Simoes', 'M', 20, 934585732),
    ('P001', 'Eduardo Gomes', 'M', 30, 912345678),
    ('P002', 'Beatriz Oliveira', 'F', 31, 923456789),
    ('P003', 'Goncalo Borges', 'M', 32, 934567890),
    ('P004', 'Viviana Silva', 'F', 33, 945678901),
    ('P005', 'Pedro Cruz', 'M', 34, 956789012),
    ('D001', 'Joao Cruz', 'M', 35, 967890123),
    ('D002', 'Sofia Almeida', 'F', 36, 978901234),
    ('D003', 'Diogo Costa', 'M', 37, 989012345),
    ('D004', 'Tatiana Cruz', 'F', 38, 990123456),
    ('D005', 'Sergio Oliveira', 'M', 39, 901234567);

SELECT * FROM SanguePlus_Pessoa;

/*-------------------- Tabelas de Staff -------------------------- */
INSERT INTO SanguePlus_Staff (NFuncionario)
VALUES  
    ('M001'),
    ('M002'),
    ('M003'),
    ('M004'),
    ('M005'),
    ('E001'),
    ('E002'),
    ('E003'),
    ('E004'),
    ('E005');

SELECT * FROM SanguePlus_Staff;

/*-------------------- Tabelas de Enfermeiros -------------------------- */
INSERT INTO SanguePlus_Enfermeiro (NEnfermeiro)
VALUES  
    ('E001'),
    ('E002'),
    ('E003'),
    ('E004'),
    ('E005');

SELECT * FROM SanguePlus_Enfermeiro;

/*-------------------- Tabelas de Medicos -------------------------- */
INSERT INTO SanguePlus_Medico (NMedico)
VALUES  
    ('M001'),
    ('M002'),
    ('M003'),
    ('M004'),
    ('M005');

SELECT * FROM SanguePlus_Medico;

/*-------------------- Tabelas de Dadores -------------------------- */
INSERT INTO SanguePlus_Dador (NDador)
VALUES
    ('D001'),
    ('D002'),
    ('D003'),
    ('D004'),
    ('D005');

SELECT * FROM SanguePlus_Dador;

/*-------------------- Tabelas de Bolsas -------------------------- */
INSERT INTO SanguePlus_Bolsa (ID, DataValidade, TipoSangue, Dador, Coletor)
VALUES
    ('B001', '2022-12-31', 'A+', 'D001', 'E001'),
    ('B002', '2022-12-31', 'B-', 'D002', 'E002'),
    ('B003', '2022-12-31', 'AB+', 'D003', 'E003'),
    ('B004', '2022-12-31', 'O-', 'D004', 'E004'),
    ('B005', '2022-12-31', 'O+', 'D005', 'E005');

SELECT * FROM SanguePlus_Bolsa;

/*-------------------- Tabelas de Pacientes -------------------------- */
INSERT INTO SanguePlus_Paciente (NPaciente, Tratador, BolsaRecebida)
VALUES
    ('P001', 'E001', 'B001'),
    ('P002', 'E001', 'B002'),
    ('P003', 'E001', 'B003'),
    ('P004', 'E001', 'B004'),
    ('P005', 'E001', 'B005');

SELECT * FROM SanguePlus_Paciente;      ------------vazia

/*-------------------- Tabelas de Fichas Medicas -------------------------- */
INSERT INTO SanguePlus_FichaMedica (NPaciente, TipoSangue, Diagnostico, Tratamento, Emissor)
VALUES
    ('P001', 'A+', 'Queimaduras', 'Uma Bolsa Sangue', 'M001'),
    ('P002', 'B-', 'Hemorragia', 'Uma Bolsa Sangue', 'M002'),
    ('P003', 'AB+', 'Perna Partida', 'Duas Bolsas Sangue', 'M003'),
    ('P004', 'O-', 'Tomou demasiada viagra', 'Mais vale tirar o sangue', 'M004'),
    ('P005', 'O+', 'Atraso Mental', 'Uma bolsa sangue', 'M005');

SELECT * FROM SanguePlus_FichaMedica;   -----------vazia

/*-------------------- Tabelas de Laboratorio -------------------------- */
INSERT INTO SanguePlus_Laboratorio(IDBolsa,Numero,HIV,Colesterol)
VALUES
    ('B001', 1, 'Negativo', 200),
    ('B002', 2, 'Negativo', 180),
    ('B003', 3, 'Positivo', 220),
    ('B004', 4, 'Negativo', 210),
    ('B005', 5, 'Negativo', 190);

SELECT * FROM SanguePlus_Laboratorio;

/*-------------------- Tabelas de Cartoes Dador -------------------------- */
INSERT INTO SanguePlus_CartaoDador(NDador,Nome,TipoSangue,EntidadeFornecedor)
VALUES
    ('D001', 'Joao Cruz', 'A+', 'Sangue+'),
    ('D002', 'Sofia Almeida', 'B-', 'Sangue+'),
    ('D003', 'Diogo Costa', 'AB+', 'Sangue+'),
    ('D004', 'Tatiana Cruz', 'O-', 'Sangue+'),
    ('D005', 'Sergio Oliveira', 'O+', 'Sangue+');

SELECT * FROM SanguePlus_CartaoDador;