require('pry-byebug')
require_relative('models/pizza_order.rb')
require_relative('models/customer.rb')
require_relative('db/sql_runner.rb')


PizzaOrder.delete_all()
Customer.delete_all()

customer1 = Customer.new({ 'name' => 'Big Bob' })
customer2 = Customer.new({ 'name' => 'Bigger Bob' })
customer3 = Customer.new({ 'name' => 'Fat Freddy' })
customer4 = Customer.new({ 'name' => 'Skinny Sarah' })

customer1.save()
customer2.save()
customer3.save()
customer4.save()

order1 = PizzaOrder.new({
  'customer_id' => customer1.id,
  'topping' => 'Meat Feast',
  'quantity' => 1
})
order2 = PizzaOrder.new({
  'customer_id' => customer2.id,
  'topping' => 'Meat Feast 2: Salami Boogaloo',
  'quantity' => 2
})
order3 = PizzaOrder.new({
  'customer_id' => customer3.id,
  'topping' => 'Impending Doom',
  'quantity' => 5
})


order1.save()
order2.save()
order3.save()

binding.pry
nil
