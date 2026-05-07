
---     5. Resolução - Lista3
insert into tb_pedido values (14, '14-05-2021', 30, 25);

select codvendedor, nomevendedor from tb_vendedor 
where codvendedor not in (
    select codvendedor from tb_pedido
    where extract(month from prazo_entrega) = 5 
    and extract(year from prazo_entrega) = 2021);

---     6. Resolução - Lista3
select codvendedor, nomevendedor from tb_vendedor 
where 

select max(count(codvendedor)) from tb_pedido
group by codvendedor;


