class ApplicationController < ActionController::Base
  def user_flag(*flags)
    success = false
    flags.each do |flag|
      flag = flag.to_s
      userFlagss = current_user.user_flags.map { |e| e.content  }
      if userFlags.include? flag
        success = true
      end
    end
    unless success
      redirect_back fallback_location: "/", :notice => "You do not have permission to access that page."
    end
  end
  def check_user_flag(*flags)
    success = false
    if current_user
      flags.each do |flag|
        flag = flag.to_s
        userFlags = current_user.user_flags.map { |e| e.content  }
        if userFlags.include? flag
          success = true
        end
      end
    end
    return success
  end

  helper_method :check_user_flag
  helper_method :user_flag

end
