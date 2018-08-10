class IdeasController < ApplicationController
  before_action :set_idea, only: %i[show update destroy]

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
    params.permit(:title, :description)
  end

  def set_idea
    @idea = Idea.find(params[:id])
  end
end
