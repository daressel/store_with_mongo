class Product
  include Mongoid::Document
  include ActionView::Helpers::TagHelper
  include ActionView::Context

  field :name,                  type: String
  field :description,           type: String
  field :presence,              type: Boolean
  field :images,                type: Array
  field :count,                 type: Integer
  field :attrs,                 type: Hash
  field :sell_price,            type: Float
  field :buy_price,             type: Float

  # belongs_to :provider
  belongs_to :category

  # validates :name, :buy_price, :attrs, :sell_price, presence: true
end