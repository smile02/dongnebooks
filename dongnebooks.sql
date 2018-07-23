--users
------------------------------------
create table users(
    nickname varchar2(50) primary key,
    id varchar2(20) not null, --unique����
    password varchar2(20) not null,
    email varchar2(50) not null,
    phone varchar2(20),
    address varchar2(20)    
);

desc users;
alter table users add constraint uni_id unique(id);
alter table users modify address varchar2(200);
alter table users modify password varchar2(70);
--name varchar2(30) not null

-------------------------
insert into users 
    values ('������','admin','admin','admin@admin.com','010-1234-4321','');

--books
------------------------------------
create table books(
    idx number primary key,  --�ǸŹ�ȣ
    title varchar2(30) not null, --����
    nickname varchar2(50) references users(nickname),  --�ۼ���
    comments clob not null, --����
    regdate date not null, --��Ͻð�
    price number not null, --����
    status varchar2(60) not null, --å����
    fee number, --��ۺ�
    photo varchar2(200), --����
    d_type varchar2(50) not null,  --�ŷ�����
    author varchar2(200), --����
    b_category varchar2(30) not null, --��з�
    s_category varchar2(30) not null,  --�Һз�
    deal varchar2(30) not null --�ŷ�����
);

create sequence seq_books_idx;
alter table books modify title varchar2(300);
desc books;
---------------------------------------------------
insert into books
    values (seq_books_idx.nextval, '����','������','������',sysdate,
            10000,'�ֻ�',2500,'','�ù輱��','','IT','���α׷���','��û ��');


--cart
---------------------------------------
create table cart(
    num number primary key,
    nickname varchar2(50) references users(nickname), --�ۼ���
    address varchar2(200) not null, --�ּ�
    d_type varchar2(50) not null, --�ŷ�����
    status varchar2(30) not null, --�ŷ�����
    idx number references books(idx), --�ǸŹ�ȣ
    request varchar2(200), --��û����
    name varchar2(30) --�ŷ����̸�
);

desc cart;
create sequence seq_cart_num;
alter table cart add regdate date;
------------------------------------
insert into cart
    values (seq_cart_num.nextval,'������','�����','�ù輱��','��� ��',1,'','');

--board
----------------------------------------
create table board(
    idx number primary key, --�۹�ȣ
    title varchar2(300) not null, --����
    nickname varchar2(50) references users(nickname), --�̸�
    comments clob not null, --����
    cnt number not null, --��ȸ��
    regdate date not null, --��¥
    code number not null --�з�(����,�Ϲ�)
);

create sequence seq_board_idx;
drop sequence seq_board_idx;

----------------------------------------
insert into board
    values(seq_board_idx.nextval, '����', '������','����',
            100,sysdate,0);
            
commit;

------------------------------------------
--��з�
create table big_category(
    idx number,
    b_name varchar2(30) primary key
);

create sequence seq_big_category_idx;
drop sequence seq_big_category_idx;
drop table big_category;


desc big_category;

---------------------------------------------
--�Һз�
create table small_category(
    idx number primary key,
    b_bname varchar2(30) references big_category(b_name),
    s_name varchar2(50) not null
);

create sequence seq_small_category_idx;
drop sequence seq_small_category_idx;
drop table small_category;


---------------------------------------------------
--��з�
insert into big_category
    values(seq_big_category_idx.nextval,'IT');
insert into big_category
    values(seq_big_category_idx.nextval,'����');
insert into big_category
    values(seq_big_category_idx.nextval,'����');
insert into big_category
    values(seq_big_category_idx.nextval,'��ȸ');
insert into big_category
    values(seq_big_category_idx.nextval,'��ġ');
insert into big_category
    values(seq_big_category_idx.nextval,'����');
insert into big_category
    values(seq_big_category_idx.nextval,'��Ÿ');
    
    
select * from big_category;
-----------------------------------------------------
--�Һз�

insert into small_category
    values(seq_small_category_idx.nextval,'IT','��');
insert into small_category
    values(seq_small_category_idx.nextval,'IT','�����');
insert into small_category
    values(seq_small_category_idx.nextval,'����','��');
insert into small_category
    values(seq_small_category_idx.nextval,'����','�Ҽ�');
insert into small_category
    values(seq_small_category_idx.nextval,'����','ȭ��');
insert into small_category
    values(seq_small_category_idx.nextval,'����','����');
insert into small_category
    values(seq_small_category_idx.nextval,'��ȸ','�����ȸ');
insert into small_category
    values(seq_small_category_idx.nextval,'��ȸ','�ٴ��ȸ');

commit;
-----------------------------------------------------
    
select * from users;
select * from books;
select * from cart;
select * from board;
select * from big_category;
select * from small_category;
select * from reply;
delete from users ;
desc board;

update users set
    password='989099e0edc9f04a2a06e3c5e4b5b56d04aed5e23973513d83068ee0cc76e0a9', email='dongnebooks21@gmail.com'
        where id='admin';
commit;

delete from books where idx != 1;

--update books set s_category = '��';

update books set b_category='��ȸ', s_category='�ٴ��ȸ'
    where idx = 62;

commit;

select * from users;   
select * from books;

drop trigger board_nickname_trg;

--pk�������� fk������Ʈ Ʈ����
create or replace trigger nickname_trg
 after update of nickname on users for each row
begin
   update books
   set nickname=:new.nickname
   where nickname=:old.nickname;
   update board
   set nickname=:new.nickname
   where nickname=:old.nickname;
   update cart
   set nickname=:new.nickname
   where nickname=:old.nickname;
end;

select * from cart;
select * from users;
select * from board;
select * from books;
update users set nickname = '������' where nickname = 'admin';

update books set deal = 'sale'
    where idx = 81;
commit;


update cart set status='deal' where num=23;

select * from 
    cart c, (select idx, title from books where nickname='test') b 
        where c.idx = b.idx;

delete from board;

select * from board;
select * from reply;

commit;


create or replace trigger nickname_trg
 after update of nickname on users for each row
begin
   update books
   set nickname=:new.nickname
   where nickname=:old.nickname;
   update board
   set nickname=:new.nickname
   where nickname=:old.nickname;
   update cart
   set nickname=:new.nickname
   where nickname=:old.nickname;
   update reply
   set nickname=:new.nickname
   where nickname=:old.nickname;
   update comments
   set nickname=:new.nickname
   where nickname=:old.nickname;
end;
