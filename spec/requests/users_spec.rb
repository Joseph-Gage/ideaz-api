# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:valid_attributes) { attributes_for(:user) }

  describe 'POST /signup' do
    context 'when request valid' do
      before { post '/signup', params: valid_attributes }

      it 'creates new user' do
        expect(response).to have_http_status(201)
      end

      it 'returns authentication token' do
        expect(json['message']).to eq(Message.user_created)
      end
    end

    context 'when request invalid' do
      before { post '/signup', params: {}, headers: headers }

      it 'does not create user' do
        expect(response).to have_http_status(422)
      end

      it 'returns failure message' do
        expect(json['message']).to match(/Validation failed: Name can't be blank, Email can't be blank, Password digest can't be blank, Password can't be blank/)
      end
    end
  end
end
