class Subscription
=begin
  include DataMapper::Resource
  
  belongs_to :user, :key => true
  belongs_to :opportunities, :key => true
=end
end
