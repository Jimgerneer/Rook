Given /^I have a user "([^\"]*)"$/ do |username|
   user = User.gen ({:username => username})
end

When /^I create an opportunity:$/ do |table|
  table.hashes.each do |data|
    user_name = data.delete("user")
    user = User.first(:username => user_name)
    OpportunityService.create(user, data)
  end
end

Then /^I should have the following opportunities:$/ do |table|
  result = Opportunity.all.map(&:title)
  expected = table.hashes.map{|data| data["title"] }
  assert_equal expected, result
end
