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

require 'test_helper'

class VoteTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
