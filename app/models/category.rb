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

  def child_cat_new(type_model) # рекурсивная функция
    str = ''
    if self.children.any? 
      str = "<div class='square category-list lvl-#{self.lvl + 1}' id=#{self.name.gsub(' ', '_')} data-lvl=#{self.lvl + 1}>"
      self.children.each do |child|
        if child.children.any? # если есть подкатегории, то добавить стрелочку
          str += "<div class='category_new' data-category=#{child.name.gsub(' ', '_')} data-action='click->#{type_model}#clickCategory'>#{child.name}<i class='fa fa-caret-right'></i></div>"
        else # иначе просто названеие
          str += "<div class='category_new' data-category=#{child.name.gsub(' ', '_')} data-action='click->#{type_model}#clickCategory'>#{child.name}</div>"
        end
      end
      str += "</div>"
      self.children.each do |child|
        str += child.child_cat_new(type_model)
      end
    end    
    str.html_safe
  end

  def child_cat_search# рекурсивная функция
    str = ''
    if self.children.any? 
      str = "<div class='square category-list lvl-#{self.lvl + 1}' id=#{self.name.gsub(' ', '_')} data-lvl=#{self.lvl + 1}>"
      self.children.each do |child|
        if child.children.any? # если есть подкатегории, то добавить стрелочку
          str += "<div class='category_search' data-category=#{child.name.gsub(' ', '_')}>#{child.name}<i class='fa fa-caret-right'></i></div>"
        else # иначе просто названеие
          str += "<div class='category_search' data-category=#{child.name.gsub(' ', '_')}>#{child.name}</div>"
        end
      end
      str += "</div>"
      self.children.each do |child|
        str += child.child_cat_search
      end
    end    
    str.html_safe
  end

  def self.max_lvl
    Category.all.pluck(:lvl).max
  end
end
