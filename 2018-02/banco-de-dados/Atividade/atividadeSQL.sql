-- Banco de Dados - Atividade
-- Bruna Zamith Santos, 628093

-- Realizei toda a atividade a partir do terminal no Postgres
-- sudo -i -u postgres
-- psql

-- 1. Banco de Dados:
-- usuario(matricula*,nome,email,endereco,telefone)
-- secao(codigo*, descricao, localizacao)
-- emprestimo(codigo*,dataHora,matriculaUsuario,dataDevolucao)
--     matriculaUsuario ref usuario.matricula
-- livro(codigo*,titulo,autor,codigoSecao)
--    codigoSecao ref secao.codigo
-- livro_emprestimo(codigoLivro*, codigoEmprestimo*)
--     codigoEmpresimo ref emprestimo.codigo
--     codigoLivro ref livro.codigo


-- a) Seguindo o modelo acima, criar um banco de dados chamado "Biblioteca" e suas tabelas com suas chaves de referencia.

Create database Biblioteca;

Create table USUARIO (
    matricula Char(6) Primary Key, 
    nome Varchar(100), 
    email Varchar(100),
    endereco Varchar(100),
    telefone Char(11)
);

Create table SECAO (
    codigo Char(6) Primary Key,
    descricao Varchar(100),
    localizacao Varchar(100)
);

Create table EMPRESTIMO (
      codigo Char(6) Primary Key,
      dataHora Date,
      matriculaUsuario Char(6),
      dataDevolucao Date,
      constraint fk_emprestimo foreign key (matriculaUsuario)
            references USUARIO (matricula)
            on delete cascade
);

Create table LIVRO (
      codigo Char(6) Primary Key,
      titulo Varchar(100),
      autor Varchar(100),
      codigoSecao Char(6),
      constraint fk_livro foreign key (codigoSecao)
            references SECAO (codigo)
            on delete cascade
);

Create table LIVRO_EMPRESTIMO (
      codigoLivro Char(6),
      codigoEmprestimo Char(6),
      constraint pk_livro_emprestimo primary key (codigoLivro, codigoEmprestimo),
      constraint fk_livro_e foreign key (codigoLivro)
            references LIVRO (codigo)
            on delete cascade,
      constraint fk_l_emprestimo foreign key (codigoEmprestimo) 
            references EMPRESTIMO (codigo)
            on delete cascade
);

-- b) Liste todas as tabelas do banco de dados Biblioteca para verificar se as mesmas foram criadas corretamente.

\dt;
select * from USUARIO;
select * from SECAO;
select * from EMPRESTIMO;
select * from LIVRO;
select * from LIVRO_EMPRESTIMO;

-- c) Inserir, pelo menos, 7 valores diferentes em cada tabela.
-- 1
insert into USUARIO 
      (matricula, nome, email, endereco, telefone) 
      values
      ('628093','Bruna Zamith','bruna.zamith@hotmail.com','Adolfo Catani','12991667541');
-- 2
insert into USUARIO 
      values
      ('628301','Marcos Faglioni','marcosfagli@gmail.com','Alojamento UFSCar','16996026929');
-- 3
insert into USUARIO 
      (matricula, nome, email, telefone) 
      values 
      ('628050','Tulio Reis','tulior3is@gmail.com','35991775358');
-- 4
insert into USUARIO
      values
      ('726494','Alisson Hayasi','hayasi.ahs@gmail.com','Alojamento UFSCar','16988349612');
-- 5
insert into USUARIO
      values
      ('594970','João Victor Pacheco','jvp1805@gmail.com','Adolfo Catani','14991212550');
-- 6
insert into USUARIO
      (matricula, nome, email)
      values
      ('628182','Leonardo Utida','utidaleonardo@gmail.com');
-- 7
insert into USUARIO
      (matricula, nome, email)
      values
      ('100000','Paulo Jeunon','paulopljsousa@gmail.com');

-- 1
insert into SECAO 
      (codigo, descricao, localizacao) 
      values
      ('001259','Literatura Inglesa','BCo, Piso 2, Esquerda');
-- 2
insert into SECAO 
      values
      ('446117','Economia','BCo, Piso 5, Esquerda');
-- 3
insert into SECAO 
      values 
      ('088913','Literatura Infanto-Juvenil',NULL);
