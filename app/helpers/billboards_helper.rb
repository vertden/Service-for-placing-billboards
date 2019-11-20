module BillboardsHelper
  def check_for_null(argument)
    if argument
      argument
    else
      t("billboard.index.none")
    end
  end

  def get_date(billboard)
    release_date = @release_date[billboard.id]
    unless @release_date[billboard.id] == 0
      release_date
    else
      t("billboard.index.vacant")
    end
  end
end
