-- =====================================
-- Resolução da LISTA 05 - USER FUNCTION
-- =====================================
-- Este script cria/atualiza as funções solicitadas e adiciona o campo de estoque.
-- Use com o usuário que contém as tabelas TB_CLIENTE, TB_PRODUTO, TB_PEDIDO e TB_ITEM_PEDIDO.

SET DEFINE OFF;
SET SERVEROUTPUT ON;

-- 1) Adiciona o campo QTDE_ESTOQUE em TB_PRODUTO se ainda não existir
BEGIN
  EXECUTE IMMEDIATE 'ALTER TABLE TB_PRODUTO ADD (QTDE_ESTOQUE NUMBER(5) DEFAULT 0)';
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -1430 THEN
      RAISE;
    END IF;
END;
/

-- Cria tabela de paciente de apoio para resolver a função do paciente
BEGIN
  EXECUTE IMMEDIATE 'CREATE TABLE TB_PACIENTE (
    COD_PACIENTE NUMBER(5) PRIMARY KEY,
    NOME_PACIENTE VARCHAR2(100),
    DATA_NASCIMENTO DATE
  )';
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -955 THEN
      RAISE;
    END IF;
END;
/

-- Insere exemplos de paciente caso a tabela esteja vazia
BEGIN
  IF (SELECT COUNT(*) FROM TB_PACIENTE) = 0 THEN
    INSERT INTO TB_PACIENTE (COD_PACIENTE, NOME_PACIENTE, DATA_NASCIMENTO) VALUES (1, 'José da Silva', DATE '1950-05-10');
    INSERT INTO TB_PACIENTE (COD_PACIENTE, NOME_PACIENTE, DATA_NASCIMENTO) VALUES (2, 'Ana Pereira', DATE '1985-07-20');
    INSERT INTO TB_PACIENTE (COD_PACIENTE, NOME_PACIENTE, DATA_NASCIMENTO) VALUES (3, 'Maria Souza', DATE '1948-01-12');
    COMMIT;
  END IF;
END;
/
-- TESTES SIMPLES
BEGIN
  DBMS_OUTPUT.PUT_LINE('Teste FN_verHora: ' || FN_verHora('06/05/2026'));
  DBMS_OUTPUT.PUT_LINE('Teste FN_IdentificaIdoso(1): ' || FN_IdentificaIdoso(1));
  DBMS_OUTPUT.PUT_LINE('Teste FN_ConsultaEstoque(11): ' || FN_ConsultaEstoque(11));
  DBMS_OUTPUT.PUT_LINE('Teste FN_FormatarTelefone: ' || FN_FormatarTelefone('1198765432'));
  DBMS_OUTPUT.PUT_LINE('Teste FN_StatusCliente(30): ' || FN_StatusCliente(30));
END;
/
