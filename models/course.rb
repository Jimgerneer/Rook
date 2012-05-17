require_relative '../rook'

class Rook::Course
  include DataMapper::Resource

  property :id,     Serial
  property :title,  String
  property :description, String
  
#  has n, :opportunities

  #belongs_to :user
end

DataMapper.finalize
