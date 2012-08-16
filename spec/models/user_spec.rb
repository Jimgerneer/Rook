require_relative '../spec_helper'
require_relative '../../models/user'

describe User do

  it 'usernames need to be at least 2 char long' do
    invalid_user = User.make(:username => 's')
    assert_invalid(invalid_user, :username)
  end

  it 'requires a vaild email format' do
    invalid_user1 = User.make(:email => 'wrong.com')
    assert ! invalid_user1.valid?
    invalid_user2 = User.make(:email => 'wrong@com')
    assert ! invalid_user2.valid?
    invalid_user3 = User.make(:email => '@wrong.com')
    assert ! invalid_user3.valid?
  end

  it 'requires unique usernames on signup' do
    invalid_user1 = User.gen(:username => 'decoy')
    invalid_user2 = User.make(:username => 'decoy')
    assert ! invalid_user2.valid?
  end

  it 'requires a unique email on signup' do
    invalid_user1 = User.gen(:email => 'Anyone@me.com')
    invalid_user2 = User.make(:email => 'Anyone@me.com')
    assert ! invalid_user2.valid?
  end

  def assert_invalid (user, attribute=nil)
    assert ! user.valid?
    assert user.errors.on(attribute) if attribute
  end
end
