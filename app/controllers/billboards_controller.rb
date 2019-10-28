class BillboardsController < ApplicationController
  before_action :set_billboard, only: [:show,:edit, :update]

  def show
  end

  def index
    @billboards = Billboard.all
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

  def edit

  end

  def update
    if @billboard.update(billboard_params)
      redirect_to home_path
    else
      render "edit"
    end
  end

  def set_billboard
    @billboard = Billboard.find(params[:id])
  end

  def billboard_params
    params.require(:billboard).permit(:id,
                                      :photo,
                                      :address,
                                      :price)
  end
end
