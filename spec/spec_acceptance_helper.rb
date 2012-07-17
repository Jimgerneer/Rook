require File.expand_path("./../spec_helper", __FILE__)

module AcceptanceHelper
 require 'capybara'
 require 'capybara/dsl'
 include Capybara::DSL

  Capybara.app = Rook
  #Capybara.javascript_driver = :webkit
end 
