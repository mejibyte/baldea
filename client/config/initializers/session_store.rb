# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_client_session',
  :secret      => '48000319ee6fb149322894d564b1c2743582d6828cfda1eee57f2a076b8b54dd7d6945abe9c566f8ce2d25e1cb37c8901b14d9de33b31c10ba3001cf542edfa0'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
