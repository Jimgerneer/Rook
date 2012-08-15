class Message
  include DataMapper::Resource

  property :id, Serial
  property :body, String

  belongs_to :sender, :model => 'User', :key => true
  belongs_to :recipient, :model => 'User', :key => true
  belongs_to :opportunity
end

