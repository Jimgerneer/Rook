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
end
