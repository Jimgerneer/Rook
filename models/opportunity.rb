class Opportunity 
  include DataMapper::Resource

  property :id,           Serial
  property :title,        String
  property :skills,       String
  property :description,  String

  belongs_to :user
  has n, :bookings
  has n, :booked_users, :model => 'User', :child_key => [:id],
         :parent_key => [:opportunity_id], :through => :bookings

end
