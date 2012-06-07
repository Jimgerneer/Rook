require_relative '../spec_helper'

describe "Signs up a user" do
  
include AcceptanceHelper
  
  before { visit "/signup" }

  it "creates a user" do
    fill_in('Username:', :with => 'Decoy2')
    fill_in('Email:', :with => 'ink2@me.com')
    fill_in('Password:', :with => 'foobar')
    fill_in('Confirm:', :with => 'foobar')
    click_button('Submit')

    assert_equal "/user", page.current_path
    assert has_content?("Decoy2")
  end
end
