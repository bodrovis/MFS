# == Schema Information
#
# Table name: votes
#
#  id         :integer          not null, primary key
#  type       :string(255)
#  review_id  :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Vote < ActiveRecord::Base
  attr_accessible :vote_type, :user_id

  default_scope order: 'created_at DESC'

  after_commit :flush_cache

  belongs_to :review
  belongs_to :user

  private

  def flush_cache
    Rails.cache.delete('summary-rating-' + self.review.id.to_s)
    Rails.cache.delete('votes-' + self.vote_type + '-for-review-' + self.review_id.to_s)
    Rails.cache.delete('user-' + self.user_id.to_s + '-voted-for-' + self.review_id.to_s)
  end
end
