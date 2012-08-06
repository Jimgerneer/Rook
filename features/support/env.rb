ENV['RACK_ENV'] = 'test'

require 'capybara'
require 'capybara/cucumber'
require 'minitest/spec'
require 'database_cleaner'
require 'database_cleaner/cucumber'
require 'capybara-webkit'

require 'pry'

$LOAD_PATH.unshift(File.expand_path('../../..', __FILE__))

=begin
class Object
  def eigenclass
    class << self
      self
    end
  end
end
=end

require 'rook'
require 'spec/spec_fixtures'
require 'mail'
require 'pony'
require 'pony-test'

Capybara.app = Rook
Capybara.server_boot_timeout = 30

World do
  include MiniTest::Assertions
  include Pony::TestHelpers
end

begin
  DatabaseCleaner.strategy = :transaction
rescue NameError
  raise "You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it."
end

# Required to make pony-test run correctly:
 Pony.mail(to: 'a@b.com')
