module ProfilesHelper
  def set_class(active)
    if active == 1
      "table-warning"
    else
      "table-light"
    end
  end
end
