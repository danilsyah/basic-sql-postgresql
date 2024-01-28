# Akses postgreSQL via Terminal
$ psql --host=localhost --port=5432 --dbname=postgres --username=postgres --password
$ psql --host=localhost --port=5432 --dbname=db_test --username=postgres --password

--# melihat daftar DB
postgres=# \l
 or
postgres=# select datname from pg_database;

--# membuat database baru
postgres=# create database nama_database;

--# menghapus database
postgres=# drop database nama_database;

--# menggunakan database
postgres=# \c nama_database;

-- menampilkan seluruh tabel 
db_belajar=# \d

-- menampilkan tabel secara spesific
db_belajar=# \d barang

-- menampilkan sequence
db_belajar=# \ds

drop database db_test;

select * from pg_tables where schemaname = 'public';

drop table barang 

--membuat table 
create table barang(
	kode int not null primary key,
	nama varchar(100) not null,
	harga int not null default 0,
	jumlah int not null default 0,
	waktu_dibuat timestamp not null default current_timestamp
);

--menambahkan kolom baru pada table yang sudah ada 
alter table barang 
	add column deskripsi text;


--menghapus kolom pada tabel
alter table barang 
	drop column deskripsi;


--rename nama kolom
alter table barang 
	rename column "nama_brg" to nama;

select * from barang;

--menghapus tabel
drop table barang

create table products(
	id varchar(10) not null,
	name varchar(100) not null,
	description text,
	price int not null,
	quantity int not null default 0,
	created_at timestamp not null default current_timestamp
)

--menambahkan data ke tabel products 
insert into products (id, name, price, quantity) 
values ('P0001', 'Mie ayam original', 15000, 100);

insert into products (id, name, description, price, quantity)
values ('P0002', 'Mie ayam bakso', 'Mie ayam + Bakso', 20000, 50);

insert into products (id, name, price, quantity)
values 	('P0003', 'Mie Yamin', 18000, 30),
		('P0004', 'Mie Jebew', 8000, 60),
		('P0005', 'Mie Gacoan', 10000, 20);
	
insert into products (id, name, price, quantity,category)
values 	('P0007', 'Es teh tawar', 7000, 30, 'Minuman'),
		('P0008', 'Es teh manis', 8000, 15,'Minuman'),
		('P0009', 'Es campur', 10000, 10, 'Minuman'),
		('P0010', 'Es cendol', 12000, 7, 'Minuman');

--get data products 
select * from products;

select id, name, quantity, price, created_at  from products p ;

--menambahkan primary key pada kolom
alter table products add primary key (id);

--where clause
select id, name, price, quantity
from products p 
where price = 20000;

select * 
from products p
where id = 'P0003';


--menambahkan kolom type enum
create type PRODUCT_CATEGORY as enum ('Makanan', 'Minuman', 'Lain-Lain');

alter table products add column category PRODUCT_CATEGORY;

select * from products p 

--update data pada kolom
 update products 
 set category = 'Makanan'
 where id = 'P0001';

update products 
set description = 'Mie dengan level ke pedasan extra',
	price = price + 3000
where id = 'P0004';

--delete data by id 
insert into products (id, name, price, quantity, category)
values ('P0006', 'teh botol', 4000, 2, 'Minuman');

delete from products 
where id = 'P0006';

--membuat alias pada kolom
select 	id as "Kode Barang", 
		price as "Harga Barang", 
		description as "Deskripsi Barang"
from products;

--membuat alias pada tabel
select p.id as Kode,
		p.price  as Harga,
		p."name" as Nama,
		p.quantity as Jumlah,
		p.category as "Kategori Barang"
from products as p; 

--where clause operator
--operator perbandingan

select * from products where price > 10000;

select * from products where price < 10000;

select * from products where category != 'Makanan';

select * from products where category = 'Makanan';

select * from products where quantity <= 50;

select * from products where quantity >= 50;

--operator logika

select * from products where price > 10000 and category = 'Minuman';

select * from products where price > 10000 or category = 'Makanan';

--prioritas dengan kurung ()

select * from products
where (quantity > 100 or category = 'Makanan') and price > 15000;


--operator like dan ilike
--like = case sensitive 
--ilike = not case sensitive

select * from products where name ilike '%mie%';

select * from products where name like 'Mie%';

select * from products where name ilike '%campur';

--operator null

select * from products where description is null;

