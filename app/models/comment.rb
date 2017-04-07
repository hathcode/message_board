class Comment < ActiveRecord::Base
	belongs_to :post
	belongs_to :user

	require 'date'

	def created_datetime
		puts Time.at(created_at).to_datetime
	end
end
