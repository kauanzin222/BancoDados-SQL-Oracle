
-- retorna data com hora no formato DD/MM/YYYY:HH24:MI:SS
CREATE OR REPLACE FUNCTION FN_verHora(p_data_in IN VARCHAR2)
RETURN VARCHAR2
IS
  v_data DATE;
BEGIN
  v_data := TO_DATE(TRIM(p_data_in), 'DD/MM/YYYY');
  RETURN TO_CHAR(v_data, 'DD/MM/YYYY:HH24:MI:SS');
EXCEPTION
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20001, 'Formato de data inválido. Use DD/MM/YYYY');
END FN_verHora;
/

-- identifica se paciente é idoso (>65 anos)
CREATE OR REPLACE FUNCTION FN_IdentificaIdoso(p_codpac IN NUMBER)
RETURN VARCHAR2
IS
  v_data_nasc DATE;
BEGIN
  SELECT DATA_NASCIMENTO
    INTO v_data_nasc
    FROM TB_PACIENTE
   WHERE COD_PACIENTE = p_codpac;

  IF MONTHS_BETWEEN(SYSDATE, v_data_nasc) / 12 >= 65 THEN
    RETURN 'IDOSO';
  ELSE
    RETURN 'NÃO IDOSO';
  END IF;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20002, 'Paciente não encontrado.');
END FN_IdentificaIdoso;
/

-- retorna quantidade em estoque de um produto
CREATE OR REPLACE FUNCTION FN_ConsultaEstoque(p_codproduto IN NUMBER)
RETURN NUMBER
IS
  v_qtde NUMBER;
BEGIN
  SELECT QTDE_ESTOQUE
    INTO v_qtde
    FROM TB_PRODUTO
   WHERE CODPRODUTO = p_codproduto;

  RETURN NVL(v_qtde, 0);
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20003, 'Produto não encontrado.');
END FN_ConsultaEstoque;
/

-- formata telefone como (xx)xxxx-xxxx
CREATE OR REPLACE FUNCTION FN_FormatarTelefone(p_telefone IN VARCHAR2)
RETURN VARCHAR2
IS
  v_num VARCHAR2(20);
BEGIN
  v_num := REGEXP_REPLACE(p_telefone, '[^0-9]', '');

  IF LENGTH(v_num) != 10 THEN
    RAISE_APPLICATION_ERROR(-20004, 'Telefone deve conter 10 dígitos numéricos.');
  END IF;

  RETURN '(' || SUBSTR(v_num, 1, 2) || ')' || SUBSTR(v_num, 3, 4) || '-' || SUBSTR(v_num, 7, 4);
END FN_FormatarTelefone;
/

-- conta pedidos de cliente e retorna mensagem correta
CREATE OR REPLACE FUNCTION FN_StatusCliente(p_codcliente IN NUMBER)
RETURN VARCHAR2
IS
  v_nomecliente TB_CLIENTE.NOMECLIENTE%TYPE;
  v_qtde       NUMBER;
  v_msg        VARCHAR2(200);
BEGIN
  SELECT NOMECLIENTE
    INTO v_nomecliente
    FROM TB_CLIENTE
   WHERE CODCLIENTE = p_codcliente;

  SELECT COUNT(*)
    INTO v_qtde
    FROM TB_PEDIDO
   WHERE CODCLIENTE = p_codcliente;

  IF v_qtde > 3 THEN
    v_msg := 'Cliente preferencial - ' || p_codcliente || ' - ' || v_nomecliente;
  ELSIF v_qtde BETWEEN 1 AND 3 THEN
    v_msg := 'Cliente Normal - ' || p_codcliente || ' - ' || v_nomecliente;
  ELSE
    v_msg := 'Cliente Inativo - ' || p_codcliente || ' - ' || v_nomecliente;
  END IF;

  RETURN v_msg;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20005, 'Cliente não encontrado.');
END FN_StatusCliente;


