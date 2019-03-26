# frozen_string_literal: true

class UsersController < ApplicationController
  skip_before_action :identify_user, only: :create
  skip_load_and_authorize_resource only: :create

  def create
    User.create!(user_params)
    render json: { message: Message.user_created }, status: :created
  end

  def me
    render json: current_user, except: %i[roles_mask password_digest],
           methods: :roles, status: :ok
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
