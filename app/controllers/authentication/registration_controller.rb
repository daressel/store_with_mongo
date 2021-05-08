class Authentication::RegistrationController < ApplicationController
  skip_before_action :authorized, :only => [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.create(registration_params)
    if @user.valid?
      @user.save
      redirect_to login_path, notice: 'Вы были успешно зарегестрированы.'
    else  
      redirect_to registrations_path, error: @user.errors
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def registration_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end
end