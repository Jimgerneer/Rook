class UserService
  def self.create(data)
    data = data.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}
    user = User.create(data)
    email_on_create(user) if user.id
    user
  end


  private

  class << self
    def email_on_create(user)
      Mailer.mail_greeting(user)
    end
  end
end
