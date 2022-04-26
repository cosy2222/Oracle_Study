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