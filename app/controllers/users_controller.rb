class UsersController < ApplicationController

  before_action :signed_in_user, only: [:edit, :update, :index, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: [:destroy]

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
    @users = User.all.paginate(page: params[:page])
  end

  
  private

  	def user_params
  		params.require(:user).permit(:name, :email, :password, :password_confirmation)
  	end

    #before actions
    def correct_user
      @user = User.find(params[:id])
      redirect_to root_path unless current_user?(@user)
    end

    def admin_user
      redirect_to root_path unless current_user.admin?
    end
end
