require 'sinatra'
require 'data_mapper'
require 'haml'
require 'will_paginate'
require 'will_paginate/data_mapper'
require 'will_paginate/view_helpers/sinatra'

=begin
connection_string = case ENV['RACK_ENV']
  when 'test' then 'mysql://root@localhost/rook_test'
  when 'development' then 'mysql://root@localhost/rook_development'
  else 'mysql://root@localhost/rook'
end
=end

connection_string = "mysql://root@localhost/rook_#{ ENV['RACK_ENV'] }"
#puts connection_string
DataMapper.setup(:default, connection_string)

class Rook < Sinatra::Base

  configure do
    helpers WillPaginate::Sinatra::Helpers
#    set :app_file, __FILE__
  end
end

require_relative 'routes/init'
require_relative 'models/init'

#class Rook::Subscription
#  include DataMapper::Resource
#end
