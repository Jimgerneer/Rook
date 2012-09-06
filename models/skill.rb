class Skill
  include DataMapper::Resource

  property :id, Serial
  property :name, String, :required => true, :length => (2..32),
           :unique => true

  has n, :opportunity_skills
  has n, :opportunities, :through => :opportunity_skills

  has n, :user_wants, :model => 'User', :required => false, :through => Resource
  has n, :user_has, :model => 'User', :required => false, :through => Resource

end
