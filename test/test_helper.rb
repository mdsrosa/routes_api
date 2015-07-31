ENV['RACK_ENV'] = 'test'
$:.unshift File.expand_path('./../../lib', __FILE__)

require './config/environment'
require 'minitest/autorun'
require 'database_cleaner'

DatabaseCleaner.strategy = :transaction
DatabaseCleaner.clean_with(:truncation)

class MiniTest::Test
  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end
end