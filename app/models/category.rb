class Category
  include Mongoid::Document
  include ActionView::Helpers::TagHelper
  include ActionView::Context 

  field :name,          type: String
  field :name_view,     type: String
  field :parent,        type: String
  field :lvl,           type: Integer
  field :childs,        type: Array,    default: []
  field :attrs,         type: Array,    default: []

  has_and_belongs_to_many :product

  validates :name, :parent, :lvl, presence: true
  validates :name, uniqueness: true

  def child_cat
    str = ''
    if self.childs.any? 
      str = "<div class='square category-list' id=#{self.name_view}>"
      Category.where(parent: self.name).each do |child|
        if child.childs.any?
          str += "<div class='category' data-category=#{child.name.gsub(' ', '_')}>#{child.name}<i class='fa fa-caret-right'></i></div>"
        else
          str += "<div class='category' data-category=#{child.name.gsub(' ', '_')}>#{child.name}</div>"
        end
      end
      str += "</div>"
      Category.where(parent: self.name).each do |child|
        str += child.child_cat
      end
    end    
    str.html_safe
  end
end
