---                             1. Resolução:

--- Dizendo que o campo CodAssunto faz referência a ASSUNTO
ALTER TABLE Livro ADD CONSTRAINT FK_Livro_CodAssunto FOREIGN KEY (CodAssunto) REFERENCES Assunto;

--- Dizendo que o campo codigoLivro faz referência a LIVRO
ALTER TABLE Autorlivro ADD CONSTRAINT FK_Autorlivro_CodLivro FOREIGN KEY (codigoLivro) REFERENCES Livro;

--- Dizendo que o campo codAutor faz referência a AUTOR
ALTER TABLE Autorlivro ADD CONSTRAINT FK_Autorlivro_CodAutor FOREIGN KEY (codAutor) REFERENCES Autor;

--- Criando a PK Composta
ALTER TABLE Autorlivro ADD CONSTRAINT PK_Autorlivro PRIMARY KEY (codigoLivro, codAutor);

--- Através deste comando, é possível visualizar as constraints registradas do USER
SELECT * FROM USER_CONSTRAINTS;

---                             2. Resolução: 

ALTER TABLE Autor ADD Nacionalidade VARCHAR2(20);

---                             3. Resolução:

-- A ordem é necessária para respeitar a integridade referencial (FKs).

--- ASSUNTO
INSERT INTO Assunto (CodAssunto, descricao, descontopromocao) VALUES (1, 'Banco de Dados', 'S');
INSERT INTO Assunto (CodAssunto, descricao, descontopromocao) VALUES (10, 'Sistemas Operacionais', 'N');

--- AUTOR
INSERT INTO Autor (CodAutor, Nomeautor, datanascimento, CidadeNasc, sexo, Nacionalidade) 
VALUES (100, 'Chris Date', TO_DATE('1941-01-01', 'YYYY-MM-DD'), 'Watford', 'M', 'Inglês');
INSERT INTO Autor (CodAutor, Nomeautor, datanascimento, CidadeNasc, sexo, Nacionalidade) 
VALUES (200, 'Andrew Tanenbaum', TO_DATE('1950-03-16', 'YYYY-MM-DD'), 'Nova York', 'M', 'Americano');

--- LIVRO
INSERT INTO Livro (CodigoLivro, Titulo, Editora, Cidade, DataEdicao, Versao, CodAssunto, Preco, DataCadastro, lancamento)
VALUES (888, 'Introdução a Sistemas', 'Campus', 'Rio', TO_DATE('2010-05-10', 'YYYY-MM-DD'), 1, 1, 150.00, SYSDATE, 'S');
INSERT INTO Livro (CodigoLivro, Titulo, Editora, Cidade, DataEdicao, Versao, CodAssunto, Preco, DataCadastro, lancamento)
VALUES (123, 'Sistemas Modernos', 'Pearson', 'SP', TO_DATE('1975-01-01', 'YYYY-MM-DD'), 2, 10, 200.00, SYSDATE, 'N');

--- AUTORLIVRO
INSERT INTO AutorLivro (codigoLivro, codAutor) VALUES (888, 100);
INSERT INTO AutorLivro (codigoLivro, codAutor) VALUES (123, 200);

---                             4. Resolução:

ALTER TABLE Livro MODIFY Titulo VARCHAR2(40);

---                             5. Resolução:

ALTER TABLE Assunto ADD CONSTRAINT CK_Desconto_SN CHECK (descontopromocao IN ('S', 'N'));

---                             6. Resolução:
