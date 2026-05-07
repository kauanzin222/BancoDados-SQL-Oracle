
select * from tab_erro;

update tb_produto
    set valor_unit = null
where codproduto = 15;

exec SP_AtualizaPreco(99);

alter table tb_item_pedido
add pco_unit number(6,2);

exec SP_InsereItem(8,12,3);
select * from tb_item_pedido;
