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
    CONSTRAINT ep_pessoa_nro_fk FOREIGN KEY (nro_pessoa) REFERENCES Pessoa(nro_pessoa) ON DELETE CASCADE,
    CONSTRAINT ep_pk PRIMARY KEY (nro_pessoa, email)
);

CREATE TABLE Estrangeiro(
   passaporte VARCHAR2(15) UNIQUE,
   nro_pessoa NUMBER,  
   CONSTRAINT est_pessoa_nro_fk FOREIGN KEY (nro_pessoa) REFERENCES Pessoa(nro_pessoa) ON DELETE CASCADE,
   CONSTRAINT est_pk PRIMARY KEY (nro_pessoa, passaporte)
);

CREATE TABLE Brasileiro(
   cpf VARCHAR2(11) UNIQUE,
   nro_pessoa NUMBER,
   CONSTRAINT br_pessoa_nro_fk FOREIGN KEY (nro_pessoa) REFERENCES Pessoa(nro_pessoa) ON DELETE CASCADE,
   CONSTRAINT br_pk PRIMARY KEY (nro_pessoa, cpf)
);

CREATE TABLE Interno(
    nro_pessoa NUMBER,
    senha VARCHAR(30),
    login VARCHAR(20) UNIQUE,
    CONSTRAINT int_pessoa_nro_fk FOREIGN KEY (nro_pessoa) REFERENCES Pessoa(nro_pessoa) ON DELETE CASCADE,
    CONSTRAINT int_pk PRIMARY KEY (nro_pessoa)
);

CREATE TABLE Externo(
    nro_pessoa NUMBER,
    CONSTRAINT ext_pessoa_nro_fk FOREIGN KEY (nro_pessoa) REFERENCES Pessoa(nro_pessoa) ON DELETE CASCADE,
    CONSTRAINT ext_pk PRIMARY KEY (nro_pessoa)
);

CREATE TABLE Servidor(
    nro_pessoa NUMBER,
    siape NUMBER(7) UNIQUE, 
    data_admissao DATE, 
    data_demissao DATE, 
    CONSTRAINT serv_interno_nro_fk FOREIGN KEY (nro_pessoa) REFERENCES Interno(nro_pessoa) ON DELETE CASCADE,
    CONSTRAINT serv_pk PRIMARY KEY (nro_pessoa, siape)
);

CREATE TABLE Pro_Reitor(
    nro_pessoa NUMBER,
    siape NUMBER(7),
    data_inicio DATE, 
    data_fim DATE, 
    CONSTRAINT prei_servidor_nro_siape_fk FOREIGN KEY (nro_pessoa, siape) REFERENCES Servidor(nro_pessoa, siape) ON DELETE CASCADE,
    CONSTRAINT prei_pk PRIMARY KEY (nro_pessoa, siape, data_inicio)
);

CREATE TABLE Docente(
    nro_pessoa NUMBER,
    siape NUMBER(7),
    CONSTRAINT doc_servidor_nro_siape_fk FOREIGN KEY (nro_pessoa, siape) REFERENCES Servidor(nro_pessoa, siape) ON DELETE CASCADE,
    CONSTRAINT doc_pk PRIMARY KEY (nro_pessoa, siape)
);

CREATE TABLE TA(
    nro_pessoa NUMBER,
    siape NUMBER(7),
    CONSTRAINT ta_servidor_nro_siape_fk FOREIGN KEY (nro_pessoa, siape) REFERENCES Servidor(nro_pessoa, siape) ON DELETE CASCADE,
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
    CONSTRAINT lot_setor_sigla_fk FOREIGN KEY (sigla) REFERENCES Setor(sigla) ON DELETE CASCADE,
    CONSTRAINT lot_servidor_nro_siape_fk FOREIGN KEY (nro_pessoa,siape) REFERENCES Servidor(nro_pessoa,siape) ON DELETE CASCADE,
    CONSTRAINT lot_pk PRIMARY KEY (sigla, nro_pessoa, siape, data_inicio)
);

CREATE TABLE Coordena(
    sigla VARCHAR2(10),
    nro_pessoa NUMBER,
    siape NUMBER(7),
    data_inicio DATE,
    data_fim DATE,
    CONSTRAINT coo_setor_sigla_fk FOREIGN KEY (sigla) REFERENCES Setor(sigla) ON DELETE CASCADE,
    CONSTRAINT coo_servidor_nro_siape_fk FOREIGN KEY (nro_pessoa,siape) REFERENCES Servidor(nro_pessoa,siape) ON DELETE CASCADE,
    CONSTRAINT coo_pk PRIMARY KEY (sigla, nro_pessoa, siape, data_inicio)
);

