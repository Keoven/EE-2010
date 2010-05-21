class Admin < ActiveRecord::Base
  acts_as_authentic

  ## VALIDATIONS
  #
  validates_presence_of [:login, :email, :password], :message => 'is required.', :allow_blank => true
  validates_uniqueness_of :login, :message => 'username already taken.'
  validates_uniqueness_of :email, :message => 'email already used in another account.'

  def super_admin?
    id == 1
  end
end

