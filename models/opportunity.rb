require_relative '../rook'

class Rook::Opportunity 
  include DataMapper::Resource

  property :id,           Serial
  property :title,        String
  property :skills,       String
  property :description,  String
end

DataMapper.finalize
