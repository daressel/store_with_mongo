class User
  include Mongoid::Document
  include ActiveModel::SecurePassword

  field :username
  field :email  
  field :password_digest
  field :email_confirmed,  type: Boolean, default: false
  field :confirm_token

  has_secure_password

  validates :username, :email, presence: true, uniqueness: true
  validates :password, presence: true

  before_create :confirmation_token

  def confirmation_token
    if self.confirm_token.blank?
      self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end

  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    save!(:validate => false)
  end
end
