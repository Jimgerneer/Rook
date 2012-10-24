class Message
  include DataMapper::Resource

  property :id,           Serial
  property :body,         Text,     :lazy => false
  property :viewed,       Boolean,  :default => false
  property :active,       Boolean,  :default => true
  property :created_at,   DateTime
  property :created_on,   Date
  property :updated_at,   DateTime
  property :updated_on,   Date

  belongs_to :opportunity
  belongs_to :recipient, :model => 'User', :key => true
  belongs_to :sender, :model => 'User', :key => true

  def viewed!
    self.viewed = true
    self.save
  end
end
