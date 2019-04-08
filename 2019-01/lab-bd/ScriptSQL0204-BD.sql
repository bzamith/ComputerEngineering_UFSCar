-- Scripts aula 02/04
-- Aluna: Bruna Zamith Santos
-- RA: 628093
-- Turma: B

--0. APAGAR TABELAS PRE-EXISTENTES
DROP TABLE Cliente;
DROP TABLE Banco;
DROP TABLE Agencia;
DROP TABLE Conta;
DROP TABLE Corrente;
DROP TABLE Poupanca;
DROP TABLE Possui;
DROP TABLE Correntista;
DROP TABLE Movimentacao;

--1. CRIAÇÃO DAS TABELAS
CREATE TABLE Cliente(
  cpf VARCHAR2(11) PRIMARY KEY,
  email VARCHAR2(255),
  pnome VARCHAR2(50),
  sobrenome VARCHAR2(50)
);

CREATE TABLE Banco(
  nrobanco INTEGER PRIMARY KEY,
  cnpj VARCHAR2(14),
  cep VARCHAR2(8),
  estado CHAR(2),
  logradouro VARCHAR2(50),
  nro INTEGER,
  compl VARCHAR2(50)
);

CREATE TABLE Agencia(
  nroagencia INTEGER,
  nrobanco INTEGER,
  cidade VARCHAR2(50),
  CONSTRAINT PK_Agencia PRIMARY KEY (nroagencia,nrobanco),
  CONSTRAINT FK_Banco FOREIGN KEY (nrobanco) REFERENCES Banco(nrobanco) ON DELETE SET NULL
);

CREATE TABLE Conta(
  nroconta INTEGER,
  nroagencia INTEGER,
  nrobanco INTEGER,
  saldo FLOAT,
  gerente VARCHAR2(50),
  tipo INTEGER,
  CONSTRAINT FK_Agencia FOREIGN KEY (nroagencia,nrobanco) REFERENCES Agencia(nroagencia,nrobanco) ON DELETE SET NULL,
  CONSTRAINT PK_Conta PRIMARY KEY (nroconta,nroagencia,nrobanco)
);

CREATE TABLE Corrente(
  nroconta INTEGER,
  nroagencia INTEGER,
  nrobanco INTEGER,
  limite FLOAT,
  CONSTRAINT FK_Conta FOREIGN KEY (nroconta,nroagencia,nrobanco) REFERENCES Conta(nroconta,nroagencia,nrobanco) ON DELETE SET NULL,
  CONSTRAINT PK_Corrente PRIMARY KEY (nroconta,nroagencia,nrobanco)
);

CREATE TABLE Poupanca(
  nroconta INTEGER,
  nroagencia INTEGER,
  nrobanco INTEGER,
  aniversario DATE,
  CONSTRAINT FK_ContaP FOREIGN KEY (nroconta,nroagencia,nrobanco) REFERENCES Conta(nroconta,nroagencia,nrobanco) ON DELETE SET NULL,
  CONSTRAINT PK_Poupanca PRIMARY KEY (nroconta,nroagencia,nrobanco)
);

CREATE TABLE Possui(
  cpf VARCHAR2(11),
  nroconta INTEGER,
  nroagencia INTEGER,
  nrobanco INTEGER,
  titular VARCHAR2(50),
  CONSTRAINT FK_ClientePs FOREIGN KEY (cpf) REFERENCES Cliente(cpf) ON DELETE SET NULL,
  CONSTRAINT FK_ContaPs FOREIGN KEY (nroconta,nroagencia,nrobanco) REFERENCES Conta(nroconta,nroagencia,nrobanco) ON DELETE SET NULL,
  CONSTRAINT PK_Possui PRIMARY KEY (cpf,nroconta,nroagencia,nrobanco)
);

CREATE TABLE Correntista(
  cpf VARCHAR2(11),
  nroconta INTEGER,
  nroagencia INTEGER,
  nrobanco INTEGER,
  CONSTRAINT FK_Possui FOREIGN KEY (cpf,nroconta,nroagencia,nrobanco) REFERENCES Possui(cpf,nroconta,nroagencia,nrobanco) ON DELETE SET NULL,
  CONSTRAINT PK_Correntista PRIMARY KEY (cpf,nroconta,nroagencia,nrobanco)
);

CREATE TABLE Movimentacao(
  datahora VARCHAR2(25),
  cpf VARCHAR2(11),
  nroconta INTEGER,
  nroagencia INTEGER,
  nrobanco INTEGER,
  valor FLOAT,
  tipo INTEGER,
  CONSTRAINT FK_Correntista FOREIGN KEY (cpf,nroconta,nroagencia,nrobanco) REFERENCES Correntista(cpf,nroconta,nroagencia,nrobanco) ON DELETE SET NULL,
  CONSTRAINT PK_Movimentacao PRIMARY KEY (cpf,nroconta,nroagencia,nrobanco)
);