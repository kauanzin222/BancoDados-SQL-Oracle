-- (Assumindo que a tabela idcodcta já existe)
-- Exemplo de criação da tabela de referência:
 CREATE TABLE idcodcta (
   codcta NUMBER(10,0) PRIMARY KEY,
   descricao VARCHAR2(100)
 );


-- 1. Cria a tabela principal
CREATE TABLE idcadcli_ctb (
  codemp  CHAR(4)      DEFAULT ' ' NOT NULL,
  cgccli  NUMBER       DEFAULT 0 NOT NULL,
  tipcli  CHAR(1)      DEFAULT ' ' NOT NULL,
  triicms CHAR(2)      DEFAULT ' ' NOT NULL,
  triipi  CHAR(1)      DEFAULT ' ' NOT NULL,
  triser  CHAR(1)      DEFAULT ' ' NOT NULL,
  codcta1 NUMBER(10,0) DEFAULT 0 NOT NULL,
  codcta2 NUMBER(10,0) DEFAULT 0 NOT NULL,
  tripis  CHAR(1)      DEFAULT ' ' NOT NULL,
  tricfi  CHAR(1)      DEFAULT ' ' NOT NULL,
  usoite  CHAR(1)      DEFAULT ' ' NOT NULL,
  aliqst  NUMBER       DEFAULT 0 NOT NULL,
  aliqir  NUMBER       DEFAULT 0 NOT NULL
);

ALTER TABLE idcadcli_ctb
ADD CONSTRAINT pk_idcadcli_ctb
PRIMARY KEY (codemp, cgccli);

-- 2. Adiciona a Chave Estrangeira para garantir a integridade dos dados
ALTER TABLE idcadcli_ctb
ADD CONSTRAINT fk_idcadcli_ctb_codcta1
FOREIGN KEY (codcta1)
REFERENCES idcodcta(codcta);


-- 3. Cria o Índice para otimizar as consultas
CREATE INDEX idx_idcadcli_ctb_codcta1 ON idcadcli_ctb (codcta1);

ALTER TABLE idcadcli_ctb
MODIFY (triser CHAR(10) DEFAULT ' ');

ALTER TABLE idcadcli_ctb
DROP COLUMN aliqir;

ALTER TABLE idcadcli_ctb
ADD (alipis NUMBER DEFAULT 0 NOT NULL);

--Parte 1: Alterando a Chave Primária (PK)
--O objetivo é mudar a chave primária de (codemp, cgccli) para (codemp, cgccli, tipcli).

--Passo 1: Excluir a Chave Primária Antiga (DROP CONSTRAINT)
--Primeiro, precisamos remover a restrição de chave primária que definimos anteriormente.
ALTER TABLE idcadcli_ctb
DROP CONSTRAINT pk_idcadcli_ctb;

ALTER TABLE idcadcli_ctb
ADD CONSTRAINT pk_idcadcli_ctb
PRIMARY KEY (codemp, cgccli, tipcli);


--Alterando o Índice Secundário
--O objetivo é mudar o índice que existia em (codcta1) para um novo índice composto em (codcta1, triser).

--Passo 1: Excluir o Índice Antigo (DROP INDEX)
--Primeiro, removemos o índice secundário que criamos para a chave estrangeira.
DROP INDEX idx_idcadcli_ctb_codcta1;

CREATE INDEX idx_ctb_codcta1_triser
ON idcadcli_ctb (codcta1, triser)

--Criando uma tabela e já copiando dados para dentro dela a partir do SELECT * FROM
CREATE TABLE Paciente 
as SELECT * FROM idcadcli_ctb;

CREATE TABLE idcodcta_bkp 
as SELECT * FROM idcodcta;

--Inserindo dados no bkp
insert into idcodcta_bkp
values (10103, 'Conta de Pagamento');

--Criando e copiando e logo em seguida deletando
CREATE TABLE idcodcta_bkp2 
as SELECT * FROM idcodcta_bkp;

DELETE FROM idcodcta_bkp2;

--Testando comando UPDATES
insert into idcodcta_bkp2
values (10103, 'Conta de Pagamento');

insert into idcodcta_bkp2
values (10105, 'Conta Corrente');

--Sem WHERE, atualiza todos os campos de DESCRICAO para "Conta de Pagamento"
UPDATE idcodcta_bkp2    
SET descricao = 'Conta de pagamento';

SELECT * FROM idcodcta_bkp2;

--Com WHERE...
UPDATE idcodcta_bkp2 SET descricao = 'Conta Corrente'
WHERE codcta = 10105; 

SELECT * FROM idcodcta_bkp2;


--Criando uma tabela Paciente e inserindo dados nela conforme LISTA 01
CREATE TABLE Paciente (
    Codigo number(5) PRIMARY KEY,
    Nome varchar2(30) not null,
    DataNasc date,
    Sexo char(1) CHECK(Sexo in ('F', 'M')),
    Endereco varchar2(40)
);

INSERT INTO Paciente
VALUES (55, 'Kaua Cardoso', '22-02-2006', 'M', 'Sorocaba');

--Alterando a tabela criando a coluna CONSULTA
ALTER TABLE Paciente
ADD (Consulta NUMBER(5,0) DEFAULT 0 NOT NULL);

SELECT * FROM Paciente;

--Fazendo um upddate 
UPDATE paciente SET consulta = 200
WHERE consulta = 0;