# spec/controllers/posts_controller_spec.rb

require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:topic) { FactoryBot.create(:topic) }
  let(:post) { FactoryBot.create(:post, topic: topic) }
  before do
    sign_in user
  end
  describe "GET " do
    context" index "do
    it "should return index"do
      get :index, params: { topic_id: topic.id }
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end
    end
    context"all posts"do
      it "returns a success response" do
        get :all_posts
        expect(response).to render_template("all_posts")
        expect(response).to have_http_status(:success)
      end
    end
    context"show"do

    end
  end
    end

