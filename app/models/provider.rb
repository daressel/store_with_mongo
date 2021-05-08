class Provider
	include Mongoid::Document

	field :name,                type: String
	field :provider_attributes, type: Array
	field :images,              type: Array

	has_many :products, dependent: :destroy

  # validates :name, presence: true
end