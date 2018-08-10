# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Ideas', type: :request do
  let(:user) { create(:user) }
  let(:sneaky_user) { create(:user) }
  let!(:ideas) { create_list(:idea, 10, user_id: user.id) }
  let(:idea_id) { ideas.first.id }
  let(:headers) { valid_headers }

  describe 'GET /ideas' do
    before { get '/ideas' }

    it 'returns ideas with status OK' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end
  end

  describe 'GET /ideas/:id' do
    before { get "/ideas/#{idea_id}" }

    context 'when record exists' do
      it 'returns idea with status OK' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(idea_id)
        expect(response).to have_http_status(200)
      end
    end

    context 'when record does not exist' do
      let(:idea_id) { -1 }

      it 'returns not found message with status NOT FOUND' do
        expect(json['message']).to match(/Couldn't find Idea/)
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'POST /ideas' do
    let(:valid_attributes) do
      { title: 'New Idea', description: 'my newest idea' }
    end

    context 'when request valid' do
      before { post '/ideas', params: valid_attributes, headers: headers }

      it 'creates idea with status CREATED' do
        expect(json['data']['attributes']['title']).to eq(valid_attributes[:title])
        expect(json['data']['attributes']['userId']).to eq(user.id)
        expect(response).to have_http_status(201)
      end
    end

    context 'when request invalid' do
      before { post '/ideas', params: {}, headers: headers }

      it 'returns failure message with status UNPROCESSABLE ENTITY' do
        expect(json['message']).to match(/Validation failed/)
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'PUT /ideas/:id' do
    let(:valid_attributes) { { title: 'A Changed Idea' } }
    before { put "/ideas/#{idea_id}", params: valid_attributes, headers: headers }

    context 'when user owns record' do
      it 'updates idea with status NO CONTENT' do
        expect(Idea.find(idea_id).title).to eq('A Changed Idea')
        expect(response.body).to be_empty
        expect(response).to have_http_status(204)
      end
    end

    context 'when user does not own record' do
      let(:headers) { auth_header(sneaky_user.id) }

      it 'returns status UNAUTHORIZED' do
        expect(json['message']).to match(/Invalid permission/)
        expect(response).to have_http_status(401)
      end
    end

    context 'when record does not exist' do
      let(:idea_id) { -1 }

      it 'returns not found message with status NOT FOUND' do
        expect(json['message']).to match(/Couldn't find Idea/)
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'DELETE /ideas/:id' do
    before { delete "/ideas/#{idea_id}", headers: headers }

    context 'when user owns record' do
      it 'deletes idea with status 204' do
        expect { Idea.find(idea_id) }.to raise_error(ActiveRecord::RecordNotFound)
        expect(response).to have_http_status(204)
      end
    end

    context 'when user does not own record' do
      let(:headers) { auth_header(sneaky_user.id) }

      it 'returns status UNAUTHORIZED' do
        expect(Idea.find(idea_id)).not_to be_nil
        expect(json['message']).to match(/Invalid permission/)
        expect(response).to have_http_status(401)
      end
    end
  end
end
