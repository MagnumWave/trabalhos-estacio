CREATE TABLE Autores (
	Codigo NUMERIC(5) PRIMARY KEY,
	Nome VARCHAR(20) NOT NULL,
	Nacionalidade VARCHAR(15) NOT NULL );

CREATE TABLE Funcionarios (
	RG NUMERIC(10) PRIMARY KEY, /* adicionar fk */
	Nome VARCHAR(50) NOT NULL,
	Salario NUMERIC(6,2) NOT NULL,
	Turno CHAR(1) NOT NULL,
	Funcao VARCHAR(9) NOT NULL );

CREATE TABLE Lotacoes (
	RG NUMERIC(10) NOT NULL UNIQUE, /* adicionar fk */
	Numero NUMERIC(3) NOT NULL UNIQUE, /* adicionar fk */
	HoraEntrada TIMESTAMP NOT NULL, 
	HoraSaida TIMESTAMP NOT NULL,
	PRIMARY KEY(RG,Numero,HoraEntrada) ); /* 3 pks de uma vez */

CREATE TABLE Saloes (
	Numero NUMERIC(3) PRIMARY KEY, /* adicionar fk */
	Andar CHAR(1) NOT NULL,
	Area NUMERIC(4,2) NOT NULL );

CREATE TABLE Obras (
	Codigo NUMERIC(10) PRIMARY KEY,
	Titulo VARCHAR(50) NOT NULL,
	Ano CHAR(4) NOT NULL,
	Autor NUMERIC(5), /* adicionar fk */
	Salao NUMERIC(3) ); /* adicionar fk */

CREATE TABLE Esculturas (
	Codigo NUMERIC(10) PRIMARY KEY, /* adicionar fk */
	Altura NUMERIC(5,2) NOT NULL,
	Peso NUMERIC(6,2) NOT NULL,
	Material VARCHAR(15) NOT NULL );

CREATE TABLE Pinturas (
	Codigo NUMERIC(10) PRIMARY KEY, /* adicionar fk */
	Estilo VARCHAR(20) NOT NULL,
	Area CHAR(2) NOT NULL );

/* adicionando chaves estrangeiras */

ALTER TABLE Funcionarios ADD FOREIGN KEY (RG) REFERENCES Lotacoes(RG);
ALTER TABLE Lotacoes ADD FOREIGN KEY (RG) REFERENCES Funcionarios(RG);
ALTER TABLE Lotacoes ADD FOREIGN KEY (Numero) REFERENCES Saloes(Numero);
ALTER TABLE Obras ADD FOREIGN KEY (Autor) REFERENCES Autores(Codigo);
ALTER TABLE Obras ADD FOREIGN KEY (Salao) REFERENCES Saloes(Numero);
ALTER TABLE Esculturas ADD FOREIGN KEY (Codigo) REFERENCES Obras(Codigo);
ALTER TABLE Pinturas ADD FOREIGN KEY (Codigo) REFERENCES Obras(Codigo);

/* adicionando indexes */

CREATE UNIQUE INDEX idx_saloes ON Saloes (Area);
CREATE UNIQUE INDEX idx_autores ON Autores (Nacionalidade);
CREATE UNIQUE INDEX idx_obras ON Obras (Ano,Autor);
CREATE UNIQUE INDEX idx_pinturas ON Pinturas (Estilo,Area);
CREATE UNIQUE INDEX idx_esculturas ON Esculturas (Material);
CREATE UNIQUE INDEX idx_funcionarios ON Funcionarios (Turno,Funcao);
CREATE UNIQUE INDEX idx_lotacoes ON Lotacoes (HoraEntrada);