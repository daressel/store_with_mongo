class ProductsController < ApplicationController

	def index
    @products = Product.all
  end

  def new
    @providers = []
    Provider.all.each do |provider|
      @providers.push(provider.name)
    end
  end

  def create
    product = Product.new
    product.name = params[:name]
    product.provider_id = Provider.find_by(name: params[:provider]).id.to_s
    product_attributes = []
    params[:namesAttr].each_with_index do |name, i|
      product_attributes.push([name, params[:valuesAttr][i]])
    end
    product.product_attributes = product_attributes
    product.save
    redirect_to root_path
  end

  def show
	end

  def edit
  end

  def update
  end 

  def desrtoy
  end  
end