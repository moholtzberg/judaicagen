class RegistrationsController < Devise::RegistrationsController
  respond_to :html, :json, :js
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  def registration_params
    params.require(:user).permit(:email, :first_name, :last_name, :user_name, :password, :password_confirmation)
  end
end