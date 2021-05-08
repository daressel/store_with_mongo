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
    @category = Category.find(params[:id])
  end

  def create    
    parent = Category.find_by(name: params['parent'])
    category = parent.children.new
    category.attrs = parent['attrs'].merge(params['attributes'])
    category.lvl = parent['lvl'] + 1
    category.name = params['name']
    if category.save
      p 'success save new category'
      redirect_to root_path
    else
      p category.errors.messages
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
