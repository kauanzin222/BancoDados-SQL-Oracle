
--- Question 1
CREATE VIEW vw_data_retorno AS
SELECT codMedico, codPaciente, dataConsulta + 30 AS Data_Retorno
FROM TB_CONSULTA;

SELECT * FROM vw_data_retorno;


--- Question 2
CREATE VIEW vw_info_consulta AS 
SELECT m.nome, p.nome AS NomePaciente, c.codConsulta, c.dataConsulta 
FROM TB_CONSULTA c   
    inner join TB_MEDICO m on (m.codMedico = c.codMedico)
    inner join TB_PACIENTE p on (p.codPaciente = c.codPaciente);

SELECT * FROM vw_info_consulta;

--- Question 3
CREATE VIEW vw_valor_total_consultas AS
SELECT m.codMedico, SUM(c.valorConsulta) AS ValorTotalConsultas
FROM TB_MEDICO m      
    inner join TB_CONSULTA c on (c.codMedico = m.codMedico)
GROUP BY m.codMedico;

SELECT * FROM vw_valor_total_consultas;

--- Question 4
CREATE VIEW vw_valor_medio_consultas AS
SELECT m.codMedico, m.nome, AVG(c.valorConsulta) AS ValorMedioConsultas
FROM TB_MEDICO m
    inner join TB_CONSULTA c on (c.codMedico = m.codMedico)
GROUP BY m.codMedico, m.nome;

SELECT * FROM vw_valor_medio_consultas;

--- Question 5
SELECT VIEW_NAME 
FROM USER_VIEWS 
WHERE VIEW_NAME LIKE '%SOR%';