-- Exercicios SQL
-- Lista 1
-- Aluna: Bruna Zamith Santos
-- RA: 628093
-- Data: 27/11/2018

--Criar as tabelas
CREATE TABLE DEPT (
	DCODIGO CHAR(3) NOT NULL PRIMARY KEY,
	DNOME VARCHAR(36) NOT NULL,
	GERENTE CHAR(6),
	DSUPER CHAR(3),
	CONSTRAINT FK_DSUPER FOREIGN KEY (DSUPER) REFERENCES DEPT(DCODIGO) ON DELETE CASCADE
);

CREATE TABLE EMPR (
	-- CHAR TEM TAMANHO FIXO, VARCHAR TEM TAMANHO VARIAVEL
	MATR CHAR(6) NOT NULL PRIMARY KEY,
	NOME VARCHAR(12) NOT NULL,
	SOBRENOME VARCHAR(15) NOT NULL,
	DEPT CHAR(3),
	FONE CHAR(14),
	DINADIM DATE,
	CARGO CHAR(10),
	NIVELED NUMERIC,
	SEX CHAR(1),
	DATANAS DATE,
	-- O SALARIO EH MENSAL
	SALARIO NUMERIC(9,2),
	BONUS NUMERIC(9,2),
	COMIS NUMERIC(9,2),
	CONSTRAINT CK_EMPR_SEX check (SEX='F' OR SEX='M'),
	CONSTRAINT FK_DEPT FOREIGN KEY (DEPT) REFERENCES DEPT(DCODIGO) ON DELETE CASCADE
);

CREATE TABLE PROJETO (
	PCODIGO CHAR(6) NOT NULL PRIMARY KEY,
	PNOME VARCHAR(24) NOT NULL,
	DCODIGO CHAR(3) NOT NULL,
	RESP CHAR(6) NOT NULL,
	EQUIPE NUMERIC(5),
	DATAINI DATE,
	DATAFIM DATE,
	PSUPER CHAR(6),
	CONSTRAINT FK_DEPT_COD FOREIGN KEY (DCODIGO) REFERENCES DEPT(DCODIGO) ON DELETE CASCADE
);

--Inserções
INSERT INTO DEPT (DCODIGO, DNOME, GERENTE) VALUES('A00','Computação','Lais');
INSERT INTO DEPT (DCODIGO, DNOME, DSUPER) VALUES('L12','Direito','A00');
INSERT INTO DEPT VALUES('R45','Engenharia Civil','Jonas','L12');
INSERT INTO DEPT (DCODIGO, DNOME, DSUPER) VALUES('A03','Serviços de Computador','R45');
INSERT INTO DEPT VALUES('B02','Serviços de Suporte','Jonas','A00');
INSERT INTO DEPT VALUES('D11','Engenharia de Materiais','Lucas','R45');
INSERT INTO DEPT (DCODIGO, DNOME, DSUPER) VALUES('D21','Suporte','A00');
INSERT INTO DEPT (DCODIGO, DNOME, DSUPER) VALUES('B01','Biologia','L12');
INSERT INTO DEPT (DCODIGO, DNOME) VALUES('C01','Matematica');
INSERT INTO DEPT (DCODIGO, DNOME) VALUES('D01','Fisica');
INSERT INTO DEPT (DCODIGO, DNOME) VALUES('E01','Sociologia');
INSERT INTO DEPT VALUES('E02','Psicologia', 'Bruno', 'E01');
INSERT INTO DEPT VALUES('D02','Fisica Computacional', 'Bruno', 'D01');


INSERT INTO EMPR VALUES ('000000', 'Bruna', 'Zamith', 'A00', '12991667541', 
	date'2018-01-12', 'DataScient', '10', 'F', date'1997-10-26', '872000', '1500', '100');
INSERT INTO EMPR VALUES ('000001', 'Marcos', 'Faglioni', 'A00', '000000000', 
	date'2018-03-27', 'Hardware', '10', 'M', date'1995-03-27', '872000', '1500', '100');
INSERT INTO EMPR VALUES ('000002', 'Tulio', 'Reis', 'A00', '000000000', 
	date'2018-03-27', 'Consult', '10', 'M', date'1995-03-27', '872000', '1500', '100');
INSERT INTO EMPR VALUES ('000003', 'Regina', 'Zamith', 'L12', '000000000', 
	date'2018-01-12', 'BrProtect', '10', 'F', date'1963-08-06', '1500000', '1500', '100');
INSERT INTO EMPR VALUES ('000004', 'Helio', 'dos Santos', 'R45', '000000000', 
	date'2018-01-12', 'Autonomo', '10', 'M', date'1961-09-04', '1500000', '1500', '100');
INSERT INTO EMPR VALUES ('000005', 'Ze', 'da Silva', 'A03', '000000000', 
	date'2010-01-01', 'Q', '1', 'M', date'1950-01-01', '1000', '10', '10');
