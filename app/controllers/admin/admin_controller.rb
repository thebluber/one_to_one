class Admin::AdminController < ApplicationController
  before_filter :authenticate_admin_user!
  private
  def authenticate_admin_user!
    if logged_in?
      redirect_to root_path, alert: "Kein Admin Recht!" unless current_user.admin?
    else
      not_authenticated
    end
  end
end
