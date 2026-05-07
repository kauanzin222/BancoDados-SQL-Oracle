--------        Lista 04

--------        Exer. 1
create or replace procedure SP_Atraso(PnumProd number) as
    V_prazo_entrega date;
    V_nome_vendedor varchar2(30);
Begin 
    select p.prazo_entrega, v.nomevendedor into V_prazo_entrega, V_nome_vendedor
    from tb_pedido p inner join tb_vendedor v 
    on  p.codvendedor = v.codvendedor 
    where p.numpedido = PnumProd;
        if V_prazo_entrega < sysdate then
            insert into tablog(datalog, campo1, campo2)
            values (V_prazo_entrega, V_nome_vendedor, 'Pedido em atraso. O vendedor deve avisar ao cliente');
        end if;
commit;
Exception
    when no_data_found then
        insert into tab_erro values (sysdate, 'Número do pedido inexistente');
End;

--------        Exer. 2

-- Primeiro, garantir que o cliente e o vendedor existem (IDs de exemplo)
-- Insert para o Pedido 1 (Prazo bem no futuro: Julho 2026)
INSERT INTO tb_pedido (numpedido, prazo_entrega, codcliente, codvendedor) 
VALUES (101, TO_DATE('15/07/2026', 'DD/MM/YYYY'), 32, 25);

-- Insert para o Pedido 2 (Mesmo prazo para não quebrar o seu GROUP BY atual)
INSERT INTO tb_pedido (numpedido, prazo_entrega, codcliente, codvendedor) 
VALUES (102, TO_DATE('15/07/2026', 'DD/MM/YYYY'), 32, 25);

-- Insert para o Pedido 3 (Mesmo prazo para atingir a contagem > 2)
INSERT INTO tb_pedido (numpedido, prazo_entrega, codcliente, codvendedor) 
VALUES (103, TO_DATE('15/07/2026', 'DD/MM/YYYY'), 32, 25);


--- Testando o SELECT
select count(codcliente) as V_qntd_ped from tb_pedido
where codcliente = 32 and prazo_entrega >= add_months(sysdate,2);


create or replace procedure SP_ClientePremium(PcodCli number) as
    V_nome_cli varchar2(30);
    V_qntd_ped number(5);
Begin 
    select count(codcliente) into V_qntd_ped from tb_pedido
    where codcliente = PcodCli and prazo_entrega > add_months(sysdate,2);
    commit;
    
    if V_qntd_ped > 2 then
        select nomecliente into V_nome_cli from tb_cliente
        where codcliente = PcodCli;
        insert into tablog(datalog, campo1, campo2)
        values(sysdate, 'Cliente Especial - Enviar Brinde', V_nome_cli || ' - ' || PcodCli);
    end if;
commit;
Exception 
    when no_data_found then
        insert into tab_erro values (sysdate, 'Cliente não encontrado');
    commit;
End;
    
    
 
