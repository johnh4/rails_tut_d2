class MicropostsController < ApplicationController

	before_action :signed_in_user, only: [:create, :destroy]
	before_action :correct_user, only: [:destroy]

	def create
		@micropost = current_user.microposts.build(micropost_params)
		if @micropost.save
			flash[:success] = "Micropost created!"
			redirect_to root_path
		else
			flash.now[:error] = "Error creating micropost."
			@feed_items = []
			render 'static_pages/home'
		end
	end

	def destroy
		@micropost = current_user.microposts.find_by(params[:id]).destroy
		flash[:success] = "Micropost destroyed!"
		redirect_to current_user
	end


	private

		def micropost_params
			params.require(:micropost).permit(:content)
		end

		#before actions

		def correct_user
			@micropost = current_user.microposts.find_by(id: params[:id])
			redirect_to root_path if @micropost.nil?
		end
end
