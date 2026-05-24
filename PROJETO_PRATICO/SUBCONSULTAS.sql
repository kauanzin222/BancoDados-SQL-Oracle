--- =====================================================================
--- BLOCO 4: SUBCONSULTAS 
--- =====================================================================
--- 1. Subconsulta utilizando o operador IN
--- Extrair uma lista com o nome e o celular de todos os responsáveis que possuem algum filho/paciente matriculado em uma escola específica
SELECT nome AS nome_responsavel, celular
FROM tab_pessoa
WHERE idcadastro IN (
    SELECT rp.idresponsavel
    FROM responsavel_paciente rp
    JOIN tab_paciente p ON rp.idpaciente = p.idpaciente
    WHERE p.idescola = 1
)
ORDER BY nome ASC;

--- 2.Subconsulta utilizando o operador NOT EXISTS
--- Identificar quais pacientes estão cadastrados no sistema, mas ainda não possuem nenhuma sessão de terapia agendada ou realizada
SELECT p.idpaciente, pes.nome AS nome_paciente, p.statuspaciente
FROM tab_paciente p
JOIN tab_pessoa pes ON p.idpaciente = pes.idcadastro
WHERE NOT EXISTS (
    SELECT 1 
    FROM paciente_terapia pt 
    WHERE pt.idpaciente = p.idpaciente
);

--- 3. Subconsulta dentro de um comando UPDATE
--- Exemplo de atualização em lote por segurança. A clínica decidiu que todos os pacientes diagnosticados 
--- com o CID de "Autismo Infantil" (F84.0) devem ter o seu convenio atualizado automaticamente para 
--- 'Plano Especial Infância' se o campo estiver nulo ou desatualizado.
UPDATE tab_paciente
SET convenio = 'Plano Especial Infância'
WHERE idpaciente IN (
    SELECT idpaciente 
    FROM paciente_cid 
    WHERE codigocid = 'F84.0'
);

--- 4. Subconsulta dentro de um comando DELETE
--- Remover do banco de dados os registros de permissões administrativas da tabela associativa 
--- perfil_permissao que estejam vinculados a perfis obsoletos ou específicos que não deveriam conter acessos
DELETE FROM perfil_permissao
WHERE idperfil = (
    SELECT idperfil 
    FROM tab_perfil 
    WHERE nome = 'Secretaria'
);