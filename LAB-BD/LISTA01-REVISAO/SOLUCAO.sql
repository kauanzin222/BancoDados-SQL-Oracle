--- 1. ADICIONAR CHAVES NA TABELA AutorLivro (PK COMPOSTA E FKs) ---
ALTER TABLE AutorLivro ADD CONSTRAINT pk_autorlivro PRIMARY KEY (codigoLivro, codAutor);
ALTER TABLE AutorLivro ADD CONSTRAINT fk_al_livro FOREIGN KEY (codigoLivro) REFERENCES Livro(CodigoLivro);
ALTER TABLE AutorLivro ADD CONSTRAINT fk_al_autor FOREIGN KEY (codAutor) REFERENCES Autor(CodAutor);

--- 2. ADICIONAR COLUNA NACIONALIDADE EM Autor ---
ALTER TABLE Autor ADD Nacionalidade VARCHAR2(20);

--- 3. INCLUSÃO DE DADOS (ORDEM: ASSUNTO/AUTOR -> LIVRO -> AUTORLIVRO) ---
-- A ordem é necessária para respeitar a integridade referencial (FKs).
INSERT INTO Assunto (CodAssunto, descricao, descontopromocao) VALUES (1, 'Banco de Dados', 'S');
INSERT INTO Assunto (CodAssunto, descricao, descontopromocao) VALUES (10, 'Sistemas Operacionais', 'N');

INSERT INTO Autor (CodAutor, Nomeautor, datanascimento, CidadeNasc, sexo, Nacionalidade) 
VALUES (100, 'Chris Date', TO_DATE('1941-01-01', 'YYYY-MM-DD'), 'Watford', 'M', 'Inglês');
INSERT INTO Autor (CodAutor, Nomeautor, datanascimento, CidadeNasc, sexo, Nacionalidade) 
VALUES (200, 'Andrew Tanenbaum', TO_DATE('1950-03-16', 'YYYY-MM-DD'), 'Nova York', 'M', 'Americano');

INSERT INTO Livro (CodigoLivro, Titulo, Editora, Cidade, DataEdicao, Versao, CodAssunto, Preco, DataCadastro, lancamento)
VALUES (888, 'Introdução a Sistemas', 'Campus', 'Rio', TO_DATE('2010-05-10', 'YYYY-MM-DD'), 1, 1, 150.00, SYSDATE, 'S');
INSERT INTO Livro (CodigoLivro, Titulo, Editora, Cidade, DataEdicao, Versao, CodAssunto, Preco, DataCadastro, lancamento)
VALUES (123, 'Sistemas Modernos', 'Pearson', 'SP', TO_DATE('1975-01-01', 'YYYY-MM-DD'), 2, 10, 200.00, SYSDATE, 'N');

INSERT INTO AutorLivro (codigoLivro, codAutor) VALUES (888, 100);
INSERT INTO AutorLivro (codigoLivro, codAutor) VALUES (123, 200);

--- 4. ALTERAR COLUNA TÍTULO PARA 40 POSIÇÕES ---
ALTER TABLE Livro MODIFY Titulo VARCHAR2(40);

--- 5. RESTRIÇÃO DE DOMÍNIO (S OU N) EM descontopromocao ---
ALTER TABLE Assunto ADD CONSTRAINT ck_desconto_sn CHECK (descontopromocao IN ('S', 'N'));

--- 6. ALTERAR EDITORA DO LIVRO 888 PARA 'Editora LTC' ---
UPDATE Livro SET Editora = 'Editora LTC' WHERE CodigoLivro = 888;

--- 7. EXCLUIR LIVROS (ASSUNTO 10 E EDIÇÃO < 1980) ---
DELETE FROM Livro 
WHERE CodAssunto = 10 
AND EXTRACT(YEAR FROM DataEdicao) < 1980;

--- 8. LISTAR LIVROS COM "BANCO DE DADOS" NO TÍTULO ---
SELECT Titulo FROM Livro WHERE Titulo LIKE '%Banco de Dados%';

--- 9. LISTAR AUTORES NASCIDOS ENTRE 1950 E 1970 (ORDENADOS) ---
SELECT Nomeautor 
FROM Autor 
WHERE EXTRACT(YEAR FROM datanascimento) BETWEEN 1950 AND 1970
ORDER BY CidadeNasc, Nomeautor;

--- 10. QUANTIDADE DE LIVROS POR ASSUNTO ---
SELECT CodAssunto, COUNT(*) AS Qtd_Livros 
FROM Livro 
GROUP BY CodAssunto;

--- 11. TÍTULO DO LIVRO E DESCRIÇÃO DO ASSUNTO ---
SELECT L.Titulo, A.descricao
FROM Livro L
JOIN Assunto A ON L.CodAssunto = A.CodAssunto;

--- 12. CÓDIGO LIVRO, TÍTULO, CÓDIGO E NOME DOS AUTORES ---
SELECT L.CodigoLivro, L.Titulo, A.CodAutor, A.Nomeautor
FROM Livro L
JOIN AutorLivro AL ON L.CodigoLivro = AL.codigoLivro
JOIN Autor A ON AL.codAutor = A.CodAutor;

--- 13. CÓDIGO DOS AUTORES COM MAIS DE 3 LIVROS ---
SELECT codAutor 
FROM AutorLivro 
GROUP BY codAutor 
HAVING COUNT(codigoLivro) > 3;
