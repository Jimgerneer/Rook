require_relative "../spec_helper"

describe MessageService do

  describe "create method" do
    before do
      User.gen :username => "DummyDrone"
      User.gen :username => "DecoyDrone"
    end

    it "creates a message" do
      data = {"recipient" => "DummyDrone",
              "sender" => "DecoyDrone",
              "body" => "hello there"}
      Message.expects(:create)
        .with({:recipient_id => User.first(:username => "DummyDrone").id,
               :sender_id => User.first(:username => "DecoyDrone").id,
               :body => "hello there"})
     MessageService.create(data)
    end
  end
end
