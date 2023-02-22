use database demo_database;


Create or replace table sv_sales_data
     (order_id  String primary key,
     order_date DATE,
     ship_date  DATE,
     ship_mode  Varchar(50),
     customer_name  Varchar(50),
     segment  Varchar2(100),
     state  Varchar2(100),
     country  Varchar2(100),
     market  Varchar2(100),
     region Varchar2(100),
     product_id String,
     category Varchar2(100),
     sub_category  Varchar2(100),
     product_name string,
     sales  int,	
     quantity int,
     discount float,
     profit  float,
     shipping_cost  float,
     order_priority Varchar(30),
     year Char(4));
     
Describe table sv_sales_data;     
     
 select * from sv_sales_data;    
 
 
----------------------------------------------------------------------------------------------------------------------------------------------

--1. Have already set the order_id as primary key.

----------------------------------------------------------------------------------------------------------------------------------------------

--2. Uploaded the table by changing the data type of order_date and ship_date into date format(YYYY-MM-DD)

----------------------------------------------------------------------------------------------------------------------------------------------

--3. EXTACT THE LAST NUMBER AFTER THE - AND CREATE OTHER COLUMN AND UPDATE IT.

  Select *,substr(order_id ,9) as extracted_order_id from sv_sales_data;
  Select *,split_part(ORDER_ID,'-',3) as extracted_order_id from sv_sales_data;
  
----------------------------------------------------------------------------------------------------------------------------------------------

--4.FLAG ,IF DISCOUNT IS GREATER THEN 0 THEN YES ELSE FALSE AND PUT IT IN NEW COLUMN FOR EVERY ORDER ID.

  Select ORDER_ID,DISCOUNT,
        Case
            When DISCOUNT > 0 Then 'YES'
            Else 'FALSE'
            End as FLAGGED_DISCOUNT
         From sv_sales_data;
         
----------------------------------------------------------------------------------------------------------------------------------------------

--5. FIND OUT THE FINAL PROFIT AND PUT IT IN COLUMN FOR EVERY ORDER ID.
     --Ans- profit is already given.
     
   Select Order_id,Profit as Final_profit from sv_sales_data;
   
----------------------------------------------------------------------------------------------------------------------------------------------
 
--6.FIND OUT HOW MUCH DAYS TAKEN FOR EACH ORDER TO PROCESS FOR THE SHIPMENT FOR EVERY ORDER ID.

   Select Order_id,Datediff(DAY,ORDER_DATE,SHIP_DATE) as PROCESS_DAYS from sv_sales_data;
   
----------------------------------------------------------------------------------------------------------------------------------------------

--7.FLAG THE PROCESS DAY AS BY RATING IF IT TAKES LESS OR EQUAL 3 DAYS MAKE 5,LESS OR
   -- EQUAL THAN 6 DAYS BUT MORE THAN 3 MAKE 4,LESS THAN 10 BUT MORE THAN 6 MAKE 3,MORE
    --THAN 10 MAKE IT 2 FOR EVERY ORDER ID.
    
    ----1st method(where we can show PROCESS_DAYS in a separate column)
    Alter table sv_sales_data
    Add column PROCESS_DAYS int;
    
    Update sv_sales_data
    set PROCESS_DAYS = Datediff(day,ORDER_DATE,SHIP_DATE) where PROCESS_DAYS is null;
    
    select * from sv_sales_data;
    
    
    Select ORDER_ID,ORDER_DATE,SHIP_DATE,PROCESS_DAYS,
           CASE
               WHEN PROCESS_DAYS <=3 THEN '5'
               WHEN (PROCESS_DAYS >3 AND PROCESS_DAYS <=6) THEN '4'
               WHEN (PROCESS_DAYS >6 AND PROCESS_DAYS <10) THEN '3'
               ELSE '2'
               END AS PROCESS_RATING
    From sv_sales_data;
    
    
    ----- 2nd method-----
    
     
    Select ORDER_ID,ORDER_DATE,SHIP_DATE,
           CASE
               WHEN PROCESS_DAYS <=3 THEN '5'
               WHEN (PROCESS_DAYS >3 AND PROCESS_DAYS <=6) THEN '4'
               WHEN (PROCESS_DAYS >6 AND PROCESS_DAYS <10) THEN '3'
               ELSE '2'
               END AS PROCESS_RATING
    From sv_sales_data;
    
    
           
 -----------------------------------------------END--------------------------------------------------------------------------------------   
    
     