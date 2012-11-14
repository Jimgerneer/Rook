ENV['RACK_ENV'] = 'test'

require 'capybara'
require 'capybara/cucumber'
require 'minitest/spec'
require 'capybara-webkit'
require 'database_cleaner'
require 'database_cleaner/cucumber'
require 'launchy'

require 'pry'

$LOAD_PATH.unshift(File.expand_path('../../..', __FILE__))

require 'rook'
require 'spec/spec_fixtures'
require 'mail'
require 'pony'
require 'pony-test'

Capybara.app = Rook.new
Capybara.default_driver = :rack_test
Capybara.javascript_driver = :webkit_debug
Capybara.default_wait_time = 5

World do
  include MiniTest::Assertions
  include Pony::TestHelpers
end

begin
  DatabaseCleaner[:data_mapper].strategy = :truncation
rescue NameError
  raise "You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it."
end

# Required to make pony-test run correctly:
 Pony.mail(to: 'a@b.com')
