
## FATEC – ADS - Database Laboratory 🎲
  
  1.  Create a view that has: Doctor code, patient code and appointment date added within 30 days (return).
  ```sql
  CREATE VIEW vw_data_retorno AS
  SELECT codMedico, codPaciente, dataConsulta + 30 AS Data_Retorno
  FROM TB_CONSULTA;

  SELECT * FROM vw_data_retorno;
  ```
  ---

  2.  Create a view that has: doctor's name, patient's name and appointment code and appointment date.
  ```sql
  CREATE VIEW vw_info_consulta AS 
  SELECT m.nome, p.nome AS NomePaciente, c.codConsulta, c.dataConsulta 
  FROM TB_CONSULTA c   
    inner join TB_MEDICO m on (m.codMedico = c.codMedico)
    inner join TB_PACIENTE p on (p.codPaciente = c.codPaciente);

  SELECT * FROM vw_info_consulta;
  ```
  ---

  3.  Create a view that displays the doctor's code and the total value of your consultations
  ```sql
  CREATE VIEW vw_valor_total_consultas AS
  SELECT m.codMedico, SUM(c.valorConsulta) AS ValorTotalConsultas
  FROM TB_MEDICO m      
    inner join TB_CONSULTA c on (c.codMedico = m.codMedico)
  GROUP BY m.codMedico;

  SELECT * FROM vw_valor_total_consultas;
  ```
  ---

  4.  Create a view that displays the doctor's code, the doctor's name and the average value of their consultations
  ```sql
  CREATE VIEW vw_valor_medio_consultas AS
  SELECT m.codMedico, m.nome, AVG(c.valorConsulta) AS ValorMedioConsultas
  FROM TB_MEDICO m
    inner join TB_CONSULTA c on (c.codMedico = m.codMedico)
  GROUP BY m.codMedico, m.nome;

  SELECT * FROM vw_valor_medio_consultas;
  ```
  ---

  5.  List the name of all views that have the string “SOR’ in the name.
  ```sql
  SELECT VIEW_NAME 
  FROM USER_VIEWS 
  WHERE VIEW_NAME LIKE '%SOR%';
  ```