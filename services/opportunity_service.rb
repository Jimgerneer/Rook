class OpportunityService
  def self.create(user, data)
    data = data.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}
    skill_objects = get_skill_objects(data[:skills].split(", "))

    new_data = data.merge(:user_id => user.id, :skills => skill_objects)

    Opportunity.create(new_data)
  end

  def self.update(id, data)
    op = Opportunity.first("id" => id)
    op.update(data.merge("skills" => get_skill_objects(data["skills"].split(/,\s*/))))
  end

  def self.thank(sender, opportunity_id, comment)
    opportunity = Opportunity.first(:id => opportunity_id.to_i)
    recipient = User.first(:id => opportunity.user.id)
    sender = User.first(:id => sender)
    comment = comment['comment']

    Gratitude.create(:sender => sender, :recipient => recipient, :opportunity => opportunity, :comment => comment)
  end


  def self.get_skill_objects(skills)
    skills.inject([]) do |memo, name|
      memo << Skill.first_or_create(:name => name)
    end
  end
end
