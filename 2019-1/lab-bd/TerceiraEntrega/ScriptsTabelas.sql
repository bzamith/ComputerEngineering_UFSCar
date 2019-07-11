DROP TABLE Proposta_ACIEPE;
DROP TABLE Proposta_Atividades_Gerais;
DROP TABLE Proposta_Atividade_Extensao;
DROP TABLE Proposta_Programa;
DROP TABLE Projeto;
DROP TABLE Prestacao_Contas;
DROP TABLE Financia;
DROP TABLE Responsavel;
DROP TABLE Tramitacao;
DROP TABLE Envolve;
DROP TABLE Esclarecimento; 
DROP TABLE Proposta_Projeto; 
DROP TABLE Orgao_Financiamento; 
DROP TABLE Edital;
DROP TABLE Participa_CoEx;
DROP TABLE Participa_CaEx;
DROP TABLE Pauta_Reuniao;
DROP TABLE Reuniao;
DROP TABLE Membro_CoEx;
DROP TABLE Membro_CaEx;
DROP TABLE Discente;
DROP TABLE Departamento;
DROP TABLE Centro_Academico;
DROP TABLE Coordena;
DROP TABLE Lotado;
DROP TABLE Setor;
DROP TABLE TA;
DROP TABLE Docente;
DROP TABLE Pro_Reitor;
DROP TABLE Servidor;
DROP TABLE Externo;
DROP TABLE Interno;
DROP TABLE Brasileiro;
DROP TABLE Estrangeiro;
DROP TABLE Email_Pessoa;
DROP TABLE Pessoa;

CREATE TABLE Pessoa(
    nro_pessoa NUMBER PRIMARY KEY,
    nome VARCHAR2(100)
);

CREATE TABLE Email_Pessoa(
    email VARCHAR2(30),
    nro_pessoa NUMBER UNIQUE,
    CONSTRAINT pessoa_nro_pessoa_email_pessoa_fk FOREIGN KEY (nro_pessoa) REFERENCES Pessoa(nro_pessoa) ON DELETE CASCADE,
    CONSTRAINT email_pessoa_pk PRIMARY KEY (nro_pessoa, email)
);

CREATE TABLE Estrangeiro(
   passaporte VARCHAR2(15) UNIQUE,
   nro_pessoa NUMBER,  
   CONSTRAINT pessoa_nro_pessoa_estrangeiro_fk FOREIGN KEY (nro_pessoa) REFERENCES Pessoa(nro_pessoa) ON DELETE CASCADE,
   CONSTRAINT estrangeiro_pk PRIMARY KEY (nro_pessoa, passaporte)
);

CREATE TABLE Brasileiro(
   cpf VARCHAR2(11) UNIQUE,
   nro_pessoa NUMBER,
   CONSTRAINT pessoa_nro_pessoa_brasileiro_fk FOREIGN KEY (nro_pessoa) REFERENCES Pessoa(nro_pessoa) ON DELETE CASCADE,
   CONSTRAINT brasileiro_pk PRIMARY KEY (nro_pessoa, cpf)
);

CREATE TABLE Interno(
    nro_pessoa NUMBER,
    senha VARCHAR(30),
    login VARCHAR(20) UNIQUE,
    CONSTRAINT pessoa_nro_pessoa_interno_fk FOREIGN KEY (nro_pessoa) REFERENCES Pessoa(nro_pessoa) ON DELETE CASCADE,
    CONSTRAINT interno_pk PRIMARY KEY (nro_pessoa)
);

CREATE TABLE Externo(
    nro_pessoa NUMBER,
    CONSTRAINT pessoa_nro_pessoa_externo_fk FOREIGN KEY (nro_pessoa) REFERENCES Pessoa(nro_pessoa) ON DELETE CASCADE,
    CONSTRAINT externo_pk PRIMARY KEY (nro_pessoa)
);

CREATE TABLE Servidor(
    nro_pessoa NUMBER,
    siape NUMBER(7) UNIQUE, 
    data_admissao DATE, 
    data_demissao DATE, 
    CONSTRAINT interno_nro_pessoa_servidor_fk FOREIGN KEY (nro_pessoa) REFERENCES Interno(nro_pessoa) ON DELETE CASCADE,
    CONSTRAINT servidor_pk PRIMARY KEY (nro_pessoa, siape)
);

