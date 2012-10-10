class UserWantedSkill
  include DataMapper::Resource

  property :id, Serial

  belongs_to :skills_desired, :model => 'Skill', :child_key => [:skill_id]
  belongs_to :user_wants, :model => 'User', :child_key => [:user_id]

end
