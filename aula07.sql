--Criando um banco de dados

--Criando a tabela de Usuário
Create table if not exists Usuario(
id SERIAL PRIMARY KEY,
nome VARCHAR(100) NOT NULL,
email VARCHAR(30) NOT NULL UNIQUE,
data_Cadastro TIMESTAMPTZ default CURRENT_TIMESTAMP
);

--Criando Gênero e Editora
Create table if not exists Genero(
id SERIAL PRIMARY KEY,
nome VARCHAR(50) NOT NULL UNIQUE
);

Create table if not exists Editora(
id SERIAL PRIMARY KEY,
nome VARCHAR(50) NOT NULL UNIQUE
);

--Criando a tabela Livro
Create table if not exists Livro(
id SERIAL PRIMARY KEY,
titulo VARCHAR (100) NOT NULL,
quantidade INT NOT NULL CHECK (quantidade >= 0),
id_Editora INT NOT NULL,
id_Genero INT NOT NULL,
foreign key(id_Editora) references Editora(id) on delete cascade,
foreign key(id_Genero) references Genero(id) on delete cascade,
UNIQUE (titulo, codigo_exemplar) --Restringe códigos  100  

);

--Criando a tabela Emprestimo
Create table if not exists Emprestimo(
id_Usuario INT,
id_Livro INT,
data_Emprestimo TIMESTAMP default CURRENT_TIMESTAMP,
data_Devolucao TIMESTAMP NOT NULL,
foreign key(id_Usuario) references Usuario(id) on delete cascade,
foreign key(id_Livro) references Livro(id) on delete cascade
); 

--Adicionando telefone ao Usuario
ALTER table Usuario add COLUMN telefone char(11) default 'Nenhum';

--Alterando o tamanho do campo na tabela de livros para compactar até 200 caracteres
Alter table livro alter column titulo type VARCHAR(200);

--Removendo o campo data_Cadastro da tabela Usuario, pois ela não sera mais utilizado
alter table Usuario drop column data_Cadastro;

--Garanta que o mesmo titulo de livro não possa ser registrado na mesma editora.
alter table livro add constraint up_livro_titulo_editora UNIQUE(titulo, id_Editora);

--Garanti que as datas de emprestimo e devolução sejam distintas e válidas.
alter table emprestimo add constraint chk_data_devolucao check (data_Devolucao >= data_Emprestimo);

INSERT INTO Usuario(id, nome, email, telefone)
values(1, 'Valtermir', 'Valtermir@senac.com.br', '9999-9999');

INSERT INTO Editora(id, nome)
values(1, 'Senac'),
(12, 'Saraiva');

INSERT INTO Genero(id, nome)
values(1, 'Terror'),
(21, 'Drama'),
(32, 'ficção');

INSERT INTO livro(titulo, quantidade, id_Editora, id_Genero)
values('harry potter', 532, 1, 32),
('os 13 porquês', 123, 12, 21),
('O hobbit', 142, 1, 32),
('O lado feio do amor', 1942, 12, 21),
('It a coisa', 172, 12, 32);

INSERT INTO Emprestimo(id_Usuario, id_Livro, data_Devolucao)
values(1, 3, '2024-12-12');


select *from livro;
select *from Usuario;
select *from Editora;
select *from Genero;
select *from Emprestimo