CREATE TABLE Pro_Reitor(
    nro_pessoa NUMBER,
    siape NUMBER(7),
    data_inicio DATE, 
    data_fim DATE, 
    CONSTRAINT servidor_nro_pessoa_siape_pro_reitor_fk FOREIGN KEY (nro_pessoa, siape) REFERENCES Servidor(nro_pessoa, siape) ON DELETE CASCADE,
    CONSTRAINT pro_reitor_pk PRIMARY KEY (nro_pessoa, siape, data_inicio)
);

CREATE TABLE Docente(
    nro_pessoa NUMBER,
    siape NUMBER(7),
    CONSTRAINT servidor_nro_pessoa_siape_docente_fk FOREIGN KEY (nro_pessoa, siape) REFERENCES Servidor(nro_pessoa, siape) ON DELETE CASCADE,
    CONSTRAINT docente_pk PRIMARY KEY (nro_pessoa, siape)
);

CREATE TABLE TA(
    nro_pessoa NUMBER,
    siape NUMBER(7),
    CONSTRAINT servidor_nro_pessoa_siape_ta_fk FOREIGN KEY (nro_pessoa, siape) REFERENCES Servidor(nro_pessoa, siape) ON DELETE CASCADE,
    CONSTRAINT ta_pk PRIMARY KEY (nro_pessoa, siape)
);

CREATE TABLE Setor(
    sigla VARCHAR2(10) PRIMARY KEY,
    nome VARCHAR2(50),
    endereco VARCHAR2(100),
    telefone VARCHAR2(15),
    email VARCHAR2(30)
);

CREATE TABLE Lotado(
    sigla VARCHAR2(10),
    nro_pessoa NUMBER,
    siape NUMBER(7),
    data_inicio DATE,
    data_fim DATE,
    CONSTRAINT setor_sigla_lotado_fk FOREIGN KEY (sigla) REFERENCES Setor(sigla) ON DELETE CASCADE,
    CONSTRAINT servidor_nro_pessoa_siape_lotado_fk FOREIGN KEY (nro_pessoa,siape) REFERENCES Servidor(nro_pessoa,siape) ON DELETE CASCADE,
    CONSTRAINT lotado_pk PRIMARY KEY (sigla, nro_pessoa, siape, data_inicio)
);

CREATE TABLE Coordena(
    sigla VARCHAR2(10),
    nro_pessoa NUMBER,
    siape NUMBER(7),
    data_inicio DATE,
    data_fim DATE,
    CONSTRAINT setor_sigla_coordena_fk FOREIGN KEY (sigla) REFERENCES Setor(sigla) ON DELETE CASCADE,
    CONSTRAINT servidor_nro_pessoa_siape_coordena_fk FOREIGN KEY (nro_pessoa,siape) REFERENCES Servidor(nro_pessoa,siape) ON DELETE CASCADE,
    CONSTRAINT coordena_pk PRIMARY KEY (sigla, nro_pessoa, siape, data_inicio)
);

CREATE TABLE Centro_Academico(
    sigla VARCHAR2(10),
    CONSTRAINT setor_sigla_centro_academico_fk FOREIGN KEY (sigla) REFERENCES Setor(sigla) ON DELETE CASCADE,
    CONSTRAINT centro_academico_pk PRIMARY KEY (sigla)
);

CREATE TABLE Departamento(
    sigla VARCHAR2(10),
    sigla_centro_academico VARCHAR2(10) NOT NULL,
    CONSTRAINT setor_sigla_departamento FOREIGN KEY (sigla) REFERENCES Setor(sigla) ON DELETE CASCADE,
    CONSTRAINT centro_academico_sigla_centro_academico_departamento_fk FOREIGN KEY (sigla_centro_academico) REFERENCES Centro_Academico(sigla) ON DELETE CASCADE,
    CONSTRAINT departamento_pk PRIMARY KEY (sigla)
);

