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
