require 'pry'
class Mailer

  def self.mail_greeting(user)
    mailer_opts = mail_config.merge(to: user.email, body: message(user))
    Pony.mail(mailer_opts)
  end

  def self.message(user)
    message = %Q{
      Welcome #{user.username},

      For right now this is just a test email. Please ignore this message.

      Thank you,

      Rook
    }
  end

  def self.mail_config
    @mail_config =
    { :via => :smtp,
      :via_options => {
      :address => 'stmp.gmail.com',
      :port => '25',
      :user_name => 'example_user',
      :password => 'rook_is_great',
      :authenticatoin => :plain,
      :domain => 'gmail.com' }
    }
  end
end
