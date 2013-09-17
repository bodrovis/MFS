module ApplicationHelper
  def long_formatted_date(raw_date)
    l(raw_date, format: '%d %B %Y %H:%M:%S')
  end
end
