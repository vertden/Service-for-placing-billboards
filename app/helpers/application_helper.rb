module ApplicationHelper
  def set_class(active)
    if active
      "table-warning"
    else
      "table-light"
    end
  end
end
