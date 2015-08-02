require 'bundler'
Bundler.require
require './lib/db_config'

require 'yaml'
environment = ENV.fetch('RACK_ENV') { 'development' }
config = YAML.load(ERB.new(File.read(File.join('config', 'database.yml'))).result)[environment]
ActiveRecord::Base.establish_connection(config)

require 'routes_api'