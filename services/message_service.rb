class MessageService
  def self.create(data)
    data = data.inject({}){ |memo, (k,v)| memo[k.to_sym] = v; memo}
    recipient = User.first(:username => data[:recipient])
    sender = User.first(:username => data[:sender])
    body = data[:body]
    Message.create({:recipient_id => recipient.id, :sender_id => sender.id, :body => body})
  end
end
