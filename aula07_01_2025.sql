--Tabela clientes
Create table if not exists Cliente(
 id SERIAL PRIMARY KEY,
 nome VARCHAR(100) NOT NULL,
 cpf CHAR(11) NOT NULL UNIQUE,
 email VARCHAR(100) UNIQUE,
 telefone VARCHAR(20),
 data_cadastro TIMESTAMP DEFAULT (CURRENT_TIMESTAMP)
);

--Tabela Produto
Create table if not exists Produto(
id SERIAL PRIMARY KEY,
nome VARCHAR(100) NOT NULL,
descricao TEXT,
preco NUMERIC(10,2) NOT NULL CHECK(preco > 0),
quantidade NUMERIC(10,2) NOT NULL CHECK(quantidade > 0),
data_cadastro TIMESTAMP  DEFAULT (CURRENT_TIMESTAMP)
);

--Tabela Funcionarios
Create table if not exists Funcionario(
id SERIAL PRIMARY KEY,
nome VARCHAR(100) NOT NULL,
cpf CHAR(11) NOT NULL UNIQUE,
cargo VARCHAR(50) NOT NULL,
salario NUMERIC(10,2) NOT NULL CHECK(salario > 0),
data_admissao TIMESTAMP DEFAULT (CURRENT_TIMESTAMP) NOT NULL,
email VARCHAR(100) UNIQUE
);

--Tabela Vendas
Create table if not exists Venda(
id SERIAL PRIMARY KEY,
cliente_id INT,
funcionario_id INT,
data_venda TIMESTAMP DEFAULT (CURRENT_TIMESTAMP),
total NUMERIC(10,2) NOT NULL CHECK(total >= 0),
Constraint fk_CLiente foreign key (cliente_id) references Cliente(id),
Constraint fk_Funcionario foreign key (funcionario_id) references Funcionario(id)
);

--Tabela Vendas 2
Create table if not exists item_venda(
id SERIAL PRIMARY KEY,
venda_id INT,
produto_id INT,
quantidade NUMERIC(10,2) NOT NULL CHECK(quantidade > 0),
preco NUMERIC(10,2) NOT NULL CHECK(preco >= 0),
subtotal NUMERIC(10,2) NOT NULL,
Constraint fk_Venda foreign key (venda_id) references Venda(id) on delete cascade,
Constraint fk_Produto foreign key (produto_id) references produto(id) on delete set null
);

INSERT INTO cliente (nome, cpf, email, telefone)
VALUES
('João Silva', '12345678901', 'joao@email.com', '123456789'),
('Maria Oliveira', '98765432100', 'maria@email.com', '987654321'),
('Carlos Pereira', '10293847565', 'carlos@email.com', NULL),
('Ana Costa', '56473829101', 'ana@email.com', '564738291'),
('Lucas Souza', '19283746509', 'lucas@email.com', '192837465');

INSERT INTO produto (nome, descricao, preco, quantidade)
VALUES
('Livro de Java', 'Livro sobre programação Java para iniciantes', 50.00, 100),
('Livro de Python', 'Introdução ao Python com exemplos práticos', 60.00, 150),
('Livro de SQL', 'Guia completo de SQL para bancos de dados relacionais', 45.00, 200),
('Livro de JavaScript', 'Explorando os conceitos básicos de JavaScript', 55.00, 120),
('Livro de C++', 'Aprenda C++ de forma fácil e prática', 70.00, 80);

INSERT INTO funcionario (nome, cpf, cargo, salario, email)
VALUES
('Fernanda Santos', '23456789012', 'Vendedor', 2000.00, 'fernanda@email.com'),
('Roberto Lima', '34567890123', 'Gerente', 5000.00, 'roberto@email.com'),
('Juliana Mendes', '45678901234', 'Caixa', 1500.00, 'juliana@email.com'),
('Paulo Gomes', '56789012345', 'Vendedor', 2200.00, 'paulo@email.com'),
('Ricardo Alves', '67890123456', 'Gerente', 5500.00, 'ricardo@email.com');

INSERT INTO venda (cliente_id, funcionario_id, total)
VALUES
(1, 1, 250.00),
(2, 2, 300.00),
(3, 3, 450.00),
(4, 4, 350.00),
(5, 5, 500.00);

INSERT INTO item_venda (venda_id, produto_id, quantidade, preco, subtotal)
VALUES
(1, 1, 2, 50.00, 100.00),
(1, 3, 3, 45.00, 135.00),
(2, 2, 2, 60.00, 120.00),
(2, 4, 2, 55.00, 110.00),
(3, 5, 3, 70.00, 210.00);

--1. Liste o total de vendas realizadas por cada cliente.

Select *from venda;

select cliente.nome, count(venda.cliente_id) 
as total from venda join cliente on venda.id = cliente.id 
group by cliente.nome 
order by cliente.nome asc;

--2. Liste o total de vendas realizadas por cada funcionario.

Select *from venda;