CREATE TABLE Centro_Academico(
    sigla VARCHAR2(10),
    CONSTRAINT ca_setor_sigla_fk FOREIGN KEY (sigla) REFERENCES Setor(sigla) ON DELETE CASCADE,
    CONSTRAINT ca_pk PRIMARY KEY (sigla)
);

CREATE TABLE Departamento(
    sigla VARCHAR2(10),
    sigla_centro_academico VARCHAR2(10) NOT NULL,
    CONSTRAINT dpto_setor_sigla FOREIGN KEY (sigla) REFERENCES Setor(sigla) ON DELETE CASCADE,
    CONSTRAINT dpto_centro_academico_sigla_fk FOREIGN KEY (sigla_centro_academico) REFERENCES Centro_Academico(sigla) ON DELETE CASCADE,
    CONSTRAINT dpto_pk PRIMARY KEY (sigla)
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
    CONSTRAINT disc_interno_nro_fk FOREIGN KEY (nro_pessoa) REFERENCES Interno(nro_pessoa) ON DELETE CASCADE,
    CONSTRAINT disc_departamento_sigla_fk FOREIGN KEY (sigla) REFERENCES Departamento(sigla) ON DELETE CASCADE,
    CONSTRAINT disc_pk PRIMARY KEY (nro_pessoa, ra)
);

CREATE TABLE Membro_CaEx(
    nro_pessoa NUMBER,
    siape NUMBER(7),
    sigla VARCHAR2(10),
    data_inicio DATE,
    data_fim DATE,
    CONSTRAINT mcaex_servidor_nro_siape_fk FOREIGN KEY (nro_pessoa,siape) REFERENCES Servidor(nro_pessoa,siape) ON DELETE CASCADE,
    CONSTRAINT mcaex_setor_sigla_fk FOREIGN KEY (sigla) REFERENCES Setor(sigla) ON DELETE CASCADE,
    CONSTRAINT mcaex_pk PRIMARY KEY (nro_pessoa,siape,data_inicio,sigla)
);

CREATE TABLE Membro_CoEx(
    nro_pessoa NUMBER,
    sigla VARCHAR2(10),
    data_inicio DATE,
    data_fim DATE,
    CONSTRAINT mcoex_interno_nro_fk FOREIGN KEY (nro_pessoa) REFERENCES Interno(nro_pessoa) ON DELETE CASCADE,
    CONSTRAINT mcoex_setor_sigla_fk FOREIGN KEY (sigla) REFERENCES Setor(sigla) ON DELETE CASCADE,
    CONSTRAINT mcoex_pk PRIMARY KEY (nro_pessoa,data_inicio,sigla)
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
    CONSTRAINT rno_preitor_nro_siape_dini_fk FOREIGN KEY (nro_pessoa_pro_reitor,siape_pro_reitor,data_inicio_pro_reitor) REFERENCES Pro_Reitor(nro_pessoa,siape,data_inicio) ON DELETE CASCADE
);

CREATE TABLE Pauta_Reuniao(
    nome VARCHAR2(25),
    cod_reuniao VARCHAR(20),
    CONSTRAINT prno_reuniao_cod_fk FOREIGN KEY (cod_reuniao) REFERENCES Reuniao(cod_reuniao) ON DELETE CASCADE,
    CONSTRAINT prno_pk PRIMARY KEY (cod_reuniao, nome)
);

CREATE TABLE Participa_CaEx(
    cod_reuniao VARCHAR(20),
    nro_pessoa NUMBER,
    siape NUMBER(7),
    sigla VARCHAR2(10),
    data_inicio DATE,
    CONSTRAINT pcaex_reuniao_cod_fk FOREIGN KEY (cod_reuniao) REFERENCES Reuniao(cod_reuniao) ON DELETE CASCADE,
    CONSTRAINT pcaex_mcaex_nro_siape_etc_fk FOREIGN KEY (nro_pessoa,siape,data_inicio,sigla) REFERENCES Membro_CaEx(nro_pessoa,siape,data_inicio,sigla) ON DELETE CASCADE,
    CONSTRAINT pcaex_pk PRIMARY KEY (cod_reuniao,nro_pessoa,siape,data_inicio,sigla)
);

