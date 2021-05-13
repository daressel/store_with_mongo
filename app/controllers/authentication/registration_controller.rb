class Authentication::RegistrationController < ApplicationController
  skip_before_action :authorized, :only => [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.create(registration_params)
    if @user.valid?
      @user.save
      ConfirmRegistrationMailer.notify_user(@user).deliver
      redirect_to login_path, success: 'Вы были успешно зарегестрированы. Проверьте письмо, которое было прислано на Ваш email'
    else  
      redirect_to registrations_path, error: @user.errors
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def forgot_password
  end

  private

  def registration_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
