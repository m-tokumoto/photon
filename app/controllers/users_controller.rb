class UsersController < ApplicationController
	before_action :correct_user,   only: [:edit, :update]

	def show
		@user  = User.find(params[:id])
		@calendar_photos = Photo.where(user_id: params[:id])
		@photos = Photo.where(user_id: @user.id)
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update(user_params)
			alert = '更新されました'
			redirect_to user_path
		else
			redirect_to user_path
		end
	end

	def favorite
		@user  = User.find(params[:user_id])
		@calendar_photos = Photo.where(user_id: @user.id)
		@photos = @user.like_photos
	end

	def following
        @user  = User.find(params[:id])
        @users = @user.followings
        render 'show_follow'
    end

  	def followers
    	@user  = User.find(params[:id])
    	@users = @user.followers
    	render 'show_follower'
  	end

  	def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless @user == current_user
    end

  	private

  	def user_params
  		params.require(:user).permit(:name, :email, :image, :camera, :introduction)
  	end

end
