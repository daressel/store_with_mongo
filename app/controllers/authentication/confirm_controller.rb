class Authentication::ConfirmController < ApplicationController
  skip_before_action :authorized
  
  def confirm_email
    begin
      user = User.find_by(confirm_token: params[:id])
      user.email_activate
      redirect_to login_path, success: 'Ваша учетная запись успешно подтверждена'
    rescue
      flash[:error] = "Извинте, данный пользователь не существует"
      redirect_to root_path
    end
  end
end
