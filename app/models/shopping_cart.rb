class ShoppingCart
  include Mongoid::Document

  field :products,    type: Hash,     default: {}
  field :full_price,  type: Float,    default: 0.0
  
  belongs_to :user
end
