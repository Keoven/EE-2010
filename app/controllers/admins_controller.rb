class AdminsController < ApplicationController
  ## Hooks/Callbacks
  #
  before_filter :require_admin
  before_filter :require_super_admin, :only => [:index, :destroy, :create, :toggle_election_status]

  ## ACTIONS
  #

  ##GET /admins/dashboard
  #
  def dashboard
    @admin = @current_admin
  end

  ##GET /admins
  #
  def index
    @admins = Admin.paginate :page => params[:page], :per_page => 10

    respond_to do |format|
      format.html
      format.js {
        render :update do |page|
          page.replace 'admin_records', :partial => 'records'
        end
      }
    end
  end

  ##POST /admins
  #
  def create
    @admin = Admin.new(params[:admin])
    if @admin.save
      flash[:notice] = 'Account registered!'
      redirect_back_or_default admin_path(@admin)
    else
      render :action => :new
    end
  end

  ##GET /admins/new
  #
  def new
    @admin = Admin.new
  end

  ##GET /admins/:id/edit
  #
  def edit
    @admin = @current_admin
  end

  ##GET /admins/:id
  #
  def show
    @admin = Admin.find(params[:id])
  end

  ##PUT /admins/:id
  #
  def update
    @admin = @current_admin
    @uattr = params[:admin]
    @uattr[:login]   = @admin.login
    @uattr[:email] ||= @admin.email
    if (@uattr.include? :password) && (@uattr.include? :password_confirmation)
      if @admin.update_attributes!(@uattr)
        flash[:notice] = 'Account updated!'
        redirect_to admin_path(@admin)
      else
        render :action => :edit
      end
    else
      if valid_email(@uattr[:email])
        @admin.update_attribute(:email, @uattr[:email])
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

  ##DELETE /admins/:id
  #
  def destroy
    Admin.find(params[:id]).destroy
    redirect_to(dashboard_admins_url)
    flash[:notice] = 'Account deleted!'
  end

  ##PUT /admins/toggle_election_status
  #
  def toggle_election_status
    case APP_CONFIG['election_status']
      when 'close'
        APP_CONFIG['election_status'] = 'open'
      when 'open'
        APP_CONFIG['election_status'] = 'finished'
      when 'finished'
        APP_CONFIG['election_status'] = 'close'
    end
    render :partial => 'election_status'
  end

end

