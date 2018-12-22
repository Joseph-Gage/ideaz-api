class IdeasController < ApplicationController
  before_action :set_idea, only: %i[show update destroy]
  before_action :require_permission, only: %i[update destroy]
  skip_before_action :authorize_request, only: %i[index show]

  def index
    ideas = Idea.all
    json_response(ideas)
  end

  def show
    json_response(@idea)
  end

  def create
    idea = current_user.ideas.create!(idea_params)
    json_response(IdeaSerializer.new(idea).serialized_json, :created)
  end

  def update
    @idea.update(idea_params)
    head :no_content
  end

  def destroy
    @idea.destroy
    head :no_content
  end

  private

  def idea_params
    params.require(:idea).permit(:title, :description)
  end

  def set_idea
    @idea = Idea.find(params[:id])
  end

  def require_permission
    raise(ExceptionHandler::AuthenticationError, Message.invalid_permission) unless @current_user.id == @idea.user_id
  end
end
