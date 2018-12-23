# frozen_string_literal: true

module AuthSpecHelper
  def token_generator(user_id)
    JsonWebToken.encode(user_id: user_id)
  end

  def expired_token_generator(user_id)
    JsonWebToken.encode({ user_id: user_id }, Time.now.to_i - 1)
  end

  def valid_headers(user_id)
    HashWithIndifferentAccess.new(Authorization: token_generator(user_id))
  end

  def invalid_headers
    HashWithIndifferentAccess.new(Authorization: 'token')
  end
end

