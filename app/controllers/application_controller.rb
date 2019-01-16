class ApplicationController < ActionController::Base

	before_action :configure_permitted_parameters, if: :devise_controller?
	before_action :user_follower_count

	def user_follower_count
		@user = User.all
		@user.each do |user|
			user.follower_count = user.followers.count
			user.save
		end
	end

	  protected

	  def configure_permitted_parameters
	    #strong parametersを設定し、nameを許可
	    devise_parameter_sanitizer.permit(:sign_up, keys:[:name, :password, :password_confirmation] )
	  end

end
