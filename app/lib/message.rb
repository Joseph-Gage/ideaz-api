# frozen_string_literal: true

class Message
  class << self
    def invalid_token
      'Invalid services token'
    end

    def invalid_credentials
      'Invalid credentials'
    end

    def invalid_permission
      'Invalid permission'
    end


    def missing_token
      'Missing auth token'
    end

    def user_created
      'User created successfully'
    end
  end
end
