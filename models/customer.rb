require('pg')
require_relative('../db/sql_runner.rb')

class Customer

  attr_reader :id, :name

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

def save()
  sql = "INSERT INTO customers (name)
  VALUES ($1)
  RETURNING id"
  values=[@name]
  result = SqlRunner.run(sql, values)
  @id = result[0]['id'].to_i


  # db = PG.connect( { dbname: 'pizza', host: 'localhost' } )
  # sql = "INSERT INTO customers (name)
  # VALUES ($1)
  # RETURNING id
  # "
  # values=[@name]
  # db.prepare("save", sql)
  # result = db.exec_prepared("save", values)
  # db.close()
  # @id = result[0]['id'].to_i
end


def delete()
  sql = "DELETE FROM customers WHERE id = $1"
  values=[@id]
  SqlRunner.run(sql, values)

  # db = PG.connect({dbname: 'pizza', host: 'localhost'})
  # sql = "DELETE FROM customers WHERE id = $1"
  # values = [@id]
  # db.prepare("delete_one", sql)
  # db.exec_prepared("delete_one", values)
  # db.close()
end

def update()
  sql = "UPDATE customers
        SET(
          name
        ) = (
          $1
        )
        WHERE id = $2"
  values=[@name, @id]
  SqlRunner.run(sql, values)

  # sql = "UPDATE customers
  #       SET(
  #         name
  #       ) = (
  #         $1
  #       )
  #       WHERE id = $2"
  # values = [@name, @id]
  # db.prepare("update", sql)
  # orders = db.exec_prepared("update", values)
  # db.close()
end

def self.all()
  sql = "SELECT * FROM customers"
  values=[]
  orders = SqlRunner.run(sql, values)
  return orders.map { |order| Customer.new(order)}

  # db = PG.connect({dbname: 'pizza', host: 'localhost'})
  # sql = "SELECT * FROM customers"
  # db.prepare("all", sql)
  # orders = db.exec_prepared("all")
  # db.close()
  # return orders.map { |order| Customer.new(order)}
end

def self.delete_all()
  sql = "DELETE FROM customers"
  values=[]
  SqlRunner.run(sql, values)

  # db = PG.connect( { dbname: 'pizza', host: 'localhost' } )
  # sql = "DELETE * FROM customers"
  # db.prepare("delete_all", sql)
  # result = db.exec_prepared("delete_all")
  # db.close()
end

def pizza_orders()
  sql = "SELECT * FROM pizza_orders
        WHERE
        customer_id = $1"
  values=[@id]
  list = SqlRunner.run(sql, values)
  return list.map { |order| PizzaOrder.new(order)}


  # db = PG.connect({dbname: 'pizza', host: 'localhost'})
  # sql = "SELECT * FROM pizza_orders
  #       WHERE
  #       customer_id = $1
  #       "
  # values = [@id]
  # db.prepare("order_list", sql)
  # list = db.exec_prepared("order_list", values)
  # db.close()
  # return list.map { |order| PizzaOrder.new(order)}
end

end
