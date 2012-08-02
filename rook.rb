require 'sinatra'
require 'data_mapper'
require 'haml'
require 'will_paginate'
require 'will_paginate/data_mapper'
require 'will_paginate/view_helpers/sinatra'
require 'pony'

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

#move to lib/server
class Rook  < Sinatra::Base
  set :sessions, true
  set :session_secret, 'Reno Blake'

  configure do
    helpers WillPaginate::Sinatra::Helpers
  end
end

#manifest file needed /lib/rook/ rook.rb
require_relative 'routes/init'
require_relative 'models/init'
require_relative 'services/init'

DataMapper.finalize
DataMapper.auto_upgrade!
