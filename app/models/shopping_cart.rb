class ShoppingCart
  include Mongoid::Document

  field :products, type: Hash, default: {}
  
  belongs_to :user
end