-- 4
insert into SECAO
      values
      ('976502','Matematica','Bco, Piso 5, Direita');
-- 5
insert into SECAO
      values
      ('100048','Literatura Nacional','BCo, Piso 2, Esquerda');
-- 6
insert into SECAO
      values
      ('054909','Literatura Portuguesa','BCo, Piso 2, Direita');
-- 7
insert into SECAO
      (descricao, codigo, localizacao) 
      values
      ('Literatura Francesa','829543','BCo, Piso 2, Direita');

-- 1
insert into EMPRESTIMO 
      (codigo, dataHora, matriculaUsuario, dataDevolucao) 
      values
      ('000001',date '2018-08-10', 
            (select matricula from USUARIO where nome = 'João Victor Pacheco'),
      date '2018-08-30');
-- 2
insert into EMPRESTIMO 
      (codigo, dataHora, matriculaUsuario, dataDevolucao) 
      values
      ('000002',date '2018-08-12', 
            (select matricula from USUARIO where nome = 'Marcos Faglioni' and endereco = 'Alojamento UFSCar'),
      date '2018-09-02');
--3 
insert into EMPRESTIMO 
      (codigo, dataHora, matriculaUsuario, dataDevolucao) 
      values
      ('000005',date '2018-10-26', '628093', date '2018-11-15');
--4
insert into EMPRESTIMO 
      (codigo, dataHora, matriculaUsuario, dataDevolucao) 
      values
      ('000006',date '2018-10-29', '628093', date '2018-11-18');
-- 5
insert into EMPRESTIMO 
      (codigo, dataHora, matriculaUsuario, dataDevolucao) 
      values
      ('000007',date '2018-11-12', 
            (select matricula from USUARIO where nome = 'Alisson Hayasi'),
      date '2018-12-02');
-- 6
insert into EMPRESTIMO 
      values
      ('000012',date '2018-11-12','628050',date '2018-12-02');
-- 7
insert into EMPRESTIMO 
      values
      ('000016',date '2018-11-17', '628301', date '2018-12-07');

-- 1
insert into LIVRO 
      (codigo,titulo,autor,codigoSecao) 
      values
      ('184563','Olhai os Lirios do Campo','Erico Verissimo',
            (select codigo from SECAO where descricao = 'Literatura Nacional'));
-- 2
insert into LIVRO 
      values
      ('091575','Ensaio sobre a Cegueira','José Saramago',
            (select codigo from SECAO where descricao = 'Literatura Portuguesa'));
--3 
insert into LIVRO 
      values
      ('010036','Grande Sertão Veredas', 'João Guimarães Rosa', 
            (select codigo from SECAO where descricao = 'Literatura Nacional'));
--4
insert into LIVRO 
      values
      ('006660','Um Curso de Calculo Vol 1', 'Hamilton Guidorizzi',   
            (select codigo from SECAO where descricao = 'Matematica'));
-- 5
insert into LIVRO 
      values
      ('126541','Microeconomia', 'Robert Pindyck', 
            (select codigo from SECAO where descricao = 'Economia'));
-- 6
insert into LIVRO 
      values
      ('482309','Os Miseráveis','Victor Hugo','829543');
-- 7
insert into LIVRO 
      values
      ('000001','A Pilula Falante','Monteiro Lobato',
            (select codigo from SECAO where descricao = 'Literatura Infanto-Juvenil'));
-- 8
insert into LIVRO 
      values
      ('091576','Claraboia','José Saramago',
            (select codigo from SECAO where descricao = 'Literatura Portuguesa'));
--9
insert into LIVRO 
      values
      ('006610','Álgebra Linear', 'Alfredo Steinbruch',   
            (select codigo from SECAO where descricao = 'Matematica'));
-- 10
insert into LIVRO 
      (codigo,titulo,autor,codigoSecao) 
      values
      ('122063','A Cartomante','Machado de Assis',
            (select codigo from SECAO where descricao = 'Literatura Nacional'));
-- 11
insert into LIVRO 
      (codigo,titulo,autor,codigoSecao) 
      values
      ('122064','Dom Casmurro','Machado de Assis',
            (select codigo from SECAO where descricao = 'Literatura Nacional'));
