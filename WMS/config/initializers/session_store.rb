# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_wms_session',
  :secret      => '736d1c812c23c784987a288213db74b8ea84b1fd8dc96efa3d5df9329bb235e471d935b0cce59cfaab7ecb8aab2b3cb94bb29d2a4f9815b6e0570c9125c3e01f'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
