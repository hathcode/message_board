require 'rails_helper'

RSpec.describe PostsController, type: :controller do
	describe "posts#index action" do
		it "should successfully show the page" do
			get :index
			expect(response).to have_http_status(:success)
		end
	end

	describe "posts#new action" do

		it "should require users to be logged in" do
			get :new
			expect(response).to redirect_to new_user_session_path
		end

		it "should successfully show the new post form" do
			user = FactoryGirl.create(:user)
			sign_in user

			get :new
			expect(response).to have_http_status(:success)
		end
	end

	describe "posts#create action" do 
    it "should require users to be logged in" do
      post :create, post: { body: "Hello" }
      expect(response).to redirect_to new_user_session_path
    end
    
    it "should successfully create a new post in our database" do
      user = FactoryGirl.create(:user)
      sign_in user
      
      post :create, post: { title: 'Title', body: 'Hello!'}
      expect(response).to redirect_to root_path
      
      post = Post.last
      expect(post.body).to eq("Hello!")
      expect(post.user).to eq(user)
    end

    it "should properly deal with validation errors" do
      user = FactoryGirl.create(:user)
      sign_in user
      
		  post :create, post: { body: nil, title: nil }
		  expect(response).to have_http_status(:unprocessable_entity)
		  expect(Post.count).to eq 0
		end
  end

  describe "posts#show action" do
  	it "should require users to be logged in to view post details" do
  		p = FactoryGirl.create(:post)
  		get :show, id: p.id
  		expect(response).to redirect_to new_user_session_path
  	end
  end

end
