-- member 테이블
create table member(
    id varchar2(20) not null constraint PK_member_id primary key,
    pwd varchar2(20),
    name varchar2(50),
    zipcode varchar2(7) ,
    constraint FK_member_id_tb_zipcode foreign key (zipcode) references tb_zipcode (zipcode),
    address varchar2(20),
    tel varchar2(13),
    indate date default sysdate
);

insert into member 
values ( 'aaa'  , '1234' , '강성민1' , '1111' , 'home1' , '010-1111-1111' , default);

insert into member 
values ( 'bbb'  , '4321' , '강성민2' , '22222' , 'home2' , '010-2222-2222' , default); 

insert into member 
values ( 'ccc'  , '2314' , '강성민3' , '33333' , 'home3' , '010-3333-3333' , '20220420'); 

select * from member;
-----------------------------------------------------------------------------



-- zipcode 테이블
create table tb_zipcode(
    zipcode varchar2(7) not null constraint PK_tb_zipcode_zipcode primary key,
    sido varchar2(30),
    gugum varchar2(30),
    dong varchar2(30),
    bungi varchar2(30)
);

alter table tb_zipcode
add ( ZIP_SEQ varchar2(10) );

alter table tb_zipcode
rename column bungi to bunji;

alter table tb_zipcode
rename column gugum to gugun;

alter table member 
drop constraint FK_member_id_tb_zipcode;

alter table tb_zipcode
drop constraint PK_tb_zipcode_zipcode;

alter table tb_zipcode
modify dong varchar2(100);



insert into tb_zipcode
values ( '11111' , 'aa' , 'bb' , 'cc' , '100');

insert into tb_zipcode
values ( '22222' , 'dd' , 'ee' , 'ff' , '200');

insert into tb_zipcode
values ( '33333' , 'gg' , 'hh' , 'ii' , '300');

select * from tb_zipcode;
-----------------------------------------------------------------------------




--product 테이블
create table products(
    product_code varchar2(20) not null constraint PK_products_product_code primary key , 
    product_name varchar2(100),
    product_kind char(1),
    product_price1 varchar2(10),
    product_price2 varchar2(10),
    product_content varchar2(1000),
    product_image varchar2(50),
    sizeSt varchar2(5),
    sizeEt varchar2(5),
    product_quantity varchar2(5),
    useyn char(1) ,
    indate date
);

insert into products
values ( '1122' , '상품1' , 'a' , '1000' , '2000' , '상품내용1' , '상품이미지1',
         '100' , '150' , '10' , 'y' , sysdate);
         
insert into products
values ( '3344' , '상품2' , 'b' , '2000' , '3000' , '상품내용2' , '상품이미지2',
         '200' , '400' , '20' , 'n' , sysdate);
         
insert into products
values ( '5566' , '상품3' , 'c' , '3000' , '4000' , '상품내용3' , '상품이미지3',
         '300' , '550' , '30' , 'n' , sysdate);         
         
select * from products;
-----------------------------------------------------------------------------


-- orders 테이블
create table orders (
    o_seq number(10) not null constraint  PK_orders_o_seq primary key ,
    
    product_code varchar2(20) ,
    constraint  FK_orders_pd_code_pd foreign key (product_code) 
    references  products (product_code),
    
    id varchar2(16),
    constraint  FK_orders_id_member foreign key (id) references member (id),
    
    product_size varchar2(5) ,
    quantity varchar2(5),
    result char(1),
    indate date 
);

insert into orders
values ( '123456789' , '1122' , 'aaa' , '50' , '3' , 'y' , sysdate);

insert into orders
values ( '987654321' , '3344' , 'bbb' , '200' , '5' , 'n' , sysdate);

insert into orders
values ( '987612345' , '5566' , 'ccc' , '250' , '1' , 'y' , '20220415');

select * from orders;
-----------------------------------------------------------------------------













