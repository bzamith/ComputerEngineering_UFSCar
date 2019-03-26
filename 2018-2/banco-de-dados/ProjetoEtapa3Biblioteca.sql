/*
ALISSON HAYASI - 726494
BRUNA ZAMITH - 628093
LUANA MENEZES - 727345 
LUÍS FERNANDO - 727348 
MARCOS FAGLIONI - 628301

*/

--0. APAGAR TABELAS PRE-EXISTENTES
drop table Pessoa;
drop table Usuario;
drop table Empresta;
drop table Bibliotecario;
drop table Exemplar;
drop table Livro;
drop table Midia;
drop table Tem_Relacao;
drop table Revista;
drop table TeseDissertacao;
drop table TeseDissertacao_Palavra_Chave;

--1. CRIAÇÃO DAS TABELAS
CREATE TABLE Pessoa(
    cpf CHAR(11) NOT NULL PRIMARY KEY,
    --1.1 USO DE UNIQUE
    email VARCHAR2(255) UNIQUE,
    telefone VARCHAR2(14),
    nome VARCHAR2(255) NOT NULL,
    data_nascimento DATE,
    rg_spe CHAR(3),
    rg_data_emissao DATE,
    rg_numero VARCHAR2(14)
); 

CREATE TABLE Usuario(
    codigo_usuario INTEGER NOT NULL PRIMARY KEY,
    senha_usuario VARCHAR2(50),
    suspensao INTEGER,
    data_cadastramento DATE,
    cpf CHAR(11),
    
    --1.2 USO DE FOREIGN KEY E ON DELETE CASCADE:
    CONSTRAINT FK_usuario_cpf FOREIGN KEY (cpf) REFERENCES Pessoa(cpf) ON DELETE CASCADE
);

CREATE TABLE Exemplar(
    codigo_exemplar INTEGER NOT NULL PRIMARY KEY,
    qte_total INTEGER,
    assunto VARCHAR2(50),
    qtd_total_emprestimos INTEGER,
    qtd_disponivel INTEGER,
    data_emprestimo DATE
);

CREATE TABLE Empresta(
	--1.3 USO DO DEFAULT
    periodo_DataInicial  DATE DEFAULT SYSDATE,  --Date Default Sysdate
    periodo_DataFinal DATE,
    usuario_cod INTEGER NOT NULL,
    exemplar_cod INTEGER NOT NULL,
    CONSTRAINT PK_empresta PRIMARY KEY (periodo_DataInicial, usuario_cod, exemplar_cod),
    CONSTRAINT FK_empresta_usuario_cod FOREIGN KEY (usuario_cod) REFERENCES Usuario(codigo_usuario) ON DELETE CASCADE,
    CONSTRAINT FK_empresta_exemplar_cod FOREIGN KEY (exemplar_cod) REFERENCES Exemplar(codigo_exemplar) ON DELETE CASCADE
);

CREATE TABLE Bibliotecario(
    codigo_bibliotecario INTEGER NOT NULL PRIMARY KEY,
    senha_bibliotecario VARCHAR2(50),
    secao VARCHAR2(50),
    data_contratacao DATE,
    cpf CHAR(11),
    CONSTRAINT FK_bibliotecario_cpf FOREIGN KEY (cpf) REFERENCES Pessoa(cpf) ON DELETE CASCADE
);

CREATE TABLE Livro(
    codigo_exemplar INTEGER NOT NULL PRIMARY KEY,
    titulo VARCHAR2(100),
    autor VARCHAR(255),
    editora VARCHAR (50),
    volume VARCHAR (50),
    isbn VARCHAR2(13),
    ano_edicao INTEGER,

    --1.4 USO DA FUNÇÃO CHECK:
    CONSTRAINT CK_Livro_isbn check (LENGTH(isbn)=10 OR LENGTH(isbn)=13),
    CONSTRAINT FK_livro_codigo_exemplar FOREIGN KEY (codigo_exemplar) REFERENCES Exemplar(codigo_exemplar) ON DELETE CASCADE
);

