$:.unshift File.expand_path('./../lib', __FILE__)
require 'bundler'
Bundler.require

require './config/environment'
require 'sinatra/base'
require 'puma'
require 'api'
require 'rack/contrib'

use ActiveRecord::ConnectionAdapters::ConnectionManagement
use Rack::PostBodyContentTypeParser

run WalmartChallengeAPI