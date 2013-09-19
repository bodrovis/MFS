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
  attr_accessible :type, :user_id

  belongs_to :review
  belongs_to :user
end