CREATE TABLE Midia(
    codigo_exemplar INTEGER NOT NULL PRIMARY KEY,
    tipo VARCHAR2(50),
    volume VARCHAR2(50),
    CONSTRAINT FK_midia_codigo_exemplar FOREIGN KEY (codigo_exemplar) REFERENCES Exemplar(codigo_exemplar) ON DELETE CASCADE
);

CREATE TABLE Tem_relacao(
    livro_codExemplar INTEGER NOT NULL,
    midia_codExemplar INTEGER NOT NULL,
    CONSTRAINT PK_Tem_relacao PRIMARY KEY (livro_codExemplar, midia_codExemplar),
    CONSTRAINT FK_Tem_relacao_livro_codExemplar FOREIGN KEY (livro_codExemplar) REFERENCES Livro(codigo_exemplar) ON DELETE CASCADE,
    CONSTRAINT FK_Tem_relacao_midia_codExemplar FOREIGN KEY (midia_codExemplar) REFERENCES Midia(codigo_exemplar) ON DELETE CASCADE
);

CREATE TABLE Revista(
    codigo_exemplar INTEGER NOT NULL PRIMARY KEY,
    nome VARCHAR(100),
    nro_edicao INTEGER,
    mes_publicacao DATE,
    editora VARCHAR(50),
    CONSTRAINT FK_revista_codigo_exemplar FOREIGN KEY (codigo_exemplar) REFERENCES Exemplar(codigo_exemplar) ON DELETE CASCADE
);

CREATE TABLE TeseDissertacao(
    codigo_exemplar INTEGER NOT NULL PRIMARY KEY,
    instituto VARCHAR2(100),
    area_conhecimento VARCHAR(100),
    supervisor VARCHAR(255),
    data_defesa DATE,
    universidade VARCHAR2(100),
    CONSTRAINT FK_teseDissertacao_codigo_exemplar FOREIGN KEY (codigo_exemplar) REFERENCES Exemplar(codigo_exemplar) ON DELETE CASCADE
);

CREATE TABLE TeseDissertacao_Palavra_Chave(
    palavra_chave VARCHAR2(20) NOT NULL,
    codigo_exemplar INTEGER NOT NULL,
    CONSTRAINT PK_TeseDissertacao_Palavra_Chave PRIMARY KEY (palavra_chave, codigo_exemplar),
    CONSTRAINT FK_TeseDissertacao_Palavra_Chave_codigo_exemplar FOREIGN KEY (codigo_exemplar) REFERENCES Exemplar(codigo_exemplar) ON DELETE CASCADE
);

--2 INSERÇÃO DE TUPLAS
--2.1 INSERÇÃO TABELA PESSOA:
--2.1.1 USUÁRIOS
select * from Pessoa;
INSERT INTO Pessoa
VALUES ('12345678910', 'ana@hotmail.com', '33213212', 'Ana', date'1992-12-22', 'SSP', date'2001-11-02', '620606459');
INSERT INTO Pessoa
VALUES ('21345678910', 'joao@hotmail.com', '33213211', 'João', date'1991-11-21', 'SSP', date'2002-12-03', '620606411');
INSERT INTO Pessoa
VALUES ('13345678910', 'Maria@hotmail.com', '33213213', 'Maria', date'1993-01-01', 'SSP', date'2003-01-03', '620606458');
INSERT INTO Pessoa
VALUES ('23345678910', 'luis@hotmail.com', '33213214', 'Luis', date'1997-12-22', 'SSP', date'2011-11-02', '620606460');
INSERT INTO Pessoa
VALUES ('45745678910', 'tiago@hotmail.com', '34213213', 'Tiago', date'1995-08-15', 'SSP', date'2003-11-10', '620606461');
INSERT INTO Pessoa
VALUES ('32145678910', 'jose@hotmail.com', '33213333', 'Jose', date'1990-02-23', 'SSP', date'2000-08-02', '620606777');
INSERT INTO Pessoa
VALUES ('13302398910', 'carlos@hotmail.com', '33299213', 'Carlos', date'1999-01-12', 'SSP', date'2015-07-07', '711606458');
INSERT INTO Pessoa
VALUES ('23345347833', 'gabriel@hotmail.com', '33900014', 'Gabriel', date'1989-03-11', 'SSP', date'2008-06-03', '620612390');
INSERT INTO Pessoa
VALUES ('45766678910', 'lucas@hotmail.com', '34213213', 'Lucas', date'1993-08-15', 'SSP', date'2007-11-10', '620555461');
INSERT INTO Pessoa
VALUES ('32145673784', 'murilo@hotmail.com', '33213666', 'Murilo', date'1996-06-23', 'SSP', date'2007-08-02', '620606666');

