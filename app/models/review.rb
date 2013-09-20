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

  belongs_to :user, touch: true
  has_many :votes, dependent: :destroy

  after_commit :flush_cache

  default_scope order: 'created_at DESC'

  validates :title, presence: true, length: {minimum: 2, maximum: 50}
  validates :body, presence: true, length: {minimum: 10, maximum: 2000}

  def summary_rating
    vote_up = self.votes_for_review('up')
    vote_down = self.votes_for_review('down')
    Rails.cache.fetch('summary-rating-' + self.id.to_s) {
      ci_lower_bound(vote_up, vote_up + vote_down)
    }
  end

  def ci_lower_bound(pos, n, confidence = 0.95)
    if n == 0
      0.0
    else
      z = Statistics2.pnormaldist(1 - (1 - confidence) / 2)
      phat = 1.0 * pos / n
      (phat + z * z / (2 * n) - z * Math.sqrt((phat * (1 - phat) + z * z / (4 * n)) / n)) /
          (1 + z * z / n)
    end
  end

  def votes_for_review(vote_type)
    if %w(up down).include?(vote_type)
      Rails.cache.fetch('votes-' + vote_type + '-for-review-' + self.id.to_s) {
        self.votes.where(vote_type: vote_type).count
      }
    else
      0
    end
  end

  private

  def flush_cache
    Rails.cache.delete('reviews-count-for-user-' + self.user_id.to_s)
    Rails.cache.delete('last-reviews-for-user-' + self.user_id.to_s)
  end
end
