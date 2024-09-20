-- Cria um novo banco de dados chamado 'gerenciamento_projetos'
CREATE DATABASE gerenciamento_projetos;

-- Seleciona o banco de dados recém-criado para uso
USE gerenciamento_projetos;

-- Cria a tabela 'funcionarios' com colunas para ID, nome, cargo e departamento
CREATE TABLE funcionarios (
    ID INT PRIMARY KEY AUTO_INCREMENT, -- Coluna 'ID' é a chave primária e incrementa automaticamente
    nome VARCHAR(100) NOT NULL,        -- Nome do funcionário, não pode ser nulo
    cargo VARCHAR(50) NOT NULL,        -- Cargo do funcionário, não pode ser nulo
    departamento VARCHAR(50)           -- Departamento do funcionário (opcional)
);

-- Cria a tabela 'projeto' com colunas para ID, nome do projeto, data de início e data de fim
CREATE TABLE projeto (
    ID INT PRIMARY KEY AUTO_INCREMENT,    -- Coluna 'ID' é a chave primária e incrementa automaticamente
    nome_do_projeto VARCHAR(100) NOT NULL, -- Nome do projeto, não pode ser nulo
    data_inicio DATE,                    -- Data de início do projeto
    data_fim DATE                        -- Data de fim do projeto
);

-- Cria a tabela 'atribuicao' para relacionar funcionários com projetos e registrar horas trabalhadas
CREATE TABLE atribuicao (
    funcionarioID INT,                   -- ID do funcionário (chave estrangeira)
    projetoID INT,                       -- ID do projeto (chave estrangeira)
    horas_trabalhadas DECIMAL(5, 2) DEFAULT 0, -- Horas trabalhadas, com valor padrão 0
    FOREIGN KEY (funcionarioID) REFERENCES funcionarios(ID), -- Define 'funcionarioID' como chave estrangeira referenciando 'ID' na tabela 'funcionarios'
    FOREIGN KEY (projetoID) REFERENCES projeto(ID)         -- Define 'projetoID' como chave estrangeira referenciando 'ID' na tabela 'projeto'
);

-- Exibe a lista de tabelas no banco de dados atual para verificação
SHOW TABLES;

-- Insere dados na tabela 'funcionarios'
INSERT INTO funcionarios (nome, cargo, departamento)
VALUES ('Kevin', 'Desenvolvedor', 'TI');

-- Insere outro registro na tabela 'funcionarios'
INSERT INTO funcionarios (nome, cargo, departamento)
VALUES ('Amanda', 'Analista', 'RH');

-- Insere um terceiro registro na tabela 'funcionarios'
INSERT INTO funcionarios (nome, cargo, departamento)
VALUES ('Vitor', 'Coordenador', 'Producao');

-- Consulta e exibe todos os registros da tabela 'funcionarios'
SELECT * FROM funcionarios;

-- Consulta e exibe todos os registros da tabela 'atribuicao' (espera-se que esteja vazio inicialmente)
SELECT * FROM atribuicao;

-- Insere um novo projeto na tabela 'projeto'
INSERT INTO projeto (nome_do_projeto, data_inicio, data_fim)
VALUES ('Projeto JUCA', '2024-08-13', '2024-09-20');

-- Insere um registro na tabela 'atribuicao' para associar um funcionário com um projeto e registrar horas trabalhadas
INSERT INTO atribuicao (funcionarioID, projetoID, horas_trabalhadas)
VALUES (1, 1, 36); -- Assumindo que o funcionário com ID 1 e o projeto com ID 1 existem
