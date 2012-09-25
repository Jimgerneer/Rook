class OpportunityService
  def self.create(user, data)
    data = data.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}

    new_data = data.merge(:user_id => user.id, :skills => get_skill_objects(data[:skills]))

    Opportunity.create(new_data)
  end

  def self.update(id, data)
    op = Opportunity.first("id" => id)
    op.update(data.merge("skills" => get_skill_objects(data["skills"])))
  end

  def self.get_skill_objects(skills)
    skills.inject([]) do |memo, name|
      memo << Skill.first_or_create(:name => name)
    end
  end
end
