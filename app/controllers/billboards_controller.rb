class BillboardsController < ApplicationController
  before_action :set_billboard, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show, :index]
  before_action :verify_user, except: [:show, :index]

  def show
  end

  def index
    @billboards = Billboard.all.order(params[:sort]).paginate(:per_page => 5, :page => params[:page])
    @free_billboards = Billboard.get_free_billboards
    @release_date = Billboard.get_release_date
  end

  def new
    @billboard = Billboard.new
  end

  def create
    @billboard = Billboard.new(billboard_params)
    if @billboard.save
      @price = @billboard.create_price(price: params[:price][:price],billboard_id: @billboard.id)
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
      @price = @billboard.create_price(price: params[:price][:price],billboard_id: @billboard.id)
      Billboard.set_price(@price.billboard_id, @price.id)
      redirect_to home_path
    else
      render "edit"
    end
  end

  def destroy
    @billboard.destroy
    redirect_to admin_billboards_path
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
    unless current_user.admin
      redirect_to home_path
    end
  end

end
