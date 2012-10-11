class Message
  include DataMapper::Resource

  property :id,           Serial
  property :body,         Text,     :lazy => false
  property :created_at,   DateTime
  property :created_on,   Date
  property :updated_at,   DateTime
  property :updated_on,   Date

  belongs_to :opportunity
  belongs_to :recipient, :model => 'User', :key => true
  belongs_to :sender, :model => 'User', :key => true
end

