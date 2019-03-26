# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'POST /register' do
    context 'when request valid' do
      let(:valid_attributes) { attributes_for(:user) }
      before { post '/register', params: valid_attributes }

      it 'creates new user' do
        expect(response).to have_http_status(201)
      end

      it 'returns authentication token' do
        expect(json['message']).to eq(Message.user_created)
      end
    end

    context 'when request invalid' do
      before { post '/register', params: {}, headers: headers }

      it 'does not create user' do
        expect(response).to have_http_status(422)
      end

      it 'returns failure message' do
        expect(json['message']).to match(/Validation failed/)
      end
    end
  end

  describe 'GET /me' do
    context 'when user logged in' do
      let(:user) { create(:user) }
      let(:headers) { valid_headers(user.id) }
      before { get '/me', headers: headers }

      it 'returns current user with status OK' do
        expect(json['id']).to eq(user.id)
        expect(response).to have_http_status(200)
      end
    end
  end
end
