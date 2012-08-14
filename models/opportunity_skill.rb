class OpportunitySkill
  include DataMapper::Resource

  belongs_to :opportunity, :key => true
  belongs_to :skill,       :key => true

end
