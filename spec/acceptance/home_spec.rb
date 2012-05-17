require_relative '../spec_helper'

describe "Home page" do

  include AcceptanceHelper

  before (:each) do
    visit "/"
  end

  it "return 200" do
    assert_equal 200, page.status_code
  end

  it "greets the visitor" do
    assert has_content?("Welcome to Rook")
  end

  it "has a button to create opportunity" do
    click_link('Create')

    assert_equal "/opportunity", page.current_path
  end
end

