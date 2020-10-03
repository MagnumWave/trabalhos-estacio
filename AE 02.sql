/* 1 */
SELECT codigo, titulo FROM Obras
WHERE Salao = 36;
/* 2 */
SELECT O.codigo, titulo FROM Obras O, Autores A, Saloes S 
WHERE O.autor = A.codigo AND O.salao = S.numero
	AND A.nome = 'Pablo Picasso' AND S.andar = '3';
/* 3 */
(SELECT O.codigo, O.titulo FROM Obras O, Esculturas E
WHERE O.codigo = E.codigo AND E.material = 'argila')
UNION
(SELECT O.codigo, O.titulo FROM Obras O, Pinturas P
WHERE O.codigo = P.codigo AND P.estilo = 'impressionista');

INSERT INTO Esculturas (codigo,altura,peso,material)
	VALUES (2,1.73,60.54,'argila');
INSERT INTO Esculturas (codigo,altura,peso,material)
	VALUES (5,1.56,5,'papelao');
select * from Esculturas;
INSERT INTO Pinturas (codigo,estilo,area)
	VALUES (3,'impressionista','14');
INSERT INTO Pinturas (codigo,estilo,area)
	VALUES (4,'frentista','15');
select * from Pinturas;
INSERT INTO Obras (codigo,titulo,ano,autor,salao)
	VALUES (1,'vento levou','1954',1,21);
INSERT INTO Obras (codigo,titulo,ano,autor,salao)
	VALUES (2,'homem de barro','1804',2,21);
INSERT INTO Obras (codigo,titulo,ano,autor,salao)
	VALUES (3,'alho sobre a tela','1736',1,22);
INSERT INTO Obras (codigo,titulo,ano,autor,salao)
	VALUES (4,'monalisa','1677',2,21);
INSERT INTO Obras (codigo,titulo,ano,autor,salao)
	VALUES (5,'link de papel','2016',1,22);
select * from Obras;
INSERT INTO Autores (codigo,nome,nacionalidade)
	VALUES (1,'Juan','Espanhol');
INSERT INTO Autores (codigo,nome,nacionalidade)
	VALUES (2,'Zezito','Brasileiro');
select * from Autores;
insert into Saloes (numero,andar,area)
	values (21,'2','13');
insert into Saloes (numero,andar,area)
	values (22,'2','16');
select * from Saloes;

/* 4.a subconsulta */
INSERT INTO Autores (codigo,nome,nacionalidade)
	VALUES (3,'Voltaire','Frances');
INSERT INTO Autores (codigo,nome,nacionalidade)
	VALUES (4,'Da Vinci','Italiano');
select * from Autores;
select * from Obras;

SELECT nome, nacionalidade FROM Autores
WHERE codigo in(SELECT autor FROM Obras);

/* 4.b usando Join*/

SELECT DISTINCT nome, nacionalidade FROM autores A
JOIN obras O ON O.autor = A.codigo;

/* 5.a subconsulta */
SELECT nome, nacionalidade FROM Autores
WHERE codigo NOT IN(SELECT autor FROM Obras);

/* 5.b join */
SELECT O.codigo, nome, nacionalidade FROM Obras O
RIGHT JOIN Autores A ON A.codigo = O.autor
WHERE O.codigo IS null;

/* 6.a subconsulta pinturas/obras/autores */
SELECT nome, nacionalidade FROM autores A
WHERE A.codigo IN (
	SELECT autor FROM Obras O
	WHERE O.codigo IN (
		SELECT P.codigo FROM Pinturas P));

select * from obras;
insert into obras (codigo,titulo,ano,autor,salao) values (6,'poxa de novo','1948','1','21');
select * from autores;
select * from pinturas;
select * from Esculturas;
insert into Pinturas (codigo,estilo,area) values (5,'borratudo','16');
insert into Pinturas (codigo,estilo,area) values (6,'impressionista','17')

