ENV['RACK_ENV'] = 'test'

require 'capybara'
require 'capybara/cucumber'
require 'minitest/spec'
require 'database_cleaner'
require 'database_cleaner/cucumber'

$LOAD_PATH.unshift(File.expand_path('../../..', __FILE__))

require 'rook'
require 'spec/spec_fixtures'

Capybara.app = Rook

World(MiniTest::Assertions)

begin
DatabaseCleaner.strategy = :transaction
rescue NameError
  raise "You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it."
end
