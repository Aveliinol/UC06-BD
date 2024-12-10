--CRIANDO TABELAS

--Tabela Genero
create table if not exists GENERO(
	ID SERIAL primary key,
	NOME VARCHAR(50) not null unique
);

--Tabela Filme
create table if not exists FILME(
	ID SERIAL primary key,
	NOME VARCHAR(60) not null,
	ID_GENERO INT not null,
	constraint fk_genero foreign key (ID_GENERO) references GENERO(ID)
);

insert into GENERO (nome)
values ('Animação'), ('Terror'), ('Ação'), ('Drama'), ('Comedia');
 
insert into FILME(nome, id_genero)
values ('Batman', 20), ('The Battle of the Dark River', 20),
('White Duck', 18), ('Breaking Barriers', 21), ('The Two Hours', 19);

--questão 04
insert into FILME(nome, id_genero)
values ('Batman - o retorno', 20), ('Moana', 7),
('Pato Donald', 18), ('Hulk', 19), ('Tropa de Elite', 6);

--questão 05
insert into GENERO (id, nome)
values (6,'Documentario'), (7, 'Suspense');

-- --questão 06
select nome from filme where id_genero = 18;

-- --questão 07
select nome from filme where id_genero = 18  or id_genero = 21 ;

--Questão 8
select * from genero;

--Questão 9
select * from filme where nome ilike 'T%';

--Questão 10
update filme 
         set id_genero=21
		 where id_genero=20;

update filme 
          set id_genero= (select id from genero where nome = 'Ação')
		  where id_genero= (select id from genero where nome = 'Drama');

--Questão 11
select filme.nome, genero.nome as gênero from filme, genero
where id_genero = genero.id order by filme.nome; 

select filme.nome as filme_nome, genero.nome as genero_nome
from filme join genero on filme.id_genero = genero.id order by filme.nome;

--Questão 12
delete from filme where id_genero = (select id from genero where nome = 'Ação');

select * from filme;
 