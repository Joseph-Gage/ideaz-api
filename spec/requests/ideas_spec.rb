# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Ideas', type: :request do
  let!(:ideas) { create_list(:idea, 10) }
  let(:idea_id) { ideas.first.id }

  describe 'GET /ideas' do
    before { get '/ideas' }

    it 'returns ideas with status OK' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
      v
    end
  end

  describe 'GET /ideas/:id' do
    before { get "/ideas/#{idea_id}" }

    context 'when record exists' do
      it 'returns idea with status OK' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(idea_id)
        expect(request).to have_http_status(200)
      end
    end

    context 'when record does not exist' do
      let(:idea_id) { -1 }

      it 'returns not found message with status NOT FOUND' do
        expect(json['message']).to match(/Couldn't find Idea/)
        expect(request).to have_http_status(404)
      end
    end
  end

  describe 'POST /ideas' do
    let(:valid_attributes) { attributes_for(:idea) }

    context 'when request valid' do
      before { post '/ideas', params: valid_attributes }

      it 'creates idea with status CREATED' do
        expect(json['data']['attributes']['title']).to eq(valid_attributes['title'])
        expect(response).to have_http_status(201)
      end
    end

    context 'when request invalid' do
      before { post '/ideas', params: {} }

      it 'returns failure message with status UNPROCESSABLE ENTITY' do
        expect(json['message']).to match(/Validation failed: Title can't be blank/)
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'PUT /ideas/:id' do
    let(:valid_attributes) { { title: 'A Changed Idea' } }
    before { put "/ideas/#{idea_id}", params: valid_attributes }

    context 'when record exists' do
      it 'updates idea with status NO CONTENT' do
        expect(response.body).to be_empty
        expect(response).to have_http_status(204)
      end
    end

    context 'when record does not exist' do
      let(:idea_id) { -1 }

      it 'returns not found message with status NOT FOUND' do
        expect(json['message']).to match(/Couldn't find Idea/)
        expect(request).to have_http_status(404)
      end
    end
  end

  describe 'DELETE /ideas/:id' do
    before { delete "/ideas/#{idea_id}" }

    it 'deletes idea with status 204' do
      expect(Idea.find(idea_id)).to be_nil
      expect(response).to have_http_status(204)
    end
  end
end
