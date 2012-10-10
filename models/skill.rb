class Skill
  include DataMapper::Resource

  property :id, Serial
  property :name, String, :required => true, :length => (2..32),
           :unique => true

  has n, :opportunity_skills
  has n, :opportunities, :through => :opportunity_skills

  has n, :user_wanted_skills, :constraint => :destroy
  has n, :user_wants, :model => 'User', :child_key => [:id],
         :parent_key => [:user_id], :through => :user_wanted_skills
  has n, :user_skills, :constraint => :destroy
  has n, :user_has, :model => 'User', :child_key => [:id],
         :parent_key => [:user_id], :through => :user_skills

end
