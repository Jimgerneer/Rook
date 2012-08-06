class Mailer

  def self.mail_greeting(user)
    mailer_opts = mail_config.merge(to: user.email, body: message(user))
    Pony.mail(mailer_opts)
  end

  private

  def self.message(user)
    message = %Q{
      Welcome #{user.username},

      For right now this is just a test email. Please ignore this message.

      Thank you,

      Rook
    }
  end

  def self.mail_config
    config_filename = File.expand_path('../config/mail_config.yml', __FILE__)
    @mail_config ||=  begin
      File.exists?(config_filename) ? YAML.load_file(config_filename).merge(:via => :smtp) : {}
    end
  end
end