INSERT INTO EMPR VALUES ('000006', 'Maria', 'de Souza', 'B02', '000000000', 
	date'2010-01-01', 'Gerente', '2', 'F', date'1950-01-01', '40000', '10', '10');
INSERT INTO EMPR VALUES ('000007', 'Maria', 'da Silva', 'D11', '000000000', 
	date'2010-01-01', 'Q', '1', 'F', date'1950-01-01', '2000', '10', '10');
INSERT INTO EMPR VALUES ('000008', 'Paulo', 'Jose', 'D21', '000000000', 
	date'2010-01-01', 'Q', '1', 'M', date'1950-01-01', '2000', '10', '10');
INSERT INTO EMPR VALUES ('000009', 'Pedro', 'Pereira', 'D21', '000000000', 
	date'2010-01-01', 'Q', '1', 'M', date'1950-01-01', '2000', '10', '10');
INSERT INTO EMPR VALUES ('000010', 'Maria', 'de Souza', 'B02', '000000000', 
	date'2010-01-01', 'Gerente', '17', 'F', date'1950-01-01', '2000', '10', '10');
INSERT INTO EMPR VALUES ('000011', 'Pedro', 'de Souza', 'B01', '000000000', 
	date'2010-01-01', 'Gerente', '1', 'M', date'1950-01-01', '45000', '10', '10');
INSERT INTO EMPR VALUES ('000012', 'Joao', 'Tavares', 'C01', '000000000', 
	date'2010-01-01', 'Q', '1', 'M', date'1950-01-01', '2100', '60', '90');
INSERT INTO EMPR VALUES ('000013', 'Joao', 'Lima', 'B01', '000000000', 
	date'2010-01-01', 'Q', '1', 'M', date'1950-01-01', '2500', '60', '90');
INSERT INTO EMPR VALUES ('000014', 'Leonardo', 'Rodrigues', 'D01', '000000000', 
	date'2010-01-01', 'RepVenda', '1', 'M', date'1950-01-01', '1100', '500', '790');
INSERT INTO EMPR VALUES ('000015', 'Gustavo', 'Alves', 'E01', '000000000', 
	date'2010-01-01', 'Q', '1', 'M', date'1950-01-01', '1700', '500', '790');
INSERT INTO EMPR VALUES ('000016', 'Luana', 'Alves', 'E02', '000000000', 
	date'2010-01-01', 'RepVenda', '1', 'F', date'1950-01-01', '3500', '100', '0');
INSERT INTO EMPR VALUES ('000017', 'Bruno', 'Aquino', 'D02', '12991667541', 
	date'2018-01-12', 'DataScient', '10', 'M', date'1997-10-26', '872000', '1500', '100');


-- LAB SQL SELECT BÁSICO
--1) Mostre o sobrenome, primeiro nome, departamentos data de nascimento, data de admissão e salário de todos os empregados que ganham mais que $30.000 por ano
SELECT SOBRENOME, NOME, DEPT, DATANAS, DINADIM, SALARIO FROM EMPR WHERE (SALARIO*12 >= 30000);

--2) Liste todas as informações de qualquer departamento cujo gerente seja desconhecido.
SELECT * FROM DEPT WHERE GERENTE IS NULL;

--3) Mostre o sobrenome, primeiro nome, departamento, data de nascimento, data de admissão e salário de todos os empregados que ganhem menos de $20.000 por ano. Classifique o resultado pelo sobrenome e primeiro nome.
SELECT SOBRENOME, NOME, DEPT, DATANAS, DINADIM, SALARIO FROM EMPR WHERE (SALARIO*12 >= 20000) ORDER BY SOBRENOME ASC;

--4) Liste tudo sobre os departamentos subordinados ao departamento A00.
SELECT * FROM DEPT WHERE DSUPER = 'A00';

--5) Liste o código e o nome dos departamento que apresentam “SERVIÇO” compondo seu nome..
SELECT DCODIGO, DNOME FROM DEPT WHERE DNOME LIKE '%Serviço%';

--6) Mostre a matricula, sobrenome, departamento e telefone dos empregados cujo código de departamento estejam compreendidos entre D11 e D21 (inclusive).
SELECT MATR, SOBRENOME, DEPT, FONE FROM EMPR WHERE DEPT = 'D11' OR DEPT = 'D21';

--7) Produza uma lista dos empregados nos departamentos B0l, C0l e D01, mostrando o sobrenome, departamento e rendimento (salário + comissão) Liste a saída em ordem descendente de rendimento dentro de cada departamento.
SELECT SOBRENOME, DEPT, SALARIO+COMIS AS RENDIMENTO FROM EMPR WHERE DEPT = 'B01' OR DEPT = 'C01' OR DEPT = 'D01' ORDER BY DEPT, RENDIMENTO DESC;

