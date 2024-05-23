CREATE TABLE[PROJ_Pessoa](
    [Nome][varchar](512) NOT NULL,
    [Numero][varchar](512) NOT NULL,
    [Sexo][varchar](512) NOT NULL,
    [Idade][int] NOT NULL,
    [Contacto][int]NOT NULL,
    PRIMARY KEY ([Numero])
)
GO

CREATE TABLE [PROJ_Staff](
    [NFuncionario][varchar](512) NOT NULL REFERENCES[PROJ_Pessoa]([Numero]),
    PRIMARY KEY ([NFuncionario])
)
GO

CREATE TABLE[PROJ_Clinica](
    [NIF][int] NOT NULL,
    [Nome][varchar](512) NOT NULL,
    [Morada][varchar](512) NOT NULL,
    [Contacto][int] NOT NULL,
    [NumeroCliente][varchar](512) NOT NULL REFERENCES[PROJ_Pessoa]([Numero]),
    PRIMARY KEY ([NIF])
)
GO

CREATE TABLE[PROJ_Dador](
    [NDador][varchar](512) NOT NULL REFERENCES[PROJ_Pessoa]([Numero]),
    PRIMARY KEY ([NDador])
)
GO

CREATE TABLE[PROJ_CartaoDador](
    [NDador][varchar](512) NOT NULL REFERENCES[PROJ_Dador]([NDador]),
    [Nome][varchar](512) NOT NULL,
    [TipoSangue][varchar](512) NOT NULL,
    [EntidadeFornecedor][int] NOT NULL REFERENCES[PROJ_Clinica]([NIF]),
    PRIMARY KEY ([NDador])
)
GO

CREATE TABLE[PROJ_Enfermeiro](
    [NEnfermeiro][varchar](512) NOT NULL REFERENCES[PROJ_Staff]([NFuncionario]),
    PRIMARY KEY ([NEnfermeiro])
)
GO

CREATE TABLE[PROJ_Bolsa](
    [ID][int] NOT NULL,
    [DataValidade][varchar](512) NOT NULL,
    [TipoSangue][int] NOT NULL,
    [Dador][varchar](512) NOT NULL REFERENCES[PROJ_Dador]([NDador]),
    [Coletor][varchar](512) NOT NULL REFERENCES[PROJ_Enfermeiro]([NEnfermeiro]),
    PRIMARY KEY ([ID])
)
GO

CREATE TABLE[PROJ_Paciente](
    [NPaciente][varchar](512) NOT NULL REFERENCES[PROJ_Pessoa]([Numero]),
    [Tratador][varchar](512) NOT NULL REFERENCES[PROJ_Enfermeiro]([NEnfermeiro]),
    [BolsaRecebida][int] NOT NULL REFERENCES[PROJ_Bolsa]([ID]),
    PRIMARY KEY ([NPaciente])
)
GO

CREATE TABLE[PROJ_Medico](
    [NMedico][varchar](512) NOT NULL REFERENCES[PROJ_Staff]([NFuncionario]),
    PRIMARY KEY ([NMedico])
)
GO

CREATE TABLE[PROJ_FichaMedica](
    [NPaciente][varchar](512) NOT NULL REFERENCES[PROJ_Paciente]([NPaciente]),
    [TipoSangue][varchar](512) NOT NULL,
    [Diagnostico][varchar](512) NOT NULL,
    [Tratamento][varchar](512) NOT NULL,
    [Emissor][varchar](512) NOT NULL REFERENCES[PROJ_Medico]([NMedico]),
    PRIMARY KEY ([NPaciente])
)
GO

CREATE TABLE [PROJ_Laboratorio](
    [HIV][varchar](512) NOT NULL,
    [Colesterol][varchar](512) NOT NULL,
    [Numero][int] NOT NULL,
    [IDBolsa][int] NOT NULL REFERENCES[PROJ_Bolsa]([ID]),
    PRIMARY KEY ([IDBolsa])
)
GO