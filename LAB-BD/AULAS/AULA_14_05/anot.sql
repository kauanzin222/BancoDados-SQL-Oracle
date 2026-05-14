create table logteste 

(nrlog number primary key,  

 Dttrans date not null,  

 Usuario varchar2(20) not null,  

 Tabela varchar2(30), 

 Opera char(1) check (opera in('I','A','E')), 

 Linhas Number(5) not Null check(linhas >=0));
 
create sequence seqlog;

insert into TB_produto values (6,'Caneta','CX', 5.00); 

Create or Replace trigger EliminaProduto 
before delete on tb_produto 
for each row 
begin 
    insert into logteste values(seqlog.nextval,sysdate,user,'produto','E',1); 
end Eliminaproduto; 

delete Tb_produto where codproduto = 6;

select * from logteste;


Create or Replace Trigger ChecaHora 
before update or delete on tb_cliente 
begin 
  if to_number(to_char(sysdate,'HH24')) not between 11 and 14 then 
    raise_application_error(-20400,'Alterações não permitidas'); 
  end if; 
end ChecaHora; 
/
 
 update tb_cliente 
 set nomecliente = 'Kauã Raimundo'
 where codcliente = 30;
 
ALTER TRIGGER ChecaHora DISABLE;
 
ALTER TRIGGER EliminaProduto DISABLE;
 
Create or Replace trigger EliminaProduto2 
before delete on tb_produto 
for each row 
begin 
    insert into logteste values(seqlog.nextval,sysdate,user,'Produto ' || :old.descricao,'E',1); 
end Eliminaproduto; 

CREATE or replace TRIGGER Troca_data 
BEFORE INSERT ON Tb_pedido 
FOR EACH ROW 
BEGIN 
      :NEW.prazo_entrega := SYSDATE + 15; 
END; 

insert into tb_pedido values (999,'16/05/2026',30,15); 

create table trigger_tablog
( numLog number primary key, 
  datalog  date, 
  usuario  varchar2(15), 
  tabela   varchar2(15), 
  oldcampo varchar2(50), 
  newcampo varchar2(50), 
  campo1   varchar2(30)); 
create sequence seqtab; 

create or replace trigger TrocaPrazo
before update of prazo_entrega on tb_pedido
for each row
declare 
    v_nomecli tb_cliente.nomecliente%type;
begin 
    select nomecliente into v_nomecli from tb_cliente
    where codcliente = :old.codcliente;
    insert into trigger_tablog values (seqtab.nextval, sysdate, user, 'Pedido', :old.prazo_entrega, :new.prazo_entrega, v_nomecli);
end;

update tb_pedido
set prazo_entrega = sysdate
where numpedido = 999;

select * from trigger_tablog;
