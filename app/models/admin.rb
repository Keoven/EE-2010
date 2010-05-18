class Admin < ActiveRecord::Base
  acts_as_authentic

  ## VALIDATIONS
  #
  validates_presence_of [:login, :email, :password], :message => 'is required.'
  validates_uniqueness_of :login, :message => 'username already taken.'
  validates_uniqueness_of :email, :message => 'email already used in another account.'
end

