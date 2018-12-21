class PhotosController < ApplicationController
	def new
		@photo = Photo.new
	end

	def create
		photo = Photo.new(photo_params)
		photo.user_id = current_user.id
		photo.save
		redirect_to photos_path
	end

	def index
		@users = User.all
		@photos = Photo.all
		@tags = ActsAsTaggableOn::Tag.most_used
	end

	def show
		@photo = Photo.find(params[:id])
		@likes = Like.where(photo_id: params[:id])
	end

	def destroy
	end

	def follow
		@photo = Photo.all
	end

	def tag_show
		@users = User.all
		@photos = Photo.tagged_with("#{params[:tag_name]}")
		@tags = ActsAsTaggableOn::Tag.most_used
		@tag_name = params[:tag_name]
	end

	private
		def photo_params
			params.require(:photo).permit(:user_id, :image, :tag_list)
		end

end
