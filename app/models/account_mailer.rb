class AccountMailer < ActionMailer::Base
  include ActionController::UrlWriter
  default_url_options[:host] = APP_CONFIG['host']

  def voter_approval(user)
    recipients     user.email
    from           "Exist Elections"
    subject        "Welcome to Exist Elections 2010"
    sent_on        Time.now
    content_type   'multipart/related; type=text/html'

    part :content_type => "text/html",
    :body => render_message('voter_approval',:user => user, :date => Date.today.year)

     inline_attachment :content_type => "image/png",
    :body => File.read("#{RAILS_ROOT}/public/images/logo.png"),
    :filename => "logo.png"

  end

  def voter_ballot_link(user, key)
    recipients    = user.email
    from          = 'Exist Elections'
    subject       = '[Exist Elections] Vote your next leader now!'
    sent_on       = Time.now
    content_type   'multipart/related; type=text/html'

    part :content_type => "text/html",
         :body => render_message('voter_ballot_link', :user => user,
                                                      :date => Date.today.year,
                                                      :url => url_for( :controller => 'users'            ,
                                                                       :action     => 'ballot'           ,
                                                                       :port       => APP_CONFIG['port'] ,
                                                                       :code       => key                ))

    inline_attachment :content_type => "image/png",
    :body => File.read("#{RAILS_ROOT}/public/images/logo.png"),
    :filename => "logo.png"
  end
end

