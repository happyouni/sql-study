 --   주문통계 테이블
CREATE TABLE order_stat (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(50),
    category VARCHAR(50), -- 카테고리
    product_name VARCHAR(100), 
    price INT,
    quantity INT,
    order_date DATE
);
desc order_stat;

INSERT INTO order_stat (customer_name, category, product_name, price, quantity, order_date) VALUES
('이순신', '전자기기', '프리미엄 기계식 키보드', 150000, 1, '2025-05-10'),
('세종대왕', '도서', 'SQL 마스터링', 35000, 2, '2025-05-10'),
('신사임당', '가구', '인체공학 사무용 의자', 250000, 1, '2025-05-11'),
('이순신', '전자기기', '고성능 게이밍 마우스', 80000, 1, '2025-05-12'),
('세종대왕', '전자기기', '4K 모니터', 450000, 1, '2025-05-12'),
('장영실', '도서', '파이썬 데이터 분석', 40000, 3, '2025-05-13'),
('이순신', '문구', '고급 만년필 세트', 200000, 1, '2025-05-14'),
('세종대왕', '가구', '높이조절 스탠딩 데스크', 320000, 1, '2025-05-15'),
('신사임당', '전자기기', '노이즈캔슬링 블루투스 이어폰', 180000, 1, '2025-05-15'),
('장영실', '전자기기', '보조배터리 20000mAh', 50000, 2, '2025-05-16'),
('홍길동', NULL, 'USB-C 허브', 65000, 1, '2025-05-17'); 
-- 카테고리가 NULL인 데이터 추가
select * from order_stat;
select count(customer_name) from order_stat;
-- count(표현식) :개수 (null 제외)
select count(category) from order_stat;
SELECT count(*) from order_stat;
-- count(*) : 전체 개수
-- sum() avg()
SELECT 
sum(price * quantity) as 총매출액,
round(AVG(price * quantity),1) as 평균매출액
from order_stat;
-- truncate TABLE : 테이블 구조는 그대로 내용만 전부 삭제
-- truncate(AVG(price * quantity),1) 
-- : 소수이하 버리는 함수
-- 집계함수(count, sum, avg, max, min~~)
SELECT 
min(order_date) as 최초주문일,
max(order_date) as 최근주문일
from order_stat;

select 
count(customer_name) as 총주문건수,
count(DISTINCT customer_name) as 순수고객수
from order_stat;
-- group by :그룹으로 묶기
-- 카테고리별 주문 건수
SELECT
	category, 
    count(*) as `카테고리별 주문건수`
FROM order_stat  -- 테이블명
GROUP BY  category; -- 카테고리별 묶음

--  고객별로 총 몇번 주문했는지(주문횟수)
SELECT
	customer_name, 
    count(*) as `주문횟수`,
    sum(quantity) as `총 주문수량`,
    sum( price * quantity ) as `총 구매 금액`
FROM order_stat  -- 테이블명
GROUP BY  customer_name
ORDER BY  `총 구매 금액` desc;

-- 1단계: 고객별 총 주문 횟수 집계하기
-- 2단계: HAVING절을 추가하여 주문 횟수 3회 이상인 그룹 필터링하기
-- HAVING: 그룹에 대한 조건을 필터링(걸러냄)
SELECT
	customer_name, 
    count(*) as `주문횟수`    
FROM order_stat  
GROUP BY  customer_name
HAVING COUNT(*) >= 3; 
-- 순서 : FROM->WHERE->GROUP BY->HAVING->SELECT->ORDER BY
-- WHERE : 전체 대상으로 한 조건
-- HAVING : GROUP BY 와 같이 사용, 그룹에 대한 조건
SELECT  -- (5) 카테고리, 회수 조회
	 category,
     count(*) as `구분별 주문횟수` 
FROM order_stat  -- (1)
WHERE PRICE >= 100000  -- (2) 가격이 10만이상 
GROUP BY category -- (3) 카테고리별로 그룹
HAVING COUNT(*) >= 2;  -- (4) 그룹 별로 개수가 2개이상

--  문제) order_stat 테이블에서(FROM)
-- 2025년 5월 14일 이전에 들어온 주문들 중에서(WHERE), 
-- 고객별로 그룹화하여(GROUP BY),
-- 주문 건수가 2회 이상인 고객을 찾아서(HAVING), 
-- 해당 고객의 이름과 총구매금액(가격*수량)을 조회하고(SELECT), 
-- 총구매금액을 기준으로 내림차순 정렬해라(ORDER BY)
-- 그리고 가장 위(금액이 큰)  하나(LIMIT)의 데이터만 출력해라.
SELECT -- 5
	customer_name,    
    sum(price * quantity) as 총구매금액
from  order_stat  -- 1 
where order_date <= '2025-05-14'  -- 2
group by customer_name  -- 3
having count(*) >= 2 -- 4
ORDER BY 총구매금액 desc -- 6
LIMIT 1; -- 7 

--  GROUP BY 나올때 SELECT에 나오는 필드명은
-- 반드시 GROUP BY 뒤에 나오는 필드명이거나
-- 집계함수 만 가능


SELECT
    category,
    SUM(price * quantity) AS total_sales
FROM
    order_stat
WHERE  -- 오류(GROUP BY 보다 먼저 실행, having으로 해야함)
  SUM(price * quantity) >= 500000
GROUP BY
    category;
-- 순서: FROM->WHERE->GROUP BY->HAVING->SELECT->ORDER BY
























 





     






