--2.1.2 BIBLIOTECÁRIOS
INSERT INTO Pessoa
VALUES ('12345611111', 'chico@hotmail.com', '33111212', 'Chico', date'1992-12-22', 'SSP', date'2001-11-02', '520606459');
INSERT INTO Pessoa
VALUES ('21345622222', 'sabrina@hotmail.com', '32223211', 'Sabrina', date'1991-11-21', 'SSP', date'2002-12-03', '520606411');
INSERT INTO Pessoa
VALUES ('13345633333', 'carol@hotmail.com', '33333213', 'Carolina', date'1993-01-01', 'SSP', date'2003-01-03', '520606458');
INSERT INTO Pessoa
VALUES ('23345644444', 'luisa@hotmail.com', '34443214', 'Luisa', date'1997-12-22', 'SSP', date'2011-11-02', '520606460');
INSERT INTO Pessoa
VALUES ('45745655555', 'victor@hotmail.com', '35553213', 'Victor', date'1995-08-15', 'SSP', date'2003-11-10', '520606461');
INSERT INTO Pessoa
VALUES ('32145666666', 'jaime@hotmail.com', '33666333', 'Jaime', date'1990-02-23', 'SSP', date'2000-08-02', '520606777');
INSERT INTO Pessoa
VALUES ('13302377777', 'yago@hotmail.com', '33777213', 'Yago', date'1999-01-12', 'SSP', date'2015-07-07', '511606658');
INSERT INTO Pessoa
VALUES ('23345388888', 'marcela@hotmail.com', '33888014', 'Marcela', date'1989-03-11', 'SSP', date'2008-06-03', '520612390');
INSERT INTO Pessoa
VALUES ('45766699999', 'lais@hotmail.com', '34999213', 'Laís', date'1993-08-15', 'SSP', date'2007-11-10', '520555461');
INSERT INTO Pessoa
VALUES ('32145600000', 'laura@hotmail.com', '33000666', 'Laura', date'1996-06-23', 'SSP', date'2007-08-02', '520606666');

--2.2 INSERÇÃO TABELA USUARIO:
select * from Usuario; 
INSERT INTO Usuario
VALUES (111, 'ana123', 121, date'2011-06-12', '12345678910');
INSERT INTO Usuario
VALUES (222, 'joao123', 122, date'2012-08-05', '21345678910');
INSERT INTO Usuario
VALUES (333, 'maria123', 123, date'2010-07-02', '13345678910');
INSERT INTO Usuario
VALUES (444, 'luis123', 124, date'2009-11-02', '23345678910');
INSERT INTO Usuario
VALUES (555, 'tiago123', 125, date'2005-12-01', '45745678910');
INSERT INTO Usuario
VALUES (666, 'jose123', 126, date'2008-01-15', '32145678910');
INSERT INTO Usuario
VALUES (777, 'carlos123', 127, date'2012-08-11', '13302398910');
INSERT INTO Usuario
VALUES (888, 'gabriel123', 128, date'2013-03-22', '23345347833');
INSERT INTO Usuario
VALUES (999, 'lucas123', 129, date'2014-06-02', '45766678910');
INSERT INTO Usuario
VALUES (100, 'murilo123', 120, date'2011-06-04', '32145673784');

