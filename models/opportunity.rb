class Rook
  class Opportunity 
  
  include DataMapper::Resource

  property :id,           Serial
  property :title,        String
  property :skills,       String
  property :description,  String

  belongs_to :user, :model => "Rook::User" 

end
end
