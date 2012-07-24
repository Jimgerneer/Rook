When /^I create a user:$/ do |table|
  table.hashes.each do |data|
    UserService.create(data)
  end
end

Then /^I should have the following user:$/ do |table|
  result = User.all.map(&:username)
  expected = table.hashes.map{|data| data["username"] }
  assert_equal expected, result
end

Then /^I should get an email$/ do
  result = inbox_for(:address => 'foo@me.com').size
  assert_equal 1, result
end
