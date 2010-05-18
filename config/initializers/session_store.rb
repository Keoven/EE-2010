# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_EE-2010_session',
  :secret      => '4507842883857e7f958e7cddd9676caeb13fdd2f4e9aac40b115b298231141fe98351e2f621ea04704a798fbad34b997a160ea116f9010493a631716f2530d1a'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