CREATE TABLE Discente(
    nro_pessoa NUMBER,
    ra VARCHAR2(6) UNIQUE,
    data_ingresso DATE NOT NULL,
    data_egresso DATE,
    curso VARCHAR2(15), 
    sigla VARCHAR(10),
    data_inicio DATE NOT NULL,
    data_fim DATE, 
    CONSTRAINT interno_nro_pessoa_discente_fk FOREIGN KEY (nro_pessoa) REFERENCES Interno(nro_pessoa) ON DELETE CASCADE,
    CONSTRAINT departamento_sigla_discente_fk FOREIGN KEY (sigla) REFERENCES Departamento(sigla) ON DELETE CASCADE,
    CONSTRAINT discente_pk PRIMARY KEY (nro_pessoa, ra)
);

CREATE TABLE Membro_CaEx(
    nro_pessoa NUMBER,
    siape NUMBER(7),
    sigla VARCHAR2(10),
    data_inicio DATE,
    data_fim DATE,
    CONSTRAINT servidor_nro_pessoa_siape_membro_caex_fk FOREIGN KEY (nro_pessoa,siape) REFERENCES Servidor(nro_pessoa,siape) ON DELETE CASCADE,
    CONSTRAINT setor_sigla_membro_caex_fk FOREIGN KEY (sigla) REFERENCES Setor(sigla) ON DELETE CASCADE,
    CONSTRAINT membro_caex_pk PRIMARY KEY (nro_pessoa,siape,data_inicio,sigla)
);

CREATE TABLE Membro_CoEx(
    nro_pessoa NUMBER,
    sigla VARCHAR2(10),
    data_inicio DATE,
    data_fim DATE,
    CONSTRAINT interno_nro_pessoa_membro_coex_fk FOREIGN KEY (nro_pessoa) REFERENCES Interno(nro_pessoa) ON DELETE CASCADE,
    CONSTRAINT setor_sigla_membro_coex_fk FOREIGN KEY (sigla) REFERENCES Setor(sigla) ON DELETE CASCADE,
    CONSTRAINT membro_coex_pk PRIMARY KEY (nro_pessoa,data_inicio,sigla)
);

CREATE TABLE Reuniao(
    cod_reuniao VARCHAR(20) PRIMARY KEY,
    nro_pessoa_pro_reitor NUMBER,
    siape_pro_reitor NUMBER(7),
    data_inicio_pro_reitor DATE,
    tipo VARCHAR(10) NOT NULL,
    prioridade VARCHAR(15) NOT NULL,
    ata VARCHAR(40),
    local VARCHAR(30) NOT NULL,
    hora INT NOT NULL,
    minuto INT NOT NULL,
    data DATE NOT NULL,
    data_convocacao DATE NOT NULL,
    CONSTRAINT pro_reitor_nro_pessoa_siape_data_inicio_reuniao_fk FOREIGN KEY (nro_pessoa_pro_reitor,siape_pro_reitor, data_inicio_pro_reitor) REFERENCES Pro_Reitor(nro_pessoa,siape,data_inicio) ON DELETE CASCADE
);

CREATE TABLE Pauta_Reuniao(
    nome VARCHAR2(25),
    cod_reuniao VARCHAR(20),
    CONSTRAINT reuniao_nome_pauta_reuniao_fk FOREIGN KEY (cod_reuniao) REFERENCES Reuniao(cod_reuniao) ON DELETE CASCADE,
    CONSTRAINT pauta_reuniao_pk PRIMARY KEY (cod_reuniao, nome)
);

CREATE TABLE Participa_CaEx(
    cod_reuniao VARCHAR(20),
    nro_pessoa NUMBER,
    siape NUMBER(7),
    sigla VARCHAR2(10),
    data_inicio DATE,
    CONSTRAINT reuniao_cod_reuniao_participa_caex_fk FOREIGN KEY (cod_reuniao) REFERENCES Reuniao(cod_reuniao) ON DELETE CASCADE,
    CONSTRAINT membro_caex_nro_pessoa_siape_data_inicio_sigla_participa_caex_fk FOREIGN KEY (nro_pessoa,siape,data_inicio,sigla) REFERENCES Membro_CaEx(nro_pessoa,siape,data_inicio,sigla) ON DELETE CASCADE,
    CONSTRAINT participa_caex_pk PRIMARY KEY (cod_reuniao,nro_pessoa,siape,data_inicio,sigla)
);

