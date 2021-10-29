/**
Sistema para gestao de uma assistencia tecnica de computadores e perifericos.
@author Daniel dias
*/


drop database dbinfox;
create database dbinfox;
use dbinfox;

create table usuario(
id int primary key auto_increment,
usuario varchar(50) not null,
login varchar(50) not null unique,
senha varchar(250) not null,
perfil varchar(50) not null
);

-- a linha abaixo insere uma senha com criptografia 
insert into usuario(usuario,login,senha,perfil)
values('Daniel dias','admin',md5('123456'),'Administrador');
insert into usuario(usuario,login,senha,perfil)
values('Lionel messi','Messi',md5('12345'),'Usuario');
insert into usuario(usuario,login,senha,perfil)
values('Juca','Juquinha',md5('12345'),'Usuario');

select * from usuario;
select * from usuario where id=1;
-- selecionando o usuario e sua senha (tela login)
select * from usuario where login='admin' and senha=md5('123456');

select id,usuario,login,perfil  from usuario where usuario like "d%";

update usuario set login='o melhor',senha=md5('1234'), perfil='operador' where id=2;

delete from usuario where id=3;
drop table usuario;
-- char (tipo de dados que aceita uma String de caracteres nao variaveis)
create table clientes(
idcli int primary key auto_increment,
nome varchar(50) not null,
cep char(8),
endereco varchar(50) not null,
numero varchar(12) not null,
completemento varchar(30),
bairro varchar(50) not null,
cidade varchar(50) not null,
uf char(2) not null,
fone varchar(50) not null);

alter table clientes change completemento complemento varchar(30);
select idcli as ID,nome as Clientes,cep,endereco,numero,complemento,bairro,cidade,uf,fone from clientes where nome like "r%";
update clientes set nome='Joaquim silva',cep=03477000,endereco='rua engenheiro gui. cris. frender',numero=1145,complemento='apt 35',bairro='vila antonieta',cidade='sao paulo',uf='SP',fone='12345678' where idcli=4;


insert into clientes(nome,cep,endereco,numero,complemento,bairro,cidade,uf,fone)
values('Romario',03477000,'rua lala',1313,'apt 32 t1','vila antonieta','sao paulo','SP',0000-0000);

insert into clientes(nome,cep,endereco,numero,complemento,bairro,cidade,uf,fone)
values('Rodrigo',09876543,'rua lele',4545,'apt 42 t1','vila dada','sao paulo','SP',0000-0000);

insert into clientes(nome,cep,endereco,numero,complemento,bairro,cidade,uf,fone)
values('Rubens',12345678,'rua lolo',1234,'apt 62 t1','tatu','sao paulo','SP',0000-0000);

insert into clientes(nome,cep,endereco,numero,complemento,bairro,cidade,uf,fone)
values('Leo',00000000,'rua cuca',2424,'casa 3','vila tostoo','sao paulo','SP',0000-0000);

insert into clientes(nome,cep,endereco,numero,complemento,bairro,cidade,uf,fone)
values('Daniel',09871234,'Rua que sobe e desce',1111,'apt56 bloco 8','vila mariana','sao paulo','SP',0000-0000);

select * from clientes;

-- foreign key (FK) cria um relacionamento de um para muitos (clientes - tbos)
create table tbos(
os int primary key auto_increment,
dataos timestamp default current_timestamp,
tipo varchar(20) not null,
osstatus varchar(30) not null,
equipamento varchar(200) not null,
defeito varchar(200) not null,
tecnico varchar(50),
valor decimal(10,2),
idcli int not null,
foreign key (idcli) references clientes(idcli)
);
describe tbos;

insert into tbos (tipo,osstatus,equipamento,defeito,idcli)
values('orçamento','bancada','Notebook Lenovo G90','Nao liga',1);

insert into tbos (tipo,osstatus,equipamento,defeito,tecnico,valor,idcli)
values('orçamento','aguardando aprovação','impresora hp2020','Papel enroscando','Robson','60',1);

insert into tbos (tipo,osstatus,equipamento,defeito,tecnico,valor,idcli)
values('serviço','retirado','PC positivo 2010','Travando muito','Leandro','50',3);

insert into tbos (tipo,osstatus,equipamento,defeito,tecnico,valor,idcli)
values('orçamento','aguardando aprovação','Notebook samsung chromebook','tela quebrada','Sirlene','100',4);

insert into tbos (tipo,osstatus,equipamento,defeito,tecnico,valor,idcli)
values ('serviço','retirado','PC Dell','trocar memoria','Leandro','150',5);


select * from tbos;



-- (inner join) uniao de tabelas relacionadas para consultas e updates
-- relatorio 1 
select * from tbos inner join clientes
on tbos.idcli = clientes.idcli;

-- relatorio 2
select tbos.equipamento,tbos.defeito,tbos.osstatus as status_os,tbos.valor,
clientes.nome,clientes.fone from  tbos inner join clientes on tbos.idcli = clientes.idcli where osstatus = 'aguardando aprovação';

-- relatorio 3 (os,data formatada(dia,mes,ano),equipamento
-- defeito, valor, nome do cliente, filtrando por retirado

select tbos.os,date_format(dataos,'%d/%m/%Y -%H:%i') as data_os,tbos.equipamento,tbos.defeito,tbos.valor,clientes.nome  as cliente from tbos inner join clientes on tbos.idcli = clientes.idcli where osstatus = 'retirado';


-- relatorio 4 
select sum(valor) as faturamento from tbos where osstatus = 'retirado';