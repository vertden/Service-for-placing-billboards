class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_user

  def billboards
    @billboards = Billboard.all
    @requests = BillboardEmployment.all
  end

  def users
    @users = User.all
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
    BillboardEmployment.confirm(params["request_id"])
    UserEmailMailer.send_notify(params["user_id"], "confirm").deliver
    redirect_to admin_billboards_path # Need JS
  end

  def verify_user
    unless current_user.admin
      redirect_to home_path
    end
  end

end

