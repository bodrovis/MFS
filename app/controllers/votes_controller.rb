class VotesController < ApplicationController
  def add
    @review = Review.find_by_id(params[:review])
    %w(up down).include?(params[:vote_type]) ? vote_type = params[:vote_type] : vote_type = nil
    if vote_type && @review && current_user && !current_user.voted_for?(@review)
      @review.votes.create(vote_type: vote_type, user_id: current_user.id)
    end
    redirect_to review_path(@review)
  end
end