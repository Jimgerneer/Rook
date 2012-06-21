Given /^I am viewing "(.+)"$/ do |url|
  visit(url)
end

Then /^I should see "(.+)"$/ do |text|
  assert has_content?(text)
end
