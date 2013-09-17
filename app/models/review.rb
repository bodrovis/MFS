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

  default_scope order: 'created_at DESC'

  validates :title, presence: true, length: {minimum: 2, maximum: 50}
  validates :body, presence: true, length: {minimum: 10, maximum: 2000}
end
