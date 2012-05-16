require_relative '../spec_helper'

require_relative '../../models/user'

describe Rook::User do
  def subject
    attrs = {
      username: 'DecoyDrone',
      email: 'inkpen1986@me.com',
      password: 'foobar' }

    Rook::User.new(attrs)
  end

  it 'has a username' do
    subject.username.must_equal 'DecoyDrone'
  end

  it 'has an id' do
    subject.must_respond_to :id
  end

  it 'has an email' do
    subject.email.must_equal 'inkpen1986@me.com'
  end

  it 'has a password' do
    subject.password.must_equal 'foobar'
  end
end
