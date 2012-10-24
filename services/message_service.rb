class MessageService
  def self.create(sender, data)
    data = data.inject({}){ |memo, (k,v)| memo[k.to_sym] = v; memo}
    new_data = {:recipient_id => data[:recipient_id].to_i,
                :opportunity_id => data[:opportunity_id].to_i,
                :sender_id => sender.id,
                :body => data[:body] }
    message = Message.create(new_data)
    return message
  end

  def self.set_to_viewed(messages)
    messages.each do |message|
      if message.viewed == false
        @message = Message.first(:id => message.id)
        @message.viewed!
      end
    end
  end
end
