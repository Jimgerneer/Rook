require_relative "../spec_helper"

describe OpportunityService do

  before { Skill.stubs(:first_or_create).returns(skill) }

  describe "create method" do

    it "creates an opportunity for user" do
      data = {"title" => "Ruby", "skills" => ["Haha"], "description" => "This is a fake"}

      user = stub({id: 42}) 
      User.stubs(:first).returns(user)

      expected = data.merge("skills" => [skill], "user_id" => user.id)
      Opportunity.expects(:create).with(expected)

      OpportunityService.create(user, data)
    end
  end

  describe "update method" do

    it "updates an opportunity for user" do
      data = {"user_id" => 1, "skills" => ["Haha"], "title" => "Ruby", "description" => "This is a fake"}

      op = stub()
      Opportunity.stubs(:first).returns(op)
      op.expects(:update).with(data.merge("skills" => [skill]))

      OpportunityService.update(data)
    end
  end

  def skill
    Skill.new(:name => "Haha")
  end
end
