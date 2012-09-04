class Gratitude
  include DataMapper::Resource

  property :id, Serial
  property :comment, String, :length => 150

  belongs_to :opportunity
  belongs_to :recipient, :model => 'User', :key => true
  belongs_to :sender, :model => 'User', :key => true
end