select * from products where description is not null;

--operator between 

select * from products where price between 10000 and 20000;

select * from products where price not between 10000 and 20000;

--operator in
insert into products (id, name, price, quantity, category)
values	('P0011', 'Mangkuk', 3000, 10, 'Lain-Lain'),
		('P0012', 'Sendok', 2000, 10, 'Lain-Lain');
	
select *
from products 
where category in ('Makanan', 'Minuman');

--order by mengurutkan kolom

select * from products order by price asc, id desc ;

--limit data yang di tampilkan

select * from products where price > 10000 order by price asc, id desc limit 2;

select * from products order by id asc limit 2 offset 2;

select * from products where price > 10000 order by price asc, id desc limit 2 offset 2;

--menghilangkan data duplicate

select distinct category from products;

select distinct price from products;

--arithmetic operator

select 10 + 10 as jumlah, 30 - 2 as kurang, 50 / 2 as bagi, 5 * 5 as kali;

select id, name, price / 1000 as price_in_k from products;

--menggunakan mathematical function

select power(10, 2) as result; --pangkat

select pi();

select cos(10), sin(10), tan(10);

select id, name, power(quantity, 2) as quantity_pangkat_2 from products;  

--membuat tabel dengan auto increment

create table admin(
	id serial not null primary key,
	first_name varchar(100) not null,
	last_name varchar(100)
);

insert into admin(first_name, last_name)
values ('danil', 'syah'),
		('haykal', 'dafiansyah'),
		('nufika', 'fitriani');
	
select * from "admin" ;
select currval('admin_id_seq');

--sequence 
-- adalah fitur dimana kita bisa membuat function auto increment
-- saat menggunakan tipe data SERIAL pada primary key, secara otomatis PostgreSQL akan
-- membuat Sequence dan memanggil function sequence nya sebagai default value untuk Primary Key nya

create sequence contoh_sequence;

select nextval('contoh_sequence');

select currval('contoh_sequence'); 

select * from contoh_sequence;

--menggunakan string function

select id, lower(name), length(name), lower(description) from products;

select id, upper(name), upper(description) from products order by name asc; 

select age(current_timestamp, '1994-10-15') as umurku;

select * from products ;

select
	id,
	extract(year from created_at) as Tahun, 
	extract(month from created_at) as Bulan, 
	extract(day from created_at) as Tanggal, 
	extract(hour from created_at) as Jam 
from products;


--flow control

select 	id,
		category,
		case category
			when 'Makanan' then 'Enak'
			when 'Minuman' then 'Segerrr'
			else 'Apa itu ?'
		end as category_case
from products;

select 	id,
		price,
		case
			when price <= 15000 then 'Murah'
			when price <= 20000	then 'Mahal'
			else 'Mahal Banget'
		end as Harga
from products;

select 	id,
		name,
		case
			when description is null then 'Kosong'
			else description
		end as description
from products;
		

--aggregate function 

select count(id) as jumlah from products;

select avg(price) as "rata-rata harga" from products;

select max(price) as "harga termahal" from products;

select min(price) as "harga termurah" from products;

select sum(price) as total from products;

--group by
--menggunakan group by harus ada aggregate function

select 	category,
		count(id) as total_produk
from products 
group by category;

select category,
		avg(price) as "Rata Rata Harga",
		min(price) as "Harga Termurah",
		max(price) as "Harga Termahal",
		sum(price) as "Total Harga"
from products 
group by category;

--having clause
--fungsi nya untuk melakukan filter terhadap data yang sudah di grouping

select 	category, 
		count(id) as "Total Product"
from products 
group by category 
having count(id) > 3;

select category,
		avg(price) as "Rata Rata Harga",
		min(price) as "Harga Termurah",
		max(price) as "Harga Termahal",
		sum(price) as "Total Harga"
from products 
group by category
having avg(price) >= 10000;

select
	extract (day from created_at) as tanggal,
	count(id) as total_products
from products 
group by extract(day from created_at);
		


--contraint unique

create table customer
(
	id serial not null,
	email varchar(100) not null,
	first_name varchar(100) not null,
	last_name varchar(100),
	primary key(id),
	constraint unique_email unique (email)
);

insert into customer (email, first_name, last_name)
	values ('danil@gmail.com', 'danil', 'syah');

select * from customer;

