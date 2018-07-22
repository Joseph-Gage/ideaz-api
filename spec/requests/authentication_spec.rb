require 'rails_helper'

RSpec.describe 'Authentication', type: :request do
  describe 'POST /auth/sign-in' do
    let!(:user) { create(:user) }
    let(:headers) { valid_headers.except('Authorization') }
    let(:valid_credentials) do
      {
        email: user.email,
        password: user.password
      }.to_json
    end
    let(:invalid_credentials) do
      {
        email: Faker::Internet.email,
        password: Faker::Internet.password
      }.to_json
    end

    context 'when request valid' do
      before { post '/auth/sign-in', params: valid_credentials, headers: headers }

      it 'returns authentication token' do
        expect(json['data']['attributes']['accessToken']).not_to be_nil
      end
    end

    context 'when request invalid' do
      before { post '/auth/sign-in', params: invalid_credentials, headers: headers }

      it 'returns failure message' do
        expect(json['message']).to match(/Invalid credentials/)
      end
    end
  end
end
