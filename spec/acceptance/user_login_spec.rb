require_relative '../spec_helper'
require_relative '../spec_acceptance_helper'

describe "login" do

  include AcceptanceHelper

  before (:each) do
    visit "/login"
  end

  it "has a header" do
    assert has_content?("Login!")
  end

  it "Login with invalid user" do
    fill_in('username', :with => 'Joe')
    fill_in('password', :with => 'eatat')
    click_button('Submit')

    assert_equal "/login", page.current_path
  end
end