--2.3 INSERÇÃO TABELA EXEMPLAR:
SELECT * FROM Exemplar; 
INSERT INTO Exemplar
VALUES (1111, 5, 'Biololgia', 3, 2, date'2018-06-04');
INSERT INTO Exemplar
VALUES (2222, 5, 'Matematica', 3, 2, date'2018-07-05');
INSERT INTO Exemplar
VALUES (3333, 5, 'Portugues', 3, 2, date'2018-08-06');
INSERT INTO Exemplar
VALUES (4444, 5, 'Fisica', 3, 2, date'2018-09-07');
INSERT INTO Exemplar
VALUES (5555, 5, 'Drama', 3, 2, date'2018-10-08');
INSERT INTO Exemplar
VALUES (6666, 5, 'Suspense', 3, 2, date'2018-11-09');
INSERT INTO Exemplar
VALUES (7777, 5, 'Ficcao', 3, 2, date'2018-11-10');
INSERT INTO Exemplar
VALUES (8888, 5, 'Ingles', 3, 2, date'2018-10-11');
INSERT INTO Exemplar
VALUES (9999, 5, 'Frances', 3, 2, date'2018-09-12');
INSERT INTO Exemplar
VALUES (1000, 5, 'Alemao', 3, 2, date'2018-09-13');
INSERT INTO Exemplar
VALUES (2000,5, 'Revista', 3, 2, date'2018-07-10');
INSERT INTO Exemplar
VALUES (2001,5, 'Revista', 3, 2, date'2018-07-10');
INSERT INTO Exemplar
VALUES (2002,5, 'Revista', 3, 2, date'2018-07-10');
INSERT INTO Exemplar
VALUES (2003,5, 'Revista', 3, 2, date'2018-07-10');
INSERT INTO Exemplar
VALUES (2004,5, 'Revista', 3, 2, date'2018-07-10');
INSERT INTO Exemplar
VALUES (2005,5, 'Revista', 3, 2, date'2018-07-10');
INSERT INTO Exemplar
VALUES (2006,5, 'Revista', 3, 2, date'2018-07-10');
INSERT INTO Exemplar
VALUES (2007,5, 'Revista', 3, 2, date'2018-07-10');
INSERT INTO Exemplar
VALUES (2008,5, 'Revista', 3, 2, date'2018-07-10');
INSERT INTO Exemplar
VALUES (2009,5, 'Revista', 3, 2, date'2018-07-10');
INSERT INTO Exemplar
VALUES (2010,5, 'Tese', 3, 2, date'2018-07-10');
INSERT INTO Exemplar
VALUES (2011,5, 'Tese', 3, 2, date'2018-07-10');
INSERT INTO Exemplar
VALUES (2012,5, 'Tese', 3, 2, date'2018-07-10');
INSERT INTO Exemplar
VALUES (2013,5, 'Tese', 3, 2, date'2018-07-10');
INSERT INTO Exemplar
VALUES (2014,5, 'Tese', 3, 2, date'2018-07-10');
INSERT INTO Exemplar
VALUES (2015,5, 'Tese', 3, 2, date'2018-07-10');
INSERT INTO Exemplar
VALUES (2016,5, 'Tese', 3, 2, date'2018-07-10');
INSERT INTO Exemplar
VALUES (2017,5, 'Tese', 3, 2, date'2018-07-10');
INSERT INTO Exemplar
VALUES (2018,5, 'Tese', 3, 2, date'2018-07-10');
INSERT INTO Exemplar
VALUES (2019,5, 'Tese', 3, 2, date'2018-07-10');

