module BillboardsHelper
  def check_for_null(argument)
    if argument
      argument
    else
      t("billboard.index.none")
    end
  end

  def get_date(id)
    date=Billboard.get_release_date(id)
    if date == Date.today
      date
    else
      t("billboard.index.vacant")
    end

  end
end
