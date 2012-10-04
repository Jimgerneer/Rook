class MessageService
  def self.create(sender, data)
    data = data.inject({}){ |memo, (k,v)| memo[k.to_sym] = v; memo}
    new_data = {:recipient_id => data[:recipient_id].to_i,
                :opportunity_id => data[:opportunity_id].to_i,
                :sender_id => sender.id,
                :body => data[:body] }
    Message.create(new_data)
  end
end
