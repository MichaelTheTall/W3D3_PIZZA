require('pg')
require_relative('../db/sql_runner.rb')


class PizzaOrder
  attr_accessor :topping, :quantity, :customer_id
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @topping = options['topping']
    @quantity = options['quantity'].to_i
    @customer_id = options['customer_id'].to_i
  end

def save()
  sql = "INSERT INTO pizza_orders
        (topping, quantity, customer_id)
        VALUES
        ($1, $2, $3) RETURNING id"
  values=[@topping, @quantity, @customer_id]
  result = SqlRunner.run(sql, values)
  @id = result[0]['id'].to_i

  # db = PG.connect({dbname: 'pizza', host: 'localhost'})
  # sql = "INSERT INTO pizza_orders
  #       (topping, quantity, customer_id)
  #       VALUES
  #       ($1, $2, $3) RETURNING id
  #       "
  # values = [@topping, @quantity, @customer_id]
  # db.prepare("save", sql)
  # @id = db.exec_prepared("save", values) [0]['id'].to_i
  # db.close()
end

def delete()
  sql = "DELETE FROM pizza_orders WHERE id = $1"
  values=[@id]
  SqlRunner.run(sql, values)

  # db = PG.connect({dbname: 'pizza', host: 'localhost'})
  # sql = "DELETE FROM pizza_orders WHERE id = $1"
  # values = [@id]
  # db.prepare("delete_one", sql)
  # db.exec_prepared("delete_one", values)
  db.close()
end

def update()
  sql = "UPDATE pizza_orders
        SET(
          topping, quantity, customer_id
        ) = (
          $1, $2, $3
        )
        WHERE id = $4"
  values=[@topping, @quantity, @customer_id, @id]
  SqlRunner.run(sql, values)

  # db = PG.connect({dbname: 'pizza', host: 'localhost'})
  # sql = "UPDATE pizza_orders
  #       SET(
  #         topping, quantity, customer_id
  #       ) = (
  #         $1, $2, $3
  #       )
  #       WHERE id = $4"
  # values = [@topping, @quantity, @customer_id, @id]
  # db.prepare("update", sql)
  # orders = db.exec_prepared("update", values)
  # db.close()
end

def self.all()
  sql = "SELECT FROM pizza_orders"
  values=[]
  orders = SqlRunner.run(sql, values)
  return orders.map { |order| PizzaOrder.new(order)}

  # db = PG.connect({dbname: 'pizza', host: 'localhost'})
  # sql = "SELECT * FROM pizza_orders"
  # db.prepare("all", sql)
  # orders = db.exec_prepared("all")
  # db.close()
  # return orders.map { |order| PizzaOrder.new(order)}
end

def self.delete_all()
  sql = "DELETE FROM pizza_orders"
  values=[]
  SqlRunner.run(sql, values)

  # db = PG.connect({dbname: 'pizza', host: 'localhost'})
  # sql = "DELETE * FROM pizza_orders"
  # db.prepare("delete_all", sql)
  # db.exec_prepared("delete_all")
  # db.close()
end

def customer()
  sql = "SELECT * FROM customers
        WHERE
        id = $1"
  values=[@customer_id]
  cust = SqlRunner.run(sql, values)
  return cust.map { |order| Customer.new(order)}[0]

  # db = PG.connect({dbname: 'pizza', host: 'localhost'})
  # sql = "SELECT * FROM customers
  #       WHERE
  #       id = $1
  #       "
  # values = [@customer_id]
  # db.prepare("customer", sql)
  # cust = db.exec_prepared("customer", values)
  # db.close()
  # return cust.map { |order| Customer.new(order)}[0]
end

end
