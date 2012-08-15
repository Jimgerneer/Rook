class Skill
  include DataMapper::Resource

  property :id, Serial
  property :name, String, :required => true, :length => (2..32),
           :unique => true

  has n, :opportunity_skills
  has n, :opportunities, :through => :opportunity_skills

end
