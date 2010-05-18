class AdminsController < ApplicationController
  before_filter :require_admin

  def new
    @admin = Admin.new
  end

  def create
    @admin = Admin.new(params[:admin])
    if @admin.save
      flash[:notice] = "Account registered!"
      redirect_back_or_default account_url
    else
      render :action => :new
    end
  end

  def edit
    @admin = @current_admin
  end

  def update
    @admin = @current_admin
    if @admin.update_attributes(params[:admin])
      flash[:notice] = "Account updated!"
      redirect_to admin_path
    else
      render :action => :edit
    end
  end
end

