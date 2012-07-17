require 'minitest/reporters'
require 'minitest/spec'
require 'minitest/autorun'
#require 'guard/minitest'
#require 'growl_notify'
#require 'rake/testtask'
require 'mocha'
require 'database_cleaner'

ENV["RACK_ENV"] = "test"
require_relative '../rook'

DatabaseCleaner.strategy = :transaction
class MiniTest::Spec
  before :each do
    DatabaseCleaner.start
  end

  after :each do
    DatabaseCleaner.clean
  end
end

MiniTest::Unit.runner = MiniTest::SuiteRunner.new
MiniTest::Unit.runner.reporters << MiniTest::Reporters::ProgressReporter.new
#MiniTest::Unit.runner.reporters << MiniTest::Reporters::GuardReporter.new
require_relative 'spec_fixtures'

def sign_in(user)
  visit "/login"
  fill_in('username', :with => 'DecoyDrone')
  fill_in('password', :with => 'doobar')
  click_button('Submit')
end
