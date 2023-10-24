class Admin::DashboardController < ApplicationController
  before_action :require_admin

  def index
    @users = User.default 
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  private
    def require_admin
      redirect_to root_path unless current_admin? 
      flash[:error] = "You must be an admin to access this page"
    end
end