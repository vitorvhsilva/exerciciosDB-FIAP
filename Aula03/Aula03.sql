CREATE TABLE TB_FILME
(
    id_filme INT,
    ator varchar(100),
    salario_ator number(20,2),
    genero_filme varchar(100),
    nome_filme varchar(100)
);

INSERT INTO TB_FILME VALUES (1,'Sylvester Stallone',600000.00,'Acao','Rock 1');
INSERT INTO TB_FILME VALUES (2,'Sylvester Stallone',1000000.00,'Acao','Mercenarios');
INSERT INTO TB_FILME VALUES (3,'Jason Statham',900000.00,'Acao','Mercenarios');
INSERT INTO TB_FILME VALUES (4,'Terry Crews',800000.00,'Acao','Mercenarios');
INSERT INTO TB_FILME VALUES (5,'Jet Li',800000.00,'Acao','Mercenarios');
INSERT INTO TB_FILME VALUES (6,'Terry Crews',1500000.00,'Comedia','As Branquelas');
INSERT INTO TB_FILME VALUES (7,'Jet Li',920000.00,'Suspense','A Mumia 1');
INSERT INTO TB_FILME VALUES (8,'Robert Downey Jr',3000000.00,'Aventura','Os Vingadores');
INSERT INTO TB_FILME VALUES (9,'Chris Evans',1500000.00,'Aventura','Os Vingadores');
INSERT INTO TB_FILME VALUES (10,'Scarlet Johansson',3000000.00,'Aventura','Os Vingadores');
INSERT INTO TB_FILME VALUES (8,'Robert Downey Jr',3100000.00,'Aventura','Os Vingadores Guerra Infinita');
INSERT INTO TB_FILME VALUES (9,'Chris Evans',1700000.00,'Aventura','Os Vingadores Guerra Infinita');
INSERT INTO TB_FILME VALUES (10,'Scarlet Johansson',3200000.00,'Aventura','Os Vingadores Guerra Infinita');

COMMIT;

SELECT * FROM TB_FILME;

SELECT ator, 
    MIN(salario_ator)
FROM TB_FILME
GROUP BY ator
ORDER BY MIN(salario_ator) DESC
FETCH FIRST 1 ROWS ONLY;

SELECT genero_filme,
    TRUNC(AVG(salario_ator), 2)
FROM TB_FILME
GROUP BY genero_filme;

SELECT nome_filme,
    MAX(salario_ator)
FROM TB_FILME
GROUP BY nome_filme
ORDER BY MAX(salario_ator) DESC;

SELECT ator, COUNT(nome_filme)
FROM TB_FILME
GROUP BY ator
FETCH FIRST 1 ROWS ONLY;

SELECT genero_filme, COUNT(genero_filme)
FROM TB_FILME
GROUP BY genero_filme;

SELECT nome_filme, COUNT(ator)
FROM TB_FILME
GROUP BY nome_filme
ORDER BY COUNT(ator) DESC
FETCH FIRST 1 ROWS ONLY;

SELECT genero_filme, SUM(salario_ator)
FROM TB_FILME
GROUP BY genero_filme
ORDER BY SUM(salario_ator) DESC
FETCH FIRST 1 ROWS ONLY;