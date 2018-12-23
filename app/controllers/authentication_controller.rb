# frozen_string_literal: true

class AuthenticationController < ApplicationController
  skip_before_action :authorize_request, only: :authenticate

  def authenticate
    token = AuthenticateUser.new(auth_parms[:email], auth_parms[:password]).call
    render json: { token: token }, status: :ok
  end

  private

  def auth_parms
    params.permit(:email, :password)
  end
end
