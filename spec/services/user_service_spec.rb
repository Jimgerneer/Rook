require_relative "../spec_helper"

describe UserService do

  describe "create method" do

    it "creates a user" do
      UserService.stubs(:email_on_create)
      data = {"username" => "Decoydrone",
              "email" => "mad@hatter.com",
              "password" => "foo",
              "password_confirmation" => "foo"}
      User.expects(:create)
        .with({:username => "Decoydrone",
              :email => "mad@hatter.com",
              :password => "foo",
              :password_confirmation => "foo"})
        .returns(stub(:id => 1))
      UserService.create(data)
    end
  end

  describe "update method" do

    it "updates a user" do
      data = {"first_name" => "Jim", "last_name" => "Denton", "bio" => "I am a sham"}

      user = stub()
      User.stubs(:first).with("id" => 3).returns(user)
      user.expects(:update).with(data)

      UserService.update(3, data)
    end
  end
end
