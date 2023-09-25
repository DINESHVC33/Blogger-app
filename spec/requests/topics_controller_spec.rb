require 'rails_helper'

RSpec.describe TopicsController, type: :controller do
  let(:valid_attributes) { { title: 'Example Title' } }
  let(:invalid_attributes) { { title: '' } }
  let(:user) { FactoryBot.create(:user) }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      topic = Topic.create! valid_attributes
      get :show, params: { id: topic.to_param }
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      topic = Topic.create! valid_attributes
      get :edit, params: { id: topic.to_param }
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new Topic and redirects to the created topic' do
        post :create, params: { topic: valid_attributes }
        expect {
          post :create, params: { topic: valid_attributes }
        }.to change(Topic, :count).by(1)
        expect(response).to redirect_to(topic_url(Topic.last))
        expect(response).to have_http_status(302)
      end
    end

  end

  describe 'PUT #update' do
    context 'with valid parameters' do
      let(:new_attributes) { { title: 'Updated Title' } }

      it 'updates the requested topic' do
        topic = Topic.create! valid_attributes
        put :update, params: { id: topic.to_param, topic: new_attributes }
        topic.reload
        expect(topic.title).to eq(new_attributes[:title])
      end

      it 'redirects to the topic' do
        topic = Topic.create! valid_attributes
        put :update, params: { id: topic.to_param, topic: valid_attributes }
        expect(response).to redirect_to(topic_url(topic))
        expect(response).to have_http_status(302)
      end
    end

    # context "PUT #update with invalid parameters" do
    #   before do
    #     @topic = FactoryBot.create(:topic) # Create a valid topic
    #   end
    #
    #   it "returns a response with :unprocessable_entity" do
    #     # Assuming you have valid @topic and invalid @invalid_attributes
    #     put :update, params: { id: @topic.id, topic: { title: "" } } # Include valid topic attributes
    #     expect(response).to have_http_status(:unprocessable_entity)
    #   end
    #
    #
    #   it "returns a response with :unprocessable_entity" do
    #     post :create, params: { topic: { title: "" } }
    #     expect(response).to have_http_status(:unprocessable_entity)
    #   end
    #
    # end
  end

  describe 'DELETE #destroy' do

    it 'destroys the requested topic' do
      topic = Topic.create! valid_attributes
      expect {
        delete :destroy, params: { id: topic.to_param }
      }.to change(Topic, :count).by(-1)
    end

    it 'redirects to the topics list' do
      topic = Topic.create! valid_attributes
      delete :destroy, params: { id: topic.to_param }
      expect(response).to redirect_to(topics_url)
      expect(response).to have_http_status(302)
    end
  end

  # Add similar tests for other actions as needed

end
