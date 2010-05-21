class PendingBallot < ActiveRecord::Base
  ##Associations
  #
  belongs_to :voter, :class_name => 'User'

  ##Callback
  #
  after_create do |ballot|
    user = User.find(:first, :conditions => {:voter_id => ballot.voter_id})
    AccountMailer.deliver_voter_ballot_link(user, ballot.ballot_key)
  end

  ##Validations
  #
  validates_presence_of [ :voter_id, :ballot_key ], :message =>"is required"
end
