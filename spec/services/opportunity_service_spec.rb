require_relative "../spec_helper"

describe OpportunityService do

  before { Skill.stubs(:first_or_create).returns(skill) }

  describe "create method" do

    it "creates an opportunity for user" do
      data = {"title" => "Ruby", "skills" => "Haha", "description" => "This is a fake"}

      user = User.new
      user.stubs(:id).returns(42)

      data_expected = {:title => "Ruby", :skills => "Haha", :description => "This is a fake"}
      expected = data_expected.merge(:skills => [skill], :user_id => user.id)
      Opportunity.expects(:create).with(expected)

      OpportunityService.create(user, data)
    end
  end

  describe "update method" do

    it "updates an opportunity for user" do
      data = {"skills" => "Haha", "title" => "Ruby", "description" => "This is a fake"}

      op = stub()
      Opportunity.stubs(:first).with("id" => 3).returns(op)
      op.expects(:update).with(data.merge("skills" => [skill]))

      OpportunityService.update(3, data)
    end
  end

  describe "thanks method" do

    it "adds a thanks to an opportunity" do

    end

  end

  def skill
    Skill.new(:name => "Haha")
  end
end
