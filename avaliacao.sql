--Tabela Clientes 
Create table if not exists Cliente(
   id SERIAL primary key,
   nome VARCHAR(100) not null unique,
   email VARCHAR(100) not null unique,
   telefone VARCHAR(20) not null unique,
   data_cadastro DATE not null
);

--Tabela Serviços
Create table if not exists Servico(
  id SERIAL primary key,
  nome VARCHAR(100) not null,
  descricao TEXT not null,
  preco DECIMAL(10,2) not null, 
  tipo_servico VARCHAR(50) not null
);

--Tabela tecnicos 
Create table if not exists Tecnico(
   id SERIAL primary key,
   nome VARCHAR(100) not null,
   especialidade VARCHAR(50) not null,
   data_contratacao DATE not null
);

--Tabela Chamados
Create table if not exists Chamado(
   id SERIAL primary key,
   cliente_id INT,
   tecnico_id INT,
   servico_id INT,
   data_chamado DATE not null,
   status VARCHAR(20) not null check ( status in ('Pendente', 'Andamento', 'Finalizado')) not null,
   descricao TEXT not null,
   Constraint fk_Cliente foreign key (cliente_id) references Cliente(id) on delete cascade,
   Constraint fk_Tecnico foreign key (tecnico_id) references Tecnico(id) on delete cascade,
   Constraint fk_Servico foreign key (servico_id) references Servico(id) on delete cascade
);

--Tabela Pagamentos
Create table if not exists Pagamento(
   id SERIAL primary key,
   cliente_id INT,
   chamado_id INT,
   valor_pago DECIMAL(10,2) not null,
   data_pagamento DATE not null,
   forma_pagamento VARCHAR(50) not null,
   Constraint fk_Cliente foreign key (cliente_id) references Cliente(id) on delete cascade,
   Constraint fk_Chamado foreign key (chamado_id) references Chamado(id) on delete cascade
);

--Adicionando um check na tabela serviço 
 Alter table Servico ADD Constraint Verificar_preco check (preco > 0);

 --Adicionando um check em pagamento
 Alter table Pagamento ADD Constraint Verificar_pagamento check (valor_pago > 0);

 --Adicionando um check em tipo de serviço
 Alter table Servico ADD Constraint Verificar_servico check (tipo_servico = 'Consultoria' or tipo_servico = 'Suporte' or tipo_servico = 'Manutenção');
 
--Criando os Insert de Clientes
 Insert into Cliente(nome, email, telefone, data_cadastro)
 values ('João Silva', 'joao@email.com', '(11) 98765-4321', '2023-01-15'),
 ('Maria Oliveira', 'maria@email.com', '(21) 99654-3210', '2023-02-20'),
 ('Pedro Souza', 'pedro@email.com', '(31) 99765-1234', '2023-03-10'),
 ('Ana Costa', 'ana@email.com', '(41) 98888-9999', '2023-04-25'),
 ('Lucas Almeida', 'lucas@email.com', '(61) 99123-4567', '2023-05-30');

 --Criando os Insert de Serviços
 Insert into Servico(nome, descricao, preco, tipo_servico)
 Values ('Consultoria em TI', 'Consultoria especializada em infraestrutura de TI', 500.00, 'Consultoria'),
 ('Manutenção de Equipamentos', 'Manutenção preventiva e corretiva de equipamentos', 300.00,'Manutenção'),
 ('Suporte Técnico', 'Suporte remoto e presencial para empresas', 200.00, 'Suporte');

 --Criando os Insert de Tecnicos
 Insert into Tecnico(nome, especialidade, data_contratacao)
 Values ('Carlos Oliveira', 'Consultoria TI', '2022-10-10'),
 ('Fernanda Souza', 'Manutenção', '2021-06-15'),
 ('Roberto Costa', 'Suporte Técnico', '2020-08-20');

 --Criando os insert de Chamados
 Insert into Chamado(cliente_id, tecnico_id, servico_id, data_chamado, status, descricao)
 values(1, 1, 1, '2023-06-01', 'Pendente', 'Fiação da casa queimada'),
 (2, 2, 2, '2023-07-10', 'Andamento', 'Vazamento na tubulação'),
 (3, 3, 3, '2023-08-05', 'Finalizado', 'Reparação no ar-condicionado'),
 (4, 1, 2, '2023-09-20', 'Pendente', 'Manutenção no servidor'),
 (5, 2, 1, '2023-10-15', 'Finalizado', 'Suporte para software');

--Criando os insert de Pagamento
Insert into Pagamento(cliente_id, chamado_id, valor_pago, data_pagamento, forma_pagamento)
Values(1, 1, 350.00, '2023-06-15', 'Pix'),
(2, 2, 450.00, '2023-07-15', 'Pix'),
(3, 3, 600.00, '2023-08-10', 'Pix'),
(4, 4, 300.00, '2023-09-25', 'Pix');
 
--Liste o nome e e-mail de todos os clientes cadastrados.
select nome, email from cliente;

--Recupere os nomes dos serviços disponíveis e seus respectivos preços.
select nome, preco from servico;

--Exiba os nomes e especialidades de todos os técnicos.
select nome from tecnico;

--Mostre a descrição e o status de todos os chamados registrados.
select descricao from chamado;

--Liste os valores pagos e as datas de pagamento de todos os registros na tabela de pagamentos
select valor_pago, data_pagamento from pagamento;

--Liste os nomes dos clientes e as descrições de seus chamados que estão com o status "Em Andamento"
select nome from chamado join cliente on chamado.cliente_id = cliente.id where chamado.status = 'Andamento';

--Recupere os nomes dos técnicos que realizaram serviços com o tipo "Manutenção"
select nome from tecnico where especialidade = 'Manutenção';

--Mostre os nomes dos clientes e o valor total pago por cada um deles.
select nome, valor_pago from pagamento join cliente on pagamento.cliente_id = cliente.id;
 
--Liste os clientes e os serviços que eles solicitaram, incluindo a descrição do serviço.
select cliente.nome, servico.nome, servico.descricao, servico.tipo_servico from servico join cliente on servico.id = cliente.id;

--Recupere os nomes dos técnicos que realizaram chamados para serviços com o preço superior a 400, e exiba também o nome do serviço.
select tecnico.nome, servico.preco, servico.nome from tecnico, servico where (servico.preco > 400);

--Atualize o preço de todos os serviços do tipo "Manutenção" para 350, se o preço atual for inferior a 350.
select * from servico update servico set preco = 350 where tipo_servico = 'Manutenção' and preco = 350 select * from servico;

--Exclua todos os técnicos que não têm chamados registrados.
select *from tecnico where id not in (select distinct tecnico_id from chamado);