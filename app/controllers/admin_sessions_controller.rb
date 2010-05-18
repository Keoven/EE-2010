class AdminSessionsController < ApplicationController
  before_filter :require_no_admin, :only => [:new, :create]
  before_filter :require_admin, :only => :destroy

  def new
    @admin_session = adminSession.new
  end

  def create
    @admin_session = adminSession.new(params[:admin_session])
    if @admin_session.save
      flash[:notice] = "Login successful!"
      redirect_back_or_default account_url
    else
      render :action => :new
    end
  end

  def destroy
    current_admin_session.destroy
    flash[:notice] = "Logout successful!"
    redirect_back_or_default new_admin_session_url
  end
end

