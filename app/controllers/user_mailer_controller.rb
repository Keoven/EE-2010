class UserMailerController < ApplicationController

  def index
    render :controller => "admin/users", :action => "new"
  end
   
  def sendmail
      UserMailer.deliver_voter_approval(:user)
      return if request.xhr?
      render :text => 'Message sent successfully'
   end
end
