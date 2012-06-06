<<<<<<< HEAD
class Rook
=begin
  class Subscription
    include DataMapper::Resource
    belongs_to :user, :key => true
    belongs_to :person, :key =>true
  end
=end
end

    
=======
class Subscription
=begin
  include DataMapper::Resource
  
  belongs_to :user, :key => true
  belongs_to :opportunities, :key => true
=end
end
>>>>>>> Namespace
