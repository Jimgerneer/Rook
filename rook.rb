require 'sinatra'
require 'bundler'
require 'data_mapper'
require 'haml'
require 'will_paginate'
require 'will_paginate/data_mapper'
require 'will_paginate/view_helpers/sinatra'
require 'pony'
require 'sanitize'
require 'sinatra/flash'
require_relative 'routes/routes_helper'

Bundler.require

#move to lib/server
class Rook  < Sinatra::Base
  set :sessions, true
  set :session_secret, ENV['SESSION_SECRET']
  register Sinatra::Flash

  configure do
    helpers WillPaginate::Sinatra::Helpers
    helpers Rookery::Helpers
  end

  configure :development, :test do
    connection_string = "mysql://root@localhost/rook_#{ ENV['RACK_ENV'] }"
    DataMapper.setup(:default, connection_string)
    enable :logging
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
