class ProductsController < ApplicationController
  require 'fileutils'

	def index
    @products = Product.all
    # @files = Dir["public/*.docx"]
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

  def test_doc
    p '-=-=-=-=-=-=-=-=-=-=-=-='
    p params
    p true
    p '-=-=-=-=-=-=-=-=-=-=-=-='
    return 123123123
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