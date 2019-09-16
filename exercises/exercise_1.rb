require_relative '../setup'

puts "Exercise 1"
puts "----------"

# Your code goes below here ...

class Store < ActiveRecord::Base
  has_many :employees
  validates :name, length: { minimum: 3 , message: "Name needs to be longer than 3 letters" }
  validates :annual_revenue, numericality: { greater_than_or_equal_to: 0, message: "%{value} needs to be greater than 0" } 
  validate :sells_some_apparel

  def sells_some_apparel
    if (!mens_apparel) && (!womens_apparel)
      errors.add(:mens_apparel, :womens_apparel, message: "Can't be empty")
    end
  end

end

class Employee < ActiveRecord::Base
  belongs_to :Store
  validate :first_name
  validate :last_name
  validate :store_id
  validates :hourly_rate, numericality: { greater_than_or_equal_to: 40, less_than_or_equal_to: 200 }
end

Store.create(name:"Burnaby", annual_revenue: 300000, mens_apparel: true, womens_apparel: true)
Store.create(name:"Richmond", annual_revenue: 1260000, mens_apparel: false, womens_apparel: true)
Store.create(name:"Gastown", annual_revenue: 190000, mens_apparel: true, womens_apparel: false)
Store.create(name:"Gastown", annual_revenue: 190000, mens_apparel: false, womens_apparel: false)
Store.create(name:"Gastown")
Store.create(name:"Gastown", annual_revenue: 190000, mens_apparel: false, womens_apparel: false)

puts Store.count