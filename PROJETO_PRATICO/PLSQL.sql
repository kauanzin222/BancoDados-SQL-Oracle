--- =====================================================================
--- BLOCO 5: PL/SQL
--- =====================================================================
--- Tabela de suporte para o sistema de auditoria (Log)
CREATE TABLE tab_log_auditoria (
    idlog NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    usuario_banco VARCHAR2(50),
    data_operacao TIMESTAMP,
    tabela_afetada VARCHAR2(30),
    acao VARCHAR2(10),
    chave_registro NUMBER(10),
    detalhes_antigos CLOB,
    detalhes_novos CLOB
);

--- 1. Stored Procedure
--- Quando um paciente recebe alta definitiva, muda de cidade ou se desvincula da instituição, não basta apenas mudar o status dele para 'Inativo'.
--- O ideal é limpar ou atualizar seus agendamentos futuros de tab_terapia para evitar "consultas fantasmas" ocupando a agenda dos especialistas.
CREATE OR REPLACE PROCEDURE pr_desativar_paciente_com_seguranca (
    p_idpaciente IN tab_paciente.idpaciente%TYPE
) AS
    v_existe_paciente NUMBER;
BEGIN
    --- 1. Valida se o paciente realmente existe no sistema
    SELECT COUNT(1)
    INTO v_existe_paciente
    FROM tab_paciente
    WHERE idpaciente = p_idpaciente;

    IF v_existe_paciente = 0 THEN
        RAISE_APPLICATION_ERROR(-20003, 'Erro: O ID informado não corresponde a um paciente cadastrado.');
    END IF;

    --- 2. Atualiza o status do paciente para Inativo
    UPDATE tab_paciente
    SET statuspaciente = 'Inativo'
    WHERE idpaciente = p_idpaciente;

    --- 3. Cancela todas as terapias futuras/agendadas vinculadas a este paciente
    UPDATE tab_terapia
    SET statusterapia = 'Cancelada'
    WHERE idterapia IN (
        SELECT pt.idterapia 
        FROM paciente_terapia pt
        WHERE pt.idpaciente = p_idpaciente
    ) 
    AND statusterapia = 'Agendada';

    --- Alerta de sucesso no console do banco
    DBMS_OUTPUT.PUT_LINE('Paciente ' || p_idpaciente || ' desativado e agendas futuras limpas com sucesso.');
END;
/

--- TESTE 
BEGIN
    --- Executa a procedure passando o ID do paciente
    pr_desativar_paciente_com_seguranca(p_idpaciente => 6);
END;
/
--- Verificação
SELECT idpaciente, statuspaciente FROM tab_paciente WHERE idpaciente = 6;
SELECT idterapia, statusterapia, descricao FROM tab_terapia WHERE idterapia = 1;


--- 2. User Function
--- Calcular a taxa de ocupação de um especialista clínico, retornando a quantidade total de sessões de terapia que ele possui associadas ao seu nome
CREATE OR REPLACE FUNCTION fn_total_terapias_especialista (
   p_idespecialista IN tab_especialista.idespecialista%TYPE
) RETURN NUMBER AS
   v_total NUMBER := 0;
BEGIN
   SELECT COUNT(1)
   INTO v_total
   FROM especialista_terapia
   WHERE idespecialista = p_idespecialista;

   RETURN v_total;
END;
/

--- TESTE
SELECT fn_total_terapias_especialista(4) AS total_atendimentos_juliana FROM DUAL;

--- 3. Trigger de Auditoria
--- Toda vez que um registro crítico da tabela tab_prontuario (alergias, comorbidades, dados sensíveis) 
--- for alterado (UPDATE) ou excluído (DELETE), o gatilho captura quem alterou, quando alterou e guarda 
--- os estados :OLD e :NEW em formato legível na tabela de auditoria
CREATE OR REPLACE TRIGGER trg_auditoria_prontuario
AFTER UPDATE OR DELETE ON tab_prontuario
FOR EACH ROW
BEGIN
    IF UPDATING THEN
        INSERT INTO tab_log_auditoria (usuario_banco, data_operacao, tabela_afetada, acao, chave_registro, detalhes_antigos, detalhes_novos)
        VALUES (
            USER, 
            SYSTIMESTAMP, 
            'TAB_PRONTUARIO', 
            'UPDATE', 
            :OLD.idpaciente,
            'Alergias: ' || :OLD.alergias || ' | Comorbidade: ' || :OLD.comorbidade || ' | Mobilidade: ' || :OLD.mobilidade,
            'Alergias: ' || :NEW.alergias || ' | Comorbidade: ' || :NEW.comorbidade || ' | Mobilidade: ' || :NEW.mobilidade
        );
    ELSIF DELETING THEN
        INSERT INTO tab_log_auditoria (usuario_banco, data_operacao, tabela_afetada, acao, chave_registro, detalhes_antigos, detalhes_novos)
        VALUES (
            USER, 
            SYSTIMESTAMP, 
            'TAB_PRONTUARIO', 
            'DELETE', 
            :OLD.idpaciente,
            'Alergias: ' || :OLD.alergias || ' | Comorbidade: ' || :OLD.comorbidade || ' | Mobilidade: ' || :OLD.mobilidade,
            NULL
        );
    END IF;
END;
/

--- TESTE
UPDATE tab_prontuario SET alergias = 'Poeira e Ácaros' WHERE idpaciente = 6;
SELECT * FROM tab_log_auditoria;

--- 4. Trigger de Consistência Complexa
--- Intercepta a inserção na tabela tab_usuario e verifica se o ID correspondente já não 
--- está cadastrado como um paciente. Se estiver, o banco de dados aborta a operação imediatamente
CREATE OR REPLACE TRIGGER trg_bloquear_paciente_usuario
BEFORE INSERT OR UPDATE ON tab_usuario
FOR EACH ROW
DECLARE
    v_eh_paciente NUMBER;
BEGIN
    SELECT COUNT(1)
    INTO v_eh_paciente
    FROM tab_paciente
    WHERE idpaciente = :NEW.idcadastro;

    IF v_eh_paciente > 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Violação de Regra de Negócio: Uma pessoa cadastrada como Paciente não possui permissão para ter um usuário de login no sistema.');
    END IF;
END;
/

--- TESTE
INSERT INTO tab_usuario (idcadastro, senha) VALUES (6, 'senhaProibida123');
