class Gratitude
  include DataMapper::Resource

  property :id, Serial
  property :comment, String, :length => 150

  belongs_to :opportunity
  belongs_to :recipient, 'User', :key => true
  belongs_to :sender, 'User', :key => true
end
