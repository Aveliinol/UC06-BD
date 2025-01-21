--1.

create view livros_com_autores_e_categorias as 
select 
      livro.id as id_livro,
	  livro.titulo,
	  autor.nome as nome_autor,
	  categoria.nome as nome_categoria
from
    livro
join autor on livro.id_autor = autor.id
join categoria on livro.id_categoria = categoria.id;

select *from livros_com_autores_e_categorias;

--2.

create view livros_com_unidade_e_categoria as
select 
      livro.disponivel = 'true' as livros_disponiveis,
	  livro.titulo,
	  unidade.nome as unidade_nome,
	  categoria.nome as categoria_nome
from 
     livro
join unidade on livro.id_unidade = unidade.id
join categoria on livro.id_categoria = categoria.id;

select *from livros_com_unidade_e_categoria;

--3.

create view usuarios_com_total_emprestimo as
select
      usuario.nome,
count(emprestimo.id_livro) as total_emprestimo
from emprestimo
join usuario on emprestimo.id_usuario = usuario.id
group by usuario.nome;

select *from usuarios_com_total_emprestimo;

--4.

create view emprestimos_atrasados_com_os_nomes_de_usuario as
select 
       emprestimo.devolvido = 'false' as emprestimos_atrasados,
	   livro.titulo,
	   usuario.nome as nome_usuario
from emprestimo
join livro on emprestimo.id_livro = livro.id
join usuario on emprestimo.id_usuario = usuario.id;

select *from emprestimos_atrasados_com_os_nomes_de_usuario;

--5.

create view livros_disponiveis_em_cada_unidade as
select 
      unidade.nome, count(livro.id_unidade)
as total_livros from livro join unidade
on livro.id_unidade = unidade.id
group by unidade.nome;

select *from livros_disponiveis_em_cada_unidade;

--6.
create view quantidade_de_livros_que_cada_autor_tem as 
select 
      autor.nome, count(livro.id_autor)
as total_livros_por_autor
from livro
join autor on livro.id_autor = autor.id
group by autor.nome;

select *from quantidade_de_livros_que_cada_autor_tem;

--7.
create view listar_de_livros_devolvidos as
select
       emprestimo.devolvido = 'true' as devolvidos,
	   livro.titulo
from emprestimo 
join livro on emprestimo.id_livro = livro.id

select *from listar_de_livros_devolvidos;

--8.

       







	   


	  
	  


