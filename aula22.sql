--8. 
create view listar_livros_por_ano_publicacao as
select 
       livro.ano_publicacao as ano_publicacao,
	   livro.titulo
from livro 
order by livro.ano_publicacao desc;

select *from listar_livros_por_ano_publicacao;

--9.

create view listar_bibliotecario_e_suas_unidades as
select 
      bibliotecario.nome,
	  unidade.nome as unidade
from bibliotecario 
join unidade on bibliotecario.id_unidade = unidade.id

select *from listar_bibliotecario_e_suas_unidades;

--10.

create view usuarios_que_nunca_realizaram_emprestimo as
select 
       usuario.id as id_usuario,
	   usuario.nome as nome_usuario
from usuario
join emprestimo on usuario.id = emprestimo.id_usuario
where emprestimo.id is null;

select *from usuarios_que_nunca_realizaram_emprestimo;

-----------------------------------------------------------

--procedures

--1. 
create or replace procedure insert_novo_autor(
nome varchar,
nacionalidade varchar,
data_nascimento date
) language sql 
as $$
insert info autor(nome, nacionalidade, data_nascimento)
values(nome, nacionalidade, data_nascimento);
$$;

call insert_novo_autor(
'elon musk',
'Americano',
'1971-06-28'
);

--2.

create or replace procedure procedure_registar_emprestimo(p_id_usuario int, p_id_livro int, p_data_devolucao date)
language plpgsql
as $$
begin 
    insert into emprestimo (id_usuario, id_livro, data_devolucao)
	values(p_id_usuario, p_id_livro, p_data_devolucao);
	update livro set disponivel = FALSE
	where id = p_id_livro;
end;
$$;

call  procedure_registar_emprestimo(2, 111, '2025-01-22');

--3.

create or replace procedure procedure_devolver_livro(p_id_emprestimo int)
language plpgsql
as $$
begin 
      -- Atualiza o status 
	  update emprestimo
	  set devolvido = true
	  where id = p_id_emprestimo;

	  -- Atualiza a disponibilidade
	  update livro
	  set disponivel = true
	  from emprestimo;
end;
$$;

call procedure_devolver_livro (858)


--4.

create or replace procedure procedure_delete_unidade(p_id_unidade int)
language plpgsql
as $$ 
      begin
           delete from unidade 
           where id = p_id_unidade;
	  end;
$$;

call procedure_delete_unidade(4)

--5.

create or replace procedure insert_novo_categoria(nome VARCHAR, descricao TEXT)
language sql 
AS $$
     INSERT INTO categoria(nome, descricao) 
     VALUES (nome, descricao);
$$;

call insert_novo_categoria('geografia', 'livros sobre geografia')

--6.

create or replace procedure update_telefone_usuario(id_usuario integer,telefone_usuario varchar)
language sql
as $$
     update usuario
     set telefone = telefone_usuario
     where id = id_usuario
$$;

call update_telefone_usuario (1, '84 912342731')

--7.

create or replace procedure procedure_transferir_livro ( p_id_livro int, p_id_unidade_destino int)
language plpgsql 
as $$ 
begin
     update livro
	 set id_unidade = p_id_unidade_destino
	 where id = p_id_livro;
end;
$$;

call procedure_transferir_livro(109, 3)

--8.

create or replace procedure procedure_delete_bibliotecario(p_id_bibliotecario int)
language plpgsql
as $$ 
      begin
           delete from bibliotecario 
           where id = p_id_bibliotecario;
	  end;
$$;

call procedure_delete_bibliotecario (1)

--9. 

create or replace procedure update_categoria_livro(id_livro integer,categoria_livro int)
language sql
as $$
     update livro
     set id_categoria = categoria_livro
     where id = id_livro
$$;

call update_categoria_livro (109, 3)

--10. 

create or replace procedure insert_novo_usuario(
nome varchar,
email varchar,
telefone varchar,
endereco varchar, 
data_cadastro timestamp
) language sql 
as $$
insert into usuario(nome, email, telefone, endereco, data_cadastro)
values(nome, email, telefone, endereco, data_cadastro);
$$;

