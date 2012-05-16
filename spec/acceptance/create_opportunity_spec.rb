require_relative '../spec_helper'

describe "Opportunity page" do
  
  include AcceptanceHelper

  it "returns 200" do
    visit "/opportunity"
    assert_equal 200, page.status_code
  end

  it "has a header" do
    visit "/opportunity"
    assert has_content?("Create an Opportunity")
  end
end
