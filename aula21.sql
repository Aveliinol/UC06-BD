--criar uma função para calcular o total de livros
create or replace function total_livros(nome_livro varchar)

--Criar uma função para calcular o total de livros

create or replace function total_livros() returns integer as $$
 declare 
 total_livros int;
   begin 
     return(select count(*) as total_livros from livro);
   end;
   $$ language plpgsql;

--Criar uma função para calcular o total de usuarios
   
create or replace function total_usuarios() returns integer as $$
 declare
 total_usuarios int;
   begin
	 return(select count(*) as total_usuarios from usuario);
   end;
$$ language plpgsql;   

--Cria uma função que retorna todos os usuarios

create or replace function listar_usuarios_por_id(user_id integer) returns 
table(id_user integer, nome_user varchar, email_user varchar, telefone_user varchar, endereco_user text, data_cadastro_user timestamp)
as $$ 
 begin
   return query
   select *
   from usuario
   where id = user_id;
 end;
 $$ language plpgsql;

 select *from listar_usuarios_por_id(4);

--Criar uma função que retorna livro por id

create or replace function listar_livro_por_id(livro_id integer) returns
table(id_livro integer, titulo_livro varchar, id_autor_livro integer, id_categoria_livro integer, ano_publicaçao_livro integer, numero_paginas_livro integer, disponivel_livro boolean, id_unidade_livro integer)
as $$
 begin
   return query 
   select *
   from livro
   where id = livro_id;
 end;
$$ language plpgsql;

select *from listar_livro_por_id(109)