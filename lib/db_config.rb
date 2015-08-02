require 'yaml/store'
require 'erb'

class DBConfig
  class UnknownEnvironment < StandardError; end

  attr_reader :file, :env
  def initialize(env, file='./config/database.yml')
    @env = env
    @file = file
  end

  def options
    read_only = true
    result = store.transaction(read_only) do
      store[env]
    end
    unless result
      error = "No environment '#{env}' configure in #{file}."
      raise UnknownEnvironment.new(error)
    end
    result
  end

  private
  def store
    @store ||= YAML::Store.new(ERB.new(file).result)
  end
end