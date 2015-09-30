module ApplicationHelper
  def date_converter(date)
    date.strftime("%m/%d/%Y %I:%M %p")
  end
end
