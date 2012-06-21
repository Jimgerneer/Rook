ENV['RACK_ENV'] = 'test'

require 'capybara'
require 'capybara/cucumber'
require 'minitest/spec'

require_relative '../../rook'

Capybara.app = Rook

World(MiniTest::Assertions)
