require('pg')

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
  db = PG.connect({dbname: 'pizza', host: 'localhost'})
  sql = "INSERT INTO pizza_orders
        (topping, quantity, customer_id)
        VALUES
        ($1, $2, $3) RETURNING id
        "
  values = [@topping, @quantity, @customer_id]
  db.prepare("save", sql)
  @id = db.exec_prepared("save", values) [0]['id'].to_i
  db.close()
end

def delete()
  db = PG.connect({dbname: 'pizza', host: 'localhost'})
  sql = "DELETE FROM pizza_orders WHERE id = $1"
  values = [@id]
  db.prepare("delete_one", sql)
  db.exec_prepared("delete_one", values)
  db.close()
end

def update()
  db = PG.connect({dbname: 'pizza', host: 'localhost'})
  sql = "UPDATE pizza_orders
        SET(
          topping, quantity, customer_id
        ) = (
          $1, $2, $3
        )
        WHERE id = $4"
  values = [@topping, @quantity, @customer_id, @id]
  db.prepare("update", sql)
  orders = db.exec_prepared("update", values)
  db.close()
end

def self.all()
  db = PG.connect({dbname: 'pizza', host: 'localhost'})
  sql = "SELECT * FROM pizza_orders"
  db.prepare("all", sql)
  orders = db.exec_prepared("all")
  db.close()
  return orders.map { |order| PizzaOrder.new(order)}
end

def self.delete_all()
  db = PG.connect({dbname: 'pizza', host: 'localhost'})
  sql = "DELETE FROM pizza_orders"
  db.prepare("delete_all", sql)
  db.exec_prepared("delete_all")
  db.close()
end

def customer()
  db = PG.connect({dbname: 'pizza', host: 'localhost'})
  sql = "SELECT * FROM customers
        WHERE
        id = $1
        "
  values = [@customer_id]
  db.prepare("customer", sql)
  cust = db.exec_prepared("customer", values)
  db.close()
  return cust.map { |order| Customer.new(order)}[0]
end

end
