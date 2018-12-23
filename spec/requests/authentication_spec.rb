require 'rails_helper'

RSpec.describe 'Authentication API', type: :request do
  describe 'POST /signin' do
    let!(:user) { create(:user) }
    let(:credentials) { { email: user.email, password: user.password } }
    before { post '/signin', params: credentials }

    context 'when the request is valid' do
      it 'returns an authentication token' do
        expect(json['token']).not_to be_nil
      end

      it 'returns status OK' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the request is invalid' do
      let(:credentials) do
        {
          email: Faker::Internet.email, password: Faker::Internet.password
        }
      end

      it 'returns status UNAUTHORIZED with message' do
        expect(response).to have_http_status(401)
        expect(json['message']).to match(Message.invalid_credentials)
      end
    end
  end
end
