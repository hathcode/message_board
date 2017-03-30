class PostsController < ApplicationController
	before_action :authenticate_user!, only: [:new, :create]

	def index
		@posts = Post.all.order("created_at DESC")
	end

	def new
		@post = Post.new
	end

	def create
		current_user.posts.create(post_params)
		redirect_to root_path
	end

	def show
		@post = Post.find(params[:id])
		@comment = Comment.new
	end

	private

	def post_params
		params.require(:post).permit(:title, :body)
	end

end
