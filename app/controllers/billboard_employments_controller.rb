class BillboardEmploymentsController < ApplicationController
  before_action :set_billboard, only: [:new, :create]

  def new
    @billboard_employment = BillboardEmployment.new
    @adv_types = %w(commercial social)
  end

  def create
    @billboard = @billboard.billboard_employments.create(billboard_employment_params)
    @billboard.user_id = current_user.id
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
