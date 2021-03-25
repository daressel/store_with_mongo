class ProvidersController < ApplicationController
  def index
    @providers = Provider.all
  end

  def new
    puts("-=-=-=-=-=-=-=-=-=-=-\n #{params}-=-=-=-=-=-=-=-=-=-=-\n" )
  end

  def new_attr
    respond_to do |format|
      format.html { render layout: false }
    end
  end
  
  def create
    provider = Provider.new
    provider.name = params[:name]
    provider.save
    redirect_to providers_path
  end
end