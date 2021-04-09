class ApplicationController < ActionController::Base
  before_action :units

  def units
    @units = ['мм', 'м', 'см', 'л', 'шт']
  end
end
