class User
  include Mongoid::Document
  include ActiveModel::SecurePassword

  field :username
  field :email  
  field :password_digest
  field :email_confirmed,  type: Boolean, default: false
  field :confirm_token
  field :forgot_token

  has_secure_password

  has_one :shopping_cart, dependent: :destroy
  has_many :orders, dependent: :destroy

  validates :username, :email, presence: true, uniqueness: true
  validates :password, presence: true

  before_create :confirmation_token
  after_create :create_shopping_cart

  def confirmation_token
    if self.confirm_token.blank?
      self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end

  def set_forgot_token
    self.forgot_token = SecureRandom.urlsafe_base64.to_s
    save!(:validate => false)
  end

  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    save!(:validate => false)
  end

  def set_forgot_nil
    self.forgot_token = nil
    save!(:validate => false)
  end

  def create_shopping_cart
    self.shopping_cart = ShoppingCart.create
    save!(:validate => false)
  end

  def test_products
    category = Category.find_by(lvl: 0)
    20.times do |index|
      product = category.products.new
      product.name = "#{index}product"
      product.provider = Provider.first.id
      product.save
    end
  end
end
