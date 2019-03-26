# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  describe '#identify_user' do
    let!(:user) { create(:user) }
    let(:headers) { valid_headers(user.id) }
    before { allow(request).to receive(:headers).and_return(headers) }

    context 'when a valid token is received' do
      it 'returns the current user' do
        expect(subject.instance_eval { identify_user }).to eq(user)
      end
    end

    context 'when an invalid token is received' do
      let(:headers) { invalid_headers }

      it 'raises invalid token error' do
        expect { subject.instance_eval { identify_user } }
          .to raise_error(ExceptionHandler::InvalidToken)
      end
    end

    context 'when no token is received' do
      let(:headers) { {} }

      it 'raises invalid token error' do
        expect { subject.instance_eval { identify_user } }
          .to raise_error(ExceptionHandler::MissingToken)
      end
    end
  end
end