CREATE TABLE Participa_CoEx(
    cod_reuniao VARCHAR(20),
    nro_pessoa NUMBER,
    sigla VARCHAR2(10),
    data_inicio DATE,
    CONSTRAINT reuniao_cod_reuniao_participa_coex_fk FOREIGN KEY (cod_reuniao) REFERENCES Reuniao(cod_reuniao) ON DELETE CASCADE,
    CONSTRAINT membro_coex_nro_pessoa_siape_data_inicio_sigla_participa_coex_fk FOREIGN KEY (nro_pessoa,data_inicio,sigla) REFERENCES Membro_CoEx(nro_pessoa,data_inicio,sigla) ON DELETE CASCADE,
    CONSTRAINT participa_coex_pk PRIMARY KEY (cod_reuniao,nro_pessoa,data_inicio,sigla)
);

CREATE TABLE Edital(
    id_edital NUMBER PRIMARY KEY,
    nro_pessoa NUMBER NOT NULL,
    siape NUMBER(7) NOT NULL,
    sigla VARCHAR2(10) NOT NULL,
    data_inicio DATE NOT NULL,
    restricoes VARCHAR2(200),
    nro_bolsistas NUMBER,
    valor FLOAT,
    duracao NUMBER,
    recurso_custeio VARCHAR2(100),
    CONSTRAINT membro_caex_nro_pessoa_siape_data_inicio_sigla_edital_fk FOREIGN KEY (nro_pessoa,siape,sigla,data_inicio) REFERENCES Membro_CaEx(nro_pessoa,siape,sigla,data_inicio) ON DELETE CASCADE
);

CREATE TABLE Orgao_Financiamento(
    cnpj VARCHAR2(14) PRIMARY KEY,
    tipo VARCHAR2(10)
);

CREATE TABLE Proposta_Projeto(
    id_proposta NUMBER,
    nro_versao INT,
    nro_pessoa NUMBER,
    siape NUMBER(7),
    nro_do_processo INT UNIQUE, 
    grande_area VARCHAR2(10), 
    linha_programática VARCHAR2(200), 
    objetivos VARCHAR2(500), 
    apresentacao_e_justificativas VARCHAR2(200),
    data_alteracao DATE, 
    alteracao VARCHAR2(200), 
    status VARCHAR(20), 
    abrangencia VARCHAR2(100), 
    titulo VARCHAR2(200), 
    data_inicio_prevista DATE, 
    data_termino_previsto DATE, 
    outros_setores VARCHAR2(200), 
    area_tematica_principal VARCHAR2(100), 
    area_tematica_secundaria VARCHAR2(100), 
    parceria_externa VARCHAR2(100), 
    resumo VARCHAR2(500), 
    comunidade_atingida VARCHAR2(200), 
    publico_alvo VARCHAR2(100), 
    palavra_chave1 VARCHAR2(30), 
    palavra_chave2 VARCHAR2(30), 
    palavra_chave3 VARCHAR2(30),
    sigla VARCHAR2(10) NOT NULL,
    CONSTRAINT servidor_nro_pessoa_siape_proposta_projeto_fk FOREIGN KEY (nro_pessoa,siape) REFERENCES Servidor(nro_pessoa,siape) ON DELETE CASCADE,
    CONSTRAINT setor_sigla_proposta_projeto_fk FOREIGN KEY (sigla) REFERENCES Setor(sigla) ON DELETE CASCADE,
    CONSTRAINT proposta_projeto_pk PRIMARY KEY (id_proposta, nro_versao)
);

CREATE TABLE Esclarecimento(
    id_proposta NUMBER,
    nro_versao INT,
    texto VARCHAR2(500),
    data DATE NOT NULL,
    CONSTRAINT proposta_projeto_id_proposta_nro_versao_esclarecimento_fk FOREIGN KEY (id_proposta,nro_versao) REFERENCES Proposta_Projeto(id_proposta,nro_versao) ON DELETE CASCADE,
    CONSTRAINT esclarecimento_pk PRIMARY KEY (id_proposta,nro_versao)
);

CREATE TABLE Envolve(
    id_proposta NUMBER,
    nro_versao INT,
    nro_pessoa NUMBER, -- nro da pessoa envolvida
	data_inicio DATE,
    data_fim DATE,
    CONSTRAINT proposta_projeto_id_proposta_nro_versao_envolve_fk FOREIGN KEY (id_proposta,nro_versao) REFERENCES Proposta_Projeto(id_proposta,nro_versao) ON DELETE CASCADE,
    CONSTRAINT pessoa_nro_pessoa_envolve_fk FOREIGN KEY (nro_pessoa) REFERENCES Pessoa(nro_pessoa) ON DELETE CASCADE,
    CONSTRAINT envolve_pk PRIMARY KEY (id_proposta,nro_versao,nro_pessoa,data_inicio)
);

