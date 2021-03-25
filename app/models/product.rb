class Product
  include Mongoid::Document

  field :name,                  type: String
  field :description,           type: String
  field :presence,              type: Boolean
  field :images,                type: Array
  field :count,                 type: Integer
  field :attrs,                 type: Hash
  field :sell_price,            type: Float
  field :buy_price,             type: Float

  belongs_to :provider
  has_and_belongs_to_many :category

  # validates :name, :buy_price, :attrs, :sell_price, presence: true
end