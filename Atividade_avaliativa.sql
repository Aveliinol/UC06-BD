-- 1. Quantidade de bibliotecários responsáveis por cada unidade.

select *from bibliotecario;
select *from unidade;

Select unidade.nome, count(bibliotecario.id_unidade) 
as total_bibliotecarios from bibliotecario join unidade 
on bibliotecario.id_unidade = unidade.id
group by unidade.nome;

-- 2. Quantidade de livros disponíveis em cada unidade.

select *from livro;
select *from unidade;

Select unidade.nome, count(livro.id_unidade)
as total_livros from livro join unidade
on livro.id_unidade = unidade.id
group by unidade.nome;

--3. Quantidade de empréstimos realizados em cada unidade

Select *from emprestimo;
select * from livro

Select unidade.nome, count(emprestimo.id_livro) as total_emprestimo
from emprestimo 
join livro on emprestimo.id_livro = livro.id 
join unidade on livro.id_unidade = unidade.id
group by unidade.nome;

-- 5. Quantidade total de usuários cadastrados no sistema.

Select *from usuario;

Select count (id) as total
from usuario;

-- 6. Quantidade total de livros cadastrados no sistema.

Select *from livro;

Select count (id) as total
from livro;

--7. Quantidade de livros emprestados por cada usuário. Ordene pelo total encontrado e em
-- ordem decrescente. 

Select *from emprestimo;
Select *from livro;
Select *from usuario;

Select usuario.nome, count(emprestimo.id_livro) as total_emprestimo
from emprestimo join usuario on emprestimo.id_usuario = usuario.id 
group by usuario.nome 
order by total_emprestimo desc; 

-- 8. Quantidade de empréstimos realizados por mês. Use EXTRACT(MONTH FROM
-- data_emprestimo) para extrair o mês.

Select *from emprestimo;

Select EXTRACT(MONTH FROM data_emprestimo) as mes, count(emprestimo.id)
from emprestimo
group by mes
order by mes;

-- 9. Média do número de páginas dos livros cadastrados no sistema.

Select *from livro;

Select round(avg(numero_paginas), 2) as media_paginas
from livro;

-- 10. Quantidade de livros cadastrados em cada categoria.

Select *from livro;

Select categoria.nome, count(livro.id_categoria) as total_livros
from livro join categoria on livro.id_categoria = categoria.id
group by categoria.nome;

-- 11. Liste os livros cujos autores possuem nacionalidade americana.

Select *from autor;

Select livro.titulo, autor.nome from livro join autor 
on livro.id_autor = autor.id
where autor.nacionalidade = 'Americana';

-- 12. Quantidade de livros emprestados atualmente (não devolvidos).

select *from emprestimo;

Select count (id_livro) from emprestimo 
where devolvido = 'false';

-- 13. Unidades com mais de 60 livros cadastrados.

select unidade.nome, count(livro.id_unidade)
from unidade  join livro on unidade.id = livro.id_unidade 
group by unidade.nome 
having count(livro.id_unidade) > 60;

-- 14. Quantidade de livros por autor. Ordene pelo total e em ordem decrescente.

select autor.nome, count (livro.id_autor) as total_livros 
from autor join livro on livro.id_autor = autor.id 
group by autor.nome
order by total_livros desc;

-- 15. Categorias que possuem mais de 5 livros disponíveis atualmente.

Select *from categoria;
Select *from autor;
Select *from livro;

select categoria.nome, count(livro.id_categoria) as total_livros
from livro join categoria on livro.id_categoria = categoria.id 
where livro.disponivel = 'true' 
group by categoria.nome
having count(livro.id_categoria) > 5;

-- 16. Unidades com pelo menos um empréstimo em aberto.

select unidade.nome from unidade join livro 
on livro.id_unidade = unidade.id
join emprestimo on emprestimo.id_livro = livro.id
where emprestimo.devolvido = 'False'
group by unidade.nome;


