class UsersController < ApplicationController
  def new
  	@user = User.new
  end

  def create
  	@user = User.create(user_params)
  	if @user.save
  		flash[:success] = "Signup successful!"
  		redirect_to @user
  	else
  		flash.now[:error] = "Signup failed."
  		render 'new'
  	end
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])
  	if @user.update_attributes(user_params)
  		flash[:success] = "Update successful!"
  		redirect_to @user
  	else
  		flash.now[:error] = "Update failed."
  		render 'edit'
  	end
  end

  def show
  end

  def index
  end

  
  private

  	def user_params
  		params.require(:user).permit(:name, :email, :password, :password_confirmation)
  	end

end
