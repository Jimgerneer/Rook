class Skill
  include DataMapper::Resource

  property :id, Serial
  property :name, String

  has n, :opportunity_skills
  has n, :opportunities, :through => :opportunity_skills

end
