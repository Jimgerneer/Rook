Given /^I create a message for another user:$/ do |table|
  table.hashes.each do |data|
    @message_sent = data
    MessageService.create(data)
  end
end

Then /^that user should have a message$/ do
  expected_message = @message_sent[:body]
  result = Message.first(:body => expected_message).body
  assert_equal expected_message, result
end
