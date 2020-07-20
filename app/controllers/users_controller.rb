class UsersController < ApplicationController
  
  # New blank user
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
      log_in @user
      flash[:success] = "Hi " + @user.name + ", welcome to CoffeeRun!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
  
end
