--- =====================================================================
--- 2b.1: TABELAS BASE (Não possuem FKs internas ou dependências)
--- =====================================================================
--- TAB_ENDERECO 
CREATE TABLE tab_endereco (
   idendereco number(10) PRIMARY KEY,
   cep varchar2(9) NOT NULL,
   rua varchar2(100) NOT NULL,
   cidade varchar2(50) NOT NULL,
   bairro varchar2(50) NOT NULL,
   estado char(2) NOT NULL,
   numero number(5),
   complemento varchar2(75)
);

--- TAB_PESSOA
CREATE TABLE tab_pessoa (
   idcadastro number(10) PRIMARY KEY,
   cpf varchar2(11) NOT NULL,
   nome varchar2(100) NOT NULL,
   datanascimento date NOT NULL,
   sexo char(1) NOT NULL,
   celular varchar2(15) NOT NULL,
   estadocivil varchar2(20) NOT NULL,
   numcns varchar2(15) NOT NULL,
   statuscadastro varchar2(20) NOT NULL
);

--- TAB_PERFIL
CREATE TABLE tab_perfil (
   idperfil number(10) PRIMARY KEY,
   nome varchar2(50) NOT NULL
);

--- TAB_PERMISSAO
CREATE TABLE tab_permissao (
   idpermissao number(10) PRIMARY KEY,
   nome varchar2(50) NOT NULL,
   descricao varchar2(400) NOT NULL
);

--- TAB_ESCOLA
CREATE TABLE tab_escola (
   idescola number(10) PRIMARY KEY,
   nome varchar2(50) NOT NULL,
   tipoescola number(1),
   telefone varchar2(11) NOT NULL
);

--- TAB_CID
CREATE TABLE tab_cid (
   codigocid varchar2(10) PRIMARY KEY,
   descricao varchar2(200) NOT NULL
);

--- TAB_CBO
CREATE TABLE tab_cbo (
   codigocbo number(6) PRIMARY KEY,
   titulocbo varchar2(50) NOT NULL
);

--- TAB_TERAPIA
CREATE TABLE tab_terapia (
   idterapia NUMBER(10) PRIMARY KEY,
   data DATE DEFAULT SYSDATE,
   descricao VARCHAR2(200),
   statusterapia VARCHAR2(20) NOT NULL,
   modalidade VARCHAR2(50)
);

--- TAB_ESPECIALIDADE
CREATE TABLE tab_especialidade (
   idespecialidade NUMBER(10) PRIMARY KEY,
   nome VARCHAR2(50) NOT NULL,
   descricao VARCHAR2(200)
);

--- =====================================================================
--- 2b.2: TABELAS DEPENDENTES (Subclasses, Associativas e Chaves Inline)
--- =====================================================================
--- ESPECIALIDADE_PROFISSIONAL (Depende de tab_especialista e tab_especialidade)
CREATE TABLE especialidade_profissional (
   idespecialidade NUMBER(10) NOT NULL,
   idespecialista NUMBER(10) NOT NULL
);

--- TAB_CARGO (Depende de tab_cbo)
CREATE TABLE tab_cargo (
   idcargo number(10) PRIMARY KEY,
   codigocbo number(6) NOT NULL,
   nomecargo varchar2(50) NOT NULL
);

--- TAB_PROFISSIONAL (Depende de tab_pessoa e tab_cargo)
CREATE TABLE tab_profissional (
   idprofissional NUMBER(10) PRIMARY KEY,
   idcargo NUMBER(10) NOT NULL
);

--- TAB_ESPECIALISTA (Depende de tab_profissional)
CREATE TABLE tab_especialista (
   idespecialista NUMBER(10) PRIMARY KEY,
   registroconselho VARCHAR2(20)
);

--- TAB_USUARIO (Depende de tab_pessoa)
CREATE TABLE tab_usuario (
   idcadastro number(10) PRIMARY KEY,
   senha varchar2(100) NOT NULL
);

--- TAB_PACIENTE (Depende de tab_escola e tab_pessoa)
CREATE TABLE tab_paciente (
   idpaciente number(10) PRIMARY KEY,
   idescola number(10) NOT NULL,
   cidprincipal varchar2(10),
   statuspaciente varchar2(10) NOT NULL,
   datacadastro date DEFAULT sysdate,
   convenio varchar2(50),
   tipoentrada varchar2(20)
);

