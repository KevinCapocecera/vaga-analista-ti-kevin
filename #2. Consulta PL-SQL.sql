
create table funcionarios (
	ID int primary key auto_increment,
	nome varchar(100) not null,
    salario decimal (5, 2)
);
create table projetos (
	ID int primary key auto_increment,
    nome varchar(100) not null
);
create table horas_trabalhadas (
	funcionarioID int,
    projetoID int,
    horas decimal (5, 2) default 0,
    foreign key (funcionarioID) references funcionarios(ID),
    foreign key (projetoID) references projetos(ID)
    );
    
select * from horas_trabalhadas;
select * from projetos;
select * from  funcionarios;

insert into funcionarios (nome, salario)
values ('kaique', 2.500);

insert into projetos (nome)
values ('Desenvolvimento Backend'),
		('Desenvolvimento Frontend');

insert into horas_trabalhadas (funcionarioID, projetoID, horas)
values (2, 1, 10),
	(2, 2, 20);
    
SELECT
    f.Nome AS Nome_Funcionario,
    GROUP_CONCAT(p.Nome SEPARATOR '/ ') AS Projetos_Envolvidos,
    SUM(h.Horas) AS Total_Horas_Trabalhadas
FROM
    horas_trabalhadas h
INNER JOIN
    funcionarios f ON h.funcionarioID = f.ID
INNER JOIN
    projetos p ON h.projetoID = p.ID
WHERE
    f.id = 1 
GROUP BY
    f.id;