--2.4 INSERÇÃO TABELA EMPRESTA:
SELECT * FROM Empresta; 
INSERT INTO Empresta
VALUES (date'2018-06-04', date'2018-07-04', 111, 1111);
INSERT INTO Empresta
VALUES (date'2018-07-05', date'2018-08-05', 222, 2222);
INSERT INTO Empresta
VALUES (date'2018-08-06', date'2018-09-06', 333, 3333);
INSERT INTO Empresta
VALUES (date'2018-09-07', date'2018-10-07', 444, 4444);
INSERT INTO Empresta
VALUES (date'2018-10-08', date'2018-11-08', 555, 5555);
INSERT INTO Empresta
VALUES (date'2018-11-09', date'2018-12-10', 666, 6666);
INSERT INTO Empresta
VALUES (date'2018-11-10', date'2018-12-11', 777, 7777);
INSERT INTO Empresta
VALUES (date'2018-10-11', date'2018-11-11', 888, 8888);
INSERT INTO Empresta
VALUES (date'2018-09-12', date'2018-10-12', 999, 9999);
INSERT INTO Empresta
VALUES (date'2018-09-13', date'2018-10-13', 100, 1000);

--2.5 INSERÇÃO TABELA BIBLIOTECARIO:
SELECT * FROM Bibliotecario; 
INSERT INTO Bibliotecario
VALUES (110, 'bib110', 's1', date'2016-09-13', '12345611111');
INSERT INTO Bibliotecario
VALUES (120, 'bib120', 's2', date'2015-09-13', '21345622222');
INSERT INTO Bibliotecario
VALUES (130, 'bib130', 's3', date'2014-09-13', '13345633333');
INSERT INTO Bibliotecario
VALUES (140, 'bib140', 's4', date'2016-09-13', '23345644444');
INSERT INTO Bibliotecario
VALUES (150, 'bib150', 's5', date'2014-09-13', '45745655555');
INSERT INTO Bibliotecario
VALUES (160, 'bib160', 's1', date'2015-09-13', '32145666666');
INSERT INTO Bibliotecario
VALUES (170, 'bib170', 's2', date'2017-09-13', '13302377777');
INSERT INTO Bibliotecario
VALUES (180, 'bib180', 's3', date'2018-09-13', '23345388888');
INSERT INTO Bibliotecario
VALUES (190, 'bib190', 's4', date'2017-09-13', '45766699999');
INSERT INTO Bibliotecario
VALUES (101, 'bib101', 's5', date'2014-09-13', '32145600000');

--2.6 INSERÇÃO TABELA LIVRO:
SELECT * FROM Livro; 
INSERT INTO Livro
VALUES (7777,'O código Da Vinci' ,'Dan Brown', 'Belas Artes', '5', '1111111111', 2009);
INSERT INTO Livro
VALUES (8888,'Inglês para vestibular' ,'Richard Loui', 'LearnEnglish', '2', '2222222222222', 2015);
INSERT INTO Livro
VALUES (1111,'Botânica Avançada' ,'Eduardo Lima', 'Botania', '3', '3333333333', 2001);
INSERT INTO Livro
VALUES (2222,'Um curso de cálculo' ,'Hamilton Guidorizzi', 'Saraiva', '1', '4444444444444', 2008);
INSERT INTO Livro
VALUES (3333,'Português ens. Médio' ,'Aline Santos', 'Belas Artes', '3', '5555555555', 2013);
INSERT INTO Livro
VALUES (4444,'Mecânica Aplicada' ,'André Cristoforo', 'Física Mecânica', '2', '6666666666', 2017);
INSERT INTO Livro
VALUES (5555,'O caminho do guerreiro pacífico' ,'Dan Millman', 'Caminho Sagrado', '4', '7777777777', 2011);
INSERT INTO Livro
VALUES (6666,'O coração delator' ,'Edgar Allan Poe', 'Romantica', '1', '8888888888888', 1980);
INSERT INTO Livro
VALUES (9999,'Francês Básico' ,'Jaquin Vaqués', 'Le France', '7', '9999999999', 2010);
INSERT INTO Livro
VALUES (1000,'Alemão Intermediário' ,'Mesut Ozil', 'Alemanha', '4', '1100000111', 2016);

