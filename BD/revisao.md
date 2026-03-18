# Revisão Oracle 🗄

## Tipos de Dados 🎲

  - ``char``
     
  - ``varchar2``
    
  - ``int`` ➡ Variáveis inteiras (ex: Nº de casa);
    
  - ``number`` ➡ Pode ser tanto inteiro quanto facionário. Sintaxe: **(tamanho_total, [ *opcional* ] casas_decimais)**;
    
  - ``date`` ➡ Carrega apenas as datas;
    
  - ``boolean`` ➡ True e False (ex: campo tá ATIVO (**true**) ou DESATIVADO (**false**);
    
  - ``datetime`` ➡ Carrega as datas e também as horas;
    
  - ``float`` ➡ Precisão de 7 casas decimais **(recomendado apenas em ocasiões matemáticas e não monetárias)**;
    
  - ``double`` ➡ Precisão de 14 casas decimais;

  - ``blob`` ➡ Guarda imagens, armazenando o endereço de onde está a foto (ponteiro).

---

## Script de Revisão 📋
```sql
CREATE TABLE aluno (
RA          NUMBER NOT NULL PRIMARY KEY,
Nome        VARCHAR2(100) NOT NULL,
Nota        NUMBER(10,2) NOT NULL,
DatInc      DATETIME,
Sexo        CHAR(1) Check (SEXO In ('M', 'F', 'B')
Ativo       BOOLEAN,
Salario     FLOAT NOT NULL,
CPF         INT NOT NULL UNIQUE,
),

CREATE TABLE curso (
CodCur INT Primary Key,
NomeCur VARCHAR2(100) NOT NULL,
),

--- Adiciona: FOREIGN KEY CodCur REFERENCE curso
ALTER TABLE aluno
ADD CONSTRAINT
FOREIGN KEY CodCur REFERENCE curso;

--- Adiciona: Faltas INT NOT NULL a tabela aluno
ALTER TABLE aluno
ADD
Faltas INT NOT NULL;

--- Modifica a coluna Nome
ALTER TABLE aluno
MODIFY
Nome VARCHAR2(200) NOT NULL;

--- Exlui a coluna inteira
ALTER TABLE aluno
DROP COLUMN Salario;

--- Para inserir novos dados na tabela
INSERT INTO aluno (CodId, Nome, Sexo)
VALUES
(10, "Joao", 'F');

--- Deleta a linha no qual o CodId é igual a 10
DELETE FROM aluno
WHERE CodId = 10;

--- Alterar/atualizar um dado. NÃO HÁ COMO ALTERAR UMA PK OU FK
UPDATE aluno
SET Nome = "Jose", Nota = 10, Curso = "TI"
WHERE (CodId = 10 and Nota = 0) or Nome = "Vitor";

--- * = TODAS AS COLUNAS
SELECT * FROM aluno;

```
---

## Funções de Agregação no Oracle 
   
 - **COUNT:**   
Retorna o número de linhas em um grupo. Exemplo:
    - ``SELECT COUNT(*) FROM funcionarios;`` (retorna o número total de funcionários)
    - ``SELECT COUNT(nome_coluna) from tabela;`` (retorna o numero de linhas onde a coluna não e nula)
      
  
  - **SUM:**  
Calcula a soma de valores numéricos em uma coluna. Exemplo:
    - ``SELECT SUM(salario) FROM funcionarios;`` (retorna a soma de todos os salários)
      
  
  - **AVG:**  
Calcula a média de valores numéricos em uma coluna. Exemplo:
    - ``SELECT AVG(salario) FROM funcionarios;`` (retorna a média dos salários)
      
  
  - **MAX:**  
Retorna o valor máximo em uma coluna. Exemplo:
    - ``SELECT MAX(salario) FROM funcionarios;`` (retorna o maior salário)
      
  
  - **MIN:**  
Retorna o valor mínimo em uma coluna. Exemplo:
    - ``SELECT MIN(salario) FROM funcionarios;`` (retorna o menor salário)
      
  
  - **STDDEV:**  
Calcula o desvio padrão de um conjunto de números. Exemplo:
    - ``SELECT STDDEV(salario) FROM funcionarios;``
      
  
  - **VARIANCE:**  
Calcula a variância de um conjunto de números. Exemplo:
    - ``SELECT VARIANCE(salario) FROM funcionarios;``
      
--- 

### Exemplos de uso com a cláusula ``GROUP BY`` 👥 

A cláusula GROUP BY é frequentemente usada em conjunto com funções de agregação para agrupar linhas com base em uma ou mais colunas e aplicar a função de agregação a cada grupo. Exemplo: 
  - ``SELECT departamento, AVG(salario) FROM funcionarios GROUP BY departamento;`` (retorna a média salarial por departamento)
  - ``SELECT departamento, COUNT(*) FROM funcionarios GROUP BY departamento;`` (retorna a quantidade de funcionarios por departamento)

### Considerações ☑
  - As funções de agregação ignoram valores nulos, exceto COUNT(*).

  - É possível usar a cláusula DISTINCT dentro de uma função de agregação para calcular a função apenas para valores distintos. Exemplo:
      - ``SELECT COUNT(DISTINCT departamento) FROM funcionarios;``
        
  - A clausula HAVING pode ser usada para filtrar resultados de funções de agregação. Exemplo:
      - ``SELECT departamento, AVG(salario) FROM funcionarios GROUP BY departamento HAVING AVG(salario) > 5000;``