/* 6.b join pinturas/obras/autores */
SELECT DISTINCT A.nome, A.nacionalidade FROM Pinturas P
JOIN Obras O ON P.codigo = O.codigo
JOIN Autores A ON O.autor = A.codigo;

/* 7.a subconsulta */
SELECT nome,nacionalidade FROM autores
WHERE codigo IN ((
	SELECT autor FROM obras
	WHERE codigo IN (
		SELECT codigo FROM esculturas))
	INTERSECT
	(SELECT autor FROM obras
	WHERE codigo IN (
		SELECT codigo FROM pinturas)));

insert into obras (codigo,titulo,ano,autor,salao)
values (7,'volt art','1803','3','22');
insert into obras (codigo,titulo,ano,autor,salao)
values (8,'vinci art ','1985','4','21');
insert into pinturas (codigo,estilo,area)
values (7,'volt style','16');
insert into esculturas (codigo,altura,peso,material)
values (8,2.13,115.4,'marmore');

/* 7.b join */
(SELECT A.nome,A.nacionalidade FROM autores A
JOIN Obras O ON A.codigo = O.autor
JOIN Esculturas E ON O.codigo = E.codigo)
INTERSECT
(SELECT A.nome,A.nacionalidade FROM autores A
JOIN Obras O ON A.codigo = O.autor
JOIN Pinturas P ON O.codigo = P.codigo)


select * from pinturas;
select * from esculturas;
select * from obras;
select * from autores;

insert into obras (codigo,titulo,ano,autor,salao)
values (9,'rivellino','1769',4,21);
insert into esculturas (codigo,altura,peso,material)
values (9,1.94,137,'lasked petre');
insert into obras (codigo,titulo,ano,autor,salao)
values (10,'real monalisa','1503',4,21);
insert into pinturas (codigo,estilo,area)
values (10,'embelezista','16');

/* 8a subconsulta */
SELECT nome,nacionalidade FROM autores
WHERE codigo IN ((
	SELECT autor FROM obras
	WHERE codigo IN (
		SELECT codigo FROM esculturas))
	UNION
	(SELECT autor FROM obras
	WHERE codigo IN (
		SELECT codigo FROM pinturas)));


select * from autores;
insert into autores (codigo,nome,nacionalidade)
values (5,'Van Gogh','Holandes');
/* 8.b join */
(SELECT A.nome,A.nacionalidade FROM autores A
JOIN Obras O ON A.codigo = O.autor
JOIN Esculturas E ON O.codigo = E.codigo)
UNION
(SELECT A.nome,A.nacionalidade FROM autores A
JOIN Obras O ON A.codigo = O.autor
JOIN Pinturas P ON O.codigo = P.codigo)

/* 9.a codigo dos autores */
(SELECT codigo FROM autores)
EXCEPT
(SELECT autor FROM Obras)

/* 9.b */
(SELECT codigo FROM autores)
INTERSECT
(SELECT autor FROM Obras
	WHERE codigo IN(
		SELECT codigo FROM Pinturas))

/* 9.c */
(SELECT codigo FROM autores)
INTERSECT
(SELECT autor FROM Obras
	WHERE codigo IN(
		SELECT codigo FROM Esculturas))
		
/* 9.d */
((SELECT autor FROM obras
WHERE codigo IN (
	SELECT codigo FROM pinturas))
INTERSECT
(SELECT autor FROM obras
WHERE codigo IN (
	SELECT codigo FROM esculturas)))
INTERSECT
(SELECT codigo FROM autores)

/* 9.e  */
/* União */
((SELECT DISTINCT autor FROM obras
WHERE codigo IN (
	SELECT codigo FROM pinturas))
UNION 
(SELECT DISTINCT autor FROM obras
WHERE codigo IN (
	SELECT codigo FROM esculturas)))
/* fim União*/
EXCEPT
/* Interseção */
((SELECT DISTINCT autor FROM obras
WHERE codigo IN (
	SELECT codigo FROM pinturas))
INTERSECT
(SELECT DISTINCT autor FROM obras
WHERE codigo IN (
	SELECT codigo FROM esculturas)))
