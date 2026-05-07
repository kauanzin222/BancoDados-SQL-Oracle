

Declare 
    V_preco number(5); 
Begin 
    select valor_unit into V_preco --- Todo bloco begin end precisa ter um select into
    from Tb_produto where codproduto = 99; 
        if v_preco is null then  
            update TB_produto set valor_unit = 100.00  
            where codproduto = 15; 
        end if; 
commit;  
Exception  
    when no_data_found then --- O oracle tem exceções pre-definidas 
       insert into tab_erro values (sysdate, 'Produto não encontrado');  
end; 

--------        Criando Stored Procedure

create or replace procedure SP_AtualizaPreco(Pcodprod number) as
    V_preco number(5); 
    V_descricao varchar2(30);
Begin 
    select valor_unit, descricao into V_preco, V_descricao 
    from Tb_produto where codproduto = Pcodprod; 
        if v_preco is null then  
            update TB_produto set valor_unit = 100.00  
            where codproduto = Pcodprod; 
        end if; 
commit;  
Exception  
    when no_data_found then --- O oracle tem exceções pre-definidas 
       insert into tab_erro values (sysdate, 'Prod. Inval.: '||Pcodprod||' - '||V_descricao);  
end; 


--------        Exer. 1 - Stored Procedure

create or replace procedure SP_InsereItem(PnumPed number, PcodProd number, Pqntd number) as
    V_preco_unit number(6,2);
begin 
    select valor_unit into V_preco_unit
    from tb_produto where codproduto = PcodProd;
        insert into tb_item_pedido 
        values(PnumPed, PcodProd, Pqntd, V_preco_unit);
commit;
end;




