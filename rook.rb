require 'sinatra'
require 'data_mapper'

DataMapper.setup(:default, 'mysql://root@localhost/rook')

class Rook < Sinatra::Base

end

#class Rook::Subscription
#  include DataMapper::Resource
#end

require_relative 'lib/user'

class Rook::Course
  include DataMapper::Resource

  property :id,     Serial
  property :title,  String
  property :description, String
  
#  has n, :opportunities

  #belongs_to :user
end


