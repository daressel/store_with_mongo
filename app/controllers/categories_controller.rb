class CategoriesController < ApplicationController

  def index
    @categories = Category.where(lvl: 1)
    @max_lvl = Category.max_lvl
  end

  def new
    @category = Category.new
    @categories = Category.where(lvl: 0)
    @max_lvl = Category.max_lvl
  end

  def show
  end

  def create 
    p params['parent']
    p params['name']
    params['attributes'].each do |key, value|
      p "#{key}, #{value}"
    end
    return
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

  def new_attr
    respond_to do |format|
      format.html { render layout: false }
    end
  end

  private

  def category_params
    params.require(:category).permit(:name, :parent)
  end

end
