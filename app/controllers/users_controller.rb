# frozen_string_literal: true

class UsersController < ApplicationController
  skip_before_action :authorize_request, only: :create

  def create
   User.create!(user_params)
    render json: { message: Message.user_created }, status: :created
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
