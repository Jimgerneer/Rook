require_relative '../spec_helper'

describe Mailer do

  let(:user) {User.gen}
  let(:config_hash) do
    { :via => :smtp,
      :via_options => {
      :address => 'stmp.gmail.com',
      :port => '25',
      :user_name => 'rook_admin',
      :password => 'rook_is_great',
      :authenticatoin => :plain, 
      :domain => 'gmail.com' }
    }
  end

  before {Mailer.stubs(:mail_config).returns(config_hash)}

  it "#mail_greeting takes a user and sends an email to that user" do
    Pony.expects(:mail).with(has_entry({to: user.email}))
    Mailer.mail_greeting(user)
  end

  it "customizes a message with user info" do
    message = %Q{
      Welcome #{user.username},

      For right now this is just a test email. Please ignore this message.

      Thank you,

      Rook
    }
    Pony.expects(:mail).with(has_entry({body: message}))
    Mailer.mail_greeting(user)
  end

  it "gets options and authentication details from config" do
    Pony.expects(:mail).with(has_entries(config_hash))
    Mailer.mail_greeting(user)
  end
end
