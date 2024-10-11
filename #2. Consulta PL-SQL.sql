CREATE DATABASE gerenciador_projetos;

USE gerenciador_projetos;

CREATE TABLE funcionario( 
	ID INT PRIMARY KEY AUTO_INCREMENT,
    NOME VARCHAR(40) NOT NULL,
    CARGO VARCHAR(40) NOT NULL,
    DEPARTAMENTO VARCHAR(60) NOT NULL
);

SELECT * FROM funcionario;

INSERT INTO funcionario(NOME, CARGO, DEPARTAMENTO)
	VALUES("Kevin", "Analista de Dados", "TI");
INSERT INTO funcionario (NOME, CARGO, DEPARTAMENTO)
  VALUES ('Maria', 'Desenvolvedora Back-End', 'TI');

INSERT INTO funcionario (NOME, CARGO, DEPARTAMENTO)
  VALUES ('João', 'Engenheiro de Redes', 'Infraestrutura');

INSERT INTO funcionario (NOME, CARGO, DEPARTAMENTO)
  VALUES ('Ana', 'Analista de Sistemas', 'TI');

INSERT INTO funcionario (NOME, CARGO, DEPARTAMENTO)
  VALUES ('Pedro', 'Gestor de Projetos', 'Gerência');
DELETE 
	FROM funcionario 
WHERE ID ;

CREATE TABLE projeto( 
	ID INT PRIMARY KEY AUTO_INCREMENT,
    NOME_PROJETO VARCHAR(60) NOT NULL,
    DATA_INICIO DATE NOT NULL,
    DATA_FIM DATE NOT NULL    
);    
SELECT * FROM projeto;

INSERT INTO projeto (NOME_PROJETO, DATA_INICIO, DATA_FIM)
	VALUES ("desenvolvimento back-end", '2024-10-24', '2024-10-28');
    
CREATE TABLE atribuicao (
	id_funcionario INT,
    id_projeto INT,
    horas_trab DECIMAL(5, 2) DEFAULT 0,
    FOREIGN KEY (id_funcionario) REFERENCES funcionario(ID),
    FOREIGN KEY (id_projeto) REFERENCES projeto(ID)
);

ALTER TABLE atribuicao
ADD horas_trab DOUBLE;

SELECT * FROM atribuicao;

INSERT INTO atribuicao(id_funcionario, id_projeto, horas_trab)
	VALUES(7, 4, 18.00);

DROP TABLE atribuicao;


DELIMITER //

CREATE PROCEDURE ObterInfoFuncionario(IN p_id_funcionario INT)
BEGIN
    DECLARE v_nome_funcionario VARCHAR(40);
    DECLARE v_horas_trabalhadas DECIMAL(10, 2);

    -- Obter o nome do funcionário
    SELECT NOME INTO v_nome_funcionario
    FROM funcionario
    WHERE ID = p_id_funcionario;

    -- Verificar se o funcionário existe
    IF v_nome_funcionario IS NULL THEN
        SELECT 'Funcionário não encontrado' AS Mensagem;
    END IF;

    -- Obter a soma total de horas trabalhadas
    SELECT SUM(horas_trab) INTO v_horas_trabalhadas
    FROM atribuicao
    WHERE id_funcionario = p_id_funcionario;

    -- Exibir o nome do funcionário
    SELECT v_nome_funcionario AS Nome, 
           GROUP_CONCAT(p.NOME_PROJETO SEPARATOR ', ') AS Projetos,
           IFNULL(v_horas_trabalhadas, 0) AS Total_Horas_Trabalhadas
    FROM atribuicao a
    JOIN projeto p ON a.id_projeto = p.ID
    WHERE a.id_funcionario = p_id_funcionario
    GROUP BY v_nome_funcionario;

END //

DELIMITER ;

CALL ObterInfoFuncionario(07);

commit;
