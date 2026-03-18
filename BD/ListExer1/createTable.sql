CREATE TABLE tb_paciente (
    codPaciente NUMBER NOT NULL PRIMARY KEY,
    nome VARCHAR2(50) NOT NULL,
    sexo CHAR(1),
    dataNasc DATE NOT NULL,
    endereco VARCHAR2(50),
    cidade VARCHAR2(30),
    idade  integer  default 0 not null,
    desconto decimal (4, 2) default 0 not null
);


CREATE TABLE tb_medico (
    codMedico NUMBER NOT NULL PRIMARY KEY,
    nome VARCHAR2(50) NOT NULL,
    especialidade VARCHAR2(50)
);



-- Script para criar a tabela tb_consulta
-- Inclui a chave primária e as chaves estrangeiras para relacionar com pacientes e médicos.

CREATE TABLE tb_consulta (
    codConsulta NUMBER NOT NULL PRIMARY KEY,
    codPaciente NUMBER NOT NULL,
    codMedico NUMBER NOT NULL,
    dataConsulta DATE,
    valorConsulta NUMBER(10, 2), -- Formato com 10 dígitos no total, sendo 2 para os centavos.

    -- Restrição (CONSTRAINT) para garantir que o codPaciente exista na tb_paciente.
    CONSTRAINT fk_paciente FOREIGN KEY (codPaciente) REFERENCES tb_paciente(codPaciente),

    -- Restrição (CONSTRAINT) para garantir que o codMedico exista na tb_medico.
    CONSTRAINT fk_medico FOREIGN KEY (codMedico) REFERENCES tb_medico(codMedico)
);


INSERT ALL
    INTO tb_paciente (codPaciente, nome, sexo, dataNasc, endereco, cidade, idade, desconto) VALUES (1, 'Ana Clara Silva', 'F', TO_DATE('1990-05-15', 'YYYY-MM-DD'), 'Rua das Flores, 123', 'São Paulo', 45, 10)
    INTO tb_paciente (codPaciente, nome, sexo, dataNasc, endereco, cidade, idade, desconto) VALUES (2, 'João Pedro Santos', 'M', TO_DATE('1985-02-20', 'YYYY-MM-DD'), 'Avenida Paulista, 1500', 'São Paulo', 55, 10)
    INTO tb_paciente (codPaciente, nome, sexo, dataNasc, endereco, cidade, idade, desconto) VALUES (3, 'Maria Eduarda Oliveira', 'F', TO_DATE('2001-11-30', 'YYYY-MM-DD'), 'Rua XV de Novembro, 789', 'Sorocaba', 65, 15)
    INTO tb_paciente (codPaciente, nome, sexo, dataNasc, endereco, cidade, idade, desconto) VALUES (4, 'Carlos Alberto Pereira', 'M', TO_DATE('1978-07-10', 'YYYY-MM-DD'), 'Alameda dos Anjos, 45', 'Campinas', 35, 5)
    INTO tb_paciente (codPaciente, nome, sexo, dataNasc, endereco, cidade, idade, desconto) VALUES (5, 'Fernanda Lima Costa', 'F', TO_DATE('1995-01-25', 'YYYY-MM-DD'), 'Travessa das Palmeiras, 99', 'Santos', 50, 10)
    INTO tb_paciente (codPaciente, nome, sexo, dataNasc, endereco, cidade, idade, desconto) VALUES (6, 'Lucas Gabriel Souza', 'M', TO_DATE('1998-09-03', 'YYYY-MM-DD'), 'Rua do Comércio, 500', 'Jundiaí', 46, 10)
    INTO tb_paciente (codPaciente, nome, sexo, dataNasc, endereco, cidade, idade, desconto) VALUES (7, 'Juliana Martins Lima', 'F', TO_DATE('1982-03-12', 'YYYY-MM-DD'), 'Avenida Brasil, 210', 'Rio de Janeiro', 25, 0)
    INTO tb_paciente (codPaciente, nome, sexo, dataNasc, endereco, cidade, idade, desconto) VALUES (8, 'Rafael Augusto Ferreira', 'M', TO_DATE('2005-06-08', 'YYYY-MM-DD'), 'Praça da Sé, 1', 'São Paulo', 15, 0)
    INTO tb_paciente (codPaciente, nome, sexo, dataNasc, endereco, cidade, idade, desconto) VALUES (9, 'Camila Vitória Alves', 'F', TO_DATE('1999-08-19', 'YYYY-MM-DD'), 'Rua Augusta, 1120', 'São Paulo', 75, 15)
    INTO tb_paciente (codPaciente, nome, sexo, dataNasc, endereco, cidade, idade, desconto) VALUES (10, 'Bruno Henrique Rodrigues', 'M', TO_DATE('1988-12-01', 'YYYY-MM-DD'), 'Rua Direita, 32', 'Sorocaba', 40, 20)
