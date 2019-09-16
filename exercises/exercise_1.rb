require_relative '../setup'

puts "Exercise 1"
puts "----------"

# Your code goes below here ...

class Store < ActiveRecord::Base
  has_many :employees,  dependent: :restrict_with_error
  validates :name, length: { minimum: 3 , message: "Name needs to be longer than 3 letters" }
  validates :annual_revenue, numericality: { greater_than_or_equal_to: 0, message: "%{value} needs to be greater than 0" } 
  # validates :sells_some_apparel, inclusion: { in: [true, false] }

  before_destroy :delete_condition?, prepend: true

  private

  def delete_condition?
    if self.employees.size > 0
      errors[:base] << "Could not destroy store"
      puts "Could not destroy store"
    else
      puts "Store has been destroyed!"
    end
  end

  # def sells_some_apparel
  #   if (!mens_apparel) && (!womens_apparel)
  #     errors.add(:mens_apparel, message: "Can't be empty")
  #     errors.add(:womens_apparel, message: "Can't be empty")
  #   end
  # end

end

class Employee < ActiveRecord::Base
  belongs_to :Store
  
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :hourly_rate, numericality: { greater_than_or_equal_to: 40, less_than_or_equal_to: 200 }
  # validates :password, presence: true
  
  before_create :create_password

  private

  def create_password
    puts @password = (0...8).map { (65 + rand(26)).chr }.join
    if password.nil?
      password = @password
    end
  end

end

Store.create(name:"Burnaby", annual_revenue: 300000, mens_apparel: true, womens_apparel: true)
Store.create(name:"Richmond", annual_revenue: 1260000, mens_apparel: false, womens_apparel: true)
Store.create(name:"Gastown", annual_revenue: 190000, mens_apparel: true, womens_apparel: false)

# puts Store.count