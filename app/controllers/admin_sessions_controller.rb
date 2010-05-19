class AdminSessionsController < ApplicationController
  before_filter :require_no_admin, :only => [:new, :create]
  before_filter :require_admin, :only => :destroy

  def new
    @admin_session = AdminSession.new
  end

  def create
    @admin_session = AdminSession.new(params[:admin_session])
    if @admin_session.save
      flash[:notice] = "Login successful!"
      redirect_back_or_default dashboard_admins_path
    else
      render :action => :new
    end
  end

  def destroy
    current_admin_session.destroy
    flash[:notice] = "Logout successful!"
    redirect_back_or_default new_admin_session_path
  end
end

