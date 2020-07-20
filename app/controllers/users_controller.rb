class UsersController < ApplicationController
  
  # Create new user
  def new
    @user = User.new
  end
  
  # Show existing user
  def show
    @user = User.find(params[:id])
  end
  
end
