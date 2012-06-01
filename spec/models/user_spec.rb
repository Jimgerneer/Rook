require_relative '../spec_helper'
require_relative '../../models/user'

describe Rook::User do
  before do
    @user = Rook::User.gen
  end

  it 'has a username' do
    @user.username.must_equal 'DecoyDrone'
  end

  it 'has an id' do
    @user.must_respond_to :id
  end

  it 'has an email' do
    @user.email.must_equal 'faker@me.com'
  end

  it 'has a password' do
    @user.password.must_equal 'doobar'
  end

  it 'requires a correct password confirmation' do
    invalid_user = Rook::User.make(:password_confirmation => 'wrong')
    assert ! invalid_user.valid?
  end
end

describe Rook::User do

  before do
    DataMapper.auto_migrate!
  end

  it 'usernames need to be at least 2 char long' do
    invalid_user = Rook::User.make(:username => 's')
    assert ! invalid_user.valid?
  end

  it 'requires a vaild email format' do
    invalid_user1 = Rook::User.make(:email => 'wrong.com')
    assert ! invalid_user1.valid?
    invalid_user2 = Rook::User.make(:email => 'wrong@com')
    assert ! invalid_user2.valid?
    invalid_user3 = Rook::User.make(:email => '@wrong.com')
    assert ! invalid_user3.valid?
  end

  it 'requires unique usernames on signup' do
    invalid_user1 = Rook::User.gen(:username => 'decoy')
    invalid_user2 = Rook::User.make(:username => 'decoy')
    assert ! invalid_user2.valid?
  end

  it 'requires a unique email on signup' do
    invalid_user1 = Rook::User.gen(:email => 'Anyone@me.com')
    invalid_user2 = Rook::User.make(:email => 'Anyone@me.com')
    assert ! invalid_user2.valid?
  end
end
