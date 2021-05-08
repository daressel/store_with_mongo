class Authentication::SessionController < ApplicationController
  skip_before_action :authorized

  def new
  end

  def create
    begin
      @user = User.find_by(username: params[:username])
      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect_to products_path
      else  
        redirect_to login_path
      end
    rescue
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end
end