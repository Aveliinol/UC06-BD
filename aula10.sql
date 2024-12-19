begin;
CREATE TABLE autor(
	id SERIAL PRIMARY KEY,
	nome VARCHAR(60) NOT NULL,
	data_nascimento DATE,
	CONSTRAINT chk_data_nascimento CHECK (data_nascimento <= CURRENT_DATE)
);

CREATE TABLE livro(
	id SERIAL PRIMARY KEY,
	titulo VARCHAR(60) NOT NULL,
	id_autor INTEGER,
	ano_publicacao INT, 
	CONSTRAINT fk_autor_livro FOREIGN KEY (id_autor) REFERENCES autor(id),
	CONSTRAINT chk_ano_publicacao CHECK (ano_publicacao >= 1500 AND ano_publicacao <= EXTRACT(YEAR FROM CURRENT_DATE))
);

CREATE TABLE usuario(
	id SERIAL PRIMARY KEY,
	nome VARCHAR(60) NOT NULL,
	email VARCHAR(60) UNIQUE,
	data_adesao DATE,
	CONSTRAINT chk_data_adesao CHECK (data_adesao <= CURRENT_DATE)
);

CREATE TABLE emprestimo(
	id SERIAL PRIMARY KEY,
	id_livro INTEGER,
	id_usuario INTEGER,
	data_emprestimo DATE NOT NULL,
	data_devolucao DATE NOT NULL,
	CONSTRAINT fk_livro FOREIGN KEY (id_livro) REFERENCES livro(id),
	CONSTRAINT fk_usuario FOREIGN KEY (id_usuario) REFERENCES usuario(id),
	CONSTRAINT chk_data_devolucao CHECK (data_emprestimo <= data_devolucao),
	CONSTRAINT uq_livro_emprestimo unique(id_livro, data_emprestimo)
);


rollback;

--Criando as inserções

--Inserindo Autores
Insert into autor(nome, data_nascimento)
values('Machado de Assis', '1839-06-21'),
('Clarice Lispector', '1920-12-10'),
('José Saramago', '1922-11-16'),
('Gabriel García Márquez', '1927-03-6'),
('J.K Rowling', '1965-07-31');

--Inserindo Livros
Insert into livro(titulo, id_autor, ano_publicacao)
values('Dom Casmurro', 1, 1899),
('A Hora da Estrela', 2, 1977),
('Ensaio sobre a cegueira', 3, 1995),
('Cem Anos de Solidão', 4, 1967),
('Harry Potter e a Pedra Filosofal', 5, 1997);

--Inserindo Usuários
Insert into usuario (nome, email, data_adesao)
values('Wania Machado', 'machado32gmail.com', '2023-05-25'),
('Fabiana Silva', 'Biana1334@gmail.com', '2024-01-30'),
('Marcelo Vieira', 'marcelo@gmail.com', '2022-10-28'),
('João Ramos', 'Ramos432@gmail.com', '2023-12-26'),
('Luis Maia', 'Maia123@gmail.com', '2023-05-15');

--Inserindo Emprestimos
Insert into emprestimo(id_livro, id_usuario, data_emprestimo, data_devolucao)
values(1, 2, '2024-05-21', '2024-05-30'),
(3, 1, '2024-12-01', '2024-12-19'),
(2, 4, '2024-10-10', '2024-10-18'),
(5, 5, '2024-08-30', '2024-09-05'),
(4, 4, '2024-09-12', '2024-09-19');

--Consulta SQL

--1
select livro.titulo, autor.nome as autor from livro join autor on livro.id_autor = Autor.id;

--2
select nome, email from usuario;

--3
select usuario.nome, livro.titulo, emprestimo.data_emprestimo, emprestimo.data_devolucao 
from emprestimo join livro on id_livro = livro.id join usuario on id_usuario = usuario.id;

--4
select livro.titulo, emprestimo.data_emprestimo from emprestimo join livro
id_livro = livro.id where data_devolucao = null;

--18
select usuario.nome, livro.titulo, autor.nome as autor from emprestimo
join livro on emprestimo.id_livro = livro.id join autor on livro.id_autor = autor.id
join usuario on emprestimo.id_usuario = usuario.id where autor.nome = 'Gabriel García Márquez';
