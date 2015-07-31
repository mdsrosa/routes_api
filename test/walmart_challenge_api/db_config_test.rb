require './test/test_helper'
require './lib/db_config'

class DBConfigTest < MiniTest::Unit::TestCase
  def test_default_file
    file = './config/database.yml'
    assert_equal file, DBConfig.new('env').file
  end

  def test_override_file
    file = './test/fixtures/database.yml'
    assert_equal file, DBConfig.new('env', file).file
  end

  def test_read_environment_specific_values
    config = DBConfig.new('fake', './test/fixtures/database.yml')
    options = {
      'adapter' => 'postgresql',
      'host' => 'localhost',
      'username' => 'matheusrosa',
      'password' => '',
      'database' => 'walmart_challenge_api_fake'
    }

    assert_equal options, config.options
  end

  def test_blow_up_for_unkown_environment
    config = DBConfig.new('real', './test/fixtures/database.yml')
    assert_raises DBConfig::UnknownEnvironment do
      config.options
    end
  end
end