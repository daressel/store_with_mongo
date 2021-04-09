class ProductsController < ApplicationController

	def index
    @products = Product.all
    # @files = Dir["public/*.docx"]
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

  def new_attr
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
end