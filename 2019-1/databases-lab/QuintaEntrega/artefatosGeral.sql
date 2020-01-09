-- Login (View, Procedure, Function)
CREATE OR REPLACE FORCE VIEW "Visoes" ("NRO_PESSOA", "TIPO", "DATA_INICIO", "DATA_FIM") AS 
	SELECT p.nro_pessoa, 'Discente' AS tipo, d.data_ingresso AS data_inicio, d.data_egresso AS data_fim FROM Interno p, Discente d WHERE p.nro_pessoa = d.nro_pessoa
	UNION ALL 
	SELECT p.nro_pessoa, 'Docente' AS tipo, s.data_admissao AS data_inicio, s.data_demissao AS data_fim FROM Interno p, Docente d, Servidor s WHERE p.nro_pessoa = d.nro_pessoa 
		AND p.nro_pessoa = s.nro_pessoa
	UNION ALL 
	SELECT p.nro_pessoa, 'TA' AS tipo, s.data_admissao AS data_inicio, s.data_demissao AS data_fim FROM Interno p, TA d, Servidor s WHERE p.nro_pessoa = d.nro_pessoa 
		AND p.nro_pessoa = s.nro_pessoa
	UNION ALL 
	SELECT p.nro_pessoa, 'Pro_Reitor' AS tipo, d.data_inicio AS data_inicio, d.data_fim AS data_fim FROM Interno p, Pro_Reitor d WHERE p.nro_pessoa = d.nro_pessoa
	UNION ALL
	SELECT p.nro_pessoa, 'Membro_CaEx' AS tipo, d.data_inicio AS data_inicio, d.data_fim AS data_fim FROM Interno p, Membro_CaEx d WHERE p.nro_pessoa = d.nro_pessoa
	UNION ALL
	SELECT p.nro_pessoa, 'Membro_CoEx' AS tipo, d.data_inicio AS data_inicio, d.data_fim AS data_fim FROM Interno p, Membro_CoEx d WHERE p.nro_pessoa = d.nro_pessoa
	UNION ALL
	SELECT i.nro_pessoa, 'Coordenador' AS tipo, s.data_admissao AS data_inicio, s.data_demissao AS data_fim FROM Interno i INNER JOIN Servidor s ON i.nro_pessoa = s.nro_pessoa
            INNER JOIN Proposta_Projeto prop ON s.nro_pessoa = prop.nro_pessoa AND s.siape = prop.siape
            INNER JOIN Projeto p ON prop.id_proposta = p.id_proposta AND prop.nro_versao = p.nro_versao
/

CREATE OR REPLACE FUNCTION checaLogin(login_in IN VARCHAR, senha_in IN VARCHAR, tipo_in IN VARCHAR) 
	RETURN VARCHAR2 
	IS 
	v_nro_pessoa NUMBER;
	BEGIN
		SELECT UNIQUE(nro_pessoa) INTO v_nro_pessoa FROM visoes  
			WHERE nro_pessoa = (SELECT nro_pessoa FROM Interno WHERE login = login_in AND senha = senha_in) AND tipo = tipo_in;
		IF tipo_in = 'Pro_Reitor' THEN 
			RETURN ('1'); 
		ELSIF tipo_in = 'Membro_CaEx' THEN 
			RETURN ('2'); 
		ELSIF tipo_in = 'Membro_CoEx' THEN 
			RETURN ('3'); 
		ELSIF tipo_in = 'Coordenador' THEN 
			RETURN ('6');
		ELSE 
			RETURN ('0'); 
		END IF; 
		EXCEPTION WHEN no_data_found THEN RETURN ('0');
	END; 
/

CREATE OR REPLACE PROCEDURE saidaLogin(valorRetorno IN VARCHAR)
	IS 
	BEGIN 
		IF valorRetorno = '0' THEN
			RAISE_APPLICATION_ERROR(-20010,'Usuario não encontrado!');
		END IF;
	END saidaLogin;
/

-- Checa Data Fim (Function)
CREATE OR REPLACE FUNCTION checaDataFim(data_fim IN DATE)
	RETURN VARCHAR
	IS
	v_sysdate DATE;
	BEGIN
		SELECT SYSDATE INTO v_sysdate FROM DUAL;
		IF data_fim IS NULL THEN
			RETURN('1');
		ELSIF data_fim > v_sysdate THEN
			RETURN('1');
		ELSE
			RETURN('0');
		END IF;
	END;
