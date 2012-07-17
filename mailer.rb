class Mailer

  def self.send_mail(to, body)
    Pony.mail({
      :to => to,
      :via => :smtp,
      :via_options => {
        :address => 'stmp.youserver.com',
        :port => '25',
        :user_name => 
        :password =>
        :authenticatoin => :plain, # :plain, :login, :cram_md5, no auth by default
        :domain =>
      }
    })
  end
end
