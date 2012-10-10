class UserSkill
  include DataMapper::Resource

  property :id, Serial

  belongs_to :skills_aquired, :model => 'Skill', :child_key => [:skill_id]
  belongs_to :user_has, :model => 'User', :child_key => [:user_id]

end