CREATE TABLE Participa_CoEx(
    cod_reuniao VARCHAR(20),
    nro_pessoa NUMBER,
    sigla VARCHAR2(10),
    data_inicio DATE,
    CONSTRAINT pcoex_reuniao_cod_fk FOREIGN KEY (cod_reuniao) REFERENCES Reuniao(cod_reuniao) ON DELETE CASCADE,
    CONSTRAINT pcoex_mcoex_nro_siape_etc_fk FOREIGN KEY (nro_pessoa,data_inicio,sigla) REFERENCES Membro_CoEx(nro_pessoa,data_inicio,sigla) ON DELETE CASCADE,
    CONSTRAINT pcoex_pk PRIMARY KEY (cod_reuniao,nro_pessoa,data_inicio,sigla)
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
    CONSTRAINT edit_mcaex_nro_siape_etc_fk FOREIGN KEY (nro_pessoa,siape,sigla,data_inicio) REFERENCES Membro_CaEx(nro_pessoa,siape,sigla,data_inicio) ON DELETE CASCADE
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
    CONSTRAINT pproj_servidor_nro_siape_fk FOREIGN KEY (nro_pessoa,siape) REFERENCES Servidor(nro_pessoa,siape) ON DELETE CASCADE,
    CONSTRAINT pproj_setor_sigla_fk FOREIGN KEY (sigla) REFERENCES Setor(sigla) ON DELETE CASCADE,
    CONSTRAINT pproj_pk PRIMARY KEY (id_proposta, nro_versao)
);

CREATE TABLE Esclarecimento(
    id_proposta NUMBER,
    nro_versao INT,
    texto VARCHAR2(500),
    data DATE NOT NULL,
    CONSTRAINT esc_pproj_id_versao_fk FOREIGN KEY (id_proposta,nro_versao) REFERENCES Proposta_Projeto(id_proposta,nro_versao) ON DELETE CASCADE,
    CONSTRAINT esc_pk PRIMARY KEY (id_proposta,nro_versao)
);

CREATE TABLE Envolve(
    id_proposta NUMBER,
    nro_versao INT,
    nro_pessoa NUMBER, -- nro da pessoa envolvida
    data_inicio DATE,
    data_fim DATE,
    CONSTRAINT env_pproj_id_versao_fk FOREIGN KEY (id_proposta,nro_versao) REFERENCES Proposta_Projeto(id_proposta,nro_versao) ON DELETE CASCADE,
    CONSTRAINT env_pessoa_nro_fk FOREIGN KEY (nro_pessoa) REFERENCES Pessoa(nro_pessoa) ON DELETE CASCADE,
    CONSTRAINT env_pk PRIMARY KEY (id_proposta,nro_versao,nro_pessoa,data_inicio)
);

CREATE TABLE Tramitacao(
    nro_tramitacao NUMBER, 
    id_proposta NUMBER,
    nro_versao INT,
    sigla VARCHAR2(10) NOT NULL,
    data_tramitacao DATE NOT NULL,
    acontecimento VARCHAR2(50) NOT NULL,
    status VARCHAR2(50) NOT NULL,
    CONSTRAINT tram_pproj_id_versao_fk FOREIGN KEY (id_proposta, nro_versao) REFERENCES Proposta_Projeto(id_proposta, nro_versao) ON DELETE CASCADE,
    CONSTRAINT tram_setor_sigla_fk FOREIGN KEY (sigla) REFERENCES Setor(sigla) ON DELETE CASCADE,
    CONSTRAINT tram_pk PRIMARY KEY (nro_tramitacao,id_proposta,nro_versao)
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
    CONSTRAINT resp_pproj_id_versao_fk FOREIGN KEY (id_proposta, nro_versao) REFERENCES Proposta_Projeto(id_proposta, nro_versao) ON DELETE CASCADE,
    CONSTRAINT resp_servidor_siape_fk FOREIGN KEY (nro_pessoa,siape) REFERENCES Servidor(nro_pessoa,siape) ON DELETE CASCADE,
    CONSTRAINT resp_mcoex_nro_sigla_etc_fk FOREIGN KEY (nro_pessoa_alteracao,data_inicio_alteracao,sigla_alteracao) REFERENCES Membro_CoEx(nro_pessoa,data_inicio,sigla) ON DELETE CASCADE,
    CONSTRAINT resp_pk PRIMARY KEY (id_proposta, nro_versao, nro_pessoa, siape, data_inicio)
);

