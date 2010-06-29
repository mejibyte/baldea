# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_api_session',
  :secret      => '67f6d3f9439e8c3230d5536aec2e6485e9f86d305b89c4319e5bc5fef3a42d9307f9fb7f85a8beb8ba1be39fc9823075f3654b73a221a391244a4de62c63391f'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
