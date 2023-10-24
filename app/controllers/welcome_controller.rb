class WelcomeController < ApplicationController 
  def index 
    unless session[:greeting]
    session[:greeting] = "Howdy"
    end
    @users = User.all
  end 
end 