class ProductsController < ApplicationController
  require 'fileutils'
  skip_before_action :authorized, only: [:index, :test_doc, :show]

	def index
    @products = Product.all
    user = current_user
    @products_in_cart = []
    if user
      shopping_cart = user.shopping_cart
      shopping_cart.products.each do |product_id, count|
        @products_in_cart.push(product_id)
      end
    end    
    # @files = Dir["public/*.docx"]
    # require "docx"  
    # docx = Caracal::Document.new("/public/example.docx")
    # p docx.iframe data: File.read('example.docx')
  end

  def new
    @product = Product.new
    @categories = Category.where(lvl: 0)
    @max_lvl = Category.max_lvl
    @providers = []
    Provider.all.each do |provider|
      @providers.push(provider.name)
    end
  end

  def create
    p params['product']
    category = Category.find_by(name: params['category'])
    provider = Provider.find_by(name: params['provider'])
    product = category.products.new
    product['attrs'] = {}.merge(product_params[:attrs])
    product['provider'] = provider[:id]
    product['name'] = params[:name]
    if product.save
      product.create_images(params['images'])
      p 'success save new product'
      redirect_to root_path
    else
      p product.errors.messages
    end
  end

  def show
    @product = Product.find(params[:id])
	end

  def edit
    @product = Product.find(params[:id])
  end

  def update
  end 

  def destroy
    if Product.find(params[:id]).destroy
      redirect_to root_path
    else
      p 'error'
    end
  end

  def new_attr
    respond_to do |format|
      format.html { render layout: false }
    end
  end

  def attrs_list 
    @attributes = Category.find_by(name: params['name']).attrs
    respond_to do |format|
      format.html { render layout: false }
    end
  end

  def test_remote
    
  end

  def test_doc
    # TestEmailMailer.notify_user(User.first).deliver
    # return
    Caracal::Document.save 'public/example.docx' do |docx|
      # page 1
      docx.h1 'Page 1 Header'
      docx.hr
      docx.p
      docx.h2 'Section 1'
      docx.p  'Lorem ipsum dolor....'
      docx.p

      # page 2
      docx.page
      docx.h1 'Page 2 Header'
      docx.hr
      docx.p
      docx.h2 'Section 2'
      docx.p  'Lorem ipsum dolor....'
      docx.ul do
        li 'Item 1'
        li 'Item 2'
      end
      docx.p
    end
    send_file(File.join(Rails.root, 'public/example.docx'))
  end
  private

   def product_params
    params.require(:product).permit(:name, images: {}, attrs: {})
  end

end
