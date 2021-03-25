class CategoriesController < ApplicationController

  def index
    @categories = Category.where(lvl: 1)
  end

  def new
    @category = Category.new
    @categories = []
    Category.all.each do |cat|
      @categories.push(cat.name)
    end
  end

  def show
  end

  def create    
    @category = Category.new(category_params)
    @parent = Category.find_by(name: category_params[:parent])
    @category.lvl = @parent.lvl + 1
    @category.name_view = category_params[:name].gsub(' ', '_')    
    if @category.save
      @parent.childs.push(@category.name)
      @parent.save
    else
      p @category.errors.messages
    end

  end

  def update
  end

  def edit
  end

  def destroy
  end

  private

  def category_params
    params.require(:category).permit(:name, :parent)
  end

end
