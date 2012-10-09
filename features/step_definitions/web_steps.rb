Given /^I am signed in with a valid user$/ do
  @current_user = User.gen
  @current_user.activate!
  visit ('/login')
  fill_in('username', :with => @current_user.username)
  fill_in('password', :with => 'doobar')
  click_button('Submit')
end

Given /^I try to log in with an inactive user$/ do
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

Given /^I click the send button$/ do
  click_button('Send')
end

Given /^I click the "([^|"]*)" link$/ do |link|
  click_link(link)
end

Given /^I click the "([^\"]*)" button$/ do |button|
  within(:xpath, '//tbody/tr//td/form')do
    click_button(button)
  end
end

Given /^I am signed in as a user that has authored an opportunity$/ do
  @current_user = User.gen
  @current_user.activate!
  login_steps(@current_user)
  data = {:user_id => @current_user.id, :title => "test", :description => "This is a test"}
  @current_opportunity = Opportunity.create(data)
end

Then /^I should have signed up$/ do
  assert_equal @current_form["Username:"], User.last.username
end

Then /^I should be on "([^\"]*)"$/ do |url|
  assert_equal url, page.current_path
end

Then /^there should only be 10 opportunities$/ do
  assert_equal 10, page.all(:xpath, '//tbody/tr').length
end

Then /^I should be on the booked opportunity page$/ do
  expect = '/opportunity/conversation.' + @current_opportunity.id.to_s
  assert_equal expect, page.current_path
end

def login_steps(user)
  visit ('/login')
  fill_in('username', :with => user.username)
  fill_in('password', :with => 'doobar')
  click_button('Submit')
end