-- 12
insert into LIVRO 
      (codigo,titulo,autor,codigoSecao) 
      values
      ('122065','Quincas Borba','Machado de Assis',
            (select codigo from SECAO where descricao = 'Literatura Nacional'));

-- 1
insert into LIVRO_EMPRESTIMO 
      values
      ((select codigo from LIVRO where autor = 'Hamilton Guidorizzi'),
            (select codigo from EMPRESTIMO where matriculaUsuario = 
                  (select matricula from USUARIO where nome = 'João Victor Pacheco')));
-- 2
insert into LIVRO_EMPRESTIMO 
      (codigoLivro, codigoEmprestimo)
      values
      ((select codigo from LIVRO where autor = 'Hamilton Guidorizzi'),'000002');
-- 3
insert into LIVRO_EMPRESTIMO 
      (codigoLivro, codigoEmprestimo)
      values
      ('126541','000002');
-- 4
insert into LIVRO_EMPRESTIMO 
      (codigoEmprestimo,codigoLivro)
      values
      ((select codigo from EMPRESTIMO where matriculaUsuario = '628093' and dataHora = date '2018-10-26'),
      (select codigo from LIVRO where titulo = 'Olhai os Lirios do Campo'));
-- 5
insert into LIVRO_EMPRESTIMO 
      values
      ((select codigo from LIVRO where titulo = 'Ensaio sobre a Cegueira'),
            (select codigo from EMPRESTIMO where matriculaUsuario = '628093' and dataHora = date '2018-10-26'));
-- 6
insert into LIVRO_EMPRESTIMO 
      values
      ((select codigo from LIVRO where titulo = 'Grande Sertão Veredas'),'000006');
-- 7
insert into LIVRO_EMPRESTIMO 
      values
      ((select codigo from LIVRO where titulo = 'Os Miseráveis'),'000007');
-- 8
insert into LIVRO_EMPRESTIMO 
      values
      ('091576','000012');
-- 9
insert into LIVRO_EMPRESTIMO 
      values
      ((select codigo from LIVRO where autor = 'Hamilton Guidorizzi'),'000016');

-- d) Crie e execute consultas de acordo com as informações abaixo:
--    d.1) Número de livros por seção.
      select codigoSecao, count(codigoSecao) from LIVRO group by codigoSecao;

--    d.2) Título (em letras maiúsculas) e Código da Seção dos livros cujo autor é Machado de Assis.
      select (titulo,codigoSecao) from LIVRO where autor = 'Machado de Assis';

--    d.3) Número de empréstimos de livros realizados.
      select count(codigo) from EMPRESTIMO;

--    d.4) Livros que foram emprestados no mês Agosto.
      Create table MESES as select extract(month from dataHora) as dataHora from EMPRESTIMO;
      select count(dataHora) from MESES where dataHora = '08';

--    d.5) Número de matrícula dos usuários que efetuaram empréstimo.
      select matriculaUsuario from EMPRESTIMO intersect select matricula from USUARIO;

--    d.6) Livros que pertencem à seção Matemática.
      select titulo from LIVRO where codigosecao = (select codigo from SECAO where descricao = 'Matematica');

-- e) Crie 5 enunciados diferentes para consulta e escreva o código para comprovar que foi possível retornar o que você deseja. Obs.: Utilize funções de agregaçao e faça pelo menos uma subconsulta. 
--    e.1) Quantos livros foram emprestados pelo usuario cuja matricula é 628093.
      Create table T1 as select matriculaUsuario,codigoLivro,codigoEmprestimo from EMPRESTIMO,LIVRO_EMPRESTIMO where codigo = codigoEmprestimo; 
      select count(matriculaUsuario) from T1 where matriculaUsuario = '628093';

--    e.2) Nome dos livros que foram emprestados.
      select titulo from LIVRO,LIVRO_EMPRESTIMO where codigo = codigoLivro intersect select titulo from LIVRO;       

--    e.3) Número de livros cadastrados.
      select count(codigo) from LIVRO;

--    e.4) Email do usuario que fez um emprestimo no dia 12 de Agosto de 2018.
      select email from USUARIO where matricula = (select matriculaUsuario from EMPRESTIMO where dataHora = '2018-08-12');

--    e.5) Retorne o numero de usuarios por endereço.
      select endereco, count(matricula) from USUARIO group by endereco;


