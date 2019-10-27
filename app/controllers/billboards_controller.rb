class BillboardsController < ApplicationController

  def index
  end

  def new
    @billboard = Billboard.new
  end

  def create
    @billboard = Billboard.new(billboard_params)
    if @billboard.save
      redirect_to home_path
    else
      render "new"
    end
  end

  def billboard_params
    params.require(:billboard).permit(:id,
                                      :photo,
                                      :address,
                                      :price)
  end
end