insert into customer (email, first_name, last_name)
	values ('danil@gmail.com', 'haykal', 'dafiansyah'); 

insert into customer (email, first_name, last_name)
	values 	('ucup@gmail.com', 'ucup', 'markucup'),
			('budi@gmail.com', 'budi', 'aja'),
			('fika@gmail.com', 'fika', 'nufika');
-- gagal menambahkan data karena email sudah ada 	

alter table customer
	drop constraint unique_email;

alter table customer
	add constraint unique_email unique (email);

--contraint check
--mengecek suatu nilai sebelum di proses

create table products(
	id varchar(10) not null,
	name varchar(100) not null,
	description text,
	price int not null,
	quantity int not null default 0,
	created_at timestamp not null default current_timestamp,
	primary key (id),
	contraint price_check check (price > 1000)
)

--menambahkan contraint pada table yang sudah ada 
alter table products
	add constraint quantity_check check (quantity >= 0);

alter table products 
	add constraint price_check check (price >= 0);

insert into products (id, name, price, quantity, category)
values ('P0012', 'Contoh Gagal', -1000, 2, 'Makanan');

insert into products (id, name, price, quantity, category)
values ('P0012', 'Contoh Gagal', 1000, -2, 'Makanan');

insert into products (id, name, price, quantity, category)
values ('P0013', 'Teh Botol', 1000, 2, 'Minuman');

select * from products 

--index 
-- index mungkin akan mempercepat untuk proses pencarian query data
-- saat membuat index, postgres akan melakukan proses update data di index
-- tiap kali menambahkan, mengubah, atau menghapus data di tabel
-- artinya index membuat proses pencarian dan query lebih cepat, tapi memperlambat proses
-- manipulasi data (insert, update, delete).
-- saat membuat primary key, unique constraint, secara otomatis menambahkan index pada kolom tersebut.

create table sellers
(
	id serial not null,
	name varchar(100) not null,
	email varchar(100) not null,
	primary key(id),
	constraint email_unique unique (email)
);

insert into sellers (name, email)
values ('Galeri olahraga', 'galeri@mail.com'),
		('Toko danil', 'danil@mail.com'),
		('Toko udin', 'udin@mail.com'),
		('Toko haykal', 'haykal@mail.com'),
		('Toko ucup', 'ucup@mail.com');

-- membuat index lebih dari 1 kolom
create index sellers_id_and_name_index on sellers(id, name);
create index sellers_email_and_name_index on sellers(email, name);
create index sellers_name_index on sellers(name);

select * from sellers where id = 1; -- menggunakan index
select * from sellers where id = 1 or name = 'Toko danil'; -- menggunakan index
select * from sellers where email = 'danil@mail.com'; -- menggunakan index

--full text search

--tanpa index 
select * from products 
where to_tsvector(name) @@ to_tsquery('mie');

--membuat full-text search index
select cfgname from pg_ts_config;

create index products_name_search on products using gin (to_tsvector('english', name));

create index products_description_search on products using gin (to_tsvector('english', description));

-- drop index
drop index products_name_search;
drop index products_description_search;

-- mencari menggunakan full-text search index

select *
from products 
where name @@ to_tsquery('mie'); 

select * 
from products 
where description @@ to_tsquery('mie');

-- operator full-text search 

select *
from products 
where name @@ to_tsquery('''mie ayam'''); -- semua data

select *
from products 
where name @@ to_tsquery('mie & bakso'); -- and

select *
from products 
where name @@ to_tsquery('mie | es'); -- or

select *
from products 
where name @@ to_tsquery('!mie'); -- not 


-- membuat tabel dengan foreign key

create table wishlist
(
	id		serial not null,
	id_product varchar(10) not null,
	description text,
	primary key (id),
	constraint fk_wishlist_product foreign key (id_product) references products(id)
);

select * from wishlist 

-- menambah foreign key pada table yang sudah ada
alter table wishlist
	add constraint fk_wishlist_product foreign key (id_product) references products(id);

-- menghapus foreign key
alter table wishlist 
	drop constraint fk_wishlist_product;

select * from products ;

insert into wishlist (id_product, description)
values 	('P0001','Mie ayam kesukaanku'),
		('P0002','Mie ayam kesukaanku'),
		('P0003','Mie ayam kesukaanku'),
		('P0004','Mie ayam kesukaanku');
	
select * from wishlist ;

select currval('wishlist_id_seq') 

