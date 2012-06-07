class Booking
  include DataMapper::Resource

  property :id, Serial

  belongs_to :booked_user, :model => 'User', :child_key => [:user_id] 
  belongs_to :booked_opportunities, :model => 'Opportunity', :child_key => [:opportunity_id] 

end
