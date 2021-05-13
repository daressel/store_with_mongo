class Authentication::SessionController < ApplicationController
  skip_before_action :authorized

  def new
  end

  def create
    begin
      if params[:login].include?('@')
        @user = User.find_by(email: params[:login])
      else
        @user = User.find_by(username: params[:login])
      end
      if @user && @user.authenticate(params[:password])
        if @user.email_confirmed
          session[:user_id] = @user.id
          redirect_to products_path
        else
          redirect_to login_path, error: { login: ['Пожалуйста, активируйте свою учетную запись, следуя инструкциям, которые были отправлени на ваш email']}
        end
      else  
        redirect_to login_path, warning: 'Неверный пароль'
      end
    rescue
      redirect_to login_path, error: { login: ['Пользоватьеля с таким логином нет']}
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end
end