-- behavior foreign key
-- restrict (default)
	-- on delete = ditolak
	-- on update = ditolak
-- cascade 
	-- on delete = data akan dihapus
	-- on update = data akan ikut diubah
-- no action
	-- on delete = data dibiarkan
	-- on update = data dibiarkan
-- set null
	-- on delete = diubah jadi null
	-- on update = diubah jadi null
-- set default
	-- on delete = diubah jadi default value
	-- on update = diubah jadi default value

--mengubah behavior fk id_product jadi cascade

alter table wishlist
drop constraint fk_wishlist_product;

alter table wishlist
add constraint fk_wishlist_product foreign key (id_product) references products(id)
on delete cascade on update cascade;

select * from wishlist 

delete from products where id = 'P0004';

update products set id = 'P1231' where id = 'P0001';


-- JOIN
-- idealnya melakukan join jangan lebih dari 5 tabel, karena itu bisa berdampak ke performa query yang lambat
-- semakin banyak join, maka proses query akan semakin berat dan lambat, jadi harap bijak ketika melakukan join

select *
from wishlist
join products on wishlist.id_product = products.id;

select p.id, p.name, w.description
from wishlist as w
join products as p on w.id_product = p.id;


--membuat relasi ke tabel customers

alter table wishlist
	add column id_customer int;

--membuat foreign key id_customer
alter table wishlist 
	add constraint fk_wishlist_customer foreign key (id_customer) references customer (id);


update wishlist 
set id_customer = 1
where id in (6,7);

update wishlist 
set id_customer = 3
where id = 5;

select * from wishlist w ;

select * from customer c ;

-- join lebih dari 1 tabel
select w.id, p."name", p.price, c.first_name, c.email 
from wishlist as w
join products as p on w.id_product = p.id 
join customer as c on w.id_customer = c.id ;

-- one to one relationship
create table wallet
(
	id serial not null,
	id_customer int not null,
	balance int not null default 0,
	primary key(id),
	constraint wallet_customer_unique unique (id_customer),
	constraint fk_wallet_customer foreign key (id_customer) references customer (id)
);

select * from wallet;

select * from customer c ;

insert into wallet(id_customer, balance)
values 	('1', 150000),
		('3', 250000),
		('5', 350000),
		('4', 550000);
	
select 
	wallet.id, 
	customer.first_name, 
	customer.last_name, 
	customer.email,
	wallet.balance  
from customer
join wallet on wallet.id_customer = customer.id 

-- one to many relationship
create table categories
(
	id varchar(10) not null,
	name varchar(100) not null,
	primary key (id)
);

insert into categories (id, name)
values ('C001', 'makanan'),
		('C002', 'minuman');

insert into categories (id, name)
values ('C003', 'Lain-lain');

select * from categories;

alter table products 
	drop column category;

alter table products
	add column id_category varchar(10);

alter table products 
	add constraint fk_product_category foreign key (id_category) references categories (id);
	
select * from products p 

update products 
set id_category = 'C001'
where name ilike '%mie%';

update products 
set id_category = 'C002'
where name ilike 'es%' or name ilike 'teh%';


update products 
set id_category = 'C003'
where name = 'Sendok'

select * from products
join categories on products.id_category = categories.id;


-- many to many relationship
-- membuat satu tabel relasi untuk penghubung antar tabel 

create table orders 
(
	id 			serial not null,
	total		int not null,
	order_date 	timestamp not null default current_timestamp,
	primary key (id)
);

select * from orders;

create table orders_detail
(
	id_product 		varchar(10) not null,
	id_order 		int not null,
	price			int not null,
	quantity		int not null,
	primary key (id_product, id_order)
);


select * from orders_detail;

alter table orders_detail
	add constraint fk_orders_detail_product foreign key (id_product) references products (id);

alter table orders_detail 
	add constraint fk_orders_detail_order foreign key (id_order) references orders (id);

insert into orders (total) 
values (1),
		(1),
		(1);
	
select * from  orders;

select * from products order by id;

insert into orders_detail (id_product, id_order, price, quantity)
values	('P0002', 1, 5000, 1),
		('P0003', 1, 13000,2),
		('P0006', 1, 8000, 2),
		('P0007', 2, 5000, 1),
		('P0008', 2, 13000,2),
		('P0006', 2, 8000, 2),
		('P0002', 3, 5000, 1),
		('P1231', 3, 15000,1),
		('P0006', 3, 8000, 2);
	
