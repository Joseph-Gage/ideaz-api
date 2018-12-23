# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AuthorizeRequest do
  let(:user) { create(:user) }
  let(:header) { valid_headers(user.id) }
  subject(:request_obj) { described_class.new(header) }
  subject(:invalid_request_obj) { described_class.new({}) }

  describe '#call' do
    context 'when request valid' do
      it 'returns user object' do
        result = request_obj.call
        expect(result).to eq(user)
      end
    end

    context 'when request invalid' do
      context 'when token missing' do
        it 'raises MissingToken error' do
          expect { invalid_request_obj.call }
            .to raise_error(ExceptionHandler::MissingToken, Message.missing_token)
        end
      end

      context 'when token invalid' do
        subject(:invalid_request_obj) do
          described_class.new('Authorization' => token_generator(-1))
        end

        it 'raises InvalidToken error' do
          expect { invalid_request_obj.call }
            .to raise_error(ExceptionHandler::InvalidToken, /Invalid services token/)
        end
      end

      context 'when token expired' do
        let(:header) { { 'Authorization' => expired_token_generator(user.id) } }
        subject(:request_obj) { described_class.new(header) }

        it 'raises ExpiredToken error' do
          expect { request_obj.call }
            .to raise_error(ExceptionHandler::InvalidToken, /Signature has expired/)
        end
      end

      context 'when token fake' do
        let(:header) { { 'Authorization' => 'fake' } }
        subject(:invalid_request_obj) { described_class.new(header) }

        it 'raises InvalidToken error' do
          expect { invalid_request_obj.call }
            .to raise_error(
              ExceptionHandler::InvalidToken,
              /Not enough or too many segments/
            )
        end
      end
    end
  end
end
