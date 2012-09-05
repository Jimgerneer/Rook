class Opportunity
  include DataMapper::Resource

  property :id,           Serial
  property :title,        String,   :required => true
  property :description,  String,   :required => true
  property :open,         Boolean,  :default=> true
  property :created_at,   DateTime
  property :created_on,   Date
  property :updated_at,   DateTime
  property :updated_on,   Date

  belongs_to :user

  has n, :bookings
  has n, :booked_users, :model => 'User', :child_key => [:id],
         :parent_key => [:user_id], :through => :bookings

  has n, :messages
  has n, :gratitudes

  has n, :opportunity_skills, :constraint => :destroy
  has n, :skills, :through => :opportunity_skills

end
