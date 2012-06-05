require_relative '../spec_helper'

describe "login" do

  include AcceptanceHelper

  before (:each) do
    visit "/login"
  end

  it "has a header" do
    assert has_content?("Login!")
  end

  it "Logs in" do
    Rook::User.gen
    fill_in('username', :with => 'DecoyDrone')
    fill_in('password', :with => 'doobar')
    click_button('Submit')

    assert_equal "/", page.current_path
  end

  it "Login with invalid user" do
    fill_in('username', :with => 'Joe')
    fill_in('password', :with => 'eatat')
    click_button('Submit')

    assert_equal "/login", page.current_path
  end
end
