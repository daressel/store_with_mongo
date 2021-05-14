class ApplicationController < ActionController::Base
  add_flash_types :info, :error, :warning, :success
  before_action :units
  helper_method :logged_in?, :current_user
  before_action :authorized

  def current_user
    # session[:user_id] = nil
    if session[:user_id]
      @user = User.find(session[:user_id])
    end
  end

  def logged_in?
    !!current_user
  end

  def authorized    
    redirect_to login_path, warning: 'Необходимо авторизоваться' unless logged_in?
  end

  def units
    @units = ['мм', 'м', 'см', 'л', 'шт', 'без единицы измерения']
  end
end