--- TAB_RESPONSAVEL (Depende de tab_pessoa)
CREATE TABLE tab_responsavel (
   idresponsavel number(10) PRIMARY KEY,
   ocupacao varchar2(50)
);

--- TAB_PRONTUARIO (Depende de tab_paciente)
CREATE TABLE tab_prontuario (
   idpaciente number(10) PRIMARY KEY,
   alergias varchar2(100),
   comorbidade varchar2(100),
   mobilidade varchar2(20)
);

--- ENDERECO_PESSOA -> TABELA ASSOCIATIVA
CREATE TABLE endereco_pessoa (
   idcadastro number(10) NOT NULL,
   idendereco number(10) NOT NULL
);

--- USUARIO_PERFIL -> TABELA ASSOCIATIVA
CREATE TABLE usuario_perfil (
   idcadastro number(10) NOT NULL,
   idperfil number(10) NOT NULL
);

--- PERFIL_PERMISSAO -> TABELA ASSOCIATIVA
CREATE TABLE perfil_permissao (
   idperfil number(10) NOT NULL,
   idpermissao number(10) NOT NULL
);

--- PACIENTE_CID -> TABELA ASSOCIATIVA
CREATE TABLE paciente_cid (
   codigocid varchar2(10) NOT NULL,
   idpaciente number(10) NOT NULL
);

--- RESPONSAVEL_PACIENTE -> TABELA ASSOCIATIVA
CREATE TABLE responsavel_paciente (
   idresponsavel number(10) NOT NULL,
   idpaciente number(10) NOT NULL,
   grauparentesco varchar2(50)
);

--- PACIENTE_TERAPIA -> TABELA ASSOCIATIVA
CREATE TABLE paciente_terapia (
   idterapia NUMBER(10) NOT NULL,
   idpaciente NUMBER(10) NOT NULL
);

--- ESPECIALISTA_TERAPIA -> TABELA ASSOCIATIVA
CREATE TABLE especialista_terapia (
   idterapia NUMBER(10) NOT NULL,
   idespecialista NUMBER(10) NOT NULL
);

--- =====================================================================
--- 2b.3: INTEGRIDADE REFERENCIAL (Constraints e Chaves Estrangeiras)
--- =====================================================================
--- CONSTRAINTS ESPECIALIDADE_PROFISSIONAL
alter table especialidade_profissional 
add (
   constraint pk_especialidade_especialista primary key (idespecialidade, idespecialista),
   constraint fk_especialidade_especialidade_profissional foreign key (idespecialidade) references tab_especialidade (idespecialidade),
   constraint fk_especialista_especialidade_profissional foreign key (idespecialista) references tab_especialista (idespecialista)
);

--- CONSTRAINTS ESPECIALISTA_TERAPIA 
ALTER TABLE especialista_terapia
ADD (
      CONSTRAINT pk_especialista_terapia PRIMARY KEY (idterapia, idespecialista),
      CONSTRAINT fk_terapia_especialista FOREIGN KEY (idterapia) REFERENCES tab_terapia (idterapia),
      CONSTRAINT fk_especialista_especialista_terapia FOREIGN KEY (idespecialista) REFERENCES tab_especialista (idespecialista)
   );

--- CONSTRAINTS PACIENTE_TERAPIA
ALTER TABLE paciente_terapia
ADD (
      CONSTRAINT pk_paciente_terapia PRIMARY KEY (idterapia, idpaciente),
      CONSTRAINT fk_terapia_paciente FOREIGN KEY (idterapia) REFERENCES tab_terapia (idterapia),
      CONSTRAINT fk_paciente_paciente_terapia FOREIGN KEY (idpaciente) REFERENCES tab_paciente (idpaciente)
   );

--- CONSTRAINTS ENDERECO_PESSOA
ALTER TABLE endereco_pessoa
ADD (
      CONSTRAINT pk_pessoa_endereco PRIMARY KEY (idendereco, idcadastro),
      CONSTRAINT fk_endereco FOREIGN KEY (idendereco) REFERENCES tab_endereco (idendereco),
      CONSTRAINT fk_pessoa_endereco_pessoa FOREIGN KEY (idcadastro) REFERENCES tab_pessoa (idcadastro)
   );

