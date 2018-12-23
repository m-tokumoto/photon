class Article < ApplicationRecord
	validates :text, presence: true
	validates :title, presence: true
	belongs_to :user
end
