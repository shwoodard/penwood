# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_penwood.git_session',
  :secret      => '149daa647e0f8e3171e0ecf4909278c3cdff5934de3523616cf102adbe9f56c19bb990388399de03656fedbf3565e0d53fd75f8523b9988391e797a7d7c7f017'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
