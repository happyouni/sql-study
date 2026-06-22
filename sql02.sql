-- 주문테이블
create table orders(
	order_id int auto_increment primary key,
    customer_id int not null,
    product_id int not null,
    
    quantity int not null -- 주문 수량
    constraint chk_order_quan check(quantity >= 1),
    -- constraint : 제약조건/ chk_order_quan(이름 명명)
    -- check(quantity >= 1) : 수량이 1개 이상 체크
    
    order_date datetime  default current_timestamp,
    o_status varchar(20) not null default '주문접수',
    
    constraint fk_orders_customers foreign key (customer_id)
      references customers(customer_id)
      -- 주문테이블의  customer_id(외래키)- 고객테이블의 customer_id 연결
      on update cascade,
      -- cascade : 부모테이블이 갱신(수정)/삭제되면 다른 자식테이블도 같이 수정/삭제 
    
    constraint fk_orders_products foreign key (product_id)
      references products(product_id)
      -- 주문테이블의  product_id(외래키)- 상품테이블의 product_id 연결
      -- fk_orders_products : 제약조건마다 이름을 정함(우리가 만든 이름)
      on update cascade
  );
  desc orders;
  
 use my_shop;
  desc customers;
  desc products;
  desc orders;
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      