--2.7 INSERÇÃO TABELA MÍDIA:
SELECT * FROM Midia; 
INSERT INTO Midia
VALUES (1111, 'Audio', '1');
INSERT INTO Midia
VALUES (2222, 'Audio', '2');
INSERT INTO Midia
VALUES (3333, 'Audio', '1');
INSERT INTO Midia
VALUES (4444, 'E-book', '3');
INSERT INTO Midia
VALUES (5555, 'E-book', '3');
INSERT INTO Midia
VALUES (6666, 'Audio', '1');
INSERT INTO Midia
VALUES (7777, 'E-book', '1');
INSERT INTO Midia
VALUES (8888, 'E-book', '2');
INSERT INTO Midia
VALUES (9999, 'Audio', '2');
INSERT INTO Midia
VALUES (1000, 'Audio', '1');

--2.8 INSERÇÃO TABELA TEM_RELAÇÃO:
SELECT * FROM Tem_Relacao; 
INSERT INTO Tem_relacao
VALUES (1111,1111);
INSERT INTO Tem_relacao
VALUES (2222,2222);
INSERT INTO Tem_relacao
VALUES (3333,3333);
INSERT INTO Tem_relacao
VALUES (4444,4444);
INSERT INTO Tem_relacao
VALUES (5555,5555);
INSERT INTO Tem_relacao
VALUES (6666,6666);
INSERT INTO Tem_relacao
VALUES (7777,7777);
INSERT INTO Tem_relacao
VALUES (8888,8888);
INSERT INTO Tem_relacao
VALUES (9999,9999);
INSERT INTO Tem_relacao
VALUES (1000,1000);

--2.9 INSERÇÃO TABELA REVISTA:
SELECT * FROM Revista;
INSERT INTO Revista
VALUES (2000,'Veja', 101, date'2008-10-22', 'Veja');
INSERT INTO Revista
VALUES (2001,'IstoÉ', 10, date'2008-10-22', 'IstoÉ');
INSERT INTO Revista
VALUES (2002,'Folha de SP', 11, date'2008-10-22', 'Folha de SP');
INSERT INTO Revista
VALUES (2003,'Época', 105, date'2008-10-22', 'Época');
INSERT INTO Revista
VALUES (2004,'Forbes', 108, date'2008-10-22', 'Forbes');
INSERT INTO Revista
VALUES (2005,'The Economist', 27, date'2008-10-22', 'The Economist');
INSERT INTO Revista
VALUES (2006,'Veja', 31, date'2008-10-22', 'Veja');
INSERT INTO Revista
VALUES (2007,'Época', 71, date'2008-10-22', 'Época');
INSERT INTO Revista
VALUES (2008,'Forbes', 101, date'2008-10-22', 'Forbes');
INSERT INTO Revista
VALUES (2009,'Super Interessante', 13, date'2008-10-22', 'Super Interessante');

--2.10 INSERÇÃO TABELA TESEDISSERTACAO:
SELECT * FROM TeseDissertacao; 
INSERT INTO TeseDissertacao
VALUES (2010,'IBB', 'Biologia', 'José', date'2008-10-22', 'Ufscar');
INSERT INTO TeseDissertacao
VALUES (2011,'IMB', 'Matemática', 'Maria', date'2015-10-05', 'Ufscar');
INSERT INTO TeseDissertacao
VALUES (2012,'IFB', 'Física', 'Ana', date'2014-10-13', 'Ufscar');
INSERT INTO TeseDissertacao
VALUES (2013,'ICB', 'Computação', 'Gustavo', date'2007-10-07', 'Ufscar');
INSERT INTO TeseDissertacao
VALUES (2014,'IQB', 'Química', 'Luís', date'2009-07-22', 'Ufscar');
INSERT INTO TeseDissertacao
VALUES (2015,'ICivB', 'Engenharia Civil', 'Amanda', date'2017-11-15', 'Ufscar');
INSERT INTO TeseDissertacao
VALUES (2016,'IPB', 'Engenharia de Produção', 'Marcela', date'2008-10-08', 'Ufscar');
INSERT INTO TeseDissertacao
VALUES (2017,'IEqB', 'Engenharia Química', 'Luana', date'2010-10-10', 'Ufscar');
INSERT INTO TeseDissertacao
VALUES (2018,'ILB', 'Letras', 'Yuri', date'2016-10-02', 'Ufscar');
INSERT INTO TeseDissertacao
VALUES (2019,'ICCB', 'Ciências Sociais', 'Carlos', date'2015-07-22', 'Ufscar');

