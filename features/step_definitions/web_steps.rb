Given /^I am signed in with a valid user$/ do
  @current_user = User.gen
  visit ('/login')
  fill_in('username', :with => @current_user.username)
  fill_in('password', :with => 'doobar')
  click_button('Submit')
end

Given /^I am on the user page$/ do
  visit "/user"
end

Given /^I am on the login page$/ do
  visit "/login"
end

Given /^I am on the signup page$/ do
  visit "/signup"
end

Given /^I try to log in with an uncreated user$/ do
  fill_in('username', :with => 'VeryRandomName')
  fill_in('password', :with => 'nope')
  click_button('Submit')
end

Given /^there is an opportunity available$/ do
#this fixture creates a user and five opportunities
  User.gen(:opp)
end

Given /^I am on the opportunities page$/ do
  visit "/"
end

Given /^I am on the create opportunity page$/ do
  visit "/opportunity"
end

Given /^I am on the update opportunity page$/ do
  visit "/opportunity/edit.#{@current_opportunity.id}"
end

Given /^I fill in the fields$/ do |table|
  @current_form = table.rows_hash
  @current_form.each {|field, value| fill_in field, :with => value }
end

Given /^I click the submit button$/ do
  click_button('Submit')
end

Given /^I click the confirm button$/ do
  click_button('Confirm')
end

Given /^I click the "([^|"]*)" link$/ do |link|
  click_link(link)
end

Given /^I click the "([^\"]*)" button$/ do |button|
  within(:xpath, '//tbody/tr//td/form')do
    click_button(button)
  end
end

Given /^11 valid opportunites are created$/ do
  #this number is for testing pagination
  11.times { User.gen(:opp) }
end

Given /^I am signed in as a user that has authored an opportunity$/ do
  User.gen(:opp)
  @current_opportunity = Opportunity.last
end

Then /^the opportunity should be updated$/ do
  assert_equal @current_form["Title:"], Opportunity.last.title 
end

Then /^the opportunity should be booked$/ do
  assert_equal 1, Booking.count
end

Then /^I should have signed up$/ do
  assert_equal @current_form["Username:"], User.last.username
end

Then /^the opportunity should be created$/ do
  assert_equal 1, Opportunity.count
end

Then /^I should be on "([^\"]*)"$/ do |url|
  assert_equal url, page.current_path
end

Then /^there should only be 10 opportunities$/ do
  assert_equal 10, page.all(:xpath, '//tbody/tr').length
end

Then /^the opportunity should be deleted$/ do
  assert_equal nil, Opportunity.first(:title => @current_form["Title:"])
end
