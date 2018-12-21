class LikesController < ApplicationController

	def create
		photo = Photo.find(params[:photo_id])
		like = current_user.likes.new(photo_id: params[:photo_id])
		like.save
		redirect_back(fallback_location: root_path)
	end

	def destroy
		photo = Photo.find(params[:photo_id])
		like = Like.find_by(user_id: current_user.id, photo_id: params[:photo_id])
	    like.destroy
	    redirect_back(fallback_location: root_path)
	end

end