--2.11 INSERÇÃO TABELA TESEDISSERTACAO_PALAVRA_CHAVE:
SELECT * FROM TeseDissertacao_Palavra_Chave; 
INSERT INTO TeseDissertacao_Palavra_Chave
VALUES ('Biologia',2010);
INSERT INTO TeseDissertacao_Palavra_Chave
VALUES ('Matemática',2011);
INSERT INTO TeseDissertacao_Palavra_Chave
VALUES ('Física',2012);
INSERT INTO TeseDissertacao_Palavra_Chave
VALUES ('Computação',2013);
INSERT INTO TeseDissertacao_Palavra_Chave
VALUES ('Química',2014);
INSERT INTO TeseDissertacao_Palavra_Chave
VALUES ('Civil',2015);
INSERT INTO TeseDissertacao_Palavra_Chave
VALUES ('Produção',2016);
INSERT INTO TeseDissertacao_Palavra_Chave
VALUES ('Eng Química',2017);
INSERT INTO TeseDissertacao_Palavra_Chave
VALUES ('Letras',2018);
INSERT INTO TeseDissertacao_Palavra_Chave
VALUES ('Sociais',2019);

--3 CONSULTAS ENVOLVENDO JUNÇÃO IMPLÍCITA
--3.1 HISTÓRICO DE PESSOAS E SEUS RESPECTIVOS LIVROS EMPRESTADOS NO MÊS DE SETEMBRO
SELECT p.cpf, p.nome ,e.exemplar_cod, l.titulo, e.periodo_DataInicial 
FROM Empresta e , Livro l, Usuario u, Pessoa p 
WHERE  e.exemplar_cod=l.codigo_exemplar AND
e.usuario_cod=u.codigo_usuario AND u.cpf=p.cpf AND EXTRACT(MONTH FROM periodo_DataInicial)=9;

--3.2 LIVROS QUE TÊM MÍDIA ASSOCIADA
SELECT * FROM Midia m, Livro l, Tem_relacao t
WHERE l.codigo_exemplar=t.livro_codExemplar AND m.codigo_exemplar= t.midia_codExemplar;

--3.3 TESES DE DISSERTAÇÃO DA UFSCAR E SUAS RESPECTIVAS PALAVRAS-CHAVE
SELECT * FROM TeseDissertacao td, TeseDissertacao_Palavra_Chave pc
WHERE pc.codigo_exemplar=td.codigo_exemplar AND td.universidade='Ufscar';

--4. CONSULTAS ENVOLVENDO JUNÇÃO INTERNA (3)
--4.1 CONSULTAR O NOME DOS BIBLIOTECÁRIOS DAS SEÇÕES S5 OU S3:
SELECT nome, secao
FROM Pessoa
INNER JOIN Bibliotecario ON Pessoa.cpf = Bibliotecario.cpf
WHERE secao = 's5' or secao ='s3';

 --4.2 CONSULTAR O NOME EM LETRAS MAIUSCULAS E O E-MAIL DOS USUÁRIOS:
SELECT Upper(nome), email
FROM Pessoa
INNER JOIN Usuario ON Pessoa.cpf = Usuario.cpf;

--4.3 CONSULTAR O CÓDIGO DO USUÁRIO QUE EMPRESTOU O LIVRO "O CÓDIGO DA VINCI", DE CÓDIGO 7777:
SELECT codigo_usuario
FROM Usuario
INNER JOIN Empresta ON (Usuario.codigo_usuario = Empresta.usuario_cod)
WHERE Empresta.exemplar_cod = 7777;

