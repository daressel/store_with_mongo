class Category
  include Mongoid::Document
  include ActionView::Helpers::TagHelper
  include ActionView::Context 

  field :name,          type: String
  field :parent_id,     type: Object
  field :lvl,           type: Integer
  field :attrs,         type: Hash,    default: {}

  has_many :products, dependent: :destroy
  has_many :children, class_name: 'Category', foreign_key: :parent_id, dependent: :destroy
  
  belongs_to :parent, class_name: 'Category', optional: true
  
  # validates :name, :parent, :parents_path, :lvl, presence: true

  def categories
    str = "<li>#{self.name}</li>"
    if self.children.any?
      str = "<li>#{self.name}<i class='fa fa-caret-right p-0'></i>"
      str += "<ul class='childs-menu'>"
      self.children.each do |child|
        str += child.categories
      end
      str += "</ul></li>"
    end
    str.html_safe
  end

  def self.max_lvl
    Category.all.pluck(:lvl).max
  end
end
