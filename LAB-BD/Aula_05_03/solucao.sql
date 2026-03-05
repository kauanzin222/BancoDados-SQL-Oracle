create or replace view pacsor
as select * from paciente 
where upper(cidade) = 'SOROCABA'
with check option;

select * from pacsor;

--- É possível realizar operações comuns em Views
--- Mas isso se limita a Views que correspondem apenas a uma tabela
insert into pacsor
values (77,'Roberto souza',sysdate,'M','rua','Sorocaba','S');

update pacsor
 set nompaciente = 'Carlos Souza'
where codpaciente = 77;


update pacsor
set nompaciente = 'DDDD'
where codpaciente = 61;

delete pacsor
where codpaciente = 61;

update pacsor
 set cidpaciente = 'KKKKK'
where codpaciente = 7;

select * from paciente;

--- Exemplo de INSERT de values que não correspondem aos elementos da View por conta do CHECK OPTION
--- Nesse caso, o problema foi que a CIDADE de Maria não era SOROCABA
insert into pacsor values (61,'Maria',sysdate,'F','rua x','itu','S');

---     2. View

create or replace view pacsor_res
as select codpaciente,nompaciente,datanasc as data_nascimento, sexo
from pacsor;

--- INSERT sem com somente os campos da View, faltando da tabela original, pode
--- dar erro por campos NOT NULL
insert into pacsor_res(codpaciente,nompaciente,data_nascimento,sexo)
values (49,'Ana',sysdate,'F');

--- Só é possível realizar UPDATE de linhas na qual contenham sobre a tabela que a view foi criada
--- Nesse caso, a View pacsor_res foi criada em cima da pacsor, logo apenas linhas que contenham
--- 'Sorocaba' como cidade podem ser alteradas
update pacsor_res
 set nompaciente = 'KKKKK'
where codpaciente = 6;

update pacsor_res
 set nompaciente = 'KKKKK'
where codpaciente = 7;

select * from pacsor_res;

---     3. View --- Não é atualizável devido a JUNÇÃO

create or replace view consulta_pac
as select p.codpaciente, p.nompaciente, c.codconsulta
from paciente p, consulta c
where c.codpaciente = p.codpaciente and p.sexo = 'F';

create or replace view consulta_pac
as select p.codpaciente, p.nompaciente, c.codconsulta
from paciente p inner join consulta c
on c.codpaciente = p.codpaciente 
where p.sexo = 'F';

select * from consulta_pac;

---     4. View --- Não há como realizar comando comuns porque valorliq nem existe na tabela original

create or replace view salario_liq
as select codmedico "Código do Médico", (valconsulta * 0.75) as valorliq, 'medico bom'  as avaliacao
from consulta;

select * from salario_liq;

---     5. View

create or replace view totalmed
as select c.codmedico "Código do Médico", m.nomemedico "Nome do Médico", count(*) as totalconsultas
from consulta c inner join medico m
on c.codmedico = m.codmedico
group by c.codmedico, m.nomemedico;

select * from totalmed;

---     Lista View

---     1.
create or replace view vw_retornocons
as select codmedico, codpaciente, dataconsulta + 30 as dataretorno
from consulta;

select * from vw_retornocons;

---     2.
create or replace view vw_consmedico
as select m.nomemedico, c.codconsulta, c.dataconsulta
from medico m inner join consulta c
on m.codmedico = c.codmedico;

select * from vw_consmedico;

---     3.
create or replace view vw_vlrtotalcons
as select codmedico, sum(valconsulta) as vlrtotalcons
from consulta
group by codmedico;

select * from vw_vlrtotalcons;

---     4. 
create or replace view vw_vlrmediocons
as select c.codmedico, m.nomemedico, avg(c.valconsulta) as vlrmediocons
from consulta c inner join medico m
on c.codmedico = m.codmedico
group by c.codmedico, m.nomemedico;

select * from vw_vlrmediocons;

---     5.
select * from user_views
where view_name like '%SOR%';
