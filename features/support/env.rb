ENV['RACK_ENV'] = 'test'

require 'pry'

require 'capybara'
require 'capybara/cucumber'
require 'minitest/spec'
require 'database_cleaner'
require 'database_cleaner/cucumber'

$LOAD_PATH.unshift(File.expand_path('../../..', __FILE__))

class Object
  def eigenclass
    class << self
      self
    end
  end
end

require 'rook'
require 'spec/spec_fixtures'

require 'mail'
require 'pony'
require 'pony-test'

Capybara.app = Rook

World do
  include MiniTest::Assertions
  include Pony::TestHelpers
end

begin
  DatabaseCleaner.strategy = :transaction
rescue NameError
  raise "You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it."
end

# stupidest requirement evar:
Pony.mail(to: 'a@b.com')
