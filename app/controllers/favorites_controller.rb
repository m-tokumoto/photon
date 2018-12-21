class FavoritesController < ApplicationController
	def index
		@user = User.find(params[:user_id])
		@users = @user.followings
		@photos = []
		if @users.present?
			@users.each do |user|
				photos = Photo.where(user_id: user.id).order(created_at: :desc)
				@photos.concat(photos)
			end
		else
	        flash[:notice]="誰かをフォローしてみましょう！"
	        redirect_to("/")
	    end

	end
end
