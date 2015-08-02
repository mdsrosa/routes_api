require 'bundler'
Bundler.require
require './lib/db_config'

require 'yaml'
environment = ENV.fetch('RACK_ENV') { 'development' }
config = DBConfig.new(environment).options

# for heroku
if environment == 'production'
  config = YAML.load(ERB.new(File.read(File.join('config', 'database.yml'))).result)
  config = config[environment]
end

ActiveRecord::Base.establish_connection(config)

require 'routes_api'