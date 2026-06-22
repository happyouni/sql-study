desc customers;
show tables;
use my_shop;
select * from customers;
insert into customers 
 (c_name, email, pass, address) values
 ('강감찬', 'kang@naver.com', 'password777', '인천 남동구 구월동');
 select * from customers;
 desc products;
 
 insert into products
 (p_name, descr, price, stock_quantity)
 value
 ('갤럭시', '최신 AI 기능이 탑재된 고성능 스마트폰', 1000000, 55);
 select * from products;
 INSERT INTO products (p_name, descr, price, stock_quantity) VALUES
('LG 그램', '초경량 디자인과 강력한 성능을 자랑하는 노트북', 500000, 35),
('아이폰', '직관적인 사용자 경험을 제공하는 스마트폰', 800000, 55),
('에어팟', '편리한 사용성의 무선 이어폰', 200000, 110),
('알뜰폰', NULL, 300000, 100);
 select * from products;
 
 truncate table products; 
 desc orders;
 insert into orders
 (customer_id, product_id, quantity) value
 (1,1,1);
 
 

 
 -- 1. 외래키 체크 비활성화
SET FOREIGN_KEY_CHECKS = 0;

-- 2. 테이블 비우기
TRUNCATE TABLE products;

-- 3. 외래키 체크 다시 활성화 (필수!)
SET FOREIGN_KEY_CHECKS = 1;
 desc table procucts;
 show tables;
 
 
 
 
 
 select * from procucts;
 select * from customers;
 select * from procucts;
  select * from orders;
 iNSERT INTO orders (customer_id, product_id, quantity) VALUES
(2, 2, 1), -- 세종대왕 고객이 LG 그램 1개 주문
(3, 3, 1), -- 장영실 고객이 아이폰 1개 주문
(1, 4, 2), -- 이순신 고객이 에어팟 2개 추가 주문
(2, 2, 1); -- 세종대왕 고객이 LG 그램 1개 주문(추가 주문)
select * from orders;

update customers set customer_id=10 
where customer_id=4;
select * from customers;

update customers set pass = 'password100'
where customer_id=10;
select * from customers;

-- delete from customers
-- where customer_id=10;

insert into customers (email, pass, address)
value ('aaa@naver.com', 'pass111', '인천 미추홀구 용현동');
desc customers;
select * from customers;

insert into customers (c_name, email, pass, address)
value ('홍길동', 'kang@naver.com', 'pass9999', '인천 남동구 논현동'); 
desc customers;

desc orders;
insert into orders (customer_id, product_id, quantity)
values (12, 1, 1);


select * from products; 

update customers set pass='password333'
where c_name='장영실';

 --  장영실-> pasword333
 -- 기본키로만 조건을 작성( 일반 필드로도 조건 작성-> 안전모드 해제)
 SET SQL_SAFE_UPDATES = 0; -- 안전 모드 해제 (0 = OFF)
 update customers set pass='password333'
where c_name='장영실';
select * from customers;
SET SQL_SAFE_UPDATES = 1; 

-- 인덱스 생성
create index  i_price on products(price);
select * from products where price >=500000;
-- view(뷰) : 데이터를 따로 저장 안함, 필요한 것만 꺼내와서 
 --  사용자에게 보여줌
create view v_masking as
	select
     customer_id,
     c_name,
     email,
     join_date
	from customers;
select * from   v_masking;

create view v_seoul as
	select customer_id, c_name, address
    from customers
    where address like '%서울%'; -- 서울 포함
    -- like 와 같다, %:모든문자 대체(공백도 대체)
select * from  v_seoul ;
	
select * from products;
 --   p_name, descr, price 조건: 설명(descr)중 AI
 --  한 테이블에서 뷰 생성
 create view v_desc as
	select p_name, descr, price
    from products
    where descr like '%ai%'; 

select * from v_desc;
create view v_order_details  as
select
      o.order_id,
      c.c_name as 고객이름,
      p.p_name as 상품명,
      o.order_date as 주문일시,
      o.o_status  as 주문상태   
    from orders o
    join customers c on o.customer_id = c.customer_id
    join products  p on o.product_id = p.product_id;
    
select * from v_order_details;

--  orders => a   customers =>b
 --  order_id, customer_id, c_name, quantity
     -- => 주문번호, 고객번호, 고객명, 수량
     -- 주문 테이블의 고객번호 = 고객테이블의 고객번호
     
select * from v_orders_customers;
create view v_orders_customers  as
select
      a.order_id as 주문번호,
      b.customer_id as 고객번호,
      b.c_name as 고객명,
      a.quantity as 수량    
    from orders a
    join customers b on a.customer_id = b.customer_id;
    
  select * from v_orders_customers;  
    
  drop view v_masking; 
  select c_name, address from customers;
  select * from products where price >= 700000;
  --  customers =>join_date 가 2026-1-1 이후 조회
  select * from customers 
  where join_date  >= '2026-1-1';
  -- (price)가격이 50만원 이상이면서 (stock_quantity)재고수량이 50 이상
  select * from products
  where price >=500000 and stock_quantity >=50;
  --  where 조건,  between 0 and 10 : 범위
  select * from products
  where price not between 500000 and  1000000;
  --  in : 포함     not in : 포함안됨 
  select * from products 
  where p_name not in ('갤럭시','아이폰', '아이폰18');
  select * from customers 
  where c_name like '%윤%';
  --  _(밑줄) : 한글자 
  
  select * from customers 
  where address not like '서울특별시%'; 
  
  use my_shop;  
  select * from customers;
  select * from products;
  select * from orders;
  -- products 상품명이 아로 시작 3글자 조회
  select * from products 
  where  p_name like '아__'; -- 밑줄(_): 글자 1자리 의미
  -- products-> 상품명이 아로 시작 모든 데이터 조회
  select * from products
  where  p_name like '아%';
  
  -- products->price  500000 미만이거나 800000 초과 조회
  select * from products
  where  price < 500000 or price > 800000;
  -- between 이용 예)between 300000 and 500000(300000~500000)
  select * from products
  where  price  not between 500000 and 800000;
  -- 상품명이 ('갤럭시', '아이폰', '에어팟') 일치하면 조회
  select * from products
  where  p_name  in ( '갤럭시', '아이폰', '에어팟');   
  
  -- 정렬(order by): asc(오름차순(작->큰, a->z, 가->하), 기본으로 생략 가능),
  -- desc(내림차순)
  
  --  customers -> join_date(가입일시)최근순으로 나열
  
  select * from customers
  order by join_date desc;
  -- products-> price이 작은 금액부터 나오게 나열
  select * from products order by price asc; 
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
    
 
 
 


















