class User < ActiveRecord::Base

  #Validations
  #
  
  validates_presence_of [ :first_name, :middle_name, :last_name, 
 			  :street_number, :street_name, :district_code, :municipality_code, :provincial_code, 
 			  :voter_id, :birth_date, :email, 
 			  :voted, :activated], :message =>"is required"
  validates_uniqueness_of :voter_id, :email
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create
  
end
