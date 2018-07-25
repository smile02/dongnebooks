--users
------------------------------------
create table users(
    nickname varchar2(50) primary key,
    id varchar2(20) not null, --unique설정
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
    values ('관리자','admin','admin','admin@admin.com','010-1234-4321','');

--books
------------------------------------
create table books(
    idx number primary key,  --판매번호
    title varchar2(30) not null, --제목
    nickname varchar2(50) references users(nickname),  --작성자
    comments clob not null, --내용
    regdate date not null, --등록시간
    price number not null, --가격
    status varchar2(60) not null, --책상태
    fee number, --배송비
    photo varchar2(200), --사진
    d_type varchar2(50) not null,  --거래유형
    author varchar2(200), --저자
    b_category varchar2(30) not null, --대분류
    s_category varchar2(30) not null,  --소분류
    deal varchar2(30) not null --거래상태
);

create sequence seq_books_idx;
alter table books modify title varchar2(300);
desc books;
---------------------------------------------------
insert into books
    values (seq_books_idx.nextval, '제목','관리자','내용등록',sysdate,
            10000,'최상',2500,'','택배선불','','IT','프로그래밍','요청 중');


--cart
---------------------------------------
create table cart(
    num number primary key,
    nickname varchar2(50) references users(nickname), --작성자
    address varchar2(200) not null, --주소
    d_type varchar2(50) not null, --거래유형
    status varchar2(30) not null, --거래상태
    idx number references books(idx), --판매번호
    request varchar2(200), --요청사항
    name varchar2(30) --거래자이름
);

desc cart;
create sequence seq_cart_num;
alter table cart add regdate date;
------------------------------------
insert into cart
    values (seq_cart_num.nextval,'관리자','서울시','택배선불','배송 중',1,'','');

--board
----------------------------------------
create table board(
    idx number primary key, --글번호
    title varchar2(300) not null, --제목
    nickname varchar2(50) references users(nickname), --이름
    comments clob not null, --내용
    cnt number not null, --조회수
    regdate date not null, --날짜
    code number not null --분류(공지,일반)
);

create sequence seq_board_idx;
drop sequence seq_board_idx;

----------------------------------------
insert into board
    values(seq_board_idx.nextval, '제목', '관리자','내용',
            100,sysdate,0);
            
commit;

------------------------------------------
--대분류
create table big_category(
    idx number,
    b_name varchar2(30) primary key
);

create sequence seq_big_category_idx;
drop sequence seq_big_category_idx;
drop table big_category;


desc big_category;

---------------------------------------------
--소분류
create table small_category(
    idx number primary key,
    b_bname varchar2(30) references big_category(b_name),
    s_name varchar2(50) not null
);

create sequence seq_small_category_idx;
drop sequence seq_small_category_idx;
drop table small_category;


---------------------------------------------------
--대분류
insert into big_category
    values(seq_big_category_idx.nextval,'IT');
insert into big_category
    values(seq_big_category_idx.nextval,'문학');
insert into big_category
    values(seq_big_category_idx.nextval,'과학');
insert into big_category
    values(seq_big_category_idx.nextval,'사회');
insert into big_category
    values(seq_big_category_idx.nextval,'정치');
insert into big_category
    values(seq_big_category_idx.nextval,'교육');
insert into big_category
    values(seq_big_category_idx.nextval,'기타');
    
    
select * from big_category;
-----------------------------------------------------
--소분류

insert into small_category
    values(seq_small_category_idx.nextval,'IT','웹');
insert into small_category
    values(seq_small_category_idx.nextval,'IT','모바일');
insert into small_category
    values(seq_small_category_idx.nextval,'문학','시');
insert into small_category
    values(seq_small_category_idx.nextval,'문학','소설');
insert into small_category
    values(seq_small_category_idx.nextval,'과학','화학');
insert into small_category
    values(seq_small_category_idx.nextval,'과학','물리');
insert into small_category
    values(seq_small_category_idx.nextval,'사회','현대사회');
insert into small_category
    values(seq_small_category_idx.nextval,'사회','근대사회');

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

--update books set s_category = '웹';

update books set b_category='사회', s_category='근대사회'
    where idx = 62;

commit;

select * from users;   
select * from books;

drop trigger board_nickname_trg;

--pk기준으로 fk업데이트 트리거
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
update users set nickname = '관리자' where nickname = 'admin';

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
