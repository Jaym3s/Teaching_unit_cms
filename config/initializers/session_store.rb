# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_sensei_session',
  :secret      => '9503d28666a602c6e5b2b62feb2b21479368ed62a3a312330c73e2d4401adb7086fb249a6ca173bdba0d180374a83dfd4b119ca7850e43b7010086582781f785'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
