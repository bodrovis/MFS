# == Schema Information
#
# Table name: users
#
#  id          :integer          not null, primary key
#  provider    :string(255)
#  name        :string(255)
#  nickname    :string(255)
#  uid         :string(255)
#  token       :string(255)
#  secret      :string(255)
#  profile_url :string(255)
#  image_url   :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class User < ActiveRecord::Base
  # attr_accessible :image_url, :name, :nickname, :profile_url, :provider, :secret, :token, :uid

  has_many :reviews, dependent: :destroy
  has_many :votes, dependent: :destroy

  def voted_for?(review)
    Rails.cache.fetch('user-' + self.id.to_s + '-voted-for-' + review.id.to_s) {
      self.votes.where(review_id: review.id).any?
    }
  end

  def reviews_count
    Rails.cache.fetch('reviews-count-for-user-' + self.id.to_s) {
      self.reviews.count
    }
  end

  def last_reviews
    Rails.cache.fetch('last-reviews-for-user-' + self.id.to_s) {
      self.reviews.limit(10).to_a
    }
  end
end
