require_relative '../rook'

class Rook::User
  include DataMapper::Resource

  property :id, Serial
  property :username, String
  property :email, String
  property :password, String

 # has n, :profile
 # has n, :courses
 # has n, :opportunities
end

#DataMapper.finalize

