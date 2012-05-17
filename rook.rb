require 'sinatra'
require 'data_mapper'
require 'haml'
require_relative 'routes/init'
require_relative 'models/init'

DataMapper.setup(:default, 'mysql://root@localhost/rook')

class Rook < Sinatra::Base

  configure do
    set :app_file, __FILE__
  end
end

#class Rook::Subscription
#  include DataMapper::Resource
#end
