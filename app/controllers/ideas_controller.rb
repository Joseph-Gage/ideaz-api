class IdeasController < ApplicationController
  before_action :set_idea, only: %i[show update destroy]
  skip_before_action :authorize_request, only: %i[index show]

  def index
    ideas = Idea.all
    render json: ideas, status: :ok
  end

  def show
    render json: @idea, status: :ok
  end

  def create
    idea = current_user.ideas.create!(idea_params)
    render json: idea, status: :created
  end

  def update
    @idea.update!(idea_params)
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
end
