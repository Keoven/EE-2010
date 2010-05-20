class User < ActiveRecord::Base

  ##Validations
  #
  
  validates_presence_of [ :first_name, :middle_name, :last_name, 
 			  :street_number, :street_name, :district_code, :municipality_code, :provincial_code, 
 			  :voter_id, :birth_date, :email], :message =>"is required"
  validates_uniqueness_of :voter_id, :email
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create
  
  ##Named Scopes
  #
  named_scope :activated, :conditions => {:activated => true}
  named_scope :voted, :conditions => {:voted => true}
  
  ##Instance Methods
  #
  def full_name
    return "#{first_name.capitalize} #{middle_name.slice(0).chr.capitalize}. #{last_name.capitalize}"
  end
  
  def complete_address
    return { :street_number => self.street_number, :street_name => self.street_name, :district_code => self.district_code, :municipality_code => self.municipality_code, :provincial_code => self.provincial_code }
  end
  
  def isActivated?
    activated == true
  end
  
  def hasVoted?
    voted == true
  end
    
  
end
