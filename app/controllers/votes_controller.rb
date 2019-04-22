class VotesController < ApplicationController
  before_action :set_vote, only: %i[show update destroy]
  skip_before_action :identify_user, only: %i[index]
  skip_load_and_authorize_resource only: %i[index]

  def index
    @votes = Vote.where(idea_id: params[:idea_id])
    render json: @votes, status: :ok
  end

  def show
    render json: @vote, status: :ok
  end

  def create
    vote = current_user.votes.create!(vote_params)
    render json: vote, status: :created
  end

  def update
    @vote.update!(vote_params)
    head :no_content
  end

  def destroy
    @vote.destroy
    head :no_content
  end

  private

  def set_vote
    @vote = Vote.find(params[:id])
  end

  def vote_params
    params.require(:vote).permit(:value, :idea_id)
  end
end
