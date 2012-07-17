require_relative '../spec_helper'
require_relative '../spec_acceptance_helper'

describe "Creating an Opportunity" do

  include AcceptanceHelper

  let(:user) { User.gen }
  before { sign_in(user) } 

  describe "Fills out opportunity form" do

    before(:each) do
      visit "/opportunity"
    end

    it "has a header" do
      assert has_content?("Create an Opportunity")
    end

    it "Creates an opportunity" do
      before = Opportunity.count
      fill_in('Title:', :with => 'Ruby for Beginners')
      fill_in('Skills:', :with => 'Ruby')
      fill_in('Description:', :with => 'Learn Ruby from the basics')
      click_button('Submit')

      assert_equal before + 1, Opportunity.count
      assert_equal "/user", page.current_path
    end

    it "page is displaying authored opportunities" do
      visit "/user"
      assert_equal 1, page.all(:xpath, '//tbody/tr').length
    end
  end
end
