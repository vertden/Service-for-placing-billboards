module AdminsHelper
  def formatted_date(date)
    date.strftime("%d.%m.%Y")
  end
  def formatted_duration(duration)
    "#{duration} months"
  end

  def set_class(active)
    if active
      "table-warning"
    else
      "table-light"
    end
  end

end
