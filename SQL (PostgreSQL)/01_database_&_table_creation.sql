
-- TABLE CREATION -- 

create table amazon_sales (
order_id varchar , 
date DATE, 
status varchar, 
fulfilment VARCHAR, 
sales_channel varchar,
ship_service_level varchar , 
style varchar, 
category varchar, 
size varchar, 
courier_status varchar,
qty int, 
currency varchar, 
amount NUMERIC(10,2), 
ship_state varchar, 
ship_country varchar, 
b2b bool,
fulfilled_by varchar, 
revenue NUMERIC(10,2), 
month varchar, 
month_num int, 
day_name varchar
);

-- CHECKING CRATED TABLE 
select * from amazon_sales;


