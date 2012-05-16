require_relative '../spec_helper'

describe "Home page" do

  include AcceptanceHelper

  it "return 200" do
    visit "/"
    assert_equal 200, page.status_code
  end

  it "greets the visitor" do
    visit "/"
    assert has_content?("Welcome to Rook")
  end

  it "returns 200" do
    visit "/opportunity"
    assert_equal 200, page.status_code
  end

  it "has a header" do
    visit "/opportunity"
    assert has_content?("Create an Opportunity")
  end
end