select * from orders_detail ;

select *
from orders 
join orders_detail on orders_detail.id_order = orders.id
join products on orders_detail.id_product = products.id;

select *
from orders 
join orders_detail on orders_detail.id_order = orders.id
join products on orders_detail.id_product = products.id
where orders.id = 1;

-- jenis - jenis join

-- inner join

select * from categories c 

insert into categories (id, name) 
values ('C004', 'Gadget'),
		('C005', 'Pulsa'),
		('C006', 'Laptop');

insert into products (id, name, price, quantity)
values 	('X0001', 'contoh 1', 1000, 10),
		('X0002', 'contoh 2', 1000, 10);
	
select * from products p 
	
select * from categories
inner join products on products.id_category = categories.id;
	
	
--left join

select *
from categories
left join products on products.id_category = categories.id;

-- right join

select *
from categories
right join products on products.id_category = categories.id;

-- full join

select *
from categories
full join products on products.id_category = categories.id;


-- subquery di where clause

select * 
from products
where price > (select avg(price) from products);

-- subquery di from clause
-- contoh mencari max price dari product yang memiliki data relasi category

select max(price)
from (select products.price as price
		from categories 
		join products on products.id_category = categories.id) as contoh;
	
	
--set operator
-- postgresql mendukung operator set, dimana ini adalah operasi antara hasil dari dua SELECT query,
	-- ada banyak jenis operator Set, yaitu :
	-- UNION
	-- UNION ALL
	-- INTERSECT 
	-- EXCEPT

create table guestbooks
(
	id 		serial not null,
	email 	varchar(100) not null,
	title 	varchar(100) not null,
	content text,
	primary key (id)
);

select * from customer;

insert into guestbooks(email, title, content)
values 	('danil@gmail.com', 'feedback danil', 'ini feedback danil'),
		('danil@gmail.com', 'feedback danil', 'ini feedback danil'),
		('ucup@gmail.com', 'feedback ucup', 'ini feedback ucup'),
		('budi@gmail.com', 'feedback budi', 'ini feedback budi'),
		('budi@gmail.com', 'feedback budi', 'ini feedback budi'),
		('haykal@gmail.com', 'feedback haykal', 'ini feedback haykal'),
		('haykal@gmail.com', 'feedback haykal', 'ini feedback haykal');

select * from guestbooks;	

-- Union
-- Union adalah operasi menggabungkan dua buah select query, dimana jika terdapat data
-- yang duplikat, data duplikatnya akan dihapus dari hasil query.

select distinct email from customer
union
select distinct email from guestbooks;

-- UNION ALL
-- adalah operasi yang sama dengan Union, namun data duplikat tetap akan ditampilkan di hasil query nya

select distinct email from customer
union all
select distinct email from guestbooks;

select email from customer
union all
select email from guestbooks;

select email, count(email) as total
from (select email
		from customer 
		union all
		select email 
		from guestbooks) as jumlah_email
group by email;

-- intersect 
-- adalah operasi menggabungkan dua query, namun yang di ambil hanya data 
-- yang terdapat pada hasil query pertama dan query kedua
-- data yang tidak ada di salah satu query akan dihapus di hasil query operasi intersect
-- data nya muncul tidak dalam keadaan duplikat

-- contoh menampilkan email customer yang mengisi questbook

select email from customer 
intersect
select email from guestbooks;

-- except
-- adalah operasi dimana query pertama akan dihilangkan oleh query kedua
-- artinya jika ada data query pertama yang sama dengan data yang ada di query kedua, 
-- maka data tersebut akan dihapus dari hasil query EXCEPT

-- contoh menampilkan data email customer yang belum pernah mengisi guestbooks

select email from customer 
except
select email from guestbooks;

-- Transaction
-- menyimpan proses data sementara, tidak langsung simpan ke tabel secara permanen
start transaction;

insert into guestbooks (email, title, content)
values ('transaction@mail.com', 'transaction', 'transaction');

insert into guestbooks (email, title, content)
values ('transaction2@mail.com', 'transaction 2', 'transaction 2');

insert into guestbooks (email, title, content)
values ('transaction3@mail.com', 'transaction 3', 'transaction 3');

insert into guestbooks (email, title, content)
values ('transaction4@mail.com', 'transaction 4', 'transaction 4');