/* fim Interseção */
select * from autores;
select * from obras;
/* pintura pro Juan */
insert into obras (codigo,titulo,ano,autor,salao)
values (11,'la pintuera','2020',1,21);
insert into pinturas (codigo,estilo,area)
values (11,'extrema juanagem','16');

/* 10 pares seguranças mesmo salão mesmo período */
select * from saloes
select * from lotacoes
alter table lotacoes

insert into lotacoes (rg,numero,horaEntrada,horaSaida)
values (127964229,21,'06:00','12:00');
insert into lotacoes (rg,numero,horaEntrada,horaSaida)
values (256358322,'Pedro Souza',1000,'T','Segurança');
insert into lotacoes (rg,numero,horaEntrada,horaSaida)
values (122369428,'Carlos Santos',1000,'N','Segurança');
insert into lotacoes (rg,numero,horaEntrada,horaSaida)
values (294647361,'José Pereira',1000,'M','Segurança');
select * from saloes
select * from lotacoes

insert into funcionarios (rg,nome,salario,turno,funcao)
values (127964229,'João da Silva',1000,'M','Segurança');
insert into funcionarios (rg,nome,salario,turno,funcao)
values (256358322,'Pedro Souza',1000,'T','Segurança');
insert into funcionarios (rg,nome,salario,turno,funcao)
values (122369428,'Carlos Santos',1000,'N','Segurança');
insert into funcionarios (rg,nome,salario,turno,funcao)
values (294647361,'José Pereira',1000,'M','Segurança');
select * from funcionarios
select * from saloes

/* removendo fks (e pks) necessarias lotacoes-funcionarios*/
alter table lotacoes
drop constraint lotacoes_rg_fkey;
alter table lotacoes
drop constraint lotacoes_numero_fkey;
alter table lotacoes
drop constraint lotacoes_numero_key;
alter table lotacoes
drop constraint lotacoes_rg_key;
alter table lotacoes
drop constraint lotacoes_pkey;
alter table funcionarios
drop constraint funcionarios_rg_fkey;
drop index idx_funcionarios;
drop index idx_lotacoes;

select * from funcionarios
select * from lotacoes
select * from saloes

/* checkpoint - inserir os demais dados e restabelecer as fks acima */
insert into lotacoes (rg,numero,horaEntrada,horaSaida)
values (256358322,21,'06:00','12:00');
insert into funcionarios (rg,nome,salario,turno,funcao)
values (256358322,'Pedro Souza',1000,'M','Segurança');

insert into lotacoes (rg,numero,horaEntrada,horaSaida)
values (122369428,21,'06:00','12:00');
insert into funcionarios (rg,nome,salario,turno,funcao)
values (122369428,'Carlos Santos',1000,'M','Segurança');

insert into lotacoes (rg,numero,horaEntrada,horaSaida)
values (294647361,21,'06:00','12:00');
insert into funcionarios (rg,nome,salario,turno,funcao)
values (294647361,'José Pereira',1000,'M','Segurança');

insert into lotacoes (rg,numero,horaEntrada,horaSaida)
values (292627361,21,'12:00','18:00');
insert into funcionarios (rg,nome,salario,turno,funcao)
values (292627361,'Cadu Teixeira',1000,'T','Segurança');

insert into lotacoes (rg,numero,horaEntrada,horaSaida)
values (292622951,22,'12:00','18:00');
insert into funcionarios (rg,nome,salario,turno,funcao)
values (292622951,'Zeca Duplex',1000,'T','Segurança');

insert into lotacoes (rg,numero,horaEntrada,horaSaida)
values (138822951,23,'18:00','00:00');
insert into funcionarios (rg,nome,salario,turno,funcao)
values (138822951,'Mário Falcão',1000,'N','Segurança');