CREATE TABLE Tramitacao(
    nro_tramitacao NUMBER, 
    id_proposta NUMBER,
    nro_versao INT,
    sigla VARCHAR2(10) NOT NULL,
    data_tramitacao DATE NOT NULL,
    acontecimento VARCHAR2(50) NOT NULL,
    status VARCHAR2(50) NOT NULL,
    CONSTRAINT proposta_projeto_id_proposta_nro_versao_tramitacao_fk FOREIGN KEY (id_proposta, nro_versao) REFERENCES Proposta_Projeto(id_proposta, nro_versao) ON DELETE CASCADE,
    CONSTRAINT setor_sigla_tramitacao_fk FOREIGN KEY (sigla) REFERENCES Setor(sigla) ON DELETE CASCADE,
    CONSTRAINT tramitacao_pk PRIMARY KEY (nro_tramitacao,id_proposta,nro_versao)
);

CREATE TABLE Responsavel(
    id_proposta NUMBER,
    nro_versao INT,
    nro_pessoa NUMBER,
    siape NUMBER(7), -- siape do novo responsavel
    data_inicio DATE,
    data_fim DATE,
    data_alteracao DATE, -- solicita alteracao
    nro_pessoa_alteracao NUMBER, -- solicita alteracao
    sigla_alteracao VARCHAR2(10), -- solicita alteracao
    data_inicio_alteracao DATE, -- solicita alteracao
    CONSTRAINT proposta_projeto_id_proposta_nro_versao_responsavel_fk FOREIGN KEY (id_proposta, nro_versao) REFERENCES Proposta_Projeto(id_proposta, nro_versao) ON DELETE CASCADE,
    CONSTRAINT servidor_siape_servidor_responsavel_fk FOREIGN KEY (nro_pessoa,siape) REFERENCES Servidor(nro_pessoa,siape) ON DELETE CASCADE,
    CONSTRAINT membro_coex_nro_pessoa_alteracao_sigla_alteracao_data_inicio_alteracao_responsavel_fk FOREIGN KEY (nro_pessoa_alteracao,data_inicio_alteracao,sigla_alteracao) REFERENCES Membro_CoEx(nro_pessoa,data_inicio,sigla) ON DELETE CASCADE,
    CONSTRAINT responsavel_pk PRIMARY KEY (id_proposta, nro_pessoa, siape, data_inicio)
);

CREATE TABLE Financia(
    id_proposta NUMBER,
    nro_versao INT,
    cnpj VARCHAR2(14),
    data_inicio DATE,
    data_fim DATE,
    CONSTRAINT orgao_financiamento_cnpj_financia_fk FOREIGN KEY (cnpj) REFERENCES Orgao_Financiamento(cnpj) ON DELETE CASCADE,
    CONSTRAINT proposta_projeto_id_proposta_nro_versao_financia_fk FOREIGN KEY (id_proposta, nro_versao) REFERENCES Proposta_Projeto(id_proposta, nro_versao) ON DELETE CASCADE,
    CONSTRAINT financia_pk PRIMARY KEY (cnpj, id_proposta, nro_versao, data_inicio)
);

CREATE TABLE Prestacao_Contas(
    nro_prestacao VARCHAR(5) PRIMARY KEY,
    atas_licitacoes VARCHAR2(200), 
    demonstrativo_despesas_receitas VARCHAR2(200), 
    documentos_fiscais VARCHAR2(200), 
    pagamentos VARCHAR2(200)
);

