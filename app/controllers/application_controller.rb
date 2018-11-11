class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if:  :devise_controller?

  def user_flag(*flags)
    success = false
    if current_user
      userFlags = current_user.user_flags.map { |e| e.content  }
      flags.each do |flag|
        flag = flag.to_s
        if userFlags.include? flag
          success = true
        end
      end
    end
    unless success
      redirect_back fallback_location: "/", :notice => "You do not have permission to access that page."
    end
  end
  def check_user_flag(*flags)
    success = false
    if current_user
      userFlags = current_user.user_flags.map { |e| e.content }
      flags.each do |flag|
        flag = flag.to_s
        if userFlags.include? flag
          success = true
        end
      end
    end
    return success
  end

  protected
  def configure_permitted_parameters

    added_attrs = [:username, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs

  end

  helper_method :check_user_flag
  helper_method :user_flag

end