insert into lotacoes (rg,numero,horaEntrada,horaSaida)
values (138953951,22,'18:00','00:00');
insert into funcionarios (rg,nome,salario,turno,funcao)
values (138953951,'Arlindo Anomalia',1000,'N','Segurança');

select * from lotacoes
select * from funcionarios


/* resposta final */
CREATE VIEW v1 AS
(SELECT F.nome, L.numero, L.horaEntrada, L.horaSaida FROM funcionarios F
JOIN lotacoes L ON F.rg = L.rg
WHERE UPPER(F.funcao) = 'SEGURANÇA');

CREATE VIEW v2 AS
(SELECT F.nome, L.numero, L.horaEntrada, L.horaSaida FROM funcionarios F
JOIN lotacoes L ON F.rg = L.rg
WHERE UPPER(F.funcao) = 'SEGURANÇA');

SELECT v1.nome, v2.nome FROM v1, v2
WHERE v1.horaEntrada = V2.horaEntrada AND v1.horaSaida = v2.horaSaida AND
	v1.numero = v2.numero AND v1.nome != v2.nome
	
/* 11 numero dos salões onde tem apenas esculturas */
SELECT DISTINCT S.numero FROM esculturas E
JOIN obras O ON E.codigo = O.codigo
JOIN saloes S ON O.salao = S.numero;

select * from saloes

/* 12 nome e rg dos faxineiros que limpam os saloes do 4º andar */
SELECT nome,rg FROM funcionarios
WHERE UPPER(funcao) = 'FAXINEIRO' AND rg IN(
	SELECT rg FROM lotacoes
	WHERE numero IN(
		SELECT numero from saloes
		WHERE andar = '4'));
	


insert into lotacoes (rg,numero,horaEntrada,horaSaida)
values (159129554,28,'06:00','12:00');
insert into funcionarios (rg,nome,salario,turno,funcao)
values (159129554,'Zapadabian Skabarivsky',700,'M','Faxineiro');
select * from funcionarios;
select * from lotacoes;
select * from saloes
where andar = '1'
insert into saloes (numero,andar,area)
values (28,1,18);

/* 13 autores brasileiros que tem apenas esculturas */
SELECT * FROM esculturas E
JOIN Obras O ON E.codigo = O.codigo
JOIN Autores A ON O.autor = A.codigo
WHERE UPPER(A.nacionalidade) = 'BRASILEIRO';

/* 14 nome e rg seguranças cuidam apenas salão 28 */
SELECT F.nome, F.rg FROM funcionarios F
JOIN lotacoes L ON F.rg = L.rg
JOIN saloes S ON S.numero = L.numero
WHERE S.numero = 28 AND UPPER(F.funcao) = 'SEGURANÇA';

select * from saloes
select * from lotacoes
select * from funcionarios

/* 15 todos os dados do salão de maior area */
SELECT * FROM saloes
ORDER BY area DESC LIMIT 1;

/* alterando a coluna area */
alter table saloes
alter column area type numeric(4,2)
using area::numeric(4,2);
select andar,max(area) from saloes
group by andar
select * from saloes

/* 16 novo salao nº 70 no 20º andar de 121 m²*/
INSERT INTO saloes (numero,andar,area)
VALUES (70,'20',121.00);

/* 17 transferir todas as obras do salao 51 para o salão 70 */
UPDATE obras
SET salao = 70
WHERE salao = 51;

update obras
set salao = 23
where salao = 22;

select * from obras
where salao = 21
select * from saloes;

/* 18 eliminar todas as pinturas do autor Salvador Dali do cadastro */
DELETE FROM pinturas
WHERE codigo IN (
	SELECT codigo FROM obras
	WHERE autor IN (
		SELECT codigo FROM autores
		WHERE UPPER(nome) = 'SALVADOR DALI'));
		
select * from pinturas
where codigo in (
	select codigo from obras
	where autor in (
		select codigo from autores
		where nome = 'Juan'))

select * from autores;
select * from obras;
select * from pinturas;