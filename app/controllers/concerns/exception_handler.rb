# frozen_string_literal: true

module ExceptionHandler
  extend ActiveSupport::Concern

  class AuthenticationError < StandardError;
  end
  class MissingToken < StandardError;
  end
  class InvalidToken < StandardError;
  end
  class ExpiredToken < StandardError;
  end

  included do
    rescue_from ActionController::ParameterMissing, with: :unprocessable_request
    rescue_from ActiveRecord::RecordNotFound, with: :resource_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_request
    rescue_from ExceptionHandler::AuthenticationError, with: :unauthorized_request
    rescue_from ExceptionHandler::MissingToken, with: :unauthorized_request
    rescue_from ExceptionHandler::InvalidToken, with: :unauthorized_request
    rescue_from CanCan::AccessDenied, with: :unauthorized_request
  end

  private

  def resource_not_found(exception)
    render json: { message: exception.message }, status: :not_found
  end

  def unauthorized_request(exception)
    render json: { message: exception.message }, status: :unauthorized
  end

  def unprocessable_request(exception)
    render json: { message: exception.message }, status: :unprocessable_entity
  end
end
