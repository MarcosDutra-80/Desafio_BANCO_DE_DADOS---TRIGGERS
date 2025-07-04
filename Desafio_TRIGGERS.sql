SHOW DATABASES;
USE company_constraints;
show tables ;
Desc employee;
SELECT * FROM employee;
SELECT * FROM departament;
SELECT * FROM seller;
SELECT * FROM works_on;

DESCRIBE company_constraints.employee;

-- Criando um trigger que adiciona aumento salarial com base no deepartamento inserido
Delimiter //
CREATE TRIGGER insercao_de_funcionario_com_aumento BEFORE INSERT ON company_constraints.employee
	FOR EACH ROW
		BEGIN 
			CASE NEW.Dno
				WHEN 1 THEN SET NEW.Salary = NEW.Salary * 1.15;
                WHEN 4 THEN SET NEW.Salary = NEW.Salary * 1.05;
                WHEN 5 THEN SET NEW.Salary = NEW.Salary * 1.20;
                ELSE SET NEW.Salary = NEW.Salary;
			END CASE;
	END //
Delimiter ;

insert into employee (Fname, Minit, Lname, Ssn, Bdate, , Sex, Salary, Super_ssn, Dno) 
			values('JOANA', 'B', 'Smith', '123856759', '1965-01-09', '731-Fondren-Houston-TX', 'M', 30000.00, '112233445', '5'); 
            


-- Criação da tabela para armazenar os funcionarios desativados
CREATE TABLE employeer_desativados (
	Fname VARCHAR (15),
    Ssn CHAR (9),
    Dno INT 
);


-- Criação da Trigger que insere os dados do funcionarios em outra planilha apos Delete
Delimiter //
CREATE TRIGGER Remocao_de_funcionarios BEFORE DELETE ON company_constraints.employee
	FOR EACH ROW
		BEGIN 
			INSERT INTO company_constraints.employeer_desativados ( Fname, Ssn , Dno)
				VALUES (OLD.Fname, OLD.Ssn, OLD.dno);
		END //
Delimiter ;

DELETE FROM employee WHERE Ssn = 987987987; 
SELECT * FROM employeer_desativados;
