class VotesController < ApplicationController
  def add
    @review = Review.find_by_id(params[:review])
    %w(up down).include?(params[:type]) ? type = params[:type] : type = nil
    if type && @review && current_user && !current_user.voted_for?(@review)
      @review.votes.create(type: type, user_id: current_user.id)
    end
    redirect_to review_path(@review)
  end
end