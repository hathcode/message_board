class Post < ActiveRecord::Base
	validates :title, presence: true
	validates :body, presence: true
	belongs_to :user
	has_many :comments

	require 'date'

	def created_datetime
		puts Time.at(created_at).to_datetime
	end


end
