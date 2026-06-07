https://www.youtube.com/watch?v=soDqgBRKi1o&list=PLiFErliE7g4XLTRzStzh2Eh2voqDkfuIq&index=7


<img width="637" height="346" alt="image" src="https://github.com/user-attachments/assets/f3fb0df3-1141-44d8-b172-bed7e275272b" />



name: supply_chain_model

tables:
  - name: sales_orders
    description: "Sales transactions data"
    
  - name: products
    description: "Product master data"

relationships:
  - left_table: sales_orders
    right_table: products
    join_condition: sales_orders.product_id = products.product_id

metrics:
  - name: total_revenue
    description: "Total sales revenue"
    expression: SUM(sales_amount)

  - name: total_orders
    description: "Number of orders"
    expression: COUNT(order_id)

dimensions:
  - name: order_date
    expression: sales_orders.order_date

  - name: product_category
    expression: products.category

  - name: region
    expression: sales_orders.region


<img width="704" height="185" alt="image" src="https://github.com/user-attachments/assets/9d7facfd-0d58-4de2-9eaa-98ee86b30a78" />

<img width="587" height="306" alt="image" src="https://github.com/user-attachments/assets/2e06aa78-c1a2-459f-990d-a11af2d4c7a5" />

<img width="614" height="294" alt="image" src="https://github.com/user-attachments/assets/c9012ef5-ba12-4e13-8fc3-334807dc5a82" />

<img width="653" height="208" alt="image" src="https://github.com/user-attachments/assets/cd4e2d0c-f556-437c-a844-dc2b9dbae509" />

<img width="663" height="218" alt="image" src="https://github.com/user-attachments/assets/bc2a6063-dc57-450b-a7c2-8dbc401d39b3" />

<img width="641" height="177" alt="image" src="https://github.com/user-attachments/assets/ee72434e-1797-4d8f-8a14-46089a440461" />

<img width="465" height="148" alt="image" src="https://github.com/user-attachments/assets/be8f063a-7edd-4d26-bfce-9282b4360e63" />

<img width="476" height="124" alt="image" src="https://github.com/user-attachments/assets/5006519e-830e-4c17-bb94-ec2e2c9567e0" />

<img width="625" height="258" alt="image" src="https://github.com/user-attachments/assets/5a6f0161-5f12-4ae5-bf98-9bb2659e929e" />

<img width="525" height="416" alt="image" src="https://github.com/user-attachments/assets/80acbc16-6858-4dfc-b858-9becf631a485" />

<img width="956" height="404" alt="image" src="https://github.com/user-attachments/assets/ee71931f-0f3a-4aa7-b446-48e7f9471e03" />

