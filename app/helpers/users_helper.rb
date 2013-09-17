module UsersHelper
  def member_for(user)
    distance_of_time_in_words(Time.now, user.created_at)
  end
end