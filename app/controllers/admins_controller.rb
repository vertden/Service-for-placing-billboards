class AdminsController < ApplicationController

  def billboards
    @billboards = Billboard.all
    @requests = BillboardEmployment.all
  end

  def users
    @users = User.all
  end

  def appoint_admin
    current_user.make_user_admin(params["user_id"],true)
    redirect_to users_admin_path # Need JS
  end

  def remove_admin
    current_user.make_user_admin(params["user_id"],false)
    redirect_to users_admin_path # Need JS
  end

  def confirm
    BillboardEmployment.confirm(params["request_id"])
    redirect_to billboards_admin_path # Need JS
  end

  def reject
    BillboardEmployment.delete(params["request_id"])
    redirect_to billboards_admin_path # Need JS
  end

end

