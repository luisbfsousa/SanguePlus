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
    PRIMARY KEY (NMedico),
    FOREIGN KEY (NMedico) REFERENCES SanguePlus_Staff(NFuncionario)
)
GO

CREATE TABLE SanguePlus_FichaMedica(
    NPaciente varchar(512) NOT NULL,
    TipoSangue varchar(512) NOT NULL,
    Diagnostico varchar(512) NOT NULL,
    Tratamento varchar(512) NOT NULL,
    Emissor varchar(512) NOT NULL,
    PRIMARY KEY (NPaciente),
    FOREIGN KEY (NPaciente) REFERENCES SanguePlus_Paciente(NPaciente),
    FOREIGN KEY (Emissor) REFERENCES SanguePlus_Medico(NMedico)
)
GO

CREATE TABLE SanguePlus_Laboratorio(
    HIV varchar(512) NOT NULL,
    Colesterol varchar(512) NOT NULL,
    Numero int NOT NULL,
    IDBolsa varchar(512) NOT NULL,
    PRIMARY KEY (IDBolsa),
    FOREIGN KEY (IDBolsa) REFERENCES SanguePlus_Bolsa(ID)
)
GO