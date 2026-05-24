--- =====================================================================
--- BLOCO 3: CONSULTAS 
--- =====================================================================

--- 1. CONSULTA USANDO JUNÇÃO DE MAIS DE 2 TABELAS
--- Objetivo: Exibir a ficha técnica dos Especialistas da clínica. O sistema cruza o cadastro da pessoa,
--- valida que ela é um profissional, confirma que ela é uma especialista (médica ou terapeuta), localiza suas especialidades 
--- técnicas e traz o nome legível de cada especialidade.
--- (Cruza 5 tabelas: tab_pessoa, tab_profissional, tab_especialista, especialidade_profissional e tab_especialidade).
SELECT 
    p.nome AS nome_especialista,
    e.registroconselho AS registro_conselho,
    esp.nome AS nome_especialidade,
    esp.descricao AS descricao_especialidade
FROM tab_pessoa p
JOIN tab_profissional prof           ON p.idcadastro = prof.idprofissional
JOIN tab_especialista e              ON prof.idprofissional = e.idespecialista
JOIN especialidade_profissional ep   ON e.idespecialista = ep.idespecialista
JOIN tab_especialidade esp           ON ep.idespecialidade = esp.idespecialidade
ORDER BY p.nome ASC, esp.nome ASC;


--- 2. CONSULTA ÚTIL USANDO TOTALIZAÇÃO (GROUP BY) E FUNÇÃO DE DATA
--- Objetivo: Fechamento mensal de produtividade. Calcular a quantidade de atendimentos/terapias
--- realizados ou agendados, agrupados por mês do ano atual (2026), ajudando os gestores no planejamento financeiro.
SELECT 
    TO_CHAR(t.data, 'MM/YYYY') AS mes_ano,
    t.statusterapia,
    COUNT(t.idterapia) AS total_atendimentos
FROM tab_terapia t
WHERE EXTRACT(YEAR FROM t.data) = 2026
GROUP BY TO_CHAR(t.data, 'MM/YYYY'), t.statusterapia
ORDER BY mes_ano DESC;


--- 3. CONSULTA USANDO JUNÇÃO EXTERNA (LEFT JOIN)
--- Objetivo: Auditoria de Especialidades. Listar TODAS as especialidades cadastradas na clínica 
--- e a quantidade de terapeutas associados a elas. Inclui as especialidades que ainda não possuem nenhum
--- profissional vinculado (essencial para saber quais áreas precisam de novas contratações).
SELECT 
    esp.nome AS nome_especialidade,
    COUNT(ep.idespecialista) AS total_especialistas_ativos
FROM tab_especialidade esp
LEFT JOIN especialidade_profissional ep ON esp.idespecialidade = ep.idespecialidade
GROUP BY esp.nome
ORDER BY total_especialistas_ativos DESC;


--- 4. CONSULTA USANDO O OPERADOR DE UNIÃO (UNION)
--- Objetivo: Lista de contatos global do sistema. Une o nome e o celular de todos os 
--- funcionários que usam o sistema com o nome e o celular de todos os responsáveis pelos pacientes,
--- consolidando uma única lista para envio de comunicados gerais ou alertas de manutenção.
SELECT nome AS nome_contato, celular, 'Profissional/Funcionário' AS tipo_vinculo
FROM tab_pessoa
WHERE idcadastro IN (SELECT idprofissional FROM tab_profissional)
UNION
SELECT nome AS nome_contato, celular, 'Responsável Legal' AS tipo_vinculo
FROM tab_pessoa
WHERE idcadastro IN (SELECT idresponsavel FROM tab_responsavel)
ORDER BY nome_contato ASC;


--- 5. CONSULTA USANDO O OPERADOR MINUS
--- Objetivo: Listar as Pessoas que trabalham na clínica (estão cadastrados em tab_profissional), 
--- mas que NÃO atuam na ponta clínica como terapeutas/médicos 
--- (não existem em tab_especialista).
SELECT idprofissional AS id_cadastro_funcionario FROM tab_profissional
MINUS
SELECT idespecialista FROM tab_especialista;


--- 6. CONSULTA USANDO O OPERADOR DE INTERSEÇÃO (INTERSECT)
--- Objetivo: Mapeamento de duplo vínculo e conflito de interesse. Identificar quais pessoas cadastradas 
--- no sistema atuam na clínica como Funcionários/Profissionais E que também são cadastrados como 
--- Responsáveis Legais por algum paciente que se trata na instituição.
SELECT idprofissional AS id_pessoa_duplo_vinculo FROM tab_profissional
INTERSECT
SELECT idresponsavel FROM tab_responsavel;