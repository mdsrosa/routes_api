$:.unshift File.expand_path('./../lib', __FILE__)
require 'rake/testtask'

namespace :db do
  desc 'migrate your database'
  task :migrate do
    require 'bundler'
    Bundler.require
    require './config/environment'
    ActiveRecord::Migrator.migrate('db/migrate')
  end
end

Rake::TestTask.new :test do |t|
  t.pattern = 'test/**/*_test.rb'
end

task default: :test