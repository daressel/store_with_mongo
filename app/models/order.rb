class Order
  include Mongoid::Document
  
  has_many :products
  belongs_to :user
end
