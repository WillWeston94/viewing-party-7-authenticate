class SessionsController < ApplicationController

  def new
    if current_user
      redirect_to user_path(current_user.id)
    end
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user[:id]   
      flash[:success] = "Welcome, #{user.name}!"

      if user.admin?
        redirect_to admin_dashboard_path
      elsif user.manager?
        redirect_to user_path(user.id)
      else
        redirect_to user_path(user.id)
      end

    else
      flash[:error] = "Email or password is incorrect"
      redirect_to new_session_path
    end
  end


  def destroy
    session.delete(:user_id)
    flash[:success] = "You have been logged out"
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end