require_relative '../spec_helper'
require 'pry'

describe "Creating an Opportunity" do
  
  include AcceptanceHelper

  before(:each) do
    visit "/opportunity"
  end

  it "returns 200" do
    assert_equal 200, page.status_code
  end

  it "has a header" do
    assert has_content?("Create an Opportunity")
  end

  it "Creates an opportunity" do
    before = Rook::Opportunity.count
    fill_in('Title:', :with => 'Ruby for Beginners')
    fill_in('Skills:', :with => 'Ruby')
    fill_in('Description:', :with => 'Learn Ruby from the basics')
    click_button('Submit')

    assert_equal before + 1, Rook::Opportunity.count
    assert_equal "/", page.current_path
  end
end