/

-- Pega Maior Versão de Projeto (Function)
CREATE OR REPLACE FUNCTION pegaMaiorVersao(in_idProposta IN NUMBER)
    RETURN INT
    IS
    out_maior_versao INT;
    BEGIN
        SELECT MAX(nro_versao) INTO out_maior_versao FROM Proposta_Projeto WHERE in_idProposta = id_proposta;
        IF out_maior_versao IS NULL THEN
			RAISE_APPLICATION_ERROR(-20701, 'ID da proposta nao existe');
		ELSE
		    RETURN(out_maior_versao);
		END IF;
    END;
/

-- Inicializa Valores (Functions)
CREATE OR REPLACE FUNCTION pegaNome(login_in IN VARCHAR)
	RETURN VARCHAR2
	IS
	v_nome VARCHAR2(100);
	BEGIN 
		SELECT UNIQUE(nome) INTO v_nome FROM Pessoa 
			WHERE nro_pessoa = (SELECT nro_pessoa FROM Interno WHERE login = login_in);
		RETURN (v_nome);
		EXCEPTION WHEN no_data_found THEN RETURN ('VOCE NAO ESTA LOGADO! ERRO!');
	END;
/

CREATE OR REPLACE FUNCTION pegaSiape(login_in IN VARCHAR, tipo_in IN VARCHAR)
	RETURN NUMBER
	IS
	v_siape NUMBER(7);
	BEGIN 
		IF tipo_in = 'Pro_Reitor' THEN 
			SELECT UNIQUE(siape) INTO v_siape FROM Pro_Reitor 
				WHERE nro_pessoa = (SELECT nro_pessoa FROM Interno WHERE login = login_in);
			RETURN (v_siape);
		ELSIF tipo_in = 'TA' THEN 
			SELECT UNIQUE(siape) INTO v_siape FROM Servidor 
			WHERE nro_pessoa = (SELECT nro_pessoa FROM Interno WHERE login = login_in);
			RETURN (v_siape);
		ELSIF tipo_in = 'Docente' THEN
			SELECT UNIQUE(siape) INTO v_siape FROM Servidor 
			WHERE nro_pessoa = (SELECT nro_pessoa FROM Interno WHERE login = login_in);
			RETURN (v_siape);
		ELSIF tipo_in = 'Membro_CaEx' THEN
			SELECT UNIQUE(siape) INTO v_siape FROM Servidor 
			WHERE nro_pessoa = (SELECT nro_pessoa FROM Interno WHERE login = login_in);
			RETURN (v_siape);
		ELSE
			RETURN ('-1');
		END IF;
		EXCEPTION WHEN no_data_found THEN RETURN ('-1');
	END;
/

CREATE OR REPLACE FUNCTION pegaNumero(login_in IN VARCHAR, tipo_in IN VARCHAR)
	RETURN NUMBER
	IS
	v_numero NUMBER;
	BEGIN
		IF tipo_in = 'Pro_Reitor' THEN 
			SELECT UNIQUE(nro_pessoa) INTO v_numero FROM Pro_Reitor 
				WHERE nro_pessoa = (SELECT nro_pessoa FROM Interno WHERE login = login_in);
			RETURN (v_numero); 
		ELSIF tipo_in = 'TA' THEN 
			SELECT UNIQUE(nro_pessoa) INTO v_numero FROM Servidor  
				WHERE nro_pessoa = (SELECT nro_pessoa FROM Interno WHERE login = login_in); 
			RETURN (v_numero);
		ELSIF tipo_in = 'Docente' THEN 
			SELECT UNIQUE(nro_pessoa) INTO v_numero FROM Servidor  
				WHERE nro_pessoa = (SELECT nro_pessoa FROM Interno WHERE login = login_in); 
			RETURN (v_numero);
		ELSIF tipo_in = 'Membro_CaEx' THEN 
			SELECT UNIQUE(nro_pessoa) INTO v_numero FROM Servidor  
				WHERE nro_pessoa = (SELECT nro_pessoa FROM Interno WHERE login = login_in); 
			RETURN (v_numero);
		ELSIF tipo_in = 'Membro_CoEx' THEN 
			SELECT UNIQUE(nro_pessoa) INTO v_numero FROM Servidor  
				WHERE nro_pessoa = (SELECT nro_pessoa FROM Interno WHERE login = login_in); 
			RETURN (v_numero);
		ELSE 
			RETURN('-1');
		END IF;
		EXCEPTION WHEN no_data_found THEN RETURN ('-1');
	END;
