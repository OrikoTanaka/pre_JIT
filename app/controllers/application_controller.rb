class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def set_user_id
    @user = User.find(params[:user_id])
  end

  protected

  def configure_permitted_parameters
    # サインアップ時にusernameも追加で許可する
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

end
