$:.unshift File.expand_path('./../lib', __FILE__)
require 'bundler'
Bundler.require

require './config/environment'
require 'sinatra/base'
require 'puma'
require 'api'

use ActiveRecord::ConnectionAdapters::ConnectionManagement

run WalmartChallengeAPI