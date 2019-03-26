# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ExceptionHandler

  before_action :identify_user
  attr_reader :current_user
  load_and_authorize_resource

  private

  def identify_user
    @current_user = IdentifyUser.new(request.headers).call
  end
end
