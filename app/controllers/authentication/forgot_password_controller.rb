class Authentication::ForgotPasswordController < ApplicationController
  skip_before_action :authorized
  
  def forgot_password
  end

  def new_password
  end

  def send_mail
    begin
      user = User.find_by(email: params[:email])
      user.set_forgot_token
      ForgotPasswordMailer.notify_user(user).deliver
      redirect_to login_path, success: 'На Вашу почту было отправлено письмо'      
    rescue
      redirect_to forgot_password_path, error: {email: ['Пользователя с такой почтой нет']}
    end
  end

  def create_new_password
    begin
      user = User.find_by(forgot_token: params[:id])
      user.update(forgot_password_params)
      user.set_forgot_nil
      redirect_to login_path, success: 'Пароль успешно изменен'
    rescue
      redirect_to forgot_password_path, warning: 'Данный ключ устарел, отправьте письмо снова'
    end
    
  end

  def forgot_password_params
    params.permit(:password, :password_confirmation)
  end
end
