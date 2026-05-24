--- =====================================================================
--- BLOCO 4: ÍNDICES
--- =====================================================================

--- 1. Busca rápida de Pessoas e Pacientes (Triagem e Recepção)
CREATE INDEX idx_pessoa_cpf ON tab_pessoa (cpf);
CREATE INDEX idx_pessoa_nome ON tab_pessoa (nome);

--- 2. Filtros de Agenda e Dashboards de Produtividade
CREATE INDEX idx_terapia_data ON tab_terapia (data);
CREATE INDEX idx_terapia_status ON tab_terapia (statusterapia);

--- 3. Chaves Estrangeiras (Subclasses e Cargos)
CREATE INDEX idx_profissional_cargo ON tab_profissional (idcargo);
CREATE INDEX idx_paciente_escola ON tab_paciente (idescola);

--- 4. SEGUNDA coluna das Tabelas Associativas
CREATE INDEX idx_fk_espec_prof_esp ON especialidade_profissional (idespecialista);
CREATE INDEX idx_fk_esp_terapia_esp ON especialista_terapia (idespecialista);
CREATE INDEX idx_fk_pac_terapia_pac ON paciente_terapia (idpaciente);
CREATE INDEX idx_fk_resp_paciente_pac ON responsavel_paciente (idpaciente);
CREATE INDEX idx_fk_paciente_cid_pac ON paciente_cid (idpaciente);
CREATE INDEX idx_fk_perfil_perm_perm ON perfil_permissao (idpermissao);
CREATE INDEX idx_fk_usuario_perf_perf ON usuario_perfil (idperfil);
CREATE INDEX idx_fk_endereco_pess_end ON endereco_pessoa (idendereco);