insert into guestbooks (email, title, content)
values ('transaction5@mail.com', 'transaction 5', 'transaction 5');
	
select * from guestbooks;

-- sebelum menjalankan perintah commit , maka user lain tidak akan melihat data yang ditambahkan
commit; -- menyimpan proses transaksi ke database

-- contoh transaksi rollback
-- membatalkan semua proses transaksi
start transaction;

insert into guestbooks (email, title, content)
values ('transaction@mail.com', 'transaction', 'rollback');

insert into guestbooks (email, title, content)
values ('transaction2@mail.com', 'transaction 2', 'rollback 2');

insert into guestbooks (email, title, content)
values ('transaction3@mail.com', 'transaction 3', 'rollback 3');

insert into guestbooks (email, title, content)
values ('transaction4@mail.com', 'transaction 4', 'rollback 4');

insert into guestbooks (email, title, content)
values ('transaction5@mail.com', 'transaction 5', 'rollback 5');
	
select * from guestbooks;

rollback; -- batalkan proses insert

-- Locking Record
-- jika ada user yang melakukan perubahan data, maka data tersebut akan di lock, 
-- dan user lain harus menunggu sampai di lakukan commit atau rollback oleh user tersebut.
-- data akan di lock sampai melakukan commit atau rollback transaksi tersebut

-- contoh melakukan update data pada tabel products

select * from products p where id='P0003';

start transaction;

update products
set description = 'Mantappppp euyyy'
where id = 'P0003';	
	
commit;

-- Locking record manual

start transaction;

select * from products p where id = 'P0003' for update;

rollback;
	
-- DEADLOCK
-- saat kita terlalu banyak melakukan proses LOCKING, hati-hati akan masalah yang muncul 
-- yaitu Deadlock.
-- deadlock adalah situasi ada 2 proses yang saling menunggu satu sama lain, namun data yang
-- ditunggu dua-duanya di lock oleh proses lainnya, sehingga proses menunggunya ini tidak akan
-- pernah selesai.

-- contoh simulasi DEADLOCK
-- Proses 1 melakukan select for update untuk data 001
-- Proses 2 melakukan select for update untuk data 002
-- Proses 1 melakukan select for update untuk data 002, diminta menunggu karena dilock oleh proses 2
-- Proses 2 melakukan select for update untuk data 001, diminta menunggu karena dilock oleh proses 1
-- Akhirnya Proses 1 dan Proses 2 saling menunggu
-- Deadlock pun terjadi.

start transaction;

select * from products where id = 'P0003' for update;

select * from products where id = 'P0002' for update;

rollback


-- schema 
-- saat membuat database di Postgresql, secara otomatis terdapat schema bernama public
-- dan saat kita membuat table, secara otomatis kita akan membuat table terssebut di schema public.

-- melihat schema saat ini

select current_schema();

show search_path;

-- membuat dan menghapus schema

create schema contoh;

drop schema contoh;

-- pindah schema

set search_path to contoh;

show search_path;

select current_schema();

-- select tab;e pada schema public
select * from public.products;

--membuat table pada schema contoh
create table contoh.products
(
	id serial not null,
	name varchar(100) not null,
	primary key (id)
);

select * from contoh.products;

set search_path to public;

insert into contoh.products (name)
values 	('iphone'),
		('Play Station');
	
select * from contoh.products;

select * from public.products;


-- Management User

-- membuat user baru
create role danil with login encrypted password 'developer123'; 

create role haykal;

-- alter role user

alter role haykal login encrypted password 'rahasia';

-- hapus user role 

drop role danil;

drop role haykal;

-- menambah hak akses ke user

grant insert, update, select on all tables in schema public to danil;

grant usage, select, update on guestbooks_id_seq to danil;

grant select on customer to haykal;

-- menghapus hak akses ke user

revoke insert, update, select on all tables in schema public from danil;

revoke select on customer from haykal;

-- backup database 

-- jalankan perintah berikut ini pada terminal 
pg_dump --host=localhost --port=5432 --dbname=db_belajar --username=postgres --format=plain --file=/home/danil/backup_`date +%Y%m%d`.sql


-- restore database
create database belajar_restore;
	
psql --host=localhost --port=5432 --dbname=belajar_restore --username=postgres --file=/home/danil/backup_20240127.sql	
	
	
	
	
		
