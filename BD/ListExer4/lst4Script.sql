

--- Comandos DDL:


--- Question 3....
ALTER TABLE TB_VENDEDOR
ADD DataNascimento DATE;

ALTER TABLE TB_VENDEDOR
MODIFY DataNascimento DATE not NULL;

--- Question 4...
ALTER TABLE TB_CLIENTE 
ADD Regiao VARCHAR2(20);

--- Question 5...
ALTER TABLE TB_CLIENTE 
MODIFY NomeCliente VARCHAR2(50);

--- Question 6... 
ALTER TABLE TB_CLIENTE
DROP COLUMN Regiao;
ALTER TABLE TB_VENDEDOR
DROP COLUMN DataNascimento;


--- Comandos DML: (insert, update, delete e select)

--- Question 1...

--- Insert na Tabela de Vendedores
INSERT INTO TB_VENDEDOR 
VALUES (10, 'Ana Paula', 3.00, 2800.00); 

UPDATE TB_VENDEDOR 
SET DATANASCIMENTO = TO_DATE('2000-10-02', 'YYYY-MM-DD') 
WHERE NomeVendedor = 'Ana Paula';


INSERT INTO TB_VENDEDOR 
VALUES (11, 'Bruno Costa', 5.50, 2400.00, '02-10-2000');

INSERT INTO TB_VENDEDOR 
VALUES (12, 'Carla Dias', 7.00, 2100.00, '17-09-1999'); 

INSERT INTO TB_VENDEDOR
VALUES (13, 'Diogo Martins', 1.50, 3100.00, '10-03-2004'); 

INSERT INTO TB_VENDEDOR (CodVendedor, NomeVendedor, FAIXACOMISSAO,SALARIOFIXO, DataNascimento)
VALUES (14, 'Elisa Fernandes', 4.00, 2750.00, '12-10-2000');

--- Insert na Tabela de Clientes
INSERT INTO TB_CLIENTE 
VALUES (100, 'Padaria Doce Pão', 'Rua da Padaria, 10', 'Sorocaba', '18010-001', 'SP'); 

INSERT INTO TB_CLIENTE 
VALUES (101, 'Mercado Central', 'Av. São Paulo, 200', 'Sorocaba', '18013-002', 'SP'); 

INSERT INTO TB_CLIENTE  
VALUES (102, 'Restaurante Sabor', 'Rua Augusta, 50', 'São Paulo', '01305-000', 'SP'); 

INSERT INTO TB_CLIENTE 
VALUES (103, 'Loja de Conveniência', 'Av. Brasil, 30', 'Campinas', '13010-001', 'SP'); 

INSERT INTO TB_CLIENTE  
VALUES (104, 'Supermercado Vila', 'Rua XV de Novembro, 77', 'Sorocaba', '18010-080', 'SP');


--- Insert na Tabela de Produtos
INSERT INTO TB_PRODUTO 
VALUES (201, 'Açúcar Refinado 1kg', 'KG', 4.50); 

INSERT INTO TB_PRODUTO 
VALUES (202, 'Café em Pó 500g', 'KG', 18.90); 

INSERT INTO TB_PRODUTO 
VALUES (203, 'Suco de Laranja 1L', 'LT', 10.20); 

INSERT INTO TB_PRODUTO 
VALUES (204, 'Água Mineral 5L', 'LT', 8.00); 

INSERT INTO TB_PRODUTO 
VALUES (205, 'Cx. Chocolate Bis', 'CX', 6.99); 

INSERT INTO TB_PRODUTO 
VALUES (206, 'Batata Palha 120g', 'KG', 5.75);

--- Insert na Tabela de Pedidos
INSERT INTO TB_PEDIDO
VALUES (1001, TO_DATE('2025-11-11', 'YYYY-MM-DD'), 100, 10); 

INSERT INTO TB_PEDIDO 
VALUES (1002, TO_DATE('2000-10-10', 'YYYY-MM-DD'), 101, 11);

INSERT INTO TB_PEDIDO 
VALUES (1003, TO_DATE('2025-11-10', 'YYYY-MM-DD'), 102, 12); 

INSERT INTO TB_PEDIDO 
VALUES (1004, TO_DATE('2025-11-12', 'YYYY-MM-DD'), 103, 10); 

INSERT INTO TB_PEDIDO  
VALUES (1005, TO_DATE('2025-11-13', 'YYYY-MM-DD'), 104, 13); 

--- Question 2