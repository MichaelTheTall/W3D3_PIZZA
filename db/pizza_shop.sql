DROP TABLE IF EXISTS pizza_orders;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255) NOT NULL
);

CREATE TABLE pizza_orders (
  id SERIAL8 PRIMARY KEY,
  topping VARCHAR(255) NOT NULL,
  quantity INT2 NOT NULL,
  customer_id INT8 REFERENCES customers(id)
);
