class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_user

  def billboards
    @billboards = Billboard
    @requests = BillboardEmployment.order('active DESC')
    @days_of_use = Billboard.get_days_of_use
    @days_of_inactive = Billboard.get_days_of_inactivity
  end

  def users
    @users = User.all
    @billboards_in_use = User.get_billboards_count
    @pay_per_month = User.get_pay_per_month
  end

  def appoint_admin
    if User.make_user_admin(params["user_id"], true)
      redirect_to admin_users_path # Need JS
    end
  end

  def remove_admin
    if User.make_user_admin(params["user_id"], false)
      redirect_to admin_users_path # Need JS
    end
  end

  def confirm
    BillboardEmployment.find(params["request_id"]).update_attribute(:active, false)
    UserEmailMailer.send_notify(params["user_id"], "confirm").deliver
    redirect_to admin_billboards_path # Need JS
  end

  def verify_user
    unless current_user.admin
      redirect_to home_path
    end
  end

end

