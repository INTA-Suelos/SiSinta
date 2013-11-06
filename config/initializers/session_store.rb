# encoding: utf-8
# Be sure to restart your server when you modify this file.

require 'action_dispatch/session/libmemcached_store'

# SiSINTA::Application.config.session_store :cookie_store, key: '_sisinta_session'

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# SiSINTA::Application.config.session_store :active_record_store

SiSINTA::Application.configure do
  config.session_store :libmemcached_store, namespace: '_session', expire_after: 1800
end
