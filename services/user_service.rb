class UserService
  def self.create(data)
    data = data.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}
    user = User.create(data)
    email_on_create(user) if user.id
    user
  end

  def self.update(id, data)
    #data = data.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}
    user = User.first("id" => id)
    data = data.reject{ |k,v| v.empty? }
    user.update(data.merge("skills_desired" => get_skill_objects(data["skills_desired"]),
                           "skills_aquired" => get_skill_objects(data["skills_aquired"])))
  end

  def self.get_skill_objects(skills)
    skills.inject([]) do |memo, name|
      memo << Skill.first_or_create(:name => name)
    end
  end

  private

  class << self
    def email_on_create(user)
      Mailer.mail(user, :beta_welcome)
    end
  end
end
