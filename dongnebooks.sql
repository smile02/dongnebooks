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

create sequence seq_cart_num;

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

----------------------------------------
insert into board
    values(seq_board_idx.nextval, '����', '������','����',
            100,sysdate,0);
            
commit;

select * from users;
select * from books;
select * from cart;
select * from board;