SELECT 1 FROM DUAL;

-- Confirma a transação, salvando os dados permanentemente na tabela.
COMMIT;

-- Opcional: comando para verificar se os dados foram inseridos corretamente.
SELECT * FROM tb_paciente;



INSERT ALL
    INTO tb_medico (codMedico, nome, especialidade) VALUES (1, 'Dr. Carlos Monteiro', 'Cardiologia')
    INTO tb_medico (codMedico, nome, especialidade) VALUES (2, 'Dra. Helena Jordão', 'Pediatria')
    INTO tb_medico (codMedico, nome, especialidade) VALUES (3, 'Dr. Ricardo Almeida', 'Ortopedia')
    INTO tb_medico (codMedico, nome, especialidade) VALUES (4, 'Dra. Beatriz Santos', 'Dermatologia')
    INTO tb_medico (codMedico, nome, especialidade) VALUES (5, 'Dr. Felipe Barros', 'Clínica Geral')
SELECT 1 FROM DUAL;

-- Confirma a transação, salvando os dados permanentemente na tabela.
COMMIT;

-- Opcional: comando para verificar se os dados foram inseridos corretamente.
SELECT * FROM tb_medico;



-- Script para popular a tabela tb_consulta com 10 registros.
-- Os códigos de paciente e médico correspondem aos dados inseridos anteriormente.

INSERT ALL
    INTO tb_consulta (codConsulta, codPaciente, codMedico, dataConsulta, valorConsulta) VALUES (100, 1, 5, TO_DATE('2023-10-10', 'YYYY-MM-DD'), 150.00)
    INTO tb_consulta (codConsulta, codPaciente, codMedico, dataConsulta, valorConsulta) VALUES (200, 3, 2, TO_DATE('2023-10-11', 'YYYY-MM-DD'), 250.50)
    INTO tb_consulta (codConsulta, codPaciente, codMedico, dataConsulta, valorConsulta) VALUES (300, 2, 1, TO_DATE('2023-10-12', 'YYYY-MM-DD'), 300.00)
    INTO tb_consulta (codConsulta, codPaciente, codMedico, dataConsulta, valorConsulta) VALUES (400, 5, 4, TO_DATE('2023-10-12', 'YYYY-MM-DD'), 220.00)
    INTO tb_consulta (codConsulta, codPaciente, codMedico, dataConsulta, valorConsulta) VALUES (500, 4, 3, TO_DATE('2023-10-13', 'YYYY-MM-DD'), 280.75)
    INTO tb_consulta (codConsulta, codPaciente, codMedico, dataConsulta, valorConsulta) VALUES (600, 7, 5, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 150.00)
    INTO tb_consulta (codConsulta, codPaciente, codMedico, dataConsulta, valorConsulta) VALUES (700, 6, 2, TO_DATE('2023-10-15', 'YYYY-MM-DD'), 250.50)
    INTO tb_consulta (codConsulta, codPaciente, codMedico, dataConsulta, valorConsulta) VALUES (800, 9, 1, TO_DATE('2023-10-16', 'YYYY-MM-DD'), 300.00)
    INTO tb_consulta (codConsulta, codPaciente, codMedico, dataConsulta, valorConsulta) VALUES (900, 8, 4, TO_DATE('2023-10-17', 'YYYY-MM-DD'), 220.00)
    INTO tb_consulta (codConsulta, codPaciente, codMedico, dataConsulta, valorConsulta) VALUES (1000, 10, 3, TO_DATE('2023-10-18', 'YYYY-MM-DD'), 280.75)
SELECT 1 FROM DUAL;

-- Confirma a transação, salvando os dados permanentemente na tabela.
COMMIT;

-- Opcional: comando para verificar se os dados foram inseridos corretamente.
SELECT * FROM tb_consulta;

