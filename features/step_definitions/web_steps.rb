Given /^I sign in as "([^\"]*)"$/ do |user|
  User.gen {{ :username => user }}
  fill_in('username', :with => user)
  fill_in('password', :with => 'doobar')
  click_button('Submit')
end

Given /^there is an opportunity available$/ do
#this fixture creates a user and five opportunities
  User.gen(:opp)
end

Given /^I am on the opportunities page$/ do
  visit "/"
end

Given /^I click the "([^\"]*)" button$/ do |button|
  within(:xpath, '//tbody/tr//td/form')do
    click_button(button)
  end
end

Then /^the opportunity should be booked$/ do
  assert_equal 5, Booking.count
end

Then /^I should be on the user page$/ do
  assert_equal "/user", page.current_path
end
