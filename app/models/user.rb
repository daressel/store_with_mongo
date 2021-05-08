class User
  include Mongoid::Document
  include ActiveModel::SecurePassword

  field :username
  field :password_digest

  has_secure_password

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true
end