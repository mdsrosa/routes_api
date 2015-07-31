require 'bundler'
Bundler.require

require 'yaml'
db_options = YAML.load(File.read('./config/database.yml'))
ActiveRecord::Base.establish_connection(db_options)

require 'walmart_challenge_api'