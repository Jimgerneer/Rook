class UserService
  def self.create(data)
    data = data.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}
    User.create(data)
    user = User.last(:username => data[:username])
    Mailer.mail_greeting(user)
  end
end
