require_relative "../spec_helper"

describe MessageService do

  describe "create method" do

    it "creates a message" do
      sender = stub(:id => 1)
      data = {"recipient_id" => "5",
              "body" => "hello there"}
      Message.expects(:create).with(data.merge("sender_id" => 1, "recipient_id" => 5))
     MessageService.create(sender, data)
    end
  end
end
