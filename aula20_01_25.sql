create or replace procedure insert_novo_categoria(
nome VARCHAR,
descricao TEXT
) language sql 
AS $$
INSERT INTO categoria(nome, descricao) 
VALUES (nome, descricao);
$$;

create or replace procedure update_telefone_unidade(
   id_unidade integer,
   telefone_unidade varchar
) language sql
 as $$
update unidade 
set telefone = telefone_unidade
where id = id_unidade
$$;

create or replace procedure update_nome_usuario(
     id_usuario integer,
	 nome_usuario varchar
) language sql
as $$ 
update usuario
set nome = nome_usuario
where id = id_usuario
$$;

create or replace procedure delete_livro_livro(
id_livro integer
)language sql 
as $$
delete from livro
where id = id_livro
$$;