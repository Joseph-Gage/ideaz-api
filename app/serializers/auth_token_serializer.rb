class AuthTokenSerializer
  include FastJsonapi::ObjectSerializer
  set_id :created_at
  set_key_transform :camel_lower
  attributes :access_token, :token_type, :expires_in
end
