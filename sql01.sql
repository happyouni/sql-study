create database my_shop; -- 데이터베이스 생성 
use my_shop; -- 사용 
-- 테이블정의(설계) : 필드=> 상품id, 상품이름,가격, 재고수량, 출시일
create table sample ( -- 관계데이터베이스의 표 생성
	pro_id int primary key, -- 기본키
    p_name varchar(100), -- varchar: 가변길이, 최대 100
    price int, 
    quan int,
    re_date date 
    );
desc sample; -- 테이블 구조 확인 
show databases;  -- 데이터베이스 보기
show tables; -- 테이블 보기
--  c(입력) : insert
insert into sample (pro_id, p_name, price, quan, re_date)
value (1, '새우깡',3000, 100, '2026-5-3');

-- r(읽기) : select
select * from sample;
insert into sample (pro_id, p_name, price, quan, re_date)
value (2, '양파링',2500, 300, '2026-4-1');
select * from sample;
select pro_id, p_name from sample;

-- u(갱신, 수정) :update

update sample set  price = 5000  where pro_id=1;
select * from sample;

-- 양파링 수량 1000 개 수정
update sample set  quan = 1000  where pro_id=2;
select * from sample;

-- d(삭제) :delete
delete from  sample where pro_id=2;
select * from sample;


























    
	