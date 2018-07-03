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

create sequence seq_cart_num;

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

----------------------------------------
insert into board
    values(seq_board_idx.nextval, '제목', '관리자','내용',
            100,sysdate,0);
            
commit;

select * from users;
select * from books;
select * from cart;
select * from board;

