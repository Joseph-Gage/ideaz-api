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
  end
end
