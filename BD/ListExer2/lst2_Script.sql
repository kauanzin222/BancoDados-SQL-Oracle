
--- Question 1...
CREATE VIEW vw_produtos_eletronicos AS
SELECT  p.NOME_PRODUTO, p.PRECO_UNITARIO 
FROM PRODUTOS p
    inner join CATEGORIAS c on (c.id_categoria = p.id_categoria)
WHERE c.nome_categoria = 'Eletrônicos';

SELECT * FROM VW_PRODUTOS_ELETRONICOS;


--- Question 2...
CREATE VIEW vw_total_vendas_nike AS
SELECT SUM(v.quantidade) AS Quantidade_Vendida
FROM VENDAS v 
    inner join PRODUTOS p on (p.id_produto = v.id_produto)
    inner join FABRICANTES f on (f.id_fabricante = p.id_fabricante)
WHERE f.nome_fabricante = 'Nike';

SELECT * FROM VW_TOTAL_VENDAS_NIKE;

--- Question 3...
CREATE VIEW vw_preco_medio_por_categoria AS
SELECT c.nome_categoria, AVG(p.preco_unitario) AS Preco_Medio
FROM PRODUTOS p 
    inner join CATEGORIAS c on (c.id_categoria = p.id_categoria)
GROUP BY c.nome_categoria;

SELECT * FROM vw_preco_medio_por_categoria;

--- Question 4...
CREATE VIEW vw_vendas_2025 AS
SELECT p.nome_produto, v.data_venda
FROM PRODUTOS p     
    inner join VENDAS v on (v.id_produto = p.id_produto)
WHERE v.data_venda >= '01-01-2025';

SELECT * FROM vw_vendas_2025;

--- Question 5...
CREATE VIEW vw_clientes_ativos_sorocaba AS
SELECT nome_cliente FROM CLIENTES
WHERE cidade = 'Sorocaba' AND status = 'ATIVO';

SELECT * FROM vw_clientes_ativos_sorocaba;

--- Question 6...
CREATE VIEW vw_produto_mais_caro AS 
SELECT nome_produto, preco_unitario
FROM PRODUTOS
ORDER BY preco_unitario DESC
FETCH FIRST 1 ROW ONLY;

SELECT * FROM vw_produto_mais_caro;

--- Question 7...
CREATE VIEW vw_contagem_vendas_por_produto AS
SELECT p.nome_produto, SUM(v.quantidade) AS Vendas_Totais
FROM PRODUTOS p
    inner join VENDAS v on (v.id_produto = p.id_produto)
GROUP BY p.nome_produto;

SELECT * FROM vw_contagem_vendas_por_produto;

--- Question 8...
CREATE VIEW vw_fabricantes_sem_produtos AS
SELECT f.nome_fabricante FROM FABRICANTES f
WHERE NOT EXISTS (
    SELECT 1 
    FROM PRODUTOS p
    WHERE p.id_fabricante = f.id_fabricante
);

SELECT * FROM vw_fabricantes_sem_produtos;

--- Question 9...
CREATE VIEW vw_total_gasto_por_vendas AS 
SELECT v.id_venda, (v.quantidade * p.preco_unitario) AS Valor_Total
FROM VENDAS v 
    inner join PRODUTOS p on (p.id_produto = v.id_produto);

SELECT * FROM vw_total_gasto_por_vendas;

--- Question 10...
CREATE VIEW vw_primeira_venda_por_produto AS
SELECT p.nome_produto, MIN(v.data_venda) AS Primeira_Venda
FROM PRODUTOS p 
    inner join VENDAS v on (v.id_produto = p.id_produto)
GROUP BY p.nome_produto;

SELECT * FROM vw_primeira_venda_por_produto;
