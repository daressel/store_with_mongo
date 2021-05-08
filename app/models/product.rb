class Product
  require 'base64'
  require 'fileutils'
  include Mongoid::Document
  include ActionView::Helpers::TagHelper
  include ActionView::Context
  
  field :name,                  type: String
  field :description,           type: String
  field :presence,              type: Boolean
  field :images,                type: Array,   default: []
  field :count,                 type: Integer
  field :attrs,                 type: Hash,    default: {}
  field :sell_price,            type: Float
  field :buy_price,             type: Float
  

  belongs_to :provider
  belongs_to :category

  before_destroy :delete_image_folder
  after_save :create_image_folder

  # validates :name, :buy_price, :attrs, :sell_price, presence: true
  def create_images(images)
    path = "public/images/uploads/#{self.class.to_s.downcase}/#{self.id}"
    images.each do |name, encoded_string|
      encoded_string = encoded_string.split(',')[1]
      File.open("#{path}/#{name}", 'wb') do |file|
        file.write(Base64.decode64(encoded_string))
      end
      self.images.push(name)
    end
    self.save
  end

  def attrs_to_s
    self.attrs.collect {|name, value| 
      if value[1] == 'без единицы измерения'
        "#{name} - #{value[0]}"
      else 
        "#{name} - #{value[0]} #{value[1]}"
      end
    }.join('; ')
  end

  def create_image_folder
    path = "public/images/uploads/#{self.class.to_s.downcase}/#{self.id}"
    FileUtils.mkdir_p(path)
  end

  def delete_image_folder
    path = "public/images/uploads/#{self.class.to_s.downcase}/#{self.id}"
    FileUtils.remove_dir(path)
  end  
end