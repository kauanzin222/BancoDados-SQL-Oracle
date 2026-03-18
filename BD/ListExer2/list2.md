# Creating Views in Oracle 🔨
## FATEC – ADS - Database Laboratory 🎲

Based on the tables **``categories, manufacturers, products, sales, and customers``**, create the following Views in Oracle:

---
  Create a View named ``vw_produtos_eletronicos`` that lists the name and unit price of all products in the 'Electronics' category.
  ```sql
CREATE VIEW vw_produtos_eletronicos AS
SELECT  p.NOME_PRODUTO, p.PRECO_UNITARIO
FROM PRODUTOS p
    inner join CATEGORIAS c on (c.id_categoria = p.id_categoria)
WHERE c.nome_categoria = 'Eletrônicos';

SELECT * FROM VW_PRODUTOS_ELETRONICOS;

  ```
---

  Create a View named ``vw_total_vendas_nike`` that shows the total number of sales (in quantity) of products from the 'Nike' manufacturer.
  ```sql
 CREATE VIEW vw_total_vendas_nike AS
SELECT SUM(v.quantidade) AS Quantidade_Vendida
FROM VENDAS v 
    inner join PRODUTOS p on (p.id_produto = v.id_produto)
    inner join FABRICANTES f on (f.id_fabricante = p.id_fabricante)
WHERE f.nome_fabricante = 'Nike';

SELECT * FROM VW_TOTAL_VENDAS_NIKE;
  ```
  ---
  
  Create a View named ``vw_preco_medio_por_categoria`` that displays the name of each category and the average price of products in that category.
   ```sql
  CREATE VIEW vw_total_vendas_nike AS
SELECT SUM(v.quantidade) AS Quantidade_Vendida
FROM VENDAS v 
    inner join PRODUTOS p on (p.id_produto = v.id_produto)
    inner join FABRICANTES f on (f.id_fabricante = p.id_fabricante)
WHERE f.nome_fabricante = 'Nike';

SELECT * FROM VW_TOTAL_VENDAS_NIKE;
  ```
  ---
  Create a View named ``vw_vendas_2025`` that lists the product name and the sale date for all sales made in the year 2025.
   ```sql
CREATE VIEW vw_vendas_2025 AS
SELECT p.nome_produto, v.data_venda
FROM PRODUTOS p     
    inner join VENDAS v on (v.id_produto = p.id_produto)
WHERE v.data_venda >= '01-01-2025';

SELECT * FROM vw_vendas_2025;
  ```
  ---
  
  Create a View named ``vw_clientes_ativos_sorocaba`` that shows the name of all customers who reside in the city of 'Sorocaba' and have an 'ACTIVE' status.
   ```sql
  CREATE VIEW vw_clientes_ativos_sorocaba AS
SELECT nome_cliente FROM CLIENTES
WHERE cidade = 'Sorocaba' AND status = 'ATIVO';

SELECT * FROM vw_clientes_ativos_sorocaba;

  ```
  ---
  
  Create a View named ``vw_produto_mais_caro `` that displays the name of the product with the highest unit price. (Hint: Use a subquery or an aggregate function with ORDER BY and ROWNUM)
   ```sql
CREATE VIEW vw_produto_mais_caro AS 
SELECT nome_produto, preco_unitario
FROM PRODUTOS
ORDER BY preco_unitario DESC
FETCH FIRST 1 ROW ONLY;

SELECT * FROM vw_produto_mais_caro;
  ```
  ---
  
  Create a View named ``vw_contagem_vendas_por_produto`` that shows the name of each product and the total number of times it was sold.
   ```sql
CREATE VIEW vw_contagem_vendas_por_produto AS
SELECT p.nome_produto, SUM(v.quantidade) AS Vendas_Totais
FROM PRODUTOS p
    inner join VENDAS v on (v.id_produto = p.id_produto)
GROUP BY p.nome_produto;

SELECT * FROM vw_contagem_vendas_por_produto;

  ```
  ---
  - Create a View named ``vw_fabricantes_sem_produtos`` that lists the name of all manufacturers who do not have any product registered in the products table. (Hint: Use NOT IN or NOT EXISTS)
   ```sql
CREATE VIEW vw_fabricantes_sem_produtos AS
SELECT f.nome_fabricante FROM FABRICANTES f
WHERE NOT EXISTS (
    SELECT 1 
    FROM PRODUTOS p
    WHERE p.id_fabricante = f.id_fabricante
);

SELECT * FROM vw_fabricantes_sem_produtos;

  ```
  ---
  Create a View named ``vw_total_gasto_por_venda`` that shows the sale ID and the total amount spent on each sale (quantity * unit price).
  ```sql
CREATE VIEW vw_total_gasto_por_vendas AS 
SELECT v.id_venda, (v.quantidade * p.preco_unitario) AS Valor_Total
FROM VENDAS v 
    inner join PRODUTOS p on (p.id_produto = v.id_produto);

SELECT * FROM vw_total_gasto_por_vendas;

  ```
  ---

  Create a View named ``vw_primeira_venda_por_produto`` that displays the name of each product and the date of its first registered sale. (Hint: Use the MIN aggregate function with grouping)
  ```sql
CREATE VIEW vw_primeira_venda_por_produto AS
SELECT p.nome_produto, MIN(v.data_venda) AS Primeira_Venda
FROM PRODUTOS p 
    inner join VENDAS v on (v.id_produto = p.id_produto)
GROUP BY p.nome_produto;

SELECT * FROM vw_primeira_venda_por_produto;
  ```
