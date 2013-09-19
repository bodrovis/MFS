# == Schema Information
#
# Table name: reviews
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#

class Review < ActiveRecord::Base
  attr_accessible :body, :title

  belongs_to :user
  has_many :votes, dependent: :destroy

  default_scope order: 'created_at DESC'

  validates :title, presence: true, length: {minimum: 2, maximum: 50}
  validates :body, presence: true, length: {minimum: 10, maximum: 2000}

  def summary_rating
    self.votes.where(vote_type: 'up').count - self.votes.where(vote_type: 'down').count
  end

  def votes_for_review(vote_type)
    if %w(up down).include?(vote_type)
      self.votes.where(vote_type: vote_type).count
    else
      0
    end
  end
end
