class UsersController < ApplicationController
  
  # Create new blank user
  def new
    @user = User.new
  end
  
  # Show existing user
  def show
    @user = User.find(params[:id])
  end
  
  # Create and save new user
  def create
    @user = User.new(user_params)
    if @user.save
      # Handle a successful save
    else
      render 'new'
    end
  end
  
  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
  
end
