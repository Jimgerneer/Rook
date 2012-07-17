require_relative '../spec_helper'
require_relative '../spec_acceptance_helper'

describe "Booking an opportunity" do

  include AcceptanceHelper

  let(:user) { User.gen }
  before do
    User.gen(:opp)
    sign_in(user) 
    visit "/"
  end

  it "books an opportunity" do
    before = Booking.count
    within(:xpath, '//tbody/tr//td/form') do 
      click_button('Book it!')
    end

    assert_equal before + 1, Booking.count
    assert_equal "/user", page.current_path
  end
end
