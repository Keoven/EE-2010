class UserObserver < ActiveRecord::Observer
  def after_create(user)
    UserMailer.deliver_voter_approval(user)
  end
end
