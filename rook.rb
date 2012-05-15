require 'sinatra'
require 'data_mapper'
require 'haml'

DataMapper.setup(:default, 'mysql://root@localhost/rook')

class Rook < Sinatra::Base
  get '/' do
    haml :index
  end
end

#class Rook::Subscription
#  include DataMapper::Resource
#end
