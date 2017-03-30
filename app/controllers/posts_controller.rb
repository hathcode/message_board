class PostsController < ApplicationController
	before_action :authenticate_user!, only: [:new, :create, :show]

	def index
		@posts = Post.all.order("created_at DESC")
	end

	def new
		@post = Post.new
	end

	def create
		@post = current_user.posts.create(post_params)
		if @post.valid?
			redirect_to root_path
		else
			render :new, status: :unprocessable_entity
		end
	end

	def show
		@post = Post.find_by_id(params[:id])
		@comment = Comment.new
	end

	private

	def post_params
		params.require(:post).permit(:title, :body)
	end

end
