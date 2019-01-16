class PhotosController < ApplicationController
	def new
		@photo = Photo.new
	end

	def create
		photo = Photo.new(photo_params)
		photo.user_id = current_user.id
		if photo.save
			redirect_to photos_path
		else
			@photo = Photo.new
			redirect_to new_photo_path, alert:'投稿写真を選択してください'
		end
	end

	def index
	    @query = Photo.ransack(params[:q])
		@users = User.where.not(id: 1).order("follower_count DESC").limit(10)
		@tags = ActsAsTaggableOn::Tag.most_used
		@photos = @query.result.page(params[:page]).per(45).order("created_at DESC")
	end

	def show
		@photo = Photo.find(params[:id])
		@likes = Like.where(photo_id: params[:id])
	end

	def destroy
		photo = Photo.find(params[:id])
		photo.destroy
		redirect_back(fallback_location: root_path)
	end

	def follow
		@query = Photo.ransack(params[:q])
		@users = User.where.not(id: 1).order("follower_count DESC").limit(10)
		@tags = ActsAsTaggableOn::Tag.most_used
		if params[:q].present?
			@photos = @query.result.page(params[:page]).per(30).order("created_at DESC")
		else
			if user_signed_in?
				@tags = ActsAsTaggableOn::Tag.most_used
				@users = User.where.not(id: 1).order("follower_count DESC").limit(10)
				@following_users = current_user.followings
				@photos = []
				if @following_users.present?
			        @following_users.each do |user|
			          photos = Photo.where(user_id: user.id).order(created_at: :desc)
			          @photos.concat(photos)
			        end
			    end
			    @photos.sort_by!{|photo| photo.created_at}.reverse!
			else
				redirect_to root_path
			end
		end
	end

	def tag_show
		@query = Photo.ransack(params[:q])
		@users = User.where.not(id: 1).order("follower_count DESC").limit(10)
		@tags = ActsAsTaggableOn::Tag.most_used
		if params[:q].present?
			@photos = @query.result.order("created_at DESC")
		else
			@photos = Photo.tagged_with("#{params[:tag_name]}").order("created_at DESC")
		end
		@tag_name = params[:tag_name]
	end

	def tag_search
	    @query = Photo.ransack(params[:q])
		@photos = @query.result.order("created_at DESC")
		@users = User.where.not(id: 1).order("follower_count DESC").limit(10)
		@tags = ActsAsTaggableOn::Tag.most_used
		render :index
	end

	private
		def photo_params
			params.require(:photo).permit(:user_id, :image, :tag_list)
		end

end
