class Photo < ApplicationRecord
	belongs_to :user
	has_many :likes
	has_many :users, through: :likes
	attachment :image
	
	acts_as_taggable


	def like_user(user_id)
   		likes.find_by(user_id: user_id)
  	end
end
