require 'sinatra'
require 'data_mapper'

DataMapper.setup(:default, 'mysql://root@localhost/rook')

class Rook < Sinatra::Base

end

#class Rook::Subscription
#  include DataMapper::Resource
#end
