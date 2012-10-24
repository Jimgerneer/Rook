require_relative "../spec_helper"

describe MessageService do

  describe "create method" do

    it "creates a message" do
      sender = stub(:id => 1)
      data = {"recipient_id" => "5",
              "opportunity_id" => "2",
              "body" => "hello there"}
      expected_data = {:recipient_id => 5,
                       :sender_id => 1,
                       :opportunity_id => 2,
                       :body => "hello there" }
      Message.expects(:create).with(expected_data)
      MessageService.create(sender, data)
    end
  end

  describe "set to viewed method" do

    it "sets a messaged to viewed" do
      message1 = stub(:id => 1, :viewed => false)
      message2 = stub(:id => 2, :viewed => false)

      Message.stubs(:first).with(:id => 1).returns(message1)
      Message.stubs(:first).with(:id => 2).returns(message2)

      message1.expects(:viewed!)
      message2.expects(:viewed!)

      messages = [message1, message2]
      MessageService.set_to_viewed(messages)
    end
  end
end
