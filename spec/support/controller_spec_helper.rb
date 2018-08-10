# frozen_string_literal: true

module ControllerSpecHelper
  def token_generator(user_id)
    JsonWebToken.encode(user_id: user_id)
  end

  def expired_token_generator(user_id)
    JsonWebToken.encode({ user_id: user_id }, (Time.now.to_i - 1))
  end

  def valid_headers
    {
        Authorization: token_generator(user.id)
    }
  end

  def auth_header(user_id)
    {
        Authorization: token_generator(user_id)
    }
  end
end
