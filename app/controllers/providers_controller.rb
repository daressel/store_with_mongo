class ProvidersController < ApplicationController
  def index
    @providers = Provider.all
  end

  def new
    @provider = Provider.new
  end

  def show
    @provider = Provider.find(params[:id])
    @products = Product.where(provider: @provider)
    render 'products/index'
  end

  def new_attr
    respond_to do |format|
      format.html { render layout: false }
    end
  end
  
  def create
    provider = Provider.new(provider_params)
    if provider.save
      redirect_to providers_path
    end
  end

  def provider_params
    params.require(:provider).permit(:name)
  end
end