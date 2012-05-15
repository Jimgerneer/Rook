require 'minitest/reporters'
require 'minitest/spec'
require 'minitest/autorun'
require 'guard/minitest'
require 'pry'
require 'growl_notify'
require 'data_mapper'

ENV["RACK_ENV"] = "test"

MiniTest::Unit.runner = MiniTest::SuiteRunner.new
MiniTest::Unit.runner.reporters << MiniTest::Reporters::ProgressReporter.new
#MiniTest::Unit.runner.reporters << MiniTest::Reporters::GuardReporter.new

require_relative '../lib/user'
require_relative '../lib/profile'
require_relative '../lib/opportunity'
DataMapper.finalize
DataMapper.auto_upgrade!

module AcceptanceHelper
 require 'capybara'
 require 'capybara/dsl'
 include Capybara::DSL

  Capybara.app = Rook
  #Capybara.javascript_driver = :webkit
end 
