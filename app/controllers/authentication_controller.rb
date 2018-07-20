# frozen_string_literal: true

class AuthenticationController < ApplicationController
  skip_before_action :authorize_request, only: :authenticate

  def authenticate
    auth_token =
      AuthenticateUser.new(auth_params[:email], auth_params[:password]).call
    json_response(AuthTokenSerializer.new(auth_token).serialized_json)
  end

  def auth_params
    params.permit(:email, :password)
  end
end
