-- Criação da tabela 'funcionarios' para armazenar dados dos funcionários
create table funcionarios (
	ID int primary key auto_increment,  -- ID do funcionário, chave primária que auto incrementa
	nome varchar(100) not null,        -- Nome do funcionário, campo obrigatório
    salario decimal (10, 2)             -- Salário do funcionário, formato decimal com até 10 dígitos, 2 casas decimais
);

-- Criação da tabela 'projetos' para armazenar informações sobre os projetos
create table projetos (
	ID int primary key auto_increment,  -- ID do projeto, chave primária que auto incrementa
    nome varchar(100) not null          -- Nome do projeto, campo obrigatório
);

-- Criação da tabela 'horas_trabalhadas' para registrar as horas que cada funcionário trabalhou em projetos
create table horas_trabalhadas (
	funcionarioID int,                  -- ID do funcionário, referência à tabela 'funcionarios'
    projetoID int,                      -- ID do projeto, referência à tabela 'projetos'
    horas decimal (5, 2) default 0,    -- Horas trabalhadas, formato decimal com 2 casas decimais, padrão é 0
    foreign key (funcionarioID) references funcionarios(ID),  -- Chave estrangeira para 'funcionarios'
    foreign key (projetoID) references projetos(ID)           -- Chave estrangeira para 'projetos'
);

-- Exibe todos os registros da tabela 'horas_trabalhadas'
select * from horas_trabalhadas;

-- Exibe todos os registros da tabela 'projetos'
select * from projetos;

-- Exibe todos os registros da tabela 'funcionarios'
select * from funcionarios;

-- Insere um novo funcionário na tabela 'funcionarios'
insert into funcionarios (nome, salario)
values ('kaique', 2.500);  -- Nome: Kaique, Salário: 2500.00

-- Insere novos projetos na tabela 'projetos'
insert into projetos (nome)
values ('Desenvolvimento Backend'),   -- Primeiro projeto
		('Desenvolvimento Frontend');   -- Segundo projeto

-- Insere horas trabalhadas por um funcionário em diferentes projetos
insert into horas_trabalhadas (funcionarioID, projetoID, horas)
values (2, 1, 10),  -- Funcionário 2 trabalhou 10 horas no projeto 1
	(2, 2, 20);     -- Funcionário 2 trabalhou 20 horas no projeto 2
    
-- Consulta para obter o nome do funcionário, os projetos em que trabalhou e o total de horas
SELECT
    f.Nome AS Nome_Funcionario,                              -- Seleciona o nome do funcionário
    GROUP_CONCAT(p.Nome SEPARATOR '/ ') AS Projetos_Envolvidos,  -- Concatena os nomes dos projetos
    SUM(h.Horas) AS Total_Horas_Trabalhadas                  -- Soma total de horas trabalhadas
FROM
    horas_trabalhadas h                                       -- Tabela de horas trabalhadas
INNER JOIN
    funcionarios f ON h.funcionarioID = f.ID                -- Junta com a tabela de funcionários
INNER JOIN
    projetos p ON h.projetoID = p.ID                         -- Junta com a tabela de projetos
WHERE
    f.id = 1                                                  -- Filtra apenas pelo funcionário com ID 1
GROUP BY
    f.id;                                                    -- Agrupa os resultados pelo ID do funcionário