--8) Mostre o sobrenome, salário anual e departamento dos empregados com salário mensal maior que $3000. Classifique a lista pelo sobrenome.
SELECT SOBRENOME, SALARIO*12, DEPT FROM EMPR WHERE (SALARIO >= 3000) ORDER BY SOBRENOME ASC;

--9) Produza uma lista de todos os empregados cujo departamento somente com “E”. Mostre a matricula, primeiro nome e sobrenome. Classifique pelo sobrenome.
SELECT MATR, NOME, SOBRENOME FROM EMPR WHERE DEPT LIKE '%E%' ORDER BY SOBRENOME ASC;

--10) Produza uma lista dos homens cujo salário mensal seja menor do que $1600. Mostre a matricula, sobrenome e salário mensal. Classifique cm ordem descendente de salário.
SELECT MATR, SOBRENOME, SALARIO FROM EMPR WHERE (SALARIO < 1600) AND SEX = 'M' ORDER BY SALARIO DESC;

--11) Para cada representante de vendas (REPVENDA), apresente a comissão em porcentagem do total de rendimento (salário, bônus e comissão). Liste nome e porcentagem.
SELECT SOBRENOME, ((100*COMIS)/(SALARIO+COMIS+BONUS)) FROM EMPR WHERE CARGO = 'RepVenda';

--12) Mostre todas as informações referentes aos departamentos “E01” e departamentos subordinados ao departamento “E01”.
SELECT * FROM DEPT WHERE DCODIGO = 'E01' OR DSUPER = 'E01';

--13) Liste o sobrenome, salário, função e nível de educação de qualquer empregado que se enquadre numa das seguintes condições:
-- Salário maior que $40.000;
-- Função gerente com nível menor que 16.
SELECT SOBRENOME,SALARIO,CARGO,NIVELED FROM EMPR WHERE (SALARIO>=40000) OR (CARGO = 'Gerente' AND (NIVELED < 16));

-- LAB SQL SELECT AVANÇADO
--1) Mostre a soma dos salários de toda a companhia, salário médio, salário mínimo e o salário máximo.
SELECT SUM(SALARIO), AVG(SALARIO), MIN(SALARIO), MAX(SALARIO) FROM EMPR;

--2) Qual é o primeiro sobrenome em ordem alfabética?
SELECT MIN(SOBRENOME) FROM EMPR;

--3) Quantos departamentos tem empregados?
SELECT COUNT(*) FROM (SELECT DISTINCT DCODIGO FROM DEPT INNER JOIN EMPR ON DEPT.DCODIGO = EMPR.DEPT);

--4) Mostre o salário médio para cada função.
SELECT CARGO, AVG(SALARIO) FROM EMPR GROUP BY CARGO;

--5) Liste a média salarial das funções onde o salário médio seja maior que $35.000.
SELECT CARGO, MEDIA FROM (SELECT CARGO, AVG(SALARIO) AS MEDIA FROM EMPR GROUP BY CARGO) WHERE MEDIA >= 35000;

--6) Mostre o sobrenome e função dos empregados dos departamentos cujo nome inclua “PLAN”.
SELECT SOBRENOME, CARGO FROM EMPR INNER JOIN DEPT ON DEPT.DCODIGO = EMPR.DEPT WHERE DEPT.DNOME LIKE '%PLAN%';

--7) Mostre o sobrenome e primeiro nome de todos os empregados que trabalham no mesmo departamento do Adamson.
SELECT SOBRENOME, NOME FROM EMPR WHERE DEPT = (SELECT DEPT FROM EMPR WHERE NOME = 'Adamson');

--8) Produza uma lista mostrando departamento média salarial e quantidade de empregados para cada departamento excluindo a função “ATENDENTE”.
-- Exclua departamentos com menos de quatro empregados
-- Classifique a lista em ordem descendente de quantidade de empregados.
SELECT DEPT, MEDIA, CONTADOR FROM (SELECT DEPT, AVG(SALARIO) AS MEDIA, COUNT(*) AS CONTADOR FROM EMPR WHERE CARGO <> 'ATENDENTE' GROUP BY DEPT) WHERE CONTADOR >= 4 ORDER BY CONTADOR DESC;  

--9) Liste o departamento e sobrenome dos gerentes dos departamentos subordinados ao departamento D01.
SELECT DEPT, SOBRENOME FROM EMPR INNER JOIN DEPT ON EMPR.NOME = DEPT.GERENTE WHERE DEPT.DSUPER = 'D01';

--10) Mostre a média salarial dos homens e a média salarial das mulheres de cada departamento. Identifique os departamentos pelo código e pelo nome. Classifique o resultado em ordem descendente de salário dentro de cada departamento.
SELECT DCODIGO, DNOME, SEX, AVG(SALARIO) AS MEDIA FROM DEPT JOIN EMPR ON DEPT.DCODIGO = EMPR.DEPT GROUP BY DCODIGO, DNOME, SEX ORDER BY MEDIA DESC;



