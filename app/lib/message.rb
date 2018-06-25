# frozen_string_literal: true

class Message
  def self.invalid_auth_token
    'Invalid auth token'
  end

  def self.missing_auth_token
    'Missing auth token'
  end

  def self.invalid_credentials
    'Invalid credentials'
  end

  def self.account_created
    'Account created successfully'
  end
end
