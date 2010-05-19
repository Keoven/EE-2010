class AdminsController < ApplicationController
  before_filter :require_admin
  before_filter :require_super_admin, :only => [:index, :destroy, :create]

  def new
    @admin = Admin.new
  end

  def create
    @admin = Admin.new(params[:admin])
    if @admin.save
      flash[:notice] = 'Account registered!'
      redirect_back_or_default admin_path(@admin)
    else
      render :action => :new
    end
  end

  def edit
    @admin = @current_admin
  end

  def dashboard
    @admin = @current_admin
  end

  def update
    @admin = @current_admin
    @uattr = params[:admin]
    @uattr[:login]   = @admin.login
    @uattr[:email] ||= @admin.email
    if (@uattr.include? :password) && (@uattr.include? :password_confirmation)
      if @admin.update_attributes(@uattr)
        flash[:notice] = 'Account updated!'
        redirect_to admin_path(@admin)
      else
        render :action => :edit
      end
    else
      if @admin.update_attribute(:email, @uattr[:email])
        flash[:notice] = 'Account updated!'
        redirect_to admin_path(@admin)
      else
        render :action => :edit
      end
    end
    rescue
      flash[:notice] = 'An error has occurred while updating account.'
      render :action => :edit
  end

  def index
    @admins = Admin.all
  end

  def show
    @admin = Admin.find(params[:id])
  end

  def destroy
    Admin.find(params[:id]).destroy
    redirect_to(dashboard_admins_url)
    flash[:notice] = 'Account deleted!'
  end
end

