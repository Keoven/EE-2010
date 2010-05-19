# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all
  helper_method :current_admin_session, :current_admin
  filter_parameter_logging :password, :password_confirmation

  private
  def current_admin_session
    return @current_admin_session if defined?(@current_admin_session)
    @current_admin_session = AdminSession.find
  end

  def current_admin
    return @current_admin if defined?(@current_admin)
    @current_admin = current_admin_session && current_admin_session.record
  end

  def require_admin
    unless current_admin
      store_location
      flash[:notice] = 'You must be logged in to access this page'
      redirect_to new_admin_session_path
      return false
    end
  end

  def require_super_admin
    require_admin
    unless current_admin.id == 1
      store_location
      flash[:notice] = 'You must be logged in as supper admin to access this page'
      redirect_to admins_path
      return false
    end
  end

  def require_no_admin
    if current_admin
      store_location
      flash[:notice] = 'You must be logged out to access this page'
      redirect_to admins_path
      return false
    end
  end

  def store_location
    session[:return_to] = request.request_uri
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end

  def require_election_open
    unless APP_CONFIG['election_status'] == 'open'
      flash[:notice] = 'Election is not yet open.'
      render :action => 'election_closed', :layout => 'election_closed'
      return false
    end
  end
end

