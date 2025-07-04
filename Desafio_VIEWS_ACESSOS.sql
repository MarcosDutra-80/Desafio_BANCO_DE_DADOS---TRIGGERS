USE company_constraints;
SHOW TABLES;
Desc works_on;
DESC Departament;
DESC employee;
DESC dept_locations;
Desc project;

SELECT * FROM employee;
SELECT * FROM works_on;
SELECT * FROM project;
SELECT * FROM Departament;
SELECT * FROM dependent;
SELECT * FROM dept_locations;

-- Querie que retorna o numero de funcionarios por Departamento e Localidade

CREATE VIEW numero_de_funcionarios_por_departament_localidade AS
SELECT e.Dno AS numero_do_departamento , COUNT(*) AS quantidade_de_funcionarios , l.Dlocation
	FROM employee e 
    INNER JOIN Departament d ON e.Dno = d.Dnumber
    INNER JOIN dept_locations l ON d.Dnumber = l.Dnumber
	GROUP BY e.dno , l.Dlocation
    ORDER BY quantidade_de_funcionarios;
    
-- Querie que retorna os departamentos e seus respectivos gerentes
CREATE VIEW departamento_e_seus_gerentes AS
SELECT Dname , Mgr_ssn , CONCAT(Fname , ' ' , Minit, ' ' , Lname) AS nome_do_gerente
	FROM Departament d
	JOIN employee e ON e.Dno = d.Dnumber
    WHERE d.Mgr_ssn = e.Ssn
;

-- Queria que retorna a quantidade de empregados por projeto na ordem decrescente
CREATE VIEW Quantidade_de_empregados_por_projeto AS
SELECT Pno as Numero_do_Projeto, COUNT(distinct Essn) AS numero_de_empregados 
	FROM Works_on
    GROUP BY Pno
    ORDER BY numero_de_empregados DESC;
    


    
    
-- Querie que retorna todos os projetos, seus respectivos departamentos e os gerentes responsáveis
CREATE VIEW projetos_departamentos_e_gerentes AS
SELECT DISTINCT Pname , Pnum , CONCAT(Fname , ' ' , Minit, ' ' , Lname) AS nome_do_gerente 
	FROM project p 
    INNER JOIN Departament d ON p.Pnum = d.Dnumber
    INNER JOIN employee e ON e.Dno = d.Dnumber
    WHERE d.Mgr_ssn = e.Ssn
    ;
    

-- Queria que retorna quais empregados possuem dependentes e se são gerentes
CREATE VIEW gerentes_que_possuem_dependentes AS
SELECT CONCAT(Fname , ' ' , Minit, ' ' , Lname) AS nome_do_empregado ,
	CASE 
        WHEN d.Essn IS NOT NULL THEN TRUE
        ELSE FALSE
    END AS possui_dependente,
    CASE 
        WHEN e.Ssn IN (SELECT Mgr_ssn FROM Departament) THEN TRUE
        ELSE FALSE
    END AS eh_gerente
	FROM employee e 
    INNER JOIN dependent d ON e.Ssn = d.ESsn;


-- Criando usuario GERENTE e concedendo todas as permissões 
CREATE USER 'gerente'@localhost identified by '123456789';
GRANT ALL PRIVILEGES ON company_constraints to 'gerente'@localhost;

-- Criando o usuario funcionario e concedendo permissões limitadas 
CREATE USER 'funcionario'@localhost identified by '987654321';
GRANT ALL PRIVILEGES ON company_constraints.numero_de_funcionarios_por_departament_localidade TO 'funcionario'@localhost;
GRANT ALL PRIVILEGES ON company_constraints.Quantidade_de_empregados_por_projeto TO 'funcionario'@localhost;