--5. CONSULTAS ENVOLVENDO JUNÇÃO EXTERNA (3)
--5.1 LISTAR OS CODIGOS DOS EXEMPLARES E, QUANDO EMRPESTADOS, A DATA DO EMPRESTIMO
SELECT ex.codigo_exemplar, em.periodo_DataInicial FROM Exemplar ex LEFT OUTER JOIN Empresta em ON (ex.codigo_exemplar = em.exemplar_cod);

--5.2 LISTAR OS CODIGOS DOS EXEMPLARES E, SE FOREM TESE DE DISSERTACAO, O NOME DO SUPERVISOR
SELECT ex.codigo_exemplar, te.supervisor FROM TeseDissertacao te RIGHT OUTER JOIN Exemplar ex ON (ex.codigo_exemplar = te.codigo_exemplar);

--5.3 LISTAR O NOME DOS USUARIOS E OS CODIGOS DOS EXEMPLARES EMPRESTADOS POR ELES
SELECT nome, exemplar_cod FROM Pessoa p JOIN 
(SELECT u.cpf, em.exemplar_cod FROM Usuario u LEFT OUTER JOIN Empresta em ON 
    (u.codigo_usuario = em.usuario_cod)) q ON p.cpf = q.cpf;

--6. CONSULTAS ENVOLVENDO AGREGAÇÃO (3)
--6.1 CONSULTAR A QUANTIDADE DE EMPRÉSTIMOS QUE FORAM FEITOS PARA O LIVRO DE CÓDIGO 9999:
SELECT COUNT(*) FROM Empresta WHERE exemplar_cod = '9999';

--6.2 CONSULTAR A MÉDIA E O MÁXIMO DE DIAS DE SUSPENSÃO DOS USUÁRIOS:
SELECT AVG(suspensao), MAX(suspensao) FROM Usuario;

--6.3 CONSULTAR A MEDIA DE QUANTIDADE TOTAL DE EMPRESTIMOS DOS EXEMPLARES:
 SELECT AVG(qtd_total_emprestimos) FROM Exemplar;

--7. TRIGGERS (2)
--7.1 CALCULA IDADE DA PESSOA
ALTER TABLE Pessoa ADD idade INTEGER NULL;
CREATE OR REPLACE TRIGGER calculaidade BEFORE INSERT OR UPDATE ON Pessoa
    FOR EACH ROW 
    BEGIN
        :new.idade := FLOOR(MONTHS_BETWEEN(SYSDATE,data_nascimento)/12);
    END;

--7.2 CALCULA DATA DE DEVOLUÇÃO DO EXEMPLAR
CREATE OR REPLACE TRIGGER datadevolucao BEFORE INSERT OR UPDATE ON Pessoa
    FOR EACH ROW 
    BEGIN
        :new.data_devolucao := DATEADD(DAY,20,data_emprestimo);
    END;

--8. STORE PROCEDURES (2)
--8.1 LIMPA SUSPENSAO DO USUARIO
CREATE OR REPLACE PROCEDURE limpaSuspensao (cod in INTEGER)
    IS
        BEGIN
            UPDATE Usuario 
            SET suspensao = 0
            WHERE codigo_usuario = cod;
        END;

--8.2 RESETA SENHA DO USUARIO PARA O PADRAO
CREATE OR REPLACE PROCEDURE resetaSenha (cod in INTEGER)
    IS
        BEGIN
            UPDATE Usuario 
            SET senha_usuario = '123'
            WHERE codigo_usuario = cod;
        END;


--9. ATUALIZAR UMA TABELA ADICIONANDO UM CAMPO
ALTER TABLE Exemplar ADD data_devolucao DATE NULL;  

--10. ATUALIZAR AS TUPLAS DA TABELA, ATUALIZANDO O VALOR DO CAMPO ADICIONADO
UPDATE Exemplar SET data_devolucao = CURRENT_DATE;