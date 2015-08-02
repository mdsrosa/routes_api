source 'https://rubygems.org'
ruby '2.2.2'

gem 'activerecord', require: 'active_record'
gem 'pg'
gem 'sinatra'
gem 'puma', require: false
gem 'rack-contrib'
gem 'sinatra-param', require: 'sinatra/param'

group :development do
  gem 'racksh', require: false
  gem 'pry-byebug', require: false
  gem 'pry-meta', require: false
  gem 'pry-nav', require: false
  gem 'pry-remote', require: false
end

group :test do
  gem 'rack-test'
  gem 'database_cleaner'
end
