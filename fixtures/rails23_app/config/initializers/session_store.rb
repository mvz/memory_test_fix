# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_rails23_app_session',
  :secret      => '0ec9f9cb03e843cbadca9486c7a1457814e8fa1fea9e4acc2a194752f1f0fadd5d3b537ac200072a3afeed9422aed46e1c7bcc37abe0eafccbe467678b2b18d0'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
