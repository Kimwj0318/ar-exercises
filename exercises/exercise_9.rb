require_relative '../setup'
require_relative './exercise_1'
require_relative './exercise_2'
require_relative './exercise_3'
require_relative './exercise_4'
require_relative './exercise_5'
require_relative './exercise_6'
require_relative './exercise_7'
require_relative './exercise_8'

puts "Exercise 9"
puts "----------"

puts Store.count

@store1.destroy
@empty_store = Store.create!(name: 'Test Empty Store', annual_revenue: 0)
@empty_store.destroy

puts Store.count