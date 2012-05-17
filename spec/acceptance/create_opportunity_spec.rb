require_relative '../spec_helper'

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

  it "has a title field" do
   fill_in('Title', :with => 'Ruby for Beginners')
  end
  
  it "has a skills field" do
    fill_in('Skills', :with => 'Ruby')
  end

  it "has a description field" do
    fill_in('Description', :with => 'Learn Ruby from the basics')
  end
end