--- CONSTRAINTS USUARIO
ALTER TABLE tab_usuario
ADD CONSTRAINT fk_usuario_pessoa FOREIGN KEY (idcadastro) REFERENCES tab_pessoa (idcadastro);

--- CONSTRAINTS USUARIO_PERFIL
ALTER TABLE usuario_perfil
ADD (
      CONSTRAINT pk_usuario_perfil PRIMARY KEY (idcadastro, idperfil),
      CONSTRAINT fk_usuario FOREIGN KEY (idcadastro) REFERENCES tab_usuario (idcadastro),
      CONSTRAINT fk_perfil_usuario_perfil FOREIGN KEY (idperfil) REFERENCES tab_perfil (idperfil)
   );

--- CONSTRAINTS PERFIL_PERMISSAO
ALTER TABLE perfil_permissao
ADD (
      CONSTRAINT pk_perfil_permissao PRIMARY KEY (idperfil, idpermissao),
      CONSTRAINT fk_perfil_perfil_permissao FOREIGN KEY (idperfil) REFERENCES tab_perfil (idperfil),
      CONSTRAINT fk_permissao FOREIGN KEY (idpermissao) REFERENCES tab_permissao (idpermissao)
   );

--- CONSTRAINTS RESPONSAVEL_PACIENTE
ALTER TABLE responsavel_paciente
ADD (
      CONSTRAINT pk_responsavel_paciente PRIMARY KEY (idresponsavel, idpaciente),
      CONSTRAINT fk_responsavel FOREIGN KEY (idresponsavel) REFERENCES tab_responsavel (idresponsavel),
      CONSTRAINT fk_paciente FOREIGN KEY (idpaciente) REFERENCES tab_paciente (idpaciente)
   );

--- CONSTRAINTS TAB_CARGO
ALTER TABLE tab_cargo
ADD CONSTRAINT fk_codigocbo FOREIGN KEY (codigocbo) REFERENCES tab_cbo (codigocbo);

--- CONSTRAINTS TAB_PACIENTE
ALTER TABLE tab_paciente
ADD (
      CONSTRAINT fk_pessoa_paciente FOREIGN KEY (idpaciente) REFERENCES tab_pessoa (idcadastro),
      CONSTRAINT fk_escola FOREIGN KEY (idescola) REFERENCES tab_escola (idescola)
   );

--- CONSTRAINTS TAB_PRONTUARIO
ALTER TABLE tab_prontuario
ADD CONSTRAINT fk_prontuario_paciente FOREIGN KEY (idpaciente) REFERENCES tab_paciente (idpaciente);

--- CONSTRAINTS PACIENTE_CID
ALTER TABLE paciente_cid
ADD (
      CONSTRAINT pk_paciente_cid PRIMARY KEY (codigocid, idpaciente),
      CONSTRAINT fk_cid FOREIGN KEY (codigocid) REFERENCES tab_cid (codigocid),
      CONSTRAINT fk_paciente_paciente_cid FOREIGN KEY (idpaciente) REFERENCES tab_paciente (idpaciente)
   );

--- CONSTRAINTS TAB_RESPONSAVEL
ALTER TABLE tab_responsavel
ADD CONSTRAINT fk_responsavel_pessoa FOREIGN KEY (idresponsavel) REFERENCES tab_pessoa (idcadastro);

--- CONSTRAINTS TAB_PROFISSIONAL
ALTER TABLE tab_profissional
ADD (
      CONSTRAINT fk_profissional_pessoa FOREIGN KEY (idprofissional) REFERENCES tab_pessoa (idcadastro),
      CONSTRAINT fk_profissional_cargo FOREIGN KEY (idcargo) REFERENCES tab_cargo (idcargo)
   );

--- CONSTRAINTS TAB_ESPECIALISTA
ALTER TABLE tab_especialista
ADD CONSTRAINT fk_especialista_profissional FOREIGN KEY (idespecialista) REFERENCES tab_profissional (idprofissional);