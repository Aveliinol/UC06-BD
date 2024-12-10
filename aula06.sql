
-- -- --CRIANDO UM BANCO DE DADOS (DATABESE)
-- -- --CREATE DATABASE aula06

-- -- --CRIANDO UMA TABELA
-- -- CREATE TABLE IF NOT EXISTS Produto(
-- -- ID INT PRIMARY KEY,
-- -- COD VARCHAR(4) NOT NULL UNIQUE,
-- -- NOME VARCHAR(100) NOT NULL,
-- -- PRECO REAL CHECK(PRECO>0)
-- -- );

-- -- --\dt (Descrição das estruturas do banco);
-- -- --\dt
-- -- \d Produto;

-- -- --DELETANDO UMA BASE DE DADOS
-- -- --DROP DATABASE aula06;
-- -- --DELETANDO UMA TABELA
-- -- DROP TABLE Produto;

-- --CRIANDO UM BANCO DE DADOS(DATABASE)

-- --CRIANDO A TABELA PROFESSOR
-- CREATE TABLE IF NOT EXISTS Professor(
-- ID INT PRIMARY KEY,
-- NOME VARCHAR(100),
-- CPF CHAR(11)
-- );

-- --CRIANDO A TABELA TURMA
-- CREATE TABLE IF NOT EXISTS Turma(
-- ID INT,
-- NUM VARCHAR(3),
-- DURACAO_DIAS CHAR(4),
-- ID_PROFESSOR INT,
-- PRIMARY KEY(NUM, ID),
-- CONSTRAINT fk_prof FOREIGN KEY(ID_PROFESSOR) REFERENCES PROFESSOR(ID)
-- );

-- \dt
-- \d Turma
-- \d Professor

CREATE TABLE IF NOT EXISTS Fornecedor(
ID INT PRIMARY KEY,
NOME VARCHAR(100) NOT NULL,
CIDADE VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS Peca( 
ID INT PRIMARY KEY,
NOME VARCHAR(100) NOT NULL,
DESCRICAO TEXT
);

CREATE TABLE IF NOT EXISTS Venda(
ID_FORNECEDOR INT,
ID_PECA INT,
DATA DATE,
QUANTIDADE INT,
FOREIGN KEY (ID_FORNECEDOR) REFERENCES FORNECEDOR(ID),
FOREIGN KEY (ID_PECA) REFERENCES PECA(ID)
);

ALTER TABLE Fornecedor ADD TELEFONE VARCHAR(9);
ALTER TABLE PECA ADD PRECO REAL;
ALTER TABLE Fornecedor DROP CIDADE;

\dt
\d Peca
\d Fornecedor
\d Venda