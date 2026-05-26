-- 1. Habilita a criação de usuários sem o prefixo C## no contêiner atual
ALTER SESSION SET "_ORACLE_SCRIPT" = true;

-- 2. Cria o usuário com as mesmas credenciais do seu application.properties
CREATE USER GISA_USER IDENTIFIED BY GISA_PASSWORD;

-- 3. Concede as permissões para o Spring Boot conseguir logar e criar a estrutura
GRANT CONNECT, RESOURCE TO GISA_USER;

-- 4. Libera espaço para o usuário conseguir gravar dados nas tabelas
ALTER USER GISA_USER QUOTA UNLIMITED ON USERS;