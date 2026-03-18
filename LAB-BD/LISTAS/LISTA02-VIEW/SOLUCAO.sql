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