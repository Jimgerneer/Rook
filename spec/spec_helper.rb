require 'minitest/reporters'
require 'minitest/spec'
require 'minitest/autorun'
require 'guard/minitest'
require 'pry'
require 'growl_notify'
require 'data_mapper'
require 'dm-migrations'

ENV["RACK_ENV"] = "test"

MiniTest::Unit.runner = MiniTest::SuiteRunner.new
MiniTest::Unit.runner.reporters << MiniTest::Reporters::ProgressReporter.new
#MiniTest::Unit.runner.reporters << MiniTest::Reporters::GuardReporter.new

require_relative '../models/user'
require_relative '../models/profile'
require_relative '../models/opportunity'
require_relative '../models/course'

DataMapper.finalize
DataMapper.auto_upgrade!

require_relative 'spec_fixtures'

module AcceptanceHelper
 require 'capybara'
 require 'capybara/dsl'
 include Capybara::DSL

  Capybara.app = Rook
  #Capybara.javascript_driver = :webkit
end 
