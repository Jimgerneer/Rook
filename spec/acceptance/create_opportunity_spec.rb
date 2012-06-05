require_relative '../spec_helper'

describe "Creating an Opportunity" do
  
  include AcceptanceHelper

  let(:user) { Rook::User.gen }
  before { sign_in(user) } 

  describe "Fills out opportunity form" do

    before(:each) do
      visit "/opportunity"
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
end
