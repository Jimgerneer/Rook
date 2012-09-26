class Mailer

  def self.mail(user, message_type)
    mailer_opts = mail_config.merge(to: user.email, body: message(user, message_type))
    Pony.mail(mailer_opts)
  end

  private

  def self.message(user, message_type)
    case message_type
    when :welcome then welcome_message(user.username)
    when :beta_welcome then beta_welcome(user.username)
    when :beta_activated then beta_activated(user.username)
    end
  end


  def self.welcome_message(username)
    %Q{
      Welcome #{username},

      For right now this is just a test email. Please ignore this message.

      Thank you,

      Rook
    }
  end

  def self.beta_welcome(username)
    %Q{
      Thank you for signing up #{username},

      As soon as your account is accepted for Beta Rook, you will be sent an email.

      Thank you,

      Jim Denton
    }
  end

  def self.beta_activated(username)
    %Q{
      #{username}!

      Your account is activated!

      Please - - -
    }
  end

  def self.mail_config
    config_filename = File.expand_path('../config/mail_config.yml', __FILE__)
    @mail_config ||=  begin
      File.exists?(config_filename) ? YAML.load_file(config_filename).merge(:from => 'rookerydev@gmail.com', :via => :smtp) : {}
    end
  end
end
