-- OBS: Em suma, eu alterei a tabela de BACKUP sempre por medo de fazer alguma besteira!

INSERT INTO tb_Paciente
VALUES (55, 'Kaua Cardoso',  'M', '22-02-2006', 'Rua Não-te-Interessa', 'Sorocaba', '19', '22.00');
/* Através desta sequência, será inserido estes dados na tabela Paciente */

SELECT * FROM tb_Paciente; /* Verficando se foi atribuido os valores a tabela */

/* 1. Criar uma nova coluna na tabela paciente com o nome País varchar2(15); */

ALTER TABLE tb_Paciente
ADD (Pais VARCHAR2(15) DEFAULT NULL);

SELECT * FROM tb_Paciente;

/* 2. Alterar a coluna endereço da tabela de paciente para 28 posições. */

/* Criando um bkp para garantir que nada dê errado */
CREATE TABLE BKP_PACIENTE
AS SELECT * FROM TB_PACIENTE;

ALTER TABLE BKP_PACIENTE
MODIFY (endereco VARCHAR2(28 BYTE));
/* Não sei se era isso que tinha que ser feito, porém alterei para ter 28 bytes*/

SELECT * FROM BKP_PACIENTE;

/* Após verificar, podemos alterar na tabela principal */
ALTER TABLE TB_PACIENTE
MODIFY (endereco VARCHAR2(28 BYTE));



/* 3. Excluir a nova coluna criada no exercício 1. */

ALTER TABLE tb_Paciente
DROP COLUMN Pais;

SELECT * FROM tb_Paciente;

/* 4. Incluir a restrição NOT NULL na coluna endereço. */ 

ALTER TABLE TB_PACIENTE
MODIFY (endereco VARCHAR2(28 BYTE) NOT NULL);

/* 5. Alterar a data de nascimento do paciente de código = 1 para ´01-09-1990´. */

UPDATE TB_PACIENTE SET DATANASC = '01-09-1990'
WHERE CODPACIENTE = 1;

/* 6. Alterar o campo desconto de todos os pacientes para ´N´. */

--Etapa 1: Alterar a col desconto para poder armazenar NULL
ALTER TABLE BKP_PACIENTE
MODIFY (DESCONTO NULL);
--Etapa 2: Atualizar todos os valores desta coluna para NULL e verificar
UPDATE BKP_PACIENTE SET DESCONTO = NULL;
SELECT * FROM BKP_PACIENTE;
--Etapa 3: Alterar o data_type para varchar
ALTER TABLE BKP_PACIENTE
MODIFY (DESCONTO VARCHAR(2));
--Etapa 4: Alterando os valores para 'N'
UPDATE BKP_PACIENTE SET DESCONTO = 'N';

/* 7. Sobre a tabela Paciente, alterar o campo endereço para ‘Rua Melo Alves,40’
e cidade para ‘Itu” para o paciente de código = 2. */

UPDATE BKP_PACIENTE SET
    ENDERECO = 'Rua Melo Alves,40',
    CIDADE = 'Itu'
WHERE CODPACIENTE = 2;

SELECT * FROM BKP_PACIENTE;

/* 8. Excluir a consulta 200, somente se o campo valor da consulta for igual a zero. */

CREATE TABLE BKP_CONSULTA
AS SELECT * FROM TB_CONSULTA;

SELECT * FROM BKP_CONSULTA;

--Tentativa de criar uma condição (NÃO FUNCIONA)
/*
IF VALORCONSULTA FROM BKP_CONSULTA == 0 THEN
    DELETE FROM BKP_CONSULTA
    WHERE CODCONSULTA = 2;
*/

DELETE FROM BKP_CONSULTA
WHERE CODCONSULTA = 200 AND VALORCONSULTA = 0;

SELECT * FROM BKP_CONSULTA;

/* 9. Excluir o paciente de código 55. */

DELETE FROM BKP_PACIENTE 
WHERE CODPACIENTE = 55;

SELECT * FROM BKP_PACIENTE;

/* 10. Excluir todos os pacientes da cidade de Sorocaba de sexo feminino. */ 

DELETE FROM BKP_PACIENTE
WHERE CIDADE = 'Sorocaba' AND SEXO = 'F';

SELECT * FROM BKP_PACIENTE;

/* 11. Alterar o campo desconto de todos os pacientes de sexo feminino e idade superior a 60 anos para ‘S’. */

UPDATE BKP_PACIENTE SET DESCONTO = 'S'
WHERE SEXO = 'F' AND IDADE > 60;

SELECT * FROM BKP_PACIENTE;

/* 12. Criar um novo campo na tabela paciente para registrar o telefone celular 
do paciente. Este campo deverá ser varchar2(15). Inserir o número de telefone 
dos pacientes neste novo campo. */

ALTER TABLE BKP_PACIENTE
ADD (TELEFONE VARCHAR2(15));

UPDATE BKP_PACIENTE SET TELEFONE = '15 991202020';
/* Inserindo todos os telefones como este por mera preguiça */

