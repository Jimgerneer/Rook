Given /^I have a user "([^\"]*)"$/ do |username|
   user = User.gen ({:username => username})
end

When /^I create an opportunity:$/ do |table|
  table.hashes.each do |data|
    user_name = data.delete("user")
    data["skills"] = data.delete("skills")
    user = User.first(:username => user_name)
    @current_opportunity = OpportunityService.create(user, data)
  end
end

Given /^there is an opportunity available$/ do
  user = User.gen(:unique)
  data = {:user_id => user.id, :title => "test test", :description => "This is a test"}
  @current_opportunity = Opportunity.create(data)
end

#Given /^11 valid opportunites are created$/ do
  #this number is for testing pagination
#  11.times { User.gen(:opp) }
#end

Given /^A user has contacted me about that opportunity$/ do
  user = User.gen(:unique)
  data = {"body" => "Hello there",
          "opportunity_id" => @current_opportunity.id,
          "recipient_id" => @current_user.id }
  message = MessageService.create(user, data) 
end

Given /^I have been booked for an opportunity$/ do
  user = User.gen(:unique)
  data = {:user_id => user.id, :title => "test test", :description => "This is a test"}
  @current_opportunity = Opportunity.create(data)
  Booking.create(:opportunity_id => @current_opportunity.id, :user_id => @current_user.id)
end

#Given /^I am viewing that opportunity$/ do
#  visit "/opportunity/#{@current_opportunity.id}"
#end

Then /^I should have the following opportunities:$/ do |table|
  result = Opportunity.all.map(&:title)
  expected = table.hashes.map{|data| data["title"] }
  assert_equal expected, result
end

Then /^the opportunity should be updated$/ do
  assert_equal @current_form["Title:"], Opportunity.last.title 
end

Then /^the opportunity should be booked$/ do
  assert_equal 1, Booking.count
end

Then /^the opportunity should be created$/ do
  op = Opportunity.first
  assert_equal @current_form["Title:"], op.title
  assert_equal @current_form["Skills:"], op.skills.map(&:name).join(", ")
  assert_equal @current_form["Description:"], op.description
  assert_equal 1, Opportunity.count
end

Then /^the opportunity should be deactivated$/ do
  op = Opportunity.first(:title => @current_form["Title:"])
  result = op.active
  assert_equal false, result
end
