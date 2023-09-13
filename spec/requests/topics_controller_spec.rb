# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TopicsController, type: :controller do
  describe 'GET #index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    it 'renders the show template' do
      topic = create(:topic) # This line creates a topic using the :topic factory
      get :show, params: { id: topic.id }
      expect(response).to render_template(:show)
    end
  end

  describe 'GET #new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'GET #edit' do
    it 'renders the edit template' do
      topic = create(:topic)
      get :edit, params: { id: topic.id }
      expect(response).to render_template(:edit)
    end
  end

  describe 'POST #create' do
    it 'creates a new topic' do
      expect do
        post :create, params: { topic: { title: 'New Topic' } }
      end.to change(Topic, :count).by(1)
    end
  end

  describe 'PATCH #update' do
    it 'updates the topic' do
      topic = create(:topic)
      patch :update, params: { id: topic.id, topic: { title: 'Updated Topic' } }
      topic.reload
      expect(topic.title).to eq('Updated Topic')
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the topic' do
      topic = create(:topic)
      expect do
        delete :destroy, params: { id: topic.id }
      end.to change(Topic, :count).by(-1)
    end
  end


  #---------http test-----------------

  describe 'GET #index' do
    it 'returns a successful response' do
      get :index
      expect(response).to have_http_status(200) # 200 OK
    end
  end

  describe 'GET #show' do
    it 'returns a successful response' do
      topic = Topic.create(title: 'Test Topic')
      get :show, params: { id: topic.id }
      expect(response).to have_http_status(200) # 200 OK
    end
  end

  describe 'GET #new' do
    it 'returns a successful response' do
      get :new
      expect(response).to have_http_status(200) # 200 OK
    end
  end

  describe 'GET #edit' do
    it 'returns a successful response' do
      topic = Topic.create(title: 'Test Topic')
      get :edit, params: { id: topic.id }
      expect(response).to have_http_status(200) # 200 OK
    end
  end

  describe 'POST #create' do
    it 'returns a successful response' do
      post :create, params: { topic: { title: 'New Topic' } }
      expect(response).to have_http_status(302) # 302 Found (assuming a redirect after create)
    end
  end

  describe 'PATCH #update' do
    it 'returns a successful response' do
      topic = Topic.create(title: 'Test Topic')
      patch :update, params: { id: topic.id, topic: { title: 'Updated Title' } }
      expect(response).to have_http_status(302) # 302 Found (assuming a redirect after update)
    end
  end

  describe 'DELETE #destroy' do
    it 'returns a successful response' do
      topic = Topic.create(title: 'Test Topic')
      delete :destroy, params: { id: topic.id }
      expect(response).to have_http_status(302) # 302 Found (assuming a redirect after delete)
    end
  end

  #---------------------------END-------------------
end