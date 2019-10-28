module AdminsHelper
  def formatted_date(date)
    date.strftime("%d.%m.%Y")
  end
  def formatted_duration(duration)
    "#{duration} months"
  end
end
