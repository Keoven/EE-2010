class AccountMailer < ActionMailer::Base
  include ActionController::UrlWriter
  default_url_options[:host] = APP_CONFIG['host']

  def voter_approval(user)
    @recipients    = user.email
    @from          = "Exist Elections"
    @subject       = "Welcome to Exist Elections 2010"
    @sent_on       = Time.now
    @body          = {:user => user, :date => Date.today.year}
  end

  def voter_ballot_link(user, key)
    @recipients    = user.email
    @from          = 'Exist Elections'
    @subject       = '[Exist Elections] Vote your next leader now!'
    @sent_on       = Time.now
    @body          = {:user => user,
                      :date => Date.today.year,
                      :url => url_for( :controller => 'users'            ,
                                       :action     => 'ballot'           ,
                                       :port       => APP_CONFIG['port'] ,
                                       :code       => key                ) }
  end

end

