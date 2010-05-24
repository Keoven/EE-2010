module AdminsHelper
  def display_admin_dashboard_panel
    if current_admin.super_admin?
      panel = admin_function('Create New Administrator', :url => new_admin_path)
      panel << admin_function('View Administrators', :url => admins_path)
      panel << admin_function('Deactivate Account')
    else
      panel = admin_function('Create New Administrator')
      panel << admin_function('View Administrators')
      panel << admin_function('Deactivate Account', :url => admin_path(current_admin), :method => :delete , :confirm => 'Are you sure you want to deactivate your account? You will be automatically logged out.')
    end
  end

  def admin_function(text, properties={})
    unless properties[:url].nil? #enabled
      link_to(text, properties[:url], properties)
    else #disabled
      content_tag(:div, text, :class => 'disabled')
    end
  end

  def election_status_button
    options = [:update => 'election_status' ,
               :method => :put              ,
               :url    => { :controller => :admins                 ,
                            :action     => :toggle_election_status }]
    case APP_CONFIG['election_status']
      when 'close'
        return button_to_remote 'Open' , *options
      when 'open'
        return button_to_remote 'Close', *options
      when 'finished'
        ## TODO
        #Store into file previous results and reset all
        return button_to_remote 'Reset', *options
    end
  end
end

