require_relative "../spec_helper"

describe UserService do

  describe "create method" do

    it "creates a user" do
      UserService.stubs(:email_on_create)
      data = {"username" => "Decoydrone", "email" => "mad@hatter.com", "password" => "foo", "password_confirmation" => "foo"}
      User.expects(:create).
        with({:username => "Decoydrone", :email => "mad@hatter.com", :password => "foo", :password_confirmation => "foo"}).
        returns(stub(:id => 1))
      UserService.create(data)
    end
  end
end
