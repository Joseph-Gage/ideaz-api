class IdeasController < ApplicationController
  before_action :set_idea, only: %i[show update destroy]
  skip_before_action :identify_user, only: %i[index show]
  skip_load_and_authorize_resource only: %i[index show]

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

  def set_idea
    @idea = Idea.find(params[:id])
  end

  def idea_params
    params.require(:idea).permit(:title, :description)
  end
end
