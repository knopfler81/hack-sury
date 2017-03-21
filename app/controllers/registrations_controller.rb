class RegistrationsController < Devise::RegistrationsController

  private

  def after_update_path_for(resource)
    if session[:redirect_to].present?
      url = session[:redirect_to]
      session[:redirect_to] = nil
      url
    else
      user_path(resource)
    end
  end

  def sign_up_params
   params.require(:user).permit(:first_name, :last_name, :nickname, :avatar,:email, :password, :password_confirmation, :current_password)
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :nickname, :avatar, :email, :bio, :birth_date, :driving_licence,  :password, :password_confirmation, :current_password)
  end
end

