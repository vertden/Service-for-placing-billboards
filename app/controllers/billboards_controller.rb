class BillboardsController < ApplicationController
  before_action :set_billboard, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new,:edit]
  before_action :verify_user, only: [:new,:edit]
  def show
  end

  def index
    @billboards = Billboard.all
  end

  def new
    @billboard = Billboard.new
    @billboard.prices.new
  end

  def create
    @billboard = Billboard.new(billboard_params)
    if @billboard.save
      @price = @billboard.prices.create(price_params)
      Billboard.set_price(@price.billboard_id, @price.id)
      redirect_to home_path
    else
      render "new"
    end
  end

  def edit
    @price = Price.find(@billboard.price_id)
  end

  def update
    if @billboard.update(billboard_params)
      @price = @billboard.prices.create(price_params)
      Billboard.set_price(@price.billboard_id, @price.id)
      redirect_to home_path
    else
      render "edit"
    end
  end

  def destroy
    @billboard.destroy
    redirect_to billboards_admin_path
  end

  def set_billboard
    @billboard = Billboard.find(params[:id])
  end

  def billboard_params
    params.require(:billboard).permit(:id,
                                      :photo,
                                      :address)
  end

  def price_params
    params.require(:price).permit(:price)
  end

  def verify_user
    if not current_user.admin
      redirect_to "home"
    end
  end
end
