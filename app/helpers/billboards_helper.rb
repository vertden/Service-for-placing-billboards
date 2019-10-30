module BillboardsHelper
  def check_for_null(argument)
    if argument
      argument
    else
      t("billboard.index.none")
    end
  end

end
