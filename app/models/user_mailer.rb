class UserMailer < ActionMailer::Base
  def voter_approval(user)
    @recipients    = user.email
    @from          = "Exist Administrator <asuarez@g2ix.net>"
    @bcc	   = "ndriz@g2ix.net, gdugay@g2ix.net, kmolina@g2ix.net"
    @subject       = "Welcome to Exist Elections 2010"
    @sent_on       = Time.now
    @body          = {:user => user, :date => Date.today.year}
  end  

end
