require 'sinatra'
require 'data_mapper'
require 'haml'
require 'will_paginate'
require 'will_paginate/data_mapper'
require 'will_paginate/view_helpers/sinatra'
require 'pony'

#move to lib/server
class Rook  < Sinatra::Base
  set :sessions, true
  set :session_secret, 'ENV[SESSION_SECRET]'

  configure do
    helpers WillPaginate::Sinatra::Helpers
  end

  configure :development, :test do
    connection_string = "mysql://root@localhost/rook_#{ ENV['RACK_ENV'] }"
    #puts connection_string
    DataMapper.setup(:default, connection_string)
  end

  configure :production do
    DataMapper.setup(:default, ENV['DATABASE_URL'] || 'postgres://localhost/mydb')
  end
end

#manifest file needed /lib/rook/ rook.rb
require_relative 'routes/init'
require_relative 'models/init'
require_relative 'services/init'

DataMapper.finalize
DataMapper.auto_upgrade!