/

CREATE OR REPLACE FUNCTION pegaDataInicio(login_in IN VARCHAR, tipo_in IN VARCHAR)
	RETURN VARCHAR
	IS
	v_dini DATE;
	BEGIN 
		IF tipo_in = 'Pro_Reitor' THEN 
			SELECT MAX(data_inicio) INTO v_dini FROM Pro_Reitor 
				WHERE nro_pessoa = (SELECT nro_pessoa FROM Interno WHERE login = login_in);
			RETURN (v_dini);
		ELSIF tipo_in = 'Membro_CaEx' THEN
			SELECT MAX(data_inicio) INTO v_dini FROM Membro_CaEx  
				WHERE nro_pessoa = (SELECT nro_pessoa FROM Interno WHERE login = login_in); 
			RETURN (v_dini);
		ELSIF tipo_in = 'Membro_CoEx' THEN
			SELECT MAX(data_inicio) INTO v_dini FROM Membro_CoEx  
				WHERE nro_pessoa = (SELECT nro_pessoa FROM Interno WHERE login = login_in); 
			RETURN (v_dini);
		ELSE 
			RETURN('-1');
		END IF;
		EXCEPTION WHEN no_data_found THEN RETURN ('-1');
	END;
/

CREATE OR REPLACE FUNCTION pegaDataFim(login_in IN VARCHAR, tipo_in IN VARCHAR)
	RETURN VARCHAR
	IS
	v_dini DATE;
	v_dfim DATE;
	v_nropessoa NUMBER;
	BEGIN 
		IF tipo_in = 'Pro_Reitor' THEN 
			SELECT nro_pessoa INTO v_nropessoa FROM Interno WHERE login = login_in;
			SELECT MAX(data_inicio) INTO v_dini FROM Pro_Reitor 
				WHERE nro_pessoa = v_nropessoa;
			SELECT data_fim INTO v_dfim FROM Pro_Reitor 
				WHERE nro_pessoa =  v_nropessoa and data_inicio = v_dini;
			RETURN (v_dfim);
		ELSIF tipo_in = 'Membro_CaEx' THEN 
			SELECT nro_pessoa INTO v_nropessoa FROM Interno WHERE login = login_in;
			SELECT MAX(data_inicio) INTO v_dini FROM Membro_CaEx 
				WHERE nro_pessoa = v_nropessoa;
			SELECT data_fim INTO v_dfim FROM Membro_CaEx 
				WHERE nro_pessoa =  v_nropessoa and data_inicio = v_dini;
			RETURN (v_dfim);
		ELSIF tipo_in = 'Membro_CoEx' THEN 
			SELECT nro_pessoa INTO v_nropessoa FROM Interno WHERE login = login_in;
			SELECT MAX(data_inicio) INTO v_dini FROM Membro_CoEx 
				WHERE nro_pessoa = v_nropessoa;
			SELECT data_fim INTO v_dfim FROM Membro_CoEx 
				WHERE nro_pessoa =  v_nropessoa and data_inicio = v_dini;
			RETURN (v_dfim);
		ELSE
			RETURN('-1');
		END IF;
		EXCEPTION WHEN no_data_found THEN RETURN ('-1');
	END;
/

CREATE OR REPLACE FUNCTION pegaSigla(login_in IN VARCHAR, tipo_in IN VARCHAR) 
	RETURN VARCHAR2 
	IS 
	v_sigla VARCHAR2(10); 
	BEGIN 
		IF tipo_in = 'Membro_CoEx' THEN  
			SELECT UNIQUE(sigla) INTO v_sigla FROM Membro_CoEx  
				WHERE nro_pessoa = (SELECT nro_pessoa FROM Interno WHERE login = login_in); 
			RETURN (v_sigla); 
		ELSIF tipo_in = 'Membro_CaEx' THEN  
			SELECT UNIQUE(sigla) INTO v_sigla FROM Membro_CaEx  
				WHERE nro_pessoa = (SELECT nro_pessoa FROM Interno WHERE login = login_in); 
			RETURN (v_sigla); 
		ELSE
			RETURN('-1');
		END IF;
		EXCEPTION WHEN no_data_found THEN RETURN ('-1'); 
	END; 
/