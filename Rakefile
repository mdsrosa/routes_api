$:.unshift File.expand_path('./../lib', __FILE__)
require 'rake/testtask'
require 'erb'

namespace :db do
  desc "Create a migration (parameters: NAME, VERSION)"
  task :create_migration do
    require 'bundler'
    Bundler.require
    require './config/environment'

    unless ENV["NAME"]
      puts "No NAME specified. Example usage: `rake db:create_migration NAME=create_users`"
      exit
    end

    name    = ENV["NAME"]
    version = ENV["VERSION"] || Time.now.utc.strftime("%Y%m%d%H%M%S")

    ActiveRecord::Migrator.migrations_paths.each do |directory|
      next unless File.exist?(directory)
      migration_files = Pathname(directory).children
      if duplicate = migration_files.find { |path| path.basename.to_s.include?(name) }
        puts "Another migration is already named \"#{name}\": #{duplicate}."
        exit
      end
    end

    filename = "#{version}_#{name}.rb"
    dirname  = ActiveRecord::Migrator.migrations_path
    path     = File.join(dirname, filename)

    FileUtils.mkdir_p(dirname)
    File.write path, <<-MIGRATION.strip_heredoc
      class #{name.camelize} < ActiveRecord::Migration
        def change
        end
      end
    MIGRATION

    puts path
  end

  desc 'migrate your database'
  task :migrate do
    require 'bundler'
    Bundler.require
    require './config/environment'
    ActiveRecord::Migrator.migrate('db/migrate')
  end

  desc 'Load the seed data from db/seeds.rb'
  task :seed do
    require 'bundler'
    Bundler.require
    require './config/environment'
    seed_file = File.join('db/seeds.rb')
    if File.exist?(seed_file)
      puts 'File db/seeds.rb found!'
      puts 'Loading...'
      load(seed_file)
      puts 'Successfully loaded.'
    else
      puts 'File db/seeds.rb not found!'
    end
  end
end

Rake::TestTask.new :test do |t|
  t.pattern = 'test/**/*_test.rb'
end

task default: :test