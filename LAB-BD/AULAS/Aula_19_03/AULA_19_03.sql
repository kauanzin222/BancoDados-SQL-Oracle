select * from tb_pedido;

---     3. RESOLUÇÃO
select c.codcliente, c.nomecliente from TB_CLIENTE c
inner join TB_PEDIDO p on c.codcliente = p.codcliente
where p.codvendedor = 5 and c.codcliente not in (select codcliente from TB_PEDIDO where codvendedor <> 5);

--- OUTRA SOLUÇÃO
select * from tb_pedido
where codvendedor = 5 and codcliente not in (select codcliente from tb_pedido where codvendedor <> 5);

---     4. RESOLUÇÃO
select codvendedor, nomevendedor from tb_vendedor
where codvendedor not in (
    select codvendedor from tb_pedido   --- Esta subquery resulta apenas em vendedores que 
    group by codvendedor                --- venderam mais de 1 pedidos
    having count(*) > 1 
);

---     5. RESOLUÇÃO
--- Preparando a base de dados
INSERT INTO TB_PEDIDO VALUES ( 11, sysdate, 30, 25);
Insert into tb_item_pedido values (11,12,2);

--- PRIMEIRO VAMOS CONTAR
select codvendedor, count(*) from tb_pedido
group by codvendedor
--- Depois percebemos que a contagem nos retorna no máx. 2
--- having count (*) = 2 -> desta forma listo os vendedores com maiores vendas
having count (*) = (
--- Troco o 2 para deixar automático o max da contagem
    select max(count(*)) from tb_pedido
    group by codvendedor 
);

--- Com inner join:
select v.codvendedor, v.nomevendedor, count(*) as Total_Vendas
from tb_pedido p inner join tb_vendedor v 
on v.codvendedor = p.codvendedor
group by v.codvendedor, v.nomevendedor
having count(*) = (
    select max(count(*)) from tb_pedido
    group by codvendedor
);

--- Exibir a frase 'não existem pedidos para o cliente 35' caso não exista pedido para tal
select 'não existem pedidos para o cliente 35' as Consulta from dual
where not exists (select 1 from tb_pedido where codcliente = 35);

