require_relative '../rook'

class Rook::Profile
  include DataMapper::Resource

  property :id, Serial
  property :first_name, String
  property :last_name, String
  property :city, String
  property :timezone, String

  #belongs_to :user
end

