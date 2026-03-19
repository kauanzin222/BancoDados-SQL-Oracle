
--- REVISÃO JUNÇÃO

---     1. RESOLUÇÃO
select v.codvendedor, v.nomevendedor 
from TB_VENDEDOR v inner join TB_PEDIDO p 
on v.codvendedor = p.codvendedor
where p.codcliente = 32;

---     2. RESOLUÇÃO
select p.numpedido, p.prazo_entrega, ip.qtde, pr.descricao
from TB_PEDIDO p 
inner join TB_ITEM_PEDIDO ip on p.numpedido = ip.NUMPEDIDO
inner join TB_PRODUTO pr on ip.codproduto = pr.codproduto
where pr.codproduto = 40;


---     3. RESOLUÇÃO
select v.codvendedor, v.nomevendedor, c.nomecliente as "Nome_Cliente"
from TB_VENDEDOR v 
inner join TB_PEDIDO p on v.codvendedor = p.codvendedor
inner join TB_CLIENTE c on p.codcliente = c.codcliente
where c.NOMECLIENTE = 'João da Silva';

---     4. RESOLUÇÃO
select p.numpedido, ip.codproduto, pr.descricao, p.codvendedor, v.nomevendedor, c.nomecliente
from TB_PEDIDO p 
inner join TB_ITEM_PEDIDO ip on p.numpedido = ip.numpedido
inner join TB_PRODUTO pr on ip.codproduto = pr.codproduto
inner join TB_VENDEDOR v on p.codvendedor = v.codvendedor
inner join TB_CLIENTE c on p.codcliente = p.codcliente
where c.CIDADE = 'SOROCABA';

---     SUBCONSULTAS

---     1. RESOLUÇÃO
select * from TB_CLIENTE 
where cidade = (select cidade from TB_CLIENTE where nomecliente = 'João da Silva');

---     2. RESOLUÇÃO
select * from TB_PRODUTO
where valor_unit > (select AVG(valor_unit) from TB_PRODUTO); 

---     3. RESOLUÇÃO
select * from TB_CLIENTE c
inner join TB_PEDIDO p on c.codcliente = p.codcliente
where p.codvendedor = 5 and c.codcliente not in (select codcliente from TB_PEDIDO where codvendedor <> 5);

---     4. RESOLUÇÃO
select v.codvendedor from TB_VENDEDOR v 
inner join TB_PEDIDO p on v.codvendedor = p.codvendedor
group by v.codvendedor
having count(p.numpedido) < 2;

---     5. RESOLUÇÃO
-- select v.codvendedor from TB_VENDEDOR v
-- inner join TB_PEDIDO p on v.codvendedor = p.codvendedor 
-- group by v.codvendedor
-- having 
--- NÃO ENTENDI COMO FAZER

---     6. RESOLUÇÃO
-- select v.codvendedor from TB_VENDEDOR v 
-- inner join TB_PEDIDO p on v.codvendedor = p.codvendedor
-- where (select );
--- NÃO ENTENDI COMO FAZER 

---     7. RESOLUÇÃO
select c.nomecliente, count(p.numpedido) as contagem_pedidos 
from TB_CLIENTE c
inner join TB_PEDIDO p on c.codcliente = p.codcliente
group by c.nomecliente
order by contagem_pedidos desc;

--- 8. RESOLUÇÃO
delete from TB_ITEM_PEDIDO
where numpedido in (
    select numpedido
    from TB_PEDIDO
    where codcliente = 32
);

--- 9. RESOLUÇÃO
-- consegui fazer não
