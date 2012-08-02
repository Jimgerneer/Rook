require_relative "../spec_helper"

describe OpportunityService do

  describe "create method" do

    it "creates an opportunity for user" do
      user = stub({id: 42}) 
      data = {"title" => "Ruby", "skills" => "Haha", "description" => "This is a fake"}
      Opportunity.expects(:create).with({:title => "Ruby",
                                       :skills => "Haha",
                                       :description => "This is a fake",
                                       :user_id => user.id})
      OpportunityService.create(user, data)
    end
  end
end