CREATE TABLE Projeto(
    cod_reuniao VARCHAR(20), 
    id_proposta NUMBER,
    nro_versao INT,
    data_inicio DATE,
    data_fim DATE,
    tipo VARCHAR(50),
    nro_prestacao VARCHAR(5),
    data_aprovacao DATE NOT NULL,
    CONSTRAINT proposta_projeto_id_proposta_nro_versao_projeto_fk FOREIGN KEY (id_proposta, nro_versao) REFERENCES Proposta_Projeto(id_proposta, nro_versao) ON DELETE CASCADE,
    CONSTRAINT reuniao_cod_reuniao_projeto_fk FOREIGN KEY (cod_reuniao) REFERENCES Reuniao(cod_reuniao) ON DELETE CASCADE,
    CONSTRAINT prestacao_nro_prestacao_projeto_fk FOREIGN KEY (nro_prestacao) REFERENCES Prestacao_Contas(nro_prestacao),
    CONSTRAINT projeto_pk PRIMARY KEY (cod_reuniao, id_proposta, nro_versao, data_inicio)
);

CREATE TABLE Proposta_Programa(
    id_proposta NUMBER,
    nro_versao INT,
    anotacoes_proex VARCHAR2(500),
    atividades_referenciais VARCHAR2(500),
    temario VARCHAR2(200),
    CONSTRAINT proposta_projeto_id_proposta_nro_versao_proposta_programa_fk FOREIGN KEY (id_proposta, nro_versao) REFERENCES Proposta_Projeto(id_proposta, nro_versao) ON DELETE CASCADE,
    CONSTRAINT proposta_programa_pk PRIMARY KEY (id_proposta,nro_versao)
);

CREATE TABLE Proposta_Atividade_Extensao(
    cod_reuniao VARCHAR(20), 
    id_proposta NUMBER,
    nro_versao INT,
    data_inicio DATE,
    id_proposta_proposta NUMBER, -- proposta de projeto
    nro_versao_proposta INT, -- proposta de projeto
    local VARCHAR2(100),
    informacoes_complementares VARCHAR2(100),
    pneplrld VARCHAR2(100),
    previsao_publico NUMBER,
    tipo VARCHAR2(100),
    subtipo VARCHAR2(100),
    tipo_financiamento VARCHAR2(100),
    outras_informacoes VARCHAR2(100),
    reoferta VARCHAR2(100),
    CONSTRAINT projeto_cod_reuniao_id_proposta_nro_versao_data_inicio_proposta_atividade_extensao_fk FOREIGN KEY (cod_reuniao, id_proposta, nro_versao, data_inicio) REFERENCES Projeto (cod_reuniao, id_proposta, nro_versao, data_inicio) ON DELETE CASCADE,
    CONSTRAINT proposta_projeto_id_proposta_nro_versao_data_inicio_proposta_atividade_extensao_fk FOREIGN KEY (id_proposta_proposta, nro_versao_proposta) REFERENCES Proposta_Projeto (id_proposta, nro_versao) ON DELETE CASCADE,
    CONSTRAINT proposta_atividade_extensao_pk PRIMARY KEY (id_proposta_proposta, nro_versao_proposta)
);

CREATE TABLE Proposta_Atividades_Gerais (
    id_proposta NUMBER,
    nro_versao INT,
    id_edital NUMBER,
    CONSTRAINT proposta_atividade_extensao_id_proposta_nro_versao_data_inicio_proposta_atividades_gerais_fk FOREIGN KEY (id_proposta, nro_versao) REFERENCES Proposta_Atividade_Extensao(id_proposta_proposta, nro_versao_proposta) ON DELETE CASCADE,
    CONSTRAINT edital_id_edital_proposta_atividades_gerais_fk FOREIGN KEY (id_edital) REFERENCES Edital(id_edital) ON DELETE CASCADE,
    CONSTRAINT proposta_atividades_gerais_pk PRIMARY KEY (id_proposta, nro_versao)   
);

CREATE TABLE Proposta_ACIEPE (
    id_proposta NUMBER,
    nro_versao INT,
    id_edital NUMBER NOT NULL,
    CONSTRAINT proposta_atividade_extensao_id_proposta_nro_versao_data_inicio_proposta_aciepe_fk FOREIGN KEY (id_proposta, nro_versao) REFERENCES Proposta_Atividade_Extensao(id_proposta_proposta, nro_versao_proposta) ON DELETE CASCADE,
    CONSTRAINT edital_id_edital_proposta_aciepe_fk FOREIGN KEY (id_edital) REFERENCES Edital(id_edital) ON DELETE CASCADE,
    CONSTRAINT proposta_aciepe_pk PRIMARY KEY (id_proposta, nro_versao)   
);