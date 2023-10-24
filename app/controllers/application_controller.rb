class ApplicationController < ActionController::Base
  helper_method :current_user  

  def current_user
    if session[:user_id]
      @_current_user ||= User.find(session[:user_id]) if session[:user_id]
    else
      @_current_user = nil
    end
  end

  def current_admin?
    current_user && current_user.admin?
  end
end
