**semantic-view-vs-semantic-model**


<img width="955" height="472" alt="image" src="https://github.com/user-attachments/assets/01087112-b958-4742-8eeb-e1d20eb6618d" />

https://medium.com/@ppritesh/%EF%B8%8F-snowflake-cortex-analyst-semantic-view-vs-semantic-model-whats-the-difference-and-which-517f04549b65

<img width="638" height="355" alt="image" src="https://github.com/user-attachments/assets/324b050a-fe1a-403d-9ac5-6a4b43f0d646" />

<img width="546" height="158" alt="image" src="https://github.com/user-attachments/assets/f8ad1ca7-141b-4adf-874b-65b9e7611e7c" />

<img width="631" height="243" alt="image" src="https://github.com/user-attachments/assets/c1420d94-9534-4df4-b44a-8904cce9c083" />

<img width="660" height="334" alt="image" src="https://github.com/user-attachments/assets/b466dcc1-ee81-450a-a6a4-7f6a7862caf7" />

<img width="510" height="271" alt="image" src="https://github.com/user-attachments/assets/d3aa3e25-6b54-4300-8640-6fc788a1030d" />

<img width="469" height="112" alt="image" src="https://github.com/user-attachments/assets/4625bae8-e15e-471f-a0d5-be5c69780e3e" />


https://www.youtube.com/watch?v=soDqgBRKi1o&list=PLiFErliE7g4XLTRzStzh2Eh2voqDkfuIq&index=7

Cortex definition: Augment BI with AI

At runtime, Cortex Analyst selects the best combination of models to ensure the highest accuracy and performance for each query

As LLMs evolve, Snowflake may add more models to the mix to further improve performance and accuracy.

<img width="538" height="128" alt="image" src="https://github.com/user-attachments/assets/9e7a68f4-8d10-4b78-9bf0-da06302bc98b" />

<img width="515" height="58" alt="image" src="https://github.com/user-attachments/assets/e9de1568-708c-46a6-8e05-108c93c213ca" />

<img width="520" height="109" alt="image" src="https://github.com/user-attachments/assets/84c97d1c-0bba-4652-b787-595a937b9921" />

<img width="524" height="152" alt="image" src="https://github.com/user-attachments/assets/5e6b9b86-0fa8-43ae-8d43-bb0afe4b955b" />


<img width="637" height="346" alt="image" src="https://github.com/user-attachments/assets/f3fb0df3-1141-44d8-b172-bed7e275272b" />

<img width="533" height="222" alt="image" src="https://github.com/user-attachments/assets/29262d3a-6edb-425b-85e5-8cd13a556d4e" />

<img width="544" height="196" alt="image" src="https://github.com/user-attachments/assets/b60c23d8-5fe6-4aa5-b200-00ae51b93114" />

<img width="545" height="217" alt="image" src="https://github.com/user-attachments/assets/524918aa-4b39-4fc5-855e-4d122d9cfe68" />

<img width="544" height="116" alt="image" src="https://github.com/user-attachments/assets/a63bd2c7-f84c-4f70-a1cd-f0066e02f13d" />



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

