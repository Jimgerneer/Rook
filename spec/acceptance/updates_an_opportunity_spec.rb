require_relative '../spec_helper'
require_relative '../spec_acceptance_helper'

describe "Updating an opportunity" do

  include AcceptanceHelper

  let(:user) { User.gen(:one) }
  before do
    sign_in(user)
    visit "/user" 
  end

  it "has an edit button" do
    click_link('Edit')
    
    assert_equal "/opportunity/update", page.current_path
  end

    describe "edits an opportunity" do
      
    end
  
end
