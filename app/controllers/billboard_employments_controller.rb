class BillboardEmploymentsController < ApplicationController
  before_action :set_billboard, only: [:new, :create]

  def new
    @billboard_employment = BillboardEmployment.new

  end

  def create
    @billboard = @billboard.billboard_employments.create(billboard_employment_params)
    if @billboard.save
      redirect_to home_path
    end
  end

  def set_billboard
    @billboard = Billboard.find(params[:billboard_id])
  end

  def billboard_employment_params
    params.require(:billboard_employment).permit(:body,
                                                 :brand,
                                                 :adv_type,
                                                 :start_date,
                                                 :billboard_id,
                                                 :duration)
  end

end