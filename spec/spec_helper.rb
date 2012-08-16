require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/spec'
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
require_relative 'spec_fixtures'
