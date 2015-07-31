$:.unshift File.expand_path('./../lib', __FILE__)
require 'rake/testtask'

Rake::TestTask.new :test do |t|
  t.pattern = 'test/**/*_test.rb'
end

task default: :test