select funcionario.nome, count(venda.funcionario_id) 
as total_vendas_funcionario from venda join funcionario on venda.funcionario_id = funcionario.id
group by funcionario.nome
order by funcionario.nome;
	
--3. Liste a quantidade total de produtos vendidos por cada venda.

Select *from produto;
Select *from venda; --Pedido
Select *from item_venda; --Itens do pedido

Select venda_id, sum(quantidade) as quantidade
from item_venda
group by venda_id
order by venda_id;

--4. Liste a quantidade total de itens vendidos por produto.
--Pulou

--5. Liste os clientes que realizaram mais de 5 compras.

Select *from venda;
Select *from item_venda;
Select *from cliente;
Select cliente.nome, count(venda.cliente_id)
from venda join item_venda
on venda.cliente_id = item_venda.venda_id
join cliente on cliente.id = venda.cliente_id
group by cliente.nome
having count(venda.cliente_id) >= 1;

--6. Liste os produtos que possuem mais de 50 unidades em estoque.

select *from produto;

select quantidade from produto where(quantidade > 50);

--7. Liste os funcionários que participaram de mais de 10 vendas.

Select *from venda;

Select funcionario.nome, count(venda.id) as total_venda
from venda 
join funcionario on funcionario.id = venda.funcionario_id
group by funcionario.nome
having count(venda.id) >= 1;

--8. Liste os produtos cujo total vendido (quantidade) seja superior a 100 unidades.

select * from item_venda;

Select produto_id, sum(item_venda.quantidade) from item_venda
group by produto_id
having sum(item_venda.quantidade) > 1

--9. Calcule o valor total das vendas de cada cliente.

select *from venda;

Select cliente.nome, sum(venda.total) as total_venda 
from venda
join cliente on cliente.id = venda.cliente_id
group by cliente.nome
order by total_venda desc;

--10. Calcule o valor total das vendas realizadas por cada funcionário.

Select *from venda;

Select funcionario.nome, sum(venda.total)
from venda
join funcionario on funcionario.id = venda.id
group by funcionario.nome;

--11. Calcule o total de itens vendidos por venda.

Select *from venda;
Select *from item_venda	;

Select venda_id, quantidade, sum(item_venda.venda_id) as total
from item_venda
group by venda_id, quantidade;

--12. Calcule o total de produtos vendidos agrupados por categoria (se
-- adicionamos uma coluna de categoria na tabela produtos).

Select *from produto;
-- Adicionando os produtos 2, 3, 4, 5 na categoria Livros
alter table produto add column categoria VARCHAR(50);
-- Adicionando 
update produto set categoria = 'Livro'
where id in(1, 2, 3, 4, 5)

Select produto.categoria, sum(produto.quantidade) as total
from item_venda 
join produto on item_venda.produto_id = produto.id
group by produto.categoria;

--13. Calcule o total arrecadado com vendas para cada cliente.

Select *from venda;

Select cliente.nome, sum(total) as total
from venda 
join cliente on venda.cliente_id = cliente.id
group by cliente.nome;

--14. Calcule o preço médio dos produtos em estoque.

Select *from produto;

Select round(avg(preco),2) as resultado
from produto;

--15. Calcule o preço médio do produto vendidos por venda.

 Select *from venda;

 Select round(avg (total),2) as resultado
 from venda;
 
--16. Calcule a média de salarios dos funcionários.

Select *from funcionario

Select round(avg (salario),2) as resultado
from funcionario;

--17. Calcule a média do total das vendas por funcionário.

Select *from venda;

Select funcionario.nome, round (avg(total),2) as resultado 
from venda
join funcionario on venda.funcionario_id = funcionario.id
group by nome
order by nome ASC;

--18. Conte quantos vendas foram realizadas por cliente.

Select *from venda;

Select cliente.nome, count(cliente.id) as vendas_realizadas
from venda 
join cliente on venda.cliente_id = cliente.id
group by nome;

--19. Conte quantas vendas cada funcionário participou.

Select *from venda;

Select funcionario.nome, count(funcionario.id) as total
from venda 
join funcionario on venda.funcionario_id = funcionario.id
group by nome;

--20. Conte quantos produtos estão cadastrados no banco.

Select *from produto;

Select sum (quantidade) as total
from produto;

--21. Conte quantas vendas foram realizadas em cada dia.

select *from venda;

Select data_venda, count(id) as vendas
from venda
group by data_venda;

--22. Liste os clientes que realizaram mais de 5 compras, ordenados 
--pelo total de vendas.

select * from item_venda;

select cliente.nome, count(item_venda.venda_id) from item_venda
group by venda_id
having sum(venda_id) > 1

--23. Liste os produtos mais vendidos (em quantidade) cujo total vendido 
-- utrapassa 50 unidades.

--24. Calcule a média de preço dos produtos vendidos em cada venda.

--25. Liste os funcionários que participaram de vendas cujo total médio é
-- superior a R$ 5.000,00.








		