-- Creamos el Schema donde trabajaremos
create schema gabrielcastro;

-- Creamos las tablas y las relaciones

create table gabrielcastro.grupo_empresarial(
	id_empresa serial primary key,
	nombre varchar(50) not null
);

create table gabrielcastro.marca(
	id_marca serial primary key,
	nombre varchar(50) not null,
	grupo_empresarial int not null,
	constraint fk_grupo_empresarial foreign key (grupo_empresarial) references gabrielcastro.grupo_empresarial (id_empresa)
);

create table gabrielcastro.modelo(
	id_modelo serial primary key,
	nombre varchar(50) not null,
	marca int not null,
	constraint fk_marca foreign key (marca) references gabrielcastro.marca (id_marca)
);


create table gabrielcastro.color(
	id_color serial primary key,
	color varchar(30) unique not null
);

create table gabrielcastro.aseguradora(
	id_aseguradora serial primary key,
	aseguradora varchar(20) unique not null
);

create table gabrielcastro.moneda(
	id_moneda serial primary key,
	moneda varchar(6) unique not null
);

create table gabrielcastro.coche(
	id_coche serial primary key,
	matricula varchar(15) not null,
	kilometros int default 0,
	fecha_de_compra date not null,
	numero_de_poliza varchar(50) not null,
	importe decimal(8,2) not null,
	modelo int not null,
	color int not null,
	aseguradora int not null,
	moneda int not null,
	constraint fk_modelo foreign key (modelo) references gabrielcastro.modelo (id_modelo),
	constraint fk_color foreign key (color) references gabrielcastro.color (id_color),
	constraint fk_aseguradora foreign key (aseguradora) references gabrielcastro.aseguradora (id_aseguradora),
	constraint fk_moneda foreign key (moneda) references gabrielcastro.moneda (id_moneda)
);

create table gabrielcastro.revision(
	id_revision serial primary key,
	kilometros int not null,
	importe decimal(8,2) not null,
	fecha date not null,
	coche int not null,
	moneda int not null,
	constraint fk_coche foreign key (coche) references gabrielcastro.coche (id_coche),
	constraint fk_moneda foreign key (moneda) references gabrielcastro.moneda (id_moneda)
);

-- Insertamos valores de prueba
insert into gabrielcastro.grupo_empresarial (nombre) values 
('Volkswagen Group'), 
('Stellantis'), 
('Mercedes Group'), 
('BMW Group');

insert into gabrielcastro.marca (nombre, grupo_empresarial) values
('Volkswagen', 1), 
('Seat', 1), 
('Opel', 2), 
('Citroen', 2),
('Mercedes', 3), 
('BMW', 4);

insert into gabrielcastro.modelo (nombre, marca) values 
('Golf', 1),
('Polo', 1),
('Leon', 2),
('Astra', 3),
('C4', 4),
('Clase C', 5),
('Serie 3', 6);

insert into gabrielcastro.color (color) values
('Rojo'),
('Blanco'),
('Azul'),
('Negro');

insert into gabrielcastro.aseguradora (aseguradora) values
('Mapfre'),
('Zurich'),
('Allianz'),
('Pelayo');

insert into gabrielcastro.moneda (moneda) values
('EUR'),
('USD');

insert into gabrielcastro.coche (matricula, modelo, kilometros, fecha_de_compra, color, aseguradora, numero_de_poliza, importe, moneda) values
('1234 ABC', 1, 120000,  now(), 2, 4, '68880', 150, 1),
('4567 DEF', 2, 80000,  now(), 1, 2, '12567', 120, 2),
('8901 GHI', 3, 190000,  now(), 4, 1, '65980', 200, 1),
('2345 JKL', 4, 95000,  now(), 3, 3, '00237', 135, 2),
('6789 MNÑ', 5, 70000,  now(), 2, 1, '28763', 300, 1),
('1234 OPQ', 6, 340000,  now(), 3, 4, '99937', 500, 2),
('5678 RST', 7, 50000,  now(), 1, 3, '28547', 600, 1);


insert into gabrielcastro.revision (coche, kilometros, fecha, importe, moneda) values
(1, 8000, now(), 60, 1),
(2, 6000, now(), 50, 2),
(3, 5000, now(), 60, 1),
(4, 7000, now(), 40, 2),
(5, 10000, now(), 60, 1),
(6, 13000, now(), 100, 2),
(7, 14000, now(), 120, 2);

-- Querys

select 
	m.nombre as "Nombre modelo",
	ma.nombre as "Nombre marca",
	ge.nombre as "Nombre grupo empresarial",
	c.fecha_de_compra as "Fecha de compra",
	c.matricula as "Matricula",
	col.color as "Color",
	c.kilometros as "Kilometros",
	a.aseguradora as "Aseguradora",
	c.numero_de_poliza as "Numero de poliza"
from gabrielcastro.coche c
join gabrielcastro.modelo m on c.modelo = m.id_modelo
join gabrielcastro.marca ma on m.marca = ma.id_marca 
join gabrielcastro.grupo_empresarial ge on ma.grupo_empresarial = ge.id_empresa
join gabrielcastro.color col on c.color = col.id_color
join gabrielcastro.aseguradora a on c.aseguradora = a.id_aseguradora;

