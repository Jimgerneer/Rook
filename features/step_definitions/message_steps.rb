Given /^I create a message to myself:$/ do |table|
  table.hashes.each do |data|
    @message_sent = data
    sender = User.first(:username => data[:sender])
    recipient_id = sender.id
    MessageService.create(sender, data.merge("recipient_id" => recipient_id))
  end
end

Then /^I should have a message$/ do
  expected_message = @message_sent["body"]
  result = Message.first(:body => expected_message).body
  assert_equal expected_message, result
end
