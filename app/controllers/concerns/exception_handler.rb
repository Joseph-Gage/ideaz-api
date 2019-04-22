# frozen_string_literal: true

module ExceptionHandler
  extend ActiveSupport::Concern

  class AuthenticationError < StandardError; end
  class MissingToken < StandardError; end
  class InvalidToken < StandardError; end
  class ExpiredToken < StandardError; end

  included do
    rescue_from ActionController::ParameterMissing, with: :unprocessable
    rescue_from ActiveRecord::RecordNotFound, with: :not_found
    rescue_from ActiveRecord::RecordInvalid, with: :unprocessable
    rescue_from ExceptionHandler::AuthenticationError, with: :unauthorized
    rescue_from ExceptionHandler::MissingToken, with: :unauthorized
    rescue_from ExceptionHandler::InvalidToken, with: :unauthorized
    rescue_from CanCan::AccessDenied, with: :forbidden
  end

  private

  def forbidden(exception)
    render json: { message: exception.message }, status: :forbidden
  end

  def not_found(exception)
    render json: { message: exception.message }, status: :not_found
  end

  def unauthorized(exception)
    render json: { message: exception.message }, status: :unauthorized
  end

  def unprocessable(exception)
    render json: { message: exception.message }, status: :unprocessable_entity
  end
end
