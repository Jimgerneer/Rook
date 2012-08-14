require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/spec'
require 'mocha'

ENV["RACK_ENV"] = "test"
require_relative '../rook'

MiniTest::Unit.runner = MiniTest::SuiteRunner.new
MiniTest::Unit.runner.reporters << MiniTest::Reporters::ProgressReporter.new
require_relative 'spec_fixtures'

def sign_in(user)
  visit "/login"
  fill_in('username', :with => 'DecoyDrone')
  fill_in('password', :with => 'doobar')
  click_button('Submit')
end