CREATE TABLE Financia(
    id_proposta NUMBER,
    nro_versao INT,
    cnpj VARCHAR2(14),
    data_inicio DATE,
    data_fim DATE,
    CONSTRAINT finc_ofinc_cnpj_fk FOREIGN KEY (cnpj) REFERENCES Orgao_Financiamento(cnpj) ON DELETE CASCADE,
    CONSTRAINT finc_pproj_id_versao_fk FOREIGN KEY (id_proposta, nro_versao) REFERENCES Proposta_Projeto(id_proposta, nro_versao) ON DELETE CASCADE,
    CONSTRAINT finc_pk PRIMARY KEY (cnpj, id_proposta, nro_versao, data_inicio)
);

CREATE TABLE Prestacao_Contas(
    nro_prestacao VARCHAR(5) PRIMARY KEY,
    atas_licitacoes VARCHAR2(200), 
    dem_despesas_receitas VARCHAR2(200), 
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
    CONSTRAINT proj_pproj_id_versao_fk FOREIGN KEY (id_proposta, nro_versao) REFERENCES Proposta_Projeto(id_proposta, nro_versao) ON DELETE CASCADE,
    CONSTRAINT proj_reuniao_cod_fk FOREIGN KEY (cod_reuniao) REFERENCES Reuniao(cod_reuniao) ON DELETE CASCADE,
    CONSTRAINT proj_pcontas_nro_fk FOREIGN KEY (nro_prestacao) REFERENCES Prestacao_Contas(nro_prestacao),
    CONSTRAINT proj_pk PRIMARY KEY (cod_reuniao, id_proposta, nro_versao, data_inicio)
);

CREATE TABLE Proposta_Programa(
    id_proposta NUMBER,
    nro_versao INT,
    anotacoes_proex VARCHAR2(500),
    atividades_referenciais VARCHAR2(500),
    temario VARCHAR2(200),
    CONSTRAINT pprog_pproj_id_versao_fk FOREIGN KEY (id_proposta, nro_versao) REFERENCES Proposta_Projeto(id_proposta, nro_versao) ON DELETE CASCADE,
    CONSTRAINT pprog_pk PRIMARY KEY (id_proposta,nro_versao)
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
    CONSTRAINT patve_proj_cod_id_etc_fk FOREIGN KEY (cod_reuniao, id_proposta, nro_versao, data_inicio) REFERENCES Projeto (cod_reuniao, id_proposta, nro_versao, data_inicio) ON DELETE CASCADE,
    CONSTRAINT patve_pproj_id_versao_etc_fk FOREIGN KEY (id_proposta_proposta, nro_versao_proposta) REFERENCES Proposta_Projeto (id_proposta, nro_versao) ON DELETE CASCADE,
    CONSTRAINT patve_pk PRIMARY KEY (id_proposta_proposta, nro_versao_proposta)
);

CREATE TABLE Proposta_Atividades_Gerais (
    id_proposta NUMBER,
    nro_versao INT,
    id_edital NUMBER,
    CONSTRAINT patvg_patve_id_versao_fk FOREIGN KEY (id_proposta, nro_versao) REFERENCES Proposta_Atividade_Extensao(id_proposta_proposta, nro_versao_proposta) ON DELETE CASCADE,
    CONSTRAINT patvg_edital_id_fk FOREIGN KEY (id_edital) REFERENCES Edital(id_edital) ON DELETE CASCADE,
    CONSTRAINT patvg_pk PRIMARY KEY (id_proposta, nro_versao)   
);

CREATE TABLE Proposta_ACIEPE (
    id_proposta NUMBER,
    nro_versao INT,
    id_edital NUMBER NOT NULL,
    CONSTRAINT paciepe_patve_id_versao_fk FOREIGN KEY (id_proposta, nro_versao) REFERENCES Proposta_Atividade_Extensao(id_proposta_proposta, nro_versao_proposta) ON DELETE CASCADE,
    CONSTRAINT paciepe_edital_id_fk FOREIGN KEY (id_edital) REFERENCES Edital(id_edital) ON DELETE CASCADE,
    CONSTRAINT paciepe_pk PRIMARY KEY (id_proposta, nro_versao)   
);