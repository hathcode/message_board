require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
	before(:each) do
		request.env["HTTP_REFERER"] = "where_i_came_from"
	end
  describe "comments#create action" do
    it "should allow users to create comments on grams" do
      p = FactoryGirl.create(:post)
      u = FactoryGirl.create(:user)
      sign_in u

      post :create, post_id: p.id, comment: {body: 'awesome post'}

      expect(response).to redirect_to "where_i_came_from"
      expect(p.comments.length).to eq 1
      expect(p.comments.first.body).to eq "awesome post"
    end

    it "should require a user to be logged in to comment on a post" do
      p = FactoryGirl.create(:post)
      post :create, post_id: p.id, comment: {body: 'awesome post'}
      expect(response).to redirect_to new_user_session_path
    end

    it "should return http status code of not found if the post is not found" do
      u = FactoryGirl.create(:user)
      sign_in u
      post :create, post_id: 'YOLOSWAG', comment: {body: 'awesome post'}
      expect(response).to have_http_status :not_found
    end
  end


end
