# frozen_string_literal: true

class AuthorizeRequest
  def initialize(headers = {})
    @headers = headers
  end

  def call
    user
  end

  private

  attr_reader :headers

  def user
    @user ||= User.find(decoded_token[:user_id]) if decoded_token
  rescue ActiveRecord::RecordNotFound
    raise ExceptionHandler::InvalidToken, Message.invalid_token
  end

  def decoded_token
    @decoded_token ||= JsonWebToken.decode(http_auth_header)
  end

  def http_auth_header
    if headers['Authorization'].present?
      return headers['Authorization'].split(' ').last
    end

    raise ExceptionHandler::MissingToken, Message.missing_token
  end
end
