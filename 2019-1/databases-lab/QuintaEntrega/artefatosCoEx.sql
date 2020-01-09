-- Visão: Membro do CoEx
-- Alterar Responsável (Procedure)
CREATE OR REPLACE PROCEDURE alteraResponsavel
	(id_proposta_in IN NUMBER, siape_novo_in IN NUMBER, nro_coex_in IN NUMBER, sigla_coex_in IN VARCHAR2, data_inicio_coex_in IN DATE, data_fim_in IN DATE)
	IS 
	v_nro_pessoa_atual NUMBER;
	v_nro_pessoa_novo NUMBER;
	v_nro_versao INT;
	v_data_inicio_atual DATE;
	v_siape_atual NUMBER(7);
	v_sysdate DATE; 
	BEGIN
		IF checaDataFim(data_fim_in) = '1' THEN 
			SELECT nro_versao, nro_pessoa, siape, data_inicio INTO 
				v_nro_versao, v_nro_pessoa_atual, v_siape_atual, v_data_inicio_atual
				FROM Responsavel WHERE id_proposta = id_proposta_in 
				AND nro_versao = pegaMaiorVersao(id_proposta_in) AND data_fim IS NULL;
			SELECT nro_pessoa INTO v_nro_pessoa_novo FROM Servidor
				WHERE siape = siape_novo_in;
			IF v_nro_pessoa_atual = v_nro_pessoa_novo THEN
				RAISE_APPLICATION_ERROR(-20310,'Servidor já é o responsável atual!');
			ELSE 
				SELECT SYSDATE INTO v_sysdate FROM Dual;
				UPDATE Responsavel SET data_fim = v_sysdate WHERE 
					id_proposta = id_proposta_in AND nro_versao = v_nro_versao
					AND nro_pessoa = v_nro_pessoa_atual AND siape = v_siape_atual
					AND data_inicio = v_data_inicio_atual; 
				UPDATE Responsavel SET data_alteracao = v_sysdate WHERE 
					id_proposta = id_proposta_in AND nro_versao = v_nro_versao
					AND nro_pessoa = v_nro_pessoa_atual AND siape = v_siape_atual
					AND data_inicio = v_data_inicio_atual; 
				UPDATE Responsavel SET nro_pessoa_alteracao = nro_coex_in, 
					data_inicio_alteracao = data_inicio_coex_in,
					sigla_alteracao = sigla_coex_in
					WHERE id_proposta = id_proposta_in AND nro_versao = v_nro_versao
					AND nro_pessoa = v_nro_pessoa_atual AND siape = v_siape_atual
					AND data_inicio = v_data_inicio_atual; 
				INSERT INTO Responsavel (id_proposta, nro_versao, nro_pessoa, siape, data_inicio)
					VALUES (id_proposta_in, v_nro_versao, v_nro_pessoa_novo, siape_novo_in, v_sysdate);
			END IF;
		ELSE 
			RAISE_APPLICATION_ERROR(-20050,'Você não pode mais alterar Responsável (seu período de Membro do CoEx esgotou)!');
		END IF;
		EXCEPTION WHEN no_data_found THEN
			RAISE_APPLICATION_ERROR(-20311,'Servidor ou Proposta não encontrado!');
	END;
/

EXCEPTION WHEN no_data_found THEN RETURN ('0');
RAISE_APPLICATION_ERROR(-20312,'Código de Reunião não encontrado!');