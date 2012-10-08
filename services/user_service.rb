class UserService
  def self.create(data)
    data = data.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}
    user = User.create(data)
    email_on_create(user) if user.id
    user
  end

  def self.update(id, data)
    user = User.first("id" => id)
    data = data.reject{ |k,v| v.empty? }
    user.update(data)
  end


  private

  class << self
    def email_on_create(user)
      Mailer.mail(user, :beta_welcome)
    end
  end
end
