# frozen_string_literal: true

class AuthenticationController < ApplicationController
  def authenticate
    auth_token =
      AuthenticateUser.new(auth_params[:email], auth_params[:password]).call
    json_response(auth_token: auth_token)
  end

  def auth_params
    params.permit(:email, :password)
  end
end
