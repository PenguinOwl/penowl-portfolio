class ApplicationController < ActionController::Base
  def user_flag(*flags)
    success = false
    flags.each do |flag|
      flag = flag.to_s
      userFlag = UserFlag.find_by(user: current_user.id, content: flag)
      if userFlag
        success = true
      end
    end
    unless success
      redirect_back fallback_location: "/", :notice => "You do not have permission to access that page."
    end
  end
  def check_user_flag(*flags)
    success = false
    flags.each do |flag|
      flag = flag.to_s
      userFlag = UserFlag.find_by(user: current_user.id, content: flag)
      if userFlag
        success = true
      end
    end
    return success
  end

  helper_method :check_user_flag
  helper_method :user_flag

end
