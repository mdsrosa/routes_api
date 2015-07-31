require 'bundler'
Bundler.require
require './lib/db_config'

require 'yaml'
environment = ENV.fetch('RACK_ENV') { 'development' }
config = DBConfig.new(environment).options
ActiveRecord::Base.establish_connection(config)

require 'walmart_challenge_api'