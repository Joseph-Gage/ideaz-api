class AuthToken
  attr_accessor :access_token, :expires_in, :token_type, :created_at

  def initialize(access_token, expires_in)
    @access_token = access_token
    @expires_in = expires_in
    @token_type = 'Bearer'
    @created_at = Time.now.to_s
  end
end
