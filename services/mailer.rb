class Mailer

  def self.mail(user, message_type)
    mailer_opts = mail_config.merge(from: 'rookerydev@gmail.com', subject: 'Rook', to: user.email, body: message(user, message_type))
    Pony.mail(mailer_opts)
  end

  def self.mail_config
    @mail_config ||= set_mail_config
  end

  def self.mail_config=(config)
    @mail_config = config
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
      Good news #{username},

      Your account has been activated for Rook Beta.

      Rook has been my learning project for the last few months. But now, I want to make
      it something useful to others. That is where beta testers like you come in. I want
      to make rook valuable for people like you. People eager to learn, people with skills
      to teach.

      Please, log on and check it out. As you might have guessed, this is not the final
      product. For example, right now I am working on getting a password reset working.
      And I am looking into if I should use Faye to make messaging a bit more dynamic.
      But the core of my inital idea works. In the coming weeks, I hope to get your
      brutally honest feedback translated into working code.

      I have set up a subreddit, www.reddit.com/r/rook to make posts about questions,
      feature requests, and error reporting. I will also be posting updates on my
      progress.

      Thank you,

      Jim Denton
      @DecoyDrone
    }
  end

  def self.beta_welcome(username)
    %Q{
      Thank you for signing up #{username},

      Beta testing is in progress. You will recive an email when your account is active.

      Thank you,

      Jim Denton
      @DecoyDrone
    }
  end

  def self.beta_activated(username)
    %Q{
      #{username}!

      Your account is activated!

      Please - - -
    }
  end

  def self.set_mail_config
    if File.exists?('./config/mail_test_settings.rb')
      require './config/mail_test_settings'
    else
      @mail_config = {
        :via => :smtp, :via_options => {
          address: ENV['EMAIL_ADDRESS'],
          port: ENV['EMAIL_PORT'],
          user_name: ENV['SENDGRID_USERNAME'],
          password: ENV['SENDGRID_PASSWORD'],
          #authentication: ENV['EMAIL_AUTHENTICATION'],
          enable_starttls_auto: ENV['EMAIL_STARTTLS_AUTO'],
          domain: ENV['EMAIL_DOMAIN'] }
      }
    end
    @mail_config
